import 'address_model.dart';
import 'date_model.dart';
const String orderIdKey = "orderId";
const String orderUserIdKey = "userId";
const String orderDateKey = "orderDate";
const String orderStatusKey = "orderStatus";
const String orderPaymentMethodKey = "paymentMethod";
const String orderGrandTotalKey = "grandTotal";
const String orderDiscountKey = "discount";
const String orderVatKey = "vat";
const String orderDeliveryChargeKey = "deliveryCharge";
const String orderDeliveryAddressKey = "deliveryAddress";

class OrderModel {
  String? orderId;
  String? userId;
  DateModel orderDate;
  String orderStatus;
  String paymentMethod;
  num grandTotal;
  num discount;
  num vat;
  num deliveryCharge;
  AddressModel deliveryAddress;

  OrderModel(
      {this.orderId,
      this.userId,
      required this.orderDate,
      required this.orderStatus,
      required this.paymentMethod,
      required this.grandTotal,
      required this.discount,
      required this.vat,
      required this.deliveryCharge,
      required this.deliveryAddress});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      orderIdKey: orderId,
      orderUserIdKey: userId,
      orderDateKey: orderDate.toMap(),
      orderStatusKey: orderStatus,
      orderPaymentMethodKey: paymentMethod,
      orderGrandTotalKey: grandTotal,
      orderDiscountKey: discount,
      orderVatKey: vat,
      orderDeliveryChargeKey: deliveryCharge,
      orderDeliveryAddressKey: deliveryAddress.toMap(),
    };
  }

  factory OrderModel.fromMap(Map<String, dynamic> map) => OrderModel(
        orderId: map[orderIdKey],
        userId: map[orderUserIdKey],
        orderDate: DateModel.fromMap(map[orderDateKey]),
        orderStatus: map[orderStatusKey],
        paymentMethod: map[orderPaymentMethodKey],
        grandTotal: map[orderGrandTotalKey],
        discount: map[orderDiscountKey],
        vat: map[orderVatKey],
        deliveryCharge: map[orderDeliveryChargeKey],
        deliveryAddress: AddressModel.fromMap(map[orderDeliveryAddressKey]),
      );
}
