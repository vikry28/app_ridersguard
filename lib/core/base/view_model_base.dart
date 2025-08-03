import 'package:flutter/foundation.dart';

abstract class ViewModelBase extends ChangeNotifier {
  bool _isLoading = false;
  bool _initialized = false;

  bool get isLoading => _isLoading;
  bool get isInitialized => _initialized;

  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Future<void> init() async {
    _initialized = true;
  }
}
