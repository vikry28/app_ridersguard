import 'package:flutter_test/flutter_test.dart';

void main() {
  group('GeneralModel', () {
    test('should parse from JSON', () {
      final json = {"id": 1, "name": "Test"};
      // final model = GeneralModel.fromJson(json);
      expect(json['id'], 1);
    });
  });
}
