import 'package:gdsc_2024/model/category.dart';
import 'package:intl/intl.dart';

class Post {
  final int id;
  final String title;
  final String content;
  final Category categoryDto;
  final String imageUrl;
  final String createdAt;

  Post({
    required this.id,
    required this.title,
    required this.categoryDto,
    required this.content,
    required this.imageUrl,
    required this.createdAt,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      categoryDto: Category.fromJson(json['categoryDto']),
      content: json['content'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
      createdAt: json['createdAt'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'categoryDto': categoryDto.toJson(),
      'imageUrl': imageUrl,
      'createdAt': createdAt,
    };
  }
}
