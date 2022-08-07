import 'dart:io';

String? getOptionalArg(
  List<String> args,
  String tag, {
  required String defaultValue,
}) {
  final flagIndex = args.indexOf('--$tag');
  if (flagIndex == -1) return null;
  final _file = flagIndex + 1 < args.length ? args[flagIndex + 1] : '--';
  return _file.startsWith('--') ? defaultValue : _file;
}

Future<void> main(List<String> args) async {
  final examplesFilePath = getOptionalArg(
    args,
    'generate-dart-file',
    defaultValue: './generated_docs/dart_examples.dart',
  );
  final mdsDirPath = getOptionalArg(
    args,
    'generate-md-dir',
    defaultValue: './generated_docs',
  );
  final justCheck =
      getOptionalArg(args, 'check', defaultValue: 'true') == 'true';

  final Map<String, Example> examples = {};
  final List<String> errors = [];
  final Set<File> mdFiles = {};

  final allEntities = Directory.current.list(
    followLinks: false,
    recursive: true,
  );
  await for (final entity in allEntities) {
    final startRegExp = RegExp('^// @example-start{([^}]+)}');
    final endRegExp = RegExp('^// @example-end{([^}]+)}');
    if (entity is File && entity.path.endsWith('.md')) {
      if (entity.parent.uri.pathSegments.last != 'generated_docs' &&
          !entity.uri.pathSegments.contains('docusaurus')) {
        mdFiles.add(entity);
      }
    } else if (entity is File && entity.path.endsWith('.dart')) {
      List<String> lines = await entity.readAsLines();
      final lineRanges = findLineRanges(
        lines,
        startRegExp,
        endRegExp,
      );
      for (final lineRange in lineRanges) {
        final match = startRegExp.firstMatch(lines[lineRange.startLine])!;
        final config = ExampleConfig.parse(match.group(1)!);
        final name = config.name;

        final endName =
            endRegExp.firstMatch(lines[lineRange.endLine!])!.group(1);
        if (examples.containsKey(name)) {
          errors.add(
            'Duplicate example definition "$name"'
            ' in line ${lineRange.startLine} of file "${entity.path}".',
          );
        }
        if (endName != name) {
          errors.add(
            'Example start name "$name" does not match end name "$endName"'
            ' in line ${lineRange.startLine}:${lineRange.endLine} of file "${entity.path}".',
          );
        }

        final mappedRange = config.mapRange(lineRange);
        examples[name] = Example(
          file: entity,
          lineRange: lineRange,
          config: config,
          content: lines.sublist(mappedRange.startLine, mappedRange.endLine),
        );
      }
    }
  }

  print(
    'Found ${examples.length} example${examples.length == 1 ? '' : 's'}',
  );
  if (errors.isNotEmpty) {
    throw Exception(errors.join('\n\n'));
  }

  /// Generate .md for each example
  if (mdsDirPath != null) {
    final docsDir = await Directory(mdsDirPath).create();
    for (final example in examples.values) {
      final file = File(
        [docsDir.path, Platform.pathSeparator, '${example.config.name}.md']
            .join(),
      );

      await file.writeAsString(
        ['```${example.config.extension ?? 'dart'}', ...example.content, '```']
            .join('\n'),
      );
    }
  }

  /// Generate Dart file with Strings for each example
  if (examplesFilePath != null) {
    final dartExamplesFile = await File(examplesFilePath).create();
    await dartExamplesFile.writeAsString(examples.values.map((e) {
      final _name = e.config.name.replaceAll(RegExp(r'[-\s]'), '_');
      final _content =
          e.content.map((e) => e.replaceAll("'''", '"""')).join('\n');
      return "final $_name = r'''\n$_content'''; ";
    }).join('\n\n'));
  }

  final List<String> checkErrors = [];

  /// Replace all include comments in .md files with the contents of the Dart examples
  for (final readme in mdFiles) {
    int includedExamples = 0;

    final readmeLines = await readme.readAsLines();
    final startRegExp = RegExp(r'^<!--\s*include{([^}]+)}\s*-->');
    final endRegExp = RegExp(r'^<!--\s*include-end{([^}]+)}\s*-->');
    final includeRanges = findLineRanges(
      readmeLines,
      startRegExp,
      endRegExp,
      endOptional: true,
      omitSectionDelimiter: RegExp('^(```|~~~)'),
    );

    final List<String> warnings = [];
    final List<String> newLines = [];
    int delta = 0;
    for (final range in includeRanges) {
      final startLine = range.startLine;
      final endLine = range.endLine;

      if (startLine > delta) {
        newLines.addAll(readmeLines.sublist(delta, startLine + 1));
        delta = startLine + 1;
      }
      final name = startRegExp.firstMatch(readmeLines[startLine])!.group(1)!;
      final example = examples[name];
      if (example == null) {
        warnings.add(
          'Example "$name" not found. README.md line ${startLine}',
        );
        continue;
      }
      if (endLine != null) {
        final endName = endRegExp.firstMatch(readmeLines[endLine])!.group(1)!;
        if (endName != name) {
          errors.add(
            'Include start name "$name" does not match end name "$endName".'
            ' README.md lines $startLine:$endLine',
          );
          continue;
        }
      }
      includedExamples++;
      final _toAdd = [
        '```${example.config.extension ?? 'dart'}',
        ...example.content,
        '```',
        if (endLine != null)
          readmeLines[endLine]
        else
          '<!-- include-end{$name} -->'
      ];
      newLines.addAll(_toAdd);
      delta += (endLine ?? startLine) - startLine;
      if (justCheck) {
        if (endLine == null) {
          checkErrors.add(
            'Error in ${example.config.name}: example not included.',
          );
        } else {
          final err = areErrorDifferent(
            readmeLines.sublist(startLine + 1, endLine + 1),
            _toAdd,
          );
          if (err != null)
            checkErrors.add('Error in ${example.config.name}: $err');
        }
      }
    }

    if (readmeLines.length > delta) {
      newLines.addAll(readmeLines.sublist(delta));
    }

    if (warnings.isNotEmpty) {
      print(warnings.join('\n\n'));
    }
    if (errors.isNotEmpty) {
      throw Exception(errors.join('\n\n'));
    }
    if (includedExamples > 0) {
      print(
        'Included $includedExamples example${includedExamples == 1 ? '' : 's'} in "${readme.path}"',
      );
      if (!justCheck) {
        await readme.writeAsString(newLines.join('\n'));
      }
    }
  }
  if (checkErrors.isNotEmpty) {
    throw Exception(checkErrors.join('\n\n'));
  }
}

String? areErrorDifferent(List<String> a, List<String> b) {
  if (a.length != b.length) {
    return 'Mismatch size.';
  }
  for (int i = 0; i < a.length; i++) {
    if (a[i] != b[i]) {
      return 'Mismatch in line: $i. Previous: ${a[i]} != Current: ${b[i]}.';
    }
  }
}

class ExampleConfig {
  final String name;
  final String? extension;
  final int? start;
  final int? end;

  const ExampleConfig({
    required this.name,
    this.extension,
    this.start,
    this.end,
  });

  static ExampleConfig parse(String value) {
    final values = value.split(',');

    String? _find(String name) {
      final key = '$name:';
      for (final v in values) {
        if (v.startsWith(key)) {
          return v.substring(key.length);
        }
      }
    }

    final end = _find('end') == null ? null : int.parse(_find('end')!);
    final start = _find('start') == null ? null : int.parse(_find('start')!);

    return ExampleConfig(
      name: values.first,
      end: end,
      start: start,
      extension: _find('extension'),
    );
  }

  LineRange mapRange(LineRange lineRange) {
    final int startLine;
    if (start == null) {
      startLine = lineRange.startLine + 1;
    } else if (start! < 0) {
      startLine = lineRange.endLine! + start!;
    } else {
      startLine = lineRange.startLine + 1 + start!;
    }
    final int? endLine;
    if (end == null) {
      endLine = lineRange.endLine;
    } else if (end! < 0) {
      endLine = lineRange.endLine! + end!;
    } else {
      endLine = lineRange.startLine + end!;
    }
    return LineRange(startLine, endLine);
  }
}

class Example {
  final File file;
  final ExampleConfig config;
  final List<String> content;
  final LineRange lineRange;

  Example({
    required this.file,
    required this.config,
    required this.content,
    required this.lineRange,
  });
}

class LineRange {
  final int startLine;
  final int? endLine;

  LineRange(this.startLine, this.endLine);
}

List<LineRange> findLineRanges(
  List<String> lines,
  RegExp startRegExp,
  RegExp endRegExp, {
  bool endOptional = false,
  RegExp? omitSectionDelimiter,
}) {
  final List<LineRange> examples = [];
  int? index = 0;
  while (index != null) {
    int? _startIndex;
    int? _endIndex;
    bool isOmitting = false;
    for (int i = index; i < lines.length; i++) {
      final line = lines[i];
      isOmitting = omitSectionDelimiter != null &&
          (isOmitting && !omitSectionDelimiter.hasMatch(line) ||
              !isOmitting && omitSectionDelimiter.hasMatch(line));
      if (isOmitting) {
        continue;
      }
      final _matchesStart = startRegExp.hasMatch(line);
      if (_startIndex == null && _matchesStart) {
        _startIndex = i;
      } else if (endOptional && _matchesStart) {
        break;
      } else if (_startIndex != null && endRegExp.hasMatch(line)) {
        _endIndex = i;
        break;
      }
    }

    if (_endIndex != null) {
      examples.add(LineRange(_startIndex!, _endIndex));
      index = _endIndex + 1;
    } else if (endOptional && _startIndex != null) {
      examples.add(LineRange(_startIndex, _endIndex));
      index = _startIndex + 1;
    } else {
      index = null;
    }
  }
  return examples;
}
