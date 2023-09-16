// ignore_for_file: public_member_api_docs, sort_constructors_first, file_names
import 'dart:convert';

class Contact {
  int? aboutId;
  String? aboutTitle;
  String? description;
  String? aboutLink;
  String? titleArabic;
  String? descriptionArabic;
  String? facebookLink;
  String? instagramLink;
  String? phoneNumber;
  Contact({
    this.aboutId,
    this.aboutTitle,
    this.description,
    this.aboutLink,
    this.titleArabic,
    this.descriptionArabic,
    this.facebookLink,
    this.instagramLink,
    this.phoneNumber,
  });

  Contact copyWith({
    int? aboutId,
    String? aboutTitle,
    String? description,
    String? aboutLink,
    String? titleArabic,
    String? descriptionArabic,
    String? facebookLink,
    String? instagramLink,
    String? phoneNumber,
  }) {
    return Contact(
      aboutId: aboutId ?? this.aboutId,
      aboutTitle: aboutTitle ?? this.aboutTitle,
      description: description ?? this.description,
      aboutLink: aboutLink ?? this.aboutLink,
      titleArabic: titleArabic ?? this.titleArabic,
      descriptionArabic: descriptionArabic ?? this.descriptionArabic,
      facebookLink: facebookLink ?? this.facebookLink,
      instagramLink: instagramLink ?? this.instagramLink,
      phoneNumber: phoneNumber ?? this.phoneNumber,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'aboutId': aboutId,
      'aboutTitle': aboutTitle,
      'description': description,
      'aboutLink': aboutLink,
      'titleArabic': titleArabic,
      'descriptionArabic': descriptionArabic,
      'facebookLink': facebookLink,
      'instagramLink': instagramLink,
      'phoneNumber': phoneNumber,
    };
  }

  factory Contact.fromMap(Map<String, dynamic> map) {
    return Contact(
      aboutId: map['aboutId'] != null ? map['aboutId'] as int : null,
      aboutTitle:
          map['aboutTitle'] != null ? map['aboutTitle'] as String : null,
      description:
          map['description'] != null ? map['description'] as String : null,
      aboutLink: map['aboutLink'] != null ? map['aboutLink'] as String : null,
      titleArabic:
          map['titleArabic'] != null ? map['titleArabic'] as String : null,
      descriptionArabic: map['descriptionArabic'] != null
          ? map['descriptionArabic'] as String
          : null,
      facebookLink:
          map['facebookLink'] != null ? map['facebookLink'] as String : null,
      instagramLink:
          map['instagramLink'] != null ? map['instagramLink'] as String : null,
      phoneNumber:
          map['phoneNumber'] != null ? map['phoneNumber'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Contact.fromJson(String source) =>
      Contact.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Contact(aboutId: $aboutId, aboutTitle: $aboutTitle, description: $description, aboutLink: $aboutLink, titleArabic: $titleArabic, descriptionArabic: $descriptionArabic, facebookLink: $facebookLink, instagramLink: $instagramLink, phoneNumber: $phoneNumber)';
  }

  @override
  bool operator ==(covariant Contact other) {
    if (identical(this, other)) return true;

    return other.aboutId == aboutId &&
        other.aboutTitle == aboutTitle &&
        other.description == description &&
        other.aboutLink == aboutLink &&
        other.titleArabic == titleArabic &&
        other.descriptionArabic == descriptionArabic &&
        other.facebookLink == facebookLink &&
        other.instagramLink == instagramLink &&
        other.phoneNumber == phoneNumber;
  }

  @override
  int get hashCode {
    return aboutId.hashCode ^
        aboutTitle.hashCode ^
        description.hashCode ^
        aboutLink.hashCode ^
        titleArabic.hashCode ^
        descriptionArabic.hashCode ^
        facebookLink.hashCode ^
        instagramLink.hashCode ^
        phoneNumber.hashCode;
  }
}
