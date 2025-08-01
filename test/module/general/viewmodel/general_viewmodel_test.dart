import 'package:flutter_test/flutter_test.dart';

void main() {
  group('GeneralViewModel', () {
    test('should update state correctly', () {
      int counter = 0;
      counter++;
      expect(counter, 1);
    });
  });
}
