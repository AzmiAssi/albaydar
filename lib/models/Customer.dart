// ignore_for_file: public_member_api_docs, sort_constructors_first, non_constant_identifier_names, file_names
import 'dart:convert';

class Customer {
  int? CustomerId;
  String? CustomerFirstName;
  String? CustomerMiddleName;
  String? CustomerLastName;
  String? CustomerNumber;
  String? CityName;
  String? CityArabicName;
  bool? CustomerStatus;
  String? CustomerEmail;
  String? Token;
  Customer({
    this.CustomerId,
    this.CustomerFirstName,
    this.CustomerMiddleName,
    this.CustomerLastName,
    this.CustomerNumber,
    this.CityName,
    this.CityArabicName,
    this.CustomerStatus,
    this.CustomerEmail,
    this.Token,
  });

  Customer copyWith({
    int? CustomerId,
    String? CustomerFirstName,
    String? CustomerMiddleName,
    String? CustomerLastName,
    String? CustomerNumber,
    String? CityName,
    String? CityArabicName,
    bool? CustomerStatus,
    String? CustomerEmail,
    String? Token,
  }) {
    return Customer(
      CustomerId: CustomerId ?? this.CustomerId,
      CustomerFirstName: CustomerFirstName ?? this.CustomerFirstName,
      CustomerMiddleName: CustomerMiddleName ?? this.CustomerMiddleName,
      CustomerLastName: CustomerLastName ?? this.CustomerLastName,
      CustomerNumber: CustomerNumber ?? this.CustomerNumber,
      CityName: CityName ?? this.CityName,
      CityArabicName: CityArabicName ?? this.CityArabicName,
      CustomerStatus: CustomerStatus ?? this.CustomerStatus,
      CustomerEmail: CustomerEmail ?? this.CustomerEmail,
      Token: Token ?? this.Token,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'CustomerId': CustomerId,
      'CustomerFirstName': CustomerFirstName,
      'CustomerMiddleName': CustomerMiddleName,
      'CustomerLastName': CustomerLastName,
      'CustomerNumber': CustomerNumber,
      'CityName': CityName,
      'CityArabicName': CityArabicName,
      'CustomerStatus': CustomerStatus,
      'CustomerEmail': CustomerEmail,
      'Token': Token,
    };
  }

  factory Customer.fromMap(Map<String, dynamic> map) {
    return Customer(
      CustomerId: map['CustomerId'] != null ? map['CustomerId'] as int : null,
      CustomerFirstName: map['CustomerFirstName'] != null
          ? map['CustomerFirstName'] as String
          : null,
      CustomerMiddleName: map['CustomerMiddleName'] != null
          ? map['CustomerMiddleName'] as String
          : null,
      CustomerLastName: map['CustomerLastName'] != null
          ? map['CustomerLastName'] as String
          : null,
      CustomerNumber: map['CustomerNumber'] != null
          ? map['CustomerNumber'] as String
          : null,
      CityName: map['CityName'] != null ? map['CityName'] as String : null,
      CityArabicName: map['CityArabicName'] != null
          ? map['CityArabicName'] as String
          : null,
      CustomerStatus:
          map['CustomerStatus'] != null ? map['CustomerStatus'] as bool : null,
      CustomerEmail:
          map['CustomerEmail'] != null ? map['CustomerEmail'] as String : null,
      Token: map['Token'] != null ? map['Token'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Customer.fromJson(String source) =>
      Customer.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Customer(CustomerId: $CustomerId, CustomerFirstName: $CustomerFirstName, CustomerMiddleName: $CustomerMiddleName, CustomerLastName: $CustomerLastName, CustomerNumber: $CustomerNumber, CityName: $CityName, CityArabicName: $CityArabicName, CustomerStatus: $CustomerStatus, CustomerEmail: $CustomerEmail, Token: $Token)';
  }

  @override
  bool operator ==(covariant Customer other) {
    if (identical(this, other)) return true;

    return other.CustomerId == CustomerId &&
        other.CustomerFirstName == CustomerFirstName &&
        other.CustomerMiddleName == CustomerMiddleName &&
        other.CustomerLastName == CustomerLastName &&
        other.CustomerNumber == CustomerNumber &&
        other.CityName == CityName &&
        other.CityArabicName == CityArabicName &&
        other.CustomerStatus == CustomerStatus &&
        other.CustomerEmail == CustomerEmail &&
        other.Token == Token;
  }

  @override
  int get hashCode {
    return CustomerId.hashCode ^
        CustomerFirstName.hashCode ^
        CustomerMiddleName.hashCode ^
        CustomerLastName.hashCode ^
        CustomerNumber.hashCode ^
        CityName.hashCode ^
        CityArabicName.hashCode ^
        CustomerStatus.hashCode ^
        CustomerEmail.hashCode ^
        Token.hashCode;
  }
}
