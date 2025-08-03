import 'package:logger/logger.dart';

final logger = Logger(
  printer: PrettyPrinter(
    methodCount: 2,
    errorMethodCount: 5,
    lineLength: 120,
    colors: true,
    printEmojis: true,
  ),
  output: SinglePrintOutput(),
);

class SinglePrintOutput extends LogOutput {
  @override
  void output(OutputEvent event) {
    for (var line in event.lines) {
      // Hanya cetak sekali
      // ignore: avoid_print
      print(line);
    }
  }
}
