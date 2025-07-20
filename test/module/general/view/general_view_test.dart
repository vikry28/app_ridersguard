import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';

void main() {
  testWidgets('GeneralView renders correctly', (WidgetTester tester) async {
    // TODO: implement view widget test
    await tester.pumpWidget(const MaterialApp(
      home: Scaffold(body: Text('Sample')),
    ));
    expect(find.text('Sample'), findsOneWidget);
  });
}
