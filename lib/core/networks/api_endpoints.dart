enum Environment { dev, prod }

class ApiEndpoints {
  /// Base URLs for different environments Api
  static const _devBaseUrl = 'https://dev-api-bikersguard.up.railway.app/api';
  static const _prodBaseUrl = 'https://api.example.com';

  static Environment environment = Environment.dev;

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
  static const logout = '/auth/logout';
  static const verify = '/auth/verify';
  static const resendcode = '/auth/resend-code';
  static const deleteaccount = '/auth/delete';
  static const getMe = '/users/me';
  static const updateFoto = '/users/update-photo';
  static const updateProfile = '/users/update-profile';
  // Tambahkan endpoint lainnya...
}
