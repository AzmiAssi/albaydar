// ignore_for_file: public_member_api_docs, sort_constructors_first, file_names
import 'dart:convert';

class CustomerOrders {
  int orderId;
  String orderRef;
  String orderDate;
  String orderValue;
  int? orderStatus;
  String orderLoaction;
  String customerName;
  String customerEmail;
  String customerPhone;
  CustomerOrders({
    required this.orderId,
    required this.orderRef,
    required this.orderDate,
    required this.orderValue,
    this.orderStatus,
    required this.orderLoaction,
    required this.customerName,
    required this.customerEmail,
    required this.customerPhone,
  });

  CustomerOrders copyWith({
    int? orderId,
    String? orderRef,
    String? orderDate,
    String? orderValue,
    int? orderStatus,
    String? orderLoaction,
    String? customerName,
    String? customerEmail,
    String? customerPhone,
  }) {
    return CustomerOrders(
      orderId: orderId ?? this.orderId,
      orderRef: orderRef ?? this.orderRef,
      orderDate: orderDate ?? this.orderDate,
      orderValue: orderValue ?? this.orderValue,
      orderStatus: orderStatus ?? this.orderStatus,
      orderLoaction: orderLoaction ?? this.orderLoaction,
      customerName: customerName ?? this.customerName,
      customerEmail: customerEmail ?? this.customerEmail,
      customerPhone: customerPhone ?? this.customerPhone,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'orderId': orderId,
      'orderRef': orderRef,
      'orderDate': orderDate,
      'orderValue': orderValue,
      'orderStatus': orderStatus,
      'orderLoaction': orderLoaction,
      'customerName': customerName,
      'customerEmail': customerEmail,
      'customerPhone': customerPhone,
    };
  }

  factory CustomerOrders.fromMap(Map<String, dynamic> map) {
    return CustomerOrders(
      orderId: map['orderId'] as int,
      orderRef: map['orderRef'] as String,
      orderDate: map['orderDate'] as String,
      orderValue: map['orderValue'] as String,
      orderStatus: map['orderStatus'] as int,
      orderLoaction: map['orderLoaction'] as String,
      customerName: map['customerName'] as String,
      customerEmail: map['customerEmail'] as String,
      customerPhone: map['customerPhone'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory CustomerOrders.fromJson(String source) =>
      CustomerOrders.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Orders(orderId: $orderId, orderRef: $orderRef, orderDate: $orderDate, orderValue: $orderValue, orderStatus: $orderStatus, orderLoaction: $orderLoaction, customerName: $customerName, customerEmail: $customerEmail, customerPhone: $customerPhone)';
  }

  @override
  bool operator ==(covariant CustomerOrders other) {
    if (identical(this, other)) return true;

    return other.orderId == orderId &&
        other.orderRef == orderRef &&
        other.orderDate == orderDate &&
        other.orderValue == orderValue &&
        other.orderStatus == orderStatus &&
        other.orderLoaction == orderLoaction &&
        other.customerName == customerName &&
        other.customerEmail == customerEmail &&
        other.customerPhone == customerPhone;
  }

  @override
  int get hashCode {
    return orderId.hashCode ^
        orderRef.hashCode ^
        orderDate.hashCode ^
        orderValue.hashCode ^
        orderStatus.hashCode ^
        orderLoaction.hashCode ^
        customerName.hashCode ^
        customerEmail.hashCode ^
        customerPhone.hashCode;
  }
}
