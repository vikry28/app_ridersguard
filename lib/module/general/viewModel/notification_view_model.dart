import 'package:app_riderguard/core/base/view_model_base.dart';
import 'package:app_riderguard/module/general/model/notification_item.dart';

class NotificationViewModel extends ViewModelBase {
  final List<NotificationItem> _allNotifications = [];

  Map<String, List<NotificationItem>> groupedNotifications = {};

  @override
  Future<void> init() async {
    await _loadDummyNotifications();
    _groupByYear();
    notifyListeners();
  }

  Future<void> _loadDummyNotifications() async {
    _allNotifications.addAll([
      NotificationItem(
        id: '1',
        title: 'RiderGuard mengucapkan Selamat Idul Fitri 1446 H',
        content:
            'Mohon maaf lahir dan batin. Semoga keselamatan dan berkah menyertai perjalanan Anda di hari yang Fitri.',
        date: DateTime(2025, 3, 31, 5, 56),
      ),
      NotificationItem(
        id: '2',
        title: 'Pembaruan Kebijakan Keamanan RiderGuard',
        content:
            'Kami telah memperbarui sistem keamanan untuk meningkatkan perlindungan data dan pengalaman pengguna Anda.',
        date: DateTime(2025, 1, 2, 9, 16),
      ),
      NotificationItem(
        id: '3',
        title: 'Pemberitahuan Sistem Pemeliharaan',
        content:
            'Yth. Pengguna RiderGuard, pemeliharaan sistem akan dilakukan pada 15 Februari 2024 pukul 00.00 - 03.00 WIB.',
        date: DateTime(2024, 2, 14, 23, 52),
        isRead: true,
      ),
      NotificationItem(
        id: '5',
        title: 'Informasi Pemeliharaan Aplikasi',
        content:
            'Peningkatan performa sistem RiderGuard akan dilakukan malam ini. Beberapa fitur mungkin tidak tersedia sementara.',
        date: DateTime(2024, 6, 12, 0, 0),
      ),
      NotificationItem(
        id: '6',
        title: 'Waspada Penipuan Mengatasnamakan RiderGuard',
        content:
            'Harap waspada terhadap pihak yang mengaku dari RiderGuard dan meminta data pribadi Anda.',
        date: DateTime(2024, 5, 3, 0, 0),
      ),
      NotificationItem(
        id: '7',
        title: 'Pembaruan Fitur Aplikasi RiderGuard',
        content:
            'Kini Anda dapat melacak riwayat perjalanan dan status pengemudi secara real-time dengan fitur terbaru kami!',
        date: DateTime(2024, 2, 22, 0, 0),
        isRead: true,
      ),
    ]);
  }

  void _groupByYear() {
    groupedNotifications = {};
    for (var notif in _allNotifications) {
      final year = notif.date.year;
      final key = year == DateTime.now().year ? 'This Year' : 'Last Year';

      groupedNotifications.putIfAbsent(key, () => []).add(notif);
    }
  }
}
