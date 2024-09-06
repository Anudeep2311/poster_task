import 'package:cloud_firestore/cloud_firestore.dart';

class TemplateModel {
  final String id;
  final String name;
  final String imageUrl;

  TemplateModel({required this.id, required this.name, required this.imageUrl});

  factory TemplateModel.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map<String, dynamic>;
    return TemplateModel(
      id: doc.id,
      name: data['name'] ?? '',
      imageUrl: data['imageUrl'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'imageUrl': imageUrl,
    };
  }
}
