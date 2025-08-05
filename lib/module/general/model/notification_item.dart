class NotificationItem {
  final String id;
  final String title;
  final String content;
  final DateTime date;
  final bool isRead;

  NotificationItem({
    required this.id,
    required this.title,
    required this.content,
    required this.date,
    this.isRead = false,
  });
}
