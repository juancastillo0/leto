import 'dart:convert';
import 'dart:io';

void main() async {
  final directories = [
    'main',
    'leto',
    'leto_schema',
    'leto_generator',
    'leto_shelf',
  ];
  const globalDir = ''; // 'global/';
  final List<Category> categories = [];

  await Directory('./docusaurus/docs').create();

  for (final dirname in directories) {
    final rootReadme = File('${dirname == 'main' ? '.' : dirname}/README.md');
    final outDirectory = Directory('./docusaurus/docs/$dirname');
    final lines = await rootReadme.readAsLines();
    final sections = <Section>[];
    final headers = <String, MapEntry<int?, int>>{};
    final allInnerLinks = <int>[];
    final _uriChars = RegExp('[${uriChars.join()}]');
    int? previousSectionTitle;
    int i = 0;
    bool isGlobal = false;

    void _addSection() {
      if (previousSectionTitle != null) {
        final section = Section(
          allLines: lines,
          start: previousSectionTitle!,
          end: i,
        );
        final isSubtitle = section.lines.first.startsWith('##');
        if (isGlobal && (categories.last.sections.isEmpty || isSubtitle)) {
          if (isSubtitle) {
            lines[section.start] = lines[section.start].substring(1);
          }
          categories.last.sections.add(section);
          isGlobal = lines[i].startsWith('##') ||
              section.isGlobal ||
              Section(allLines: lines, start: i, end: i + 1).isGlobal;
        } else {
          sections.add(section);

          final globalSection = i != lines.length
              ? Section(allLines: lines, start: i, end: i + 1)
              : null;
          isGlobal = i != lines.length && globalSection!.isGlobal;
          if (isGlobal) {
            categories.add(Category(
              directoryPath:
                  './docusaurus/docs/$globalDir${globalSection!.title}',
              position: categories.length + 4,
              sections: [],
              label: globalSection.lines.first
                  .substring(1)
                  .replaceAll(RegExp(r'<!--.*-->'), '')
                  .trim(),
            ));
          }
        }
      }
      previousSectionTitle = i;
    }

    bool inCodeSection = false;
    final innerLinkRegExp = RegExp(r'\[(.*)\]\(#([^\)]+)\)');
    while (i < lines.length) {
      final line = lines[i];

      if (innerLinkRegExp.hasMatch(line)) {
        allInnerLinks.add(i);
      }

      if ((line.startsWith('# ') || isGlobal && line.startsWith('## ')) &&
          !inCodeSection) {
        _addSection();
      } else if (line.startsWith('```')) {
        inCodeSection = !inCodeSection;
      }

      if (line.startsWith('#') && !inCodeSection) {
        final title =
            cleanTitle(line).replaceAll(_uriChars, '').replaceAll(r'\_', '_');
        int num = 1;
        String titleMapped = title;
        while (headers.containsKey(titleMapped)) {
          titleMapped = '$title-${num++}';
        }
        final _sections = isGlobal ? categories.last.sections : sections;
        headers[titleMapped] = MapEntry(
          isGlobal ? categories.length - 1 : null,
          _sections.length,
        );
      }
      i++;
    }
    _addSection();

    for (final linkLine in allInnerLinks) {
      final newLine =
          lines[linkLine].replaceAllMapped(innerLinkRegExp, (match) {
        final ref = match.group(2)!;
        if (!headers.containsKey(ref)) {
          throw Exception('ref $ref $headers line ${lines[linkLine]}');
        }
        final pos = headers[ref]!;
        final sIndex = pos.value;

        final String path;
        if (pos.key == null) {
          final sectionPath =
              sections[sIndex < sections.length ? sIndex : sIndex - 1].title;
          path = '$sectionPath.md${ref != sectionPath ? '#$ref' : ''}';
        } else {
          final category = categories[pos.key!];
          final sections = category.sections;
          final sTitle =
              sections[sIndex < sections.length ? sIndex : sIndex - 1].title;
          if (sTitle == category.directoryName) {
            // It's a global category
            path = '../category/$globalDir${category.directoryName}';
          } else {
            // Relative path to the md file (https://docusaurus.io/docs/markdown-features/links)
            path = '../$globalDir${category.directoryName}/${sTitle}.md'
                '${ref != sTitle ? '#$ref' : ''}';
          }
        }
        return '[${match.group(1)}]($path)';
      });
      lines[linkLine] = newLine;
    }

    categories.add(Category(
      directoryPath: outDirectory.path,
      position: categories.length + 4,
      sections: sections,
      title: dirname == 'main' ? 'Main Documentation' : null,
      description: dirname == 'main'
          ? 'In this section you will find most of the documentation for the external APIs,'
              ' functionalities, examples, utilities and integrations.'
              ' However, you may also find useful the documentation, code'
              ' and tests of the external and internal APIs for each'
              ' package on the sidebar. These include packages for execution (leto),'
              ' schema creation (leto_schema), code generation (leto_generator)'
              ' and shelf web server integration (leto_shelf).'
          : null,
    ));
  }

  await Future.wait(categories.map(writeCategory));
}

class Category {
  final String directoryPath;
  final int position;
  final List<Section> sections;
  final String? label;
  final String? description;
  final String? title;
  String get directoryName => directoryPath.split(Platform.pathSeparator).last;

  String get descriptionOrDefault =>
      description ??
      sections.first.lines
          .where((e) => !e.startsWith(RegExp(r'\[!|#')))
          .take(6)
          .join('\n');

  Category({
    required this.directoryPath,
    required this.position,
    required this.sections,
    this.label,
    this.description,
    this.title,
  });
}

Future<void> writeCategory(Category category) async {
  print(
    'writeCategory directoryPath: "${category.directoryPath}", position: ${category.position}'
    ', sections: "${category.sections.map((e) => e.title).join('", "')}"',
  );
  final outDirectory = Directory(category.directoryPath);
  if (await outDirectory.exists()) {
    await outDirectory.delete(recursive: true);
  }
  await outDirectory.create();

  final categoryFile = File(
    '${category.directoryPath}${Platform.pathSeparator}_category_.json',
  );
  await categoryFile.create();

// "label",
// "collapsible": true,
// "collapsed": false,
// "className": "red",
// "link.title",
// "link.description",
  await categoryFile.writeAsString(prettyPrintJson({
    "label": category.label,
    "position": category.position,
    "link": {
      "title": category.title,
      "description": category.descriptionOrDefault,
      "type": "generated-index"
    }
  }));

  int i = 0;
  for (final section in category.sections) {
    i++;
    final file = File(
      '${category.directoryPath}${Platform.pathSeparator}${section.title}.md',
    );
    final tags = section.tags;

    await file.create();

// https://docusaurus.io/docs/api/plugins/@docusaurus/plugin-content-docs#markdown-front-matter
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

String prettyPrintJson(Map<String, Object?> map) {
  return jsonEncode(cleanMapNulls(map))
      .replaceAll(',"', ',\n"')
      .replaceAll('":{"', '":{\n\t"');
}

Map<String, Object?> cleanMapNulls(Map<String, Object?> map) {
  return map
    ..removeWhere((key, value) {
      if (value is Map<String, Object?>) cleanMapNulls(value);
      return value == null;
    });
}

Map<String, Object?> parseConfig(String title) {
  final jsonValue =
      RegExp(r'<!--\s*docusaurus\{(.*)\}\s*-->').firstMatch(title)?.group(1);
  final value = jsonDecode('{${jsonValue ?? ''}}');
  return value as Map<String, Object?>;
}

class Section {
  final List<String> allLines;
  final int start;
  final int end;

  Iterable<String> get lines =>
      Iterable.generate(end - start, (index) => allLines[index + start]);

  late final String title = cleanTitle(lines.first);

  List<String> get tags => (config['tags'] as List? ?? const []).cast();
  bool get isGlobal => config['global'] == true;

  late final Map<String, Object?> config = parseConfig(lines.first);

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

const uriChars = [
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
  // these are not special uri chars
  '\\.'
      '`',
  '"',
];
