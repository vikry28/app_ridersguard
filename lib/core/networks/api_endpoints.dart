enum Environment { dev, prod }

class ApiEndpoints {
  /// Base URLs for different environments Api
  static const _devBaseUrl = 'https://dev-api.example.com';
  static const _prodBaseUrl = 'https://api.example.com';

  static Environment environment = Environment.dev; // Ubah ini saat build

  static String get baseUrl {
    switch (environment) {
      case Environment.prod:
        return _prodBaseUrl;
      case Environment.dev:
        return _devBaseUrl;
    }
  }

  // Endpoint paths
  static const login = '/auth/login';
  static const register = '/auth/register';
  // Tambahkan endpoint lainnya...
}
