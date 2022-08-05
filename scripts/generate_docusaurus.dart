import 'dart:io';

void main() async {
  final directories = [
    'main',
    'leto',
    'leto_schema',
    'leto_generator',
    'leto_shelf',
  ];

  for (final dirname in directories) {
    final rootReadme = File('${dirname == 'main' ? '.' : dirname}/README.md');
    final outDirectory = Directory('./docusaurus/docs/$dirname');

    await outDirectory.create();
    final lines = await rootReadme.readAsLines();

    final sections = <Section>[];
    final headers = <String, int>{};
    final allInnerLinks = <int>[];
    final _uriChars = RegExp('[${uriChars.join()}]');
    int? previousSectionTitle;
    int i = 0;
    bool inCodeSection = false;
    final innerLinkRegExp = RegExp(r'\[(.*)\]\(#([^\)]+)\)');
    for (final line in lines) {
      if (line.startsWith('#') && !inCodeSection) {
        final title =
            cleanTitle(line).replaceAll(_uriChars, '').replaceAll(r'\_', '_');
        int num = 1;
        String titleMapped = title;
        while (headers.containsKey(titleMapped)) {
          titleMapped = '$title-${num++}';
        }
        headers[titleMapped] = sections.length;
      }
      if (innerLinkRegExp.hasMatch(line)) {
        allInnerLinks.add(i);
      }

      if (line.startsWith('# ') && !inCodeSection) {
        if (previousSectionTitle != null) {
          sections.add(
            Section(
              allLines: lines,
              start: previousSectionTitle,
              end: i,
            ),
          );
        }

        previousSectionTitle = i;
      } else if (line.startsWith('```')) {
        inCodeSection = !inCodeSection;
      }
      i++;
    }
    if (previousSectionTitle != null) {
      sections.add(
        Section(
          allLines: lines,
          start: previousSectionTitle,
          end: i,
        ),
      );
    }

    for (final linkLine in allInnerLinks) {
      final newLine =
          lines[linkLine].replaceAllMapped(innerLinkRegExp, (match) {
        final ref = match.group(2)!;
        if (!headers.containsKey(ref)) {
          throw Exception('ref $ref $headers line ${lines[linkLine]}');
        }
        final sectionIndex = headers[ref]!;
        final path = sections[sectionIndex].title;
        return '[${match.group(1)}]($path#$ref)';
      });
      lines[linkLine] = newLine;
    }

    final categoryFile = File(
      '${outDirectory.path}${Platform.pathSeparator}_category_.json',
    );
    await categoryFile.create();

// "link.description",
// "label",
// "collapsible": true,
// "collapsed": false,
// "className": "red",
// "link.title",
    await categoryFile.writeAsString('''
{
  "position": ${directories.indexOf(dirname) + 4},
  "link": {
    "type": "generated-index"
  }
}
''');

    i = 0;
    for (final section in sections) {
      i++;
      final file = File(
        '${outDirectory.path}${Platform.pathSeparator}${section.title}.md',
      );
      final tags = section.tags;

      await file.create();

// id
// slug: greetings
// title: Greetings!
// sidebar_label: Easy
// sidebar_class_name: green
      await file.writeAsString([
        '''
---
sidebar_position: $i
${tags.isEmpty ? '' : 'tags: $tags'}
---
''',
        section.lines.first.replaceAll(RegExp(r'<!--.*-->'), ''),
      ].followedBy(section.lines.skip(1)).join('\n'));
    }
  }
}

final linkRegExp = RegExp(r'\[(.*)\]\(([^\)]+)\)');

String cleanTitle(String value) {
  return value
      .replaceAllMapped(
        linkRegExp,
        (match) => match.group(1)!,
      )
      .replaceFirst(RegExp(r'#+\s+'), '')
      .replaceAll(RegExp(r'<!--.*-->|[\(\)]'), '')
      .trim()
      .replaceAll(RegExp(r'(\s*\-\s*)|\s+'), '-')
      .toLowerCase();
}

class Section {
  final List<String> allLines;
  final int start;
  final int end;

  Iterable<String> get lines =>
      Iterable.generate(end - start, (index) => allLines[index + start]);

  late final String title = cleanTitle(lines.first);

  static final tagStartRegExp = RegExp(r'<!--\s*tags:');

  List<String> get tags {
    final index = lines.first.indexOf(tagStartRegExp);
    if (index == -1) return [];
    final indexEnd = lines.first.indexOf('-->', index);
    return indexEnd == -1
        ? []
        : lines.first
            .substring(index, indexEnd)
            .replaceFirst(tagStartRegExp, '')
            .split(',')
            .map((e) => e.trim())
            .toList();
  }

  late final Map<String, String> config = Map.fromEntries(
    RegExp(r'<!--\s*docusaurus\{(.*)\}\s*-->')
            .firstMatch(lines.first)
            ?.group(1)
            ?.split(',')
            .map((e) {
          final split = e.split(':');
          return MapEntry(split.first, split.last);
        }) ??
        const [],
  );

  Section({
    required this.allLines,
    required this.start,
    required this.end,
  });
}

// final allEntities = await Directory.current.list(
//   followLinks: false,
//   recursive: true,
// ).where((entity) {
//   if (entity is File && entity.path.endsWith('README.md')) {
//     if (entity.parent.uri.pathSegments.last != 'generated_docs' &&
//         !entity.uri.pathSegments.contains('docusaurus')) {
//       return true;
//     }
//   }
//   return false;
// }).cast<File>().toList();

final uriChars = const [
  ':',
  '/',
  '?',
  '#',
  '\\[',
  '\\]',
  '@',
  '!',
  '\$',
  '&',
  "'",
  '\\(',
  '\\)',
  '\\*',
  '\\+',
  ',',
  ';',
  '=',
  '%',
  '\\.'
      '`',
  '"',
];
