class NotificationModel {
  final int id;
  final String title;
  final String content;
  final String createdAt;
  final String imageUrl;

  NotificationModel({
    required this.id,
    required this.title,
    required this.content,
    required this.createdAt,
    required this.imageUrl,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['id'],
      title: json['title'],
      content: json['content'],
      imageUrl: json['imageUrl'],
      createdAt: json['createdAt'],
    );
  }
}
