// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

// ignore_for_file: file_names

class Category {
  final int categoryId;
  final String categoryName;
  final String categoryImage;
  final String categoryArabicName;
  final String categoryStatus;
  final String imageBase64;

  Category(
    this.categoryId,
    this.categoryName,
    this.categoryImage,
    this.categoryArabicName,
    this.categoryStatus,
    this.imageBase64,
  );

  Category copyWith({
    int? categoryId,
    String? categoryName,
    String? categoryImage,
    String? categoryArabicName,
    String? categoryStatus,
    String? imageBase64,
  }) {
    return Category(
      categoryId ?? this.categoryId,
      categoryName ?? this.categoryName,
      categoryImage ?? this.categoryImage,
      categoryArabicName ?? this.categoryArabicName,
      categoryStatus ?? this.categoryStatus,
      imageBase64 ?? this.imageBase64,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'categoryId': categoryId,
      'categoryName': categoryName,
      'categoryImage': categoryImage,
      'categoryArabicName': categoryArabicName,
      'categoryStatus': categoryStatus,
      'imageBase64': imageBase64,
    };
  }

  factory Category.fromMap(Map<String, dynamic> map) {
    return Category(
      map['categoryId'] as int,
      map['categoryName'] as String,
      map['categoryImage'] as String,
      map['categoryArabicName'] as String,
      map['categoryStatus'] as String,
      map['imageBase64'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Category.fromJson(String source) =>
      Category.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Category(categoryId: $categoryId, categoryName: $categoryName, categoryImage: $categoryImage, categoryArabicName: $categoryArabicName, categoryStatus: $categoryStatus, imageBase64: $imageBase64)';
  }

  @override
  bool operator ==(covariant Category other) {
    if (identical(this, other)) return true;

    return other.categoryId == categoryId &&
        other.categoryName == categoryName &&
        other.categoryImage == categoryImage &&
        other.categoryArabicName == categoryArabicName &&
        other.categoryStatus == categoryStatus &&
        other.imageBase64 == imageBase64;
  }

  @override
  int get hashCode {
    return categoryId.hashCode ^
        categoryName.hashCode ^
        categoryImage.hashCode ^
        categoryArabicName.hashCode ^
        categoryStatus.hashCode ^
        imageBase64.hashCode;
  }
}
