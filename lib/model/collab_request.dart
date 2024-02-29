import 'package:gdsc_2024/model/collab_form.dart';
import 'package:gdsc_2024/model/user.dart';

class CollabRequest {
  final int id;
  final String fullName;
  final String email;
  final String phone;
  final String address;
  final String tag;
  final String title;
  final String description;
  final String photographicEvidenceUrl;
  final String status;
  final Collab collabDto;
  final User userDto;

  CollabRequest({
    required this.id,
    required this.fullName,
    required this.email,
    required this.phone,
    required this.address,
    required this.tag,
    required this.title,
    required this.description,
    required this.photographicEvidenceUrl,
    required this.status,
    required this.collabDto,
    required this.userDto,
  });

  factory CollabRequest.fromJson(Map<String, dynamic> json) {
    return CollabRequest(
      id: json['id'],
      fullName: json['fullName'],
      email: json['email'],
      phone: json['phone'],
      address: json['address'],
      tag: json['tag'],
      title: json['title'],
      description: json['description'],
      photographicEvidenceUrl: json['photographicEvidenceUrl'],
      status: json['status'],
      collabDto: Collab.fromJson(json['collabDto']),
      userDto: User.fromJson(json['userDto']),
    );
  }
  factory CollabRequest.toJson(Map<String, dynamic> json) {
    return CollabRequest(
      id: json['id'],
      fullName: json['fullName'],
      email: json['email'],
      phone: json['phone'],
      address: json['address'],
      tag: json['tag'],
      title: json['title'],
      description: json['description'],
      photographicEvidenceUrl: json['photographicEvidenceUrl'],
      status: json['status'],
      collabDto: Collab.fromJson(json['collabDto']),
      userDto: User.fromJson(json['userDto']),
    );
  }
}
