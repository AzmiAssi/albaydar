// ignore_for_file: file_names

import 'dart:convert';

import 'package:flutter/foundation.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first

class Products {
  int productId;
  int categoryId;
  int unitId;
  double rate;
  String productName;
  String productArabicName;
  String productDescription;
  String productArabicDescription;
  String productImage;
  double productPrice;
  List<dynamic> imgesBase64;
  bool status;
  bool isTop;
  String imageExt;
  bool isFavorite;
  int quantity;
  Products({
    required this.productId,
    required this.categoryId,
    required this.unitId,
    required this.rate,
    required this.productName,
    required this.productArabicName,
    required this.productDescription,
    required this.productArabicDescription,
    required this.productImage,
    required this.productPrice,
    required this.imgesBase64,
    required this.status,
    required this.isTop,
    required this.imageExt,
    required this.isFavorite,
    required this.quantity,
  });

  Products copyWith({
    int? productId,
    int? categoryId,
    int? unitId,
    double? rate,
    String? productName,
    String? productArabicName,
    String? productDescription,
    String? productArabicDescription,
    String? productImage,
    double? productPrice,
    List<dynamic>? imgesBase64,
    bool? status,
    bool? isTop,
    String? imageExt,
    bool? isFavorite,
    int? quantity,
  }) {
    return Products(
      productId: productId ?? this.productId,
      categoryId: categoryId ?? this.categoryId,
      unitId: unitId ?? this.unitId,
      rate: rate ?? this.rate,
      productName: productName ?? this.productName,
      productArabicName: productArabicName ?? this.productArabicName,
      productDescription: productDescription ?? this.productDescription,
      productArabicDescription:
          productArabicDescription ?? this.productArabicDescription,
      productImage: productImage ?? this.productImage,
      productPrice: productPrice ?? this.productPrice,
      imgesBase64: imgesBase64 ?? this.imgesBase64,
      status: status ?? this.status,
      isTop: isTop ?? this.isTop,
      imageExt: imageExt ?? this.imageExt,
      isFavorite: isFavorite ?? this.isFavorite,
      quantity: quantity ?? this.quantity,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'productId': productId,
      'categoryId': categoryId,
      'unitId': unitId,
      'rate': rate,
      'productName': productName,
      'productArabicName': productArabicName,
      'productDescription': productDescription,
      'productArabicDescription': productArabicDescription,
      'productImage': productImage,
      'productPrice': productPrice,
      'imgesBase64': imgesBase64,
      'status': status,
      'isTop': isTop,
      'imageExt': imageExt,
      'isFavorite': isFavorite,
      'quantity': quantity,
    };
  }

  factory Products.fromMap(Map<String, dynamic> map) {
    return Products(
      productId: map['productId'] as int,
      categoryId: map['categoryId'] as int,
      unitId: map['unitId'] as int,
      rate: map['rate'] as double,
      productName: map['productName'] as String,
      productArabicName: map['productArabicName'] as String,
      productDescription: map['productDescription'] as String,
      productArabicDescription: map['productArabicDescription'] as String,
      productImage: map['productImage'] as String,
      productPrice: map['productPrice'] as double,
      imgesBase64: List<dynamic>.from((map['imgesBase64'] as List<dynamic>)),
      status: map['status'] as bool,
      isTop: map['isTop'] as bool,
      imageExt: map['imageExt'] as String,
      isFavorite: map['isFavorite'] as bool,
      quantity: map['quantity'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory Products.fromJson(String source) =>
      Products.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Products(productId: $productId, categoryId: $categoryId, unitId: $unitId, rate: $rate, productName: $productName, productArabicName: $productArabicName, productDescription: $productDescription, productArabicDescription: $productArabicDescription, productImage: $productImage, productPrice: $productPrice, imgesBase64: $imgesBase64, status: $status, isTop: $isTop, imageExt: $imageExt, isFavorite: $isFavorite, quantity: $quantity)';
  }

  @override
  bool operator ==(covariant Products other) {
    if (identical(this, other)) return true;

    return other.productId == productId &&
        other.categoryId == categoryId &&
        other.unitId == unitId &&
        other.rate == rate &&
        other.productName == productName &&
        other.productArabicName == productArabicName &&
        other.productDescription == productDescription &&
        other.productArabicDescription == productArabicDescription &&
        other.productImage == productImage &&
        other.productPrice == productPrice &&
        listEquals(other.imgesBase64, imgesBase64) &&
        other.status == status &&
        other.isTop == isTop &&
        other.imageExt == imageExt &&
        other.isFavorite == isFavorite &&
        other.quantity == quantity;
  }

  @override
  int get hashCode {
    return productId.hashCode ^
        categoryId.hashCode ^
        unitId.hashCode ^
        rate.hashCode ^
        productName.hashCode ^
        productArabicName.hashCode ^
        productDescription.hashCode ^
        productArabicDescription.hashCode ^
        productImage.hashCode ^
        productPrice.hashCode ^
        imgesBase64.hashCode ^
        status.hashCode ^
        isTop.hashCode ^
        imageExt.hashCode ^
        isFavorite.hashCode ^
        quantity.hashCode;
  }
}
