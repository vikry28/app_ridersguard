# 🚀 app_riderguard

A new Flutter project built with **Clean Architecture**, **Riverpod State Management**, and **MVVM pattern**, designed to be modular, scalable, and maintainable.

---

## ✅ Features

- ✅ Riverpod for state management
- ✅ Clean architecture folder structure
- ✅ MVVM pattern with `ViewModelBase` and `BaseView`
- ✅ Global `setLoading()` handling
- ✅ API Base with full HTTP method support (GET, POST, PUT, PATCH, DELETE, Multipart)
- ✅ GetIt for dependency injection
- ✅ Easy localization (Indonesian & English)
- ✅ Theme and custom fonts support
- ✅ Rive animations ready
- ✅ Local storage dengan shared_preferences
- ✅ Logger integration for debug

---

## 📁 Folder Structure

```
lib/
│
├── core/
│   ├── base/         # BaseView, ViewModelBase
│   ├── constants/    # Texts, colors, themes, fonts
│   ├── network/      # API base, endpoints, client handler
│   ├── di/           # Service Locator (GetIt)
│   ├── localization/ # Language support
│   └── utils/        # Logger, formatters, etc
│
├── module/
│   ├── home/
│   │   ├── api/
│   │   ├── model/
│   │   ├── view/
│   │   ├── viewmodel/
│   │
│   └── ... (feature modules)
│
├── routes/app_router.dart   # App routes configuration
│
├── app.dart              # App initialization
└── main.dart             # App entry point
```

---

## 📥 Clone Project

```bash
# Clone project
git clone https://github.com/vikry28/app_ridersguard.git

# Masuk ke folder project
cd app_riderguard

# Gunakan FVM (jika belum, install terlebih dahulu)
dart pub global activate fvm
fvm install 3.32.7
fvm use 3.32.7

# Install semua dependency
fvm flutter pub get

# Jalankan project
fvm flutter run
```

> Pastikan kamu sudah mengatur `FVM` dan `Flutter SDK` di environment kamu sebelum menjalankan perintah di atas.

---

## ⚙️ Installation

```bash
# Make sure FVM is installed
dart pub global activate fvm
fvm install 3.32.7
fvm use 3.32.7

# Install dependencies
fvm flutter pub get
```

---

## 🧪 Testing

Unit testing is encouraged for viewmodel, repository, and network layer.
Struktur project ini cocok untuk pengujian unit test dan widget test. Direkomendasikan:

- ✅ Uji ViewModel menggunakan flutter_test atau mocktail

- ✅ Mocking repository/API layer

- ✅ Buat FakeHttpClient untuk uji API

## 👨‍💻 Author

Created by Vickry Taufik Firmansyah — 2025.

---

## 📜 License

This project is licensed under the MIT License.

---

## 📎 Resources

- [Riverpod Docs](https://riverpod.dev/)
- [Clean Architecture in Flutter](https://medium.com/flutter-community/clean-architecture-fadab03f5d62)
- [Flutter HTTP Package](https://pub.dev/packages/http)
