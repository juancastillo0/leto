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
    'dart-file',
    defaultValue: './generated_docs/dart_examples.dart',
  );
  final mdsDirPath = getOptionalArg(
    args,
    'mds-dir',
    defaultValue: './generated_docs',
  );

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
      if (entity.parent.uri.pathSegments.last != 'generated_docs') {
        mdFiles.add(entity);
      }
    } else if (entity is File && entity.path.endsWith('.dart')) {
      List<String> lines = await entity.readAsLines();
      final lineRanges = await findLineRanges(
        lines,
        startRegExp,
        endRegExp,
      );
      for (final lineRange in lineRanges) {
        final match = startRegExp.firstMatch(lines[lineRange.startLine])!;
        final name = match.group(1)!;
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
        examples[name] = Example(
          file: entity,
          lineRange: lineRange,
          name: name,
          content: lines.sublist(
            lineRange.startLine + 1,
            lineRange.endLine,
          ),
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
        [docsDir.path, Platform.pathSeparator, '${example.name}.md'].join(),
      );

      await file.writeAsString(
        ['```dart', ...example.content, '```'].join('\n'),
      );
    }
  }

  /// Generate Dart file with Strings for each example
  if (examplesFilePath != null) {
    final dartExamplesFile = await File(examplesFilePath).create();
    await dartExamplesFile.writeAsString(examples.values.map((e) {
      final _name = e.name.replaceAll(RegExp(r'[-\s]'), '_');
      final _content =
          e.content.map((e) => e.replaceAll("'''", '"""')).join('\n');
      return "final $_name = r'''\n$_content'''; ";
    }).join('\n\n'));
  }

  /// Replace all include comments in .md files with the contents of the Dart examples
  for (final readme in mdFiles) {
    int includedExamples = 0;

    final readmeLines = await readme.readAsLines();
    final startRegExp = RegExp(r'^<!--\s*include{([^}]+)}\s*-->');
    final endRegExp = RegExp(r'^<!--\s*include-end{([^}]+)}\s*-->');
    final includeRanges = await findLineRanges(
      readmeLines,
      startRegExp,
      endRegExp,
      endOptional: true,
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
        '```dart',
        ...example.content,
        '```',
        if (endLine != null)
          readmeLines[endLine]
        else
          '<!-- include-end{$name} -->'
      ];
      newLines.addAll(_toAdd);
      delta += (endLine ?? startLine) - startLine;
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
      await readme.writeAsString(newLines.join('\n'));
    }
  }
}

class Example {
  final File file;
  final String name;
  final List<String> content;
  final LineRange lineRange;

  Example({
    required this.file,
    required this.name,
    required this.content,
    required this.lineRange,
  });
}

class LineRange {
  final int startLine;
  final int? endLine;

  LineRange(this.startLine, this.endLine);
}

Future<List<LineRange>> findLineRanges(
  List<String> lines,
  RegExp startRegExp,
  RegExp endRegExp, {
  bool endOptional = false,
}) async {
  final List<LineRange> examples = [];
  int? index = 0;
  while (index != null) {
    int? _startIndex;
    int? _endIndex;
    for (int i = index; i < lines.length; i++) {
      final _matchesStart = startRegExp.hasMatch(lines[i]);
      if (_startIndex == null && _matchesStart) {
        _startIndex = i;
      } else if (endOptional && _matchesStart) {
        break;
      } else if (_startIndex != null && endRegExp.hasMatch(lines[i])) {
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
