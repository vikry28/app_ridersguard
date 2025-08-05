// ignore_for_file: avoid_print

import 'dart:io';

void main(List<String> arguments) {
  if (arguments.isEmpty) {
    print(
        '❌ Harap masukkan path modul.\nContoh: dart run tool/create_module.dart general/profile');
    exit(1);
  }

  final hasTest = arguments.contains('--with-test');
  final rawPath = arguments.first.trim().replaceAll('\\', '/');
  final segments = rawPath.split('/');
  final moduleName = segments.last;
  final modulePath = segments.sublist(0, segments.length - 1).join('/');
  final fullPath = modulePath.isEmpty ? moduleName : '$modulePath/$moduleName';

  final snakeCase = _toSnakeCase(moduleName);
  final pascalCase = _toPascalCase(moduleName);
  final baseDir = 'lib/module/$fullPath';

  final structure = {
    'view/${snakeCase}_view.dart': _viewTemplate(snakeCase, pascalCase),
    'viewmodel/${snakeCase}_view_model.dart': _viewModelTemplate(pascalCase),
    'model/${snakeCase}_model.dart': _modelTemplate(pascalCase),
    'api/${snakeCase}_api.dart': _apiTemplate(pascalCase),
  };

  if (hasTest) {
    final testPath = 'test/module/$fullPath';
    structure['../../$testPath/viewmodel/${snakeCase}_view_model_test.dart'] =
        _viewModelTestTemplate(fullPath, pascalCase);
    structure['../../$testPath/view/${snakeCase}_view_test.dart'] =
        _viewWidgetTestTemplate(fullPath, snakeCase, pascalCase);
  }

  for (final entry in structure.entries) {
    final filePath = '$baseDir/${entry.key}';
    final file = File(filePath);
    file.createSync(recursive: true);
    file.writeAsStringSync(entry.value);

    // Replace placeholder in test imports
    if (filePath.contains('_view_model_test.dart') ||
        filePath.contains('_view_test.dart')) {
      final corrected = file
          .readAsStringSync()
          .replaceAll('module/.../', 'module/$fullPath/');
      file.writeAsStringSync(corrected);
    }

    print('✅ Created: $filePath');
  }

  appendRouteToRouter(fullPath, pascalCase);
  print('\n🎉 Modul "$fullPath" berhasil dibuat!');
}

// --- Helpers ---

String _toPascalCase(String input) {
  return input
      .split(RegExp(r'[_\-/\s]'))
      .map((word) =>
          word.isNotEmpty ? '${word[0].toUpperCase()}${word.substring(1)}' : '')
      .join();
}

String _toSnakeCase(String input) {
  return input
      .replaceAllMapped(
          RegExp(r'[A-Z]'), (match) => '_${match.group(0)!.toLowerCase()}')
      .replaceFirst(RegExp(r'^_'), '')
      .toLowerCase();
}

// --- Templates ---

String _viewTemplate(String snake, String pascal) => '''
import 'package:flutter/material.dart';
import 'package:app_riderguard/core/base/base_view.dart';
import '../viewmodel/${snake}_view_model.dart';

class ${pascal}View extends StatelessWidget {
  const ${pascal}View({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView<${pascal}ViewModel>(
      viewModelBuilder: () => ${pascal}ViewModel(),
      onModelReady: (vm) => vm.init(),
      builder: (context, viewModel, ref) {
        return Scaffold(
          appBar: AppBar(title: const Text('$pascal')),
          body: const Center(child: Text('$pascal Page')),
        );
      },
    );
  }
}
''';

String _viewModelTemplate(String pascal) => '''
import 'package:app_riderguard/core/base/view_model_base.dart';

class ${pascal}ViewModel extends ViewModelBase {
  @override
  Future<void> init() async {
    // TODO: implement init
  }
}
''';

String _modelTemplate(String pascal) => '''
class ${pascal}Model {
  final int id;
  final String name;

  ${pascal}Model({required this.id, required this.name});

  factory ${pascal}Model.fromJson(Map<String, dynamic> json) {
    return ${pascal}Model(
      id: json['id'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
      };
}
''';

String _apiTemplate(String pascal) => '''
import '../model/${_toSnakeCase(pascal)}_model.dart';

class ${pascal}Api extends ApiBase {
  Future<List<${pascal}Model>> fetch${pascal}s() async {
    await Future.delayed(const Duration(seconds: 1));
    return [${pascal}Model(id: 1, name: 'Contoh')];
  }
}
''';

String _viewModelTestTemplate(String path, String pascal) => '''
import 'package:flutter_test/flutter_test.dart';
import 'package:app_riderguard/module/.../viewmodel/${_toSnakeCase(pascal)}_view_model.dart';

void main() {
  group('${pascal}ViewModel', () {
    late ${pascal}ViewModel viewModel;

    setUp(() {
      viewModel = ${pascal}ViewModel();
    });

    test('should initialize correctly', () async {
      await viewModel.init();
    });
  });
}
''';

String _viewWidgetTestTemplate(String path, String snake, String pascal) => '''
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:app_riderguard/module/.../view/${snake}_view.dart';

void main() {
  testWidgets('${pascal}View renders correctly', (tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: MaterialApp(
          home: ${pascal}View(),
        ),
      ),
    );

    expect(find.text('$pascal Page'), findsOneWidget);
  });
}
''';

// --- Append Route ---

void appendRouteToRouter(String fullPath, String pascalCase) {
  final routerPath = 'lib/router/app_router.dart';
  final file = File(routerPath);

  if (!file.existsSync()) {
    print('⚠️  File app_router.dart tidak ditemukan.');
    return;
  }

  final content = file.readAsStringSync();
  final segments = fullPath.split('/');
  final routePath = '/${segments.join('/')}';

  final importPath =
      'package:app_riderguard/module/$fullPath/view/${segments.last}_view.dart';
  final importStatement = "import '$importPath';";
  final newRoute = '''
      GoRoute(
        path: '$routePath',
        builder: (context, state) => const ${pascalCase}View(),
      ),''';

  if (content.contains(importStatement) ||
      content.contains("path: '$routePath'")) {
    print('⚠️  Route atau import untuk "$routePath" sudah ada.');
    return;
  }

  // 🟢 Tambahkan import sebelum baris pertama 'import package:go_router/go_router.dart';
  final importInserted = content.replaceFirstMapped(
    RegExp(r"(import\s+'package:go_router/go_router\.dart';)"),
    (match) => "$importStatement\n${match.group(0)}",
  );

  // 🟢 Tambahkan GoRoute ke dalam routes utama GoRouter
  final updatedRoutes = importInserted.replaceFirstMapped(
    RegExp(r'routes:\s*\[\s*((?:.|\s)*?)\n\s*\]', multiLine: true),
    (match) {
      final existingRoutes = match.group(1);
      return 'routes: [\n$existingRoutes\n$newRoute\n  ]';
    },
  );

  file.writeAsStringSync(updatedRoutes);
  print('✅ Route $routePath ditambahkan ke app_router.dart');
}
