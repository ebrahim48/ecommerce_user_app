import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_user_project/pages/products_page.dart';
import 'package:ecommerce_user_project/pages/user_address_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../auth/auth_service.dart';
import '../models/date_model.dart';
import '../models/order_model.dart';
import '../models/user_model.dart';
import '../providers/cart_provider.dart';
import '../providers/order_provider.dart';
import '../providers/product_provider.dart';
import '../providers/user_provider.dart';
import '../utils/constansts.dart';
import '../utils/helper_function.dart';
import '../widgets/show_loading.dart';
import 'order_successfull_page.dart';

class CheckoutPage extends StatefulWidget {
  static const routeName = "check-out";
  const CheckoutPage({Key? key}) : super(key: key);

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  late CartProvider cartProvider;
  late OrderProvider orderProvider;
  late UserProvider userProvider;
  String groupValue = PaymentMethod.cod;
  bool isFirst = true;
  bool _isLoadding = false;

  @override
  void didChangeDependencies() {
    if (isFirst) {
      cartProvider = Provider.of<CartProvider>(context);
      orderProvider = Provider.of<OrderProvider>(context);

      userProvider = Provider.of<UserProvider>(context, listen: false);
      orderProvider.getOrderConstants();
      isFirst = false;
    }

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    print("Build called");

    return Scaffold(
      appBar: AppBar(
        title: Text("Checkout"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: ListView(
              padding: EdgeInsets.all(8),
              children: [
                Text(
                  "Product Info",
                  style: Theme.of(context).textTheme.headline6,
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 10,
                ),
                Card(
                  child: Column(
                    children: cartProvider.cartList
                        .map((cartModel) => ListTile(
                              dense: true,
                              title: Text(cartModel.productName!),
                              trailing: Text(
                                  "${cartModel.quantity}* ৳${cartModel.salePrice}"),
                            ))
                        .toList(),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Payment Info",
                  style: Theme.of(context).textTheme.headline6,
                  textAlign: TextAlign.center,
                ),
                Card(
                  child: Column(
                    children: [
                      ListTile(
                        leading: Text("Subtotal:"),
                        trailing: Text("৳${cartProvider.getCartSubtotal()}"),
                        dense: true,
                      ),
                      ListTile(
                        leading: Text(
                            "Discount(${orderProvider.orderConstantsModel.discount}%)"),
                        trailing: Text(
                            "৳${orderProvider.getDiscountAmount(cartProvider.getCartSubtotal())}"),
                        dense: true,
                      ),
                      ListTile(
                        leading: Text("Delivery Charge:"),
                        trailing: Text(
                            "৳${orderProvider.orderConstantsModel.deliveryCharge}"),
                        dense: true,
                      ),
                      ListTile(
                        leading: Text("Vat(15%)"),
                        trailing: Text(
                            "৳${orderProvider.getVatAmount(cartProvider.getCartSubtotal())}"),
                        dense: true,
                      ),
                      Divider(),
                      ListTile(
                        leading: Text(
                          "Grand total:",
                          style: TextStyle(color: Colors.red),
                        ),
                        trailing: Text(
                          "৳${orderProvider.getGrandTotal(cartProvider.getCartSubtotal())}",
                          style: TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.w500,
                              fontSize: 16),
                        ),
                        dense: true,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Delivery Address",
                  style: Theme.of(context).textTheme.headline6,
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 5,
                ),
                Card(
                  child: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                    stream: userProvider.getUserByUid(AuthService.user!.uid),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        final userModel =
                            UserModel.fromMap(snapshot.data!.data()!);
                        userProvider.userModel = userModel;
                        final addressModel = userModel.address;

                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(addressModel == null
                                  ? "No address found"
                                  : "${addressModel.streetAddress}\n ${addressModel.area}, ${addressModel.city}\n${addressModel.zipCode}"),
                              ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15))),
                                  onPressed: () {
                                    Navigator.pushNamed(
                                        context, UserAddressPage.routeName);
                                  },
                                  child: Text("Change"))
                            ],
                          ),
                        );
                      }
                      if (snapshot.hasError) {
                        return Center(
                          child: Text("Failed to face data"),
                        );
                      }
                      return Center(
                        child: Text("Feacthing address..."),
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Payment Method",
                  style: Theme.of(context).textTheme.headline6,
                  textAlign: TextAlign.center,
                ),
                Card(
                  child: Row(
                    children: [
                      Expanded(
                        child: ListTile(
                          title: Text(PaymentMethod.cod),
                          leading: Radio<String>(
                              value: PaymentMethod.cod,
                              groupValue: groupValue,
                              fillColor: MaterialStateColor.resolveWith(
                                  (states) => groupValue == PaymentMethod.cod
                                      ? Colors.red
                                      : Colors.grey),
                              onChanged: (value) {
                                setState(() {
                                  groupValue = value as String;
                                });
                              }),
                        ),
                      ),
                      Expanded(
                        child: ListTile(
                          title: Text("Online"),
                          leading: Radio<String>(
                            value: "Online",
                            groupValue: groupValue,
                            fillColor: MaterialStateColor.resolveWith(
                                (states) => groupValue == PaymentMethod.online
                                    ? Colors.red
                                    : Colors.grey),
                            onChanged: (value) {
                              setState(() {
                                groupValue = value as String;
                              });
                            },
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          _isLoadding? ShowLoading():Container(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15))),
                onPressed: _saveOrder,
                child: const Text("Place order")),
          )
        ],
      ),
    );
  }

  void _saveOrder() {
    if (userProvider.userModel?.address == null) {
      showMsg(context, "Please provide a delivery address!");
      return;
    }
  setState(() {
    _isLoadding = true;
  });
    final orderModel = OrderModel(
      userId: AuthService.user!.uid,
      orderStatus: OrderStatus.pending,
      paymentMethod: groupValue,
      deliveryAddress: userProvider.userModel!.address!,
      orderDate: DateModel(
          timestamp: Timestamp.fromDate(DateTime.now()),
          day: DateTime.now().day,
          month: DateTime.now().month,
          year: DateTime.now().year),
      grandTotal: orderProvider.getGrandTotal(cartProvider.getCartSubtotal()),
      discount: orderProvider.orderConstantsModel.discount,
      vat: orderProvider.orderConstantsModel.vat,
      deliveryCharge: orderProvider.orderConstantsModel.deliveryCharge,
    );

    orderProvider.addNewOrder(orderModel, cartProvider.cartList)
        .then((_) {

          orderProvider.updateProductStock(cartProvider.cartList)
              .then((_) => {

                orderProvider.updateCategoryProductCount(cartProvider.cartList,
                    context.read<ProductProvider>().categoryList)


          }).then((_) {
            
            orderProvider.clearUserCartItems(cartProvider.cartList).then((_) {

              Navigator.pushNamedAndRemoveUntil(context, OrderSuccessfulPage.routeName,  ModalRoute.withName(ProductPage.routeName));


            });


          });


    });
  }
}
