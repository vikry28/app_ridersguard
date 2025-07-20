#!/bin/bash

MODULE=$1

if [ -z "$MODULE" ]; then
  echo "❌ Mohon masukkan nama module. Contoh: ./generate_test_module.sh home"
  exit 1
fi

CAPITALIZED=$(echo "$MODULE" | awk '{print toupper(substr($0,1,1)) substr($0,2)}')

mkdir -p test/module/$MODULE/{api,model,view,viewmodel}

# ======= API =======
cat > test/module/$MODULE/api/${MODULE}_api_test.dart <<EOF
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('${CAPITALIZED}Api', () {
    test('should return success response', () async {
      // TODO: implement API test
      expect(true, isTrue);
    });
  });
}
EOF

# ======= MODEL =======
cat > test/module/$MODULE/model/${MODULE}_model_test.dart <<EOF
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('${CAPITALIZED}Model', () {
    test('should parse from JSON', () {
      // TODO: implement model JSON test
      final json = {"id": 1, "name": "Test"};
      // final model = ${CAPITALIZED}Model.fromJson(json);
      expect(json['id'], 1);
    });
  });
}
EOF

# ======= VIEW =======
cat > test/module/$MODULE/view/${MODULE}_view_test.dart <<EOF
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';

void main() {
  testWidgets('${CAPITALIZED}View renders correctly', (WidgetTester tester) async {
    // TODO: implement view widget test
    await tester.pumpWidget(const MaterialApp(
      home: Scaffold(body: Text('Sample')),
    ));
    expect(find.text('Sample'), findsOneWidget);
  });
}
EOF

# ======= VIEWMODEL =======
cat > test/module/$MODULE/viewmodel/${MODULE}_viewmodel_test.dart <<EOF
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('${CAPITALIZED}ViewModel', () {
    test('should update state correctly', () {
      // TODO: implement ViewModel test
      int counter = 0;
      counter++;
      expect(counter, 1);
    });
  });
}
EOF

echo "✅ Test folder dan isi unit test untuk module '$MODULE' berhasil dibuat."
