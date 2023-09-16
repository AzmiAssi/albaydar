// ignore_for_file: public_member_api_docs, sort_constructors_first, non_constant_identifier_names, file_names
import 'dart:convert';

class PaymentTerm {
  int? PaymentId;
  String? PaymentName;
  String? PaymentArabicName;
  bool? PaymentStatus;
  PaymentTerm({
    this.PaymentId,
    this.PaymentName,
    this.PaymentArabicName,
    this.PaymentStatus,
  });

  PaymentTerm copyWith({
    int? PaymentId,
    String? PaymentName,
    String? PaymentArabicName,
    bool? PaymentStatus,
  }) {
    return PaymentTerm(
      PaymentId: PaymentId ?? this.PaymentId,
      PaymentName: PaymentName ?? this.PaymentName,
      PaymentArabicName: PaymentArabicName ?? this.PaymentArabicName,
      PaymentStatus: PaymentStatus ?? this.PaymentStatus,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'PaymentId': PaymentId,
      'PaymentName': PaymentName,
      'PaymentArabicName': PaymentArabicName,
      'PaymentStatus': PaymentStatus,
    };
  }

  factory PaymentTerm.fromMap(Map<String, dynamic> map) {
    return PaymentTerm(
      PaymentId: map['PaymentId'] != null ? map['PaymentId'] as int : null,
      PaymentName:
          map['PaymentName'] != null ? map['PaymentName'] as String : null,
      PaymentArabicName: map['PaymentArabicName'] != null
          ? map['PaymentArabicName'] as String
          : null,
      PaymentStatus:
          map['PaymentStatus'] != null ? map['PaymentStatus'] as bool : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory PaymentTerm.fromJson(String source) =>
      PaymentTerm.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'PaymentTerm(PaymentId: $PaymentId, PaymentName: $PaymentName, PaymentArabicName: $PaymentArabicName, PaymentStatus: $PaymentStatus)';
  }

  @override
  bool operator ==(covariant PaymentTerm other) {
    if (identical(this, other)) return true;

    return other.PaymentId == PaymentId &&
        other.PaymentName == PaymentName &&
        other.PaymentArabicName == PaymentArabicName &&
        other.PaymentStatus == PaymentStatus;
  }

  @override
  int get hashCode {
    return PaymentId.hashCode ^
        PaymentName.hashCode ^
        PaymentArabicName.hashCode ^
        PaymentStatus.hashCode;
  }
}
