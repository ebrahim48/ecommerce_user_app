
import 'package:flutter/cupertino.dart';

import '../auth/auth_service.dart';
import '../db/db_helper.dart';
import '../models/cart_model.dart';
import '../models/category_model.dart';
import '../models/order_constants_model.dart';
import '../models/order_model.dart';

class OrderProvider extends ChangeNotifier {
  OrderConstantsModel orderConstantsModel = OrderConstantsModel();


  Future<void> addNewOrder(OrderModel orderModel, List<CartModel> cartList) =>
  DBHelper.addNewOrder(orderModel, cartList);
  Future<void> updateProductStock(List<CartModel> cartList) =>
      DBHelper.updateProductStock(cartList);

  Future<void> clearUserCartItems(List<CartModel> cartList) =>
      DBHelper.clearUserCartItems(AuthService.user!.uid, cartList);

  Future<void> updateCategoryProductCount(
      List<CartModel> cartList,
      List<CategoryModel> categoryList) =>
      DBHelper.updateCategoryProductCount(cartList, categoryList);

  Future<void> getOrderConstants() async{
   final snapshot = await DBHelper.getAllOrderConstants();
   orderConstantsModel = OrderConstantsModel.fromMap(snapshot.data()!);
   notifyListeners();
  }

  num getDiscountAmount(num subtotal){
    return (subtotal * orderConstantsModel.discount)/100;
  }
  num getVatAmount(num subtotal){
    final priceAfterDiscount = subtotal-getDiscountAmount(subtotal);
    return (priceAfterDiscount * orderConstantsModel.vat)/100;
  }

  num getGrandTotal(num subtotal){
    return (subtotal-getDiscountAmount(subtotal))+getVatAmount(subtotal)+orderConstantsModel.deliveryCharge;
  }
}
