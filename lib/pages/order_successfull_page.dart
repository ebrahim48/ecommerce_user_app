import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OrderSuccessfulPage extends StatelessWidget {
  static const routeName = "order-successful";
  const OrderSuccessfulPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Order Successful"),
      ),

      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset("assets/images/success.png",height: 120,width: 120,),

            SizedBox(height: 30,),
            
            Text("Order Placed", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Theme.of(context).primaryColor),),
            SizedBox(height: 20,),
            
            Text("Your Order Was Placed Successfully", textAlign: TextAlign.center,)


          ],
        ),
      ),

    );
  }
}
