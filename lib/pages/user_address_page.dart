
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../auth/auth_service.dart';
import '../models/address_model.dart';
import '../providers/user_provider.dart';
import '../utils/helper_function.dart';
import '../widgets/show_loading.dart';

class UserAddressPage extends StatefulWidget {
  static const routeName = "user-address";
  const UserAddressPage({Key? key}) : super(key: key);

  @override
  State<UserAddressPage> createState() => _UserAddressPageState();
}

class _UserAddressPageState extends State<UserAddressPage> {
  final addressController = TextEditingController();
  final zipcodeController = TextEditingController();
  late UserProvider userProvider;
  bool isFirst = true;
  bool _isLoding = false;
  String? city, area;

  final formKey = GlobalKey<FormState>();

  @override
  void didChangeDependencies() {
    if (isFirst) {
      userProvider = Provider.of<UserProvider>(context);
      userProvider.getAllCities();
      isFirst = false;
    }
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    addressController.dispose();
    zipcodeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Set Address"),
      ),
      body: Form(
          key: formKey,
          child: ListView(
            padding: EdgeInsets.all(10),
            children: [
              TextFormField(
                controller: addressController,
                style: const TextStyle(
                    color: Colors.black, fontWeight: FontWeight.w500),
                decoration: InputDecoration(
                    filled: true,
                    fillColor: const Color(0xffe6e6e6),
                    contentPadding: const EdgeInsets.only(left: 10),
                    focusColor: Colors.white,
                    hintText: "Enter your address",
                    hintStyle: TextStyle(
                        color: Colors.grey, fontWeight: FontWeight.normal),
                    border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(20))),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'This field must not be empty';
                  } else {
                    return null;
                  }
                },
              ),
              const SizedBox(
                height: 15,
              ),
              TextFormField(
                controller: zipcodeController,
                keyboardType: TextInputType.number,
                style: const TextStyle(
                    color: Colors.black, fontWeight: FontWeight.w500),
                decoration: InputDecoration(
                    filled: true,
                    fillColor: const Color(0xffe6e6e6),
                    contentPadding: const EdgeInsets.only(left: 10),
                    focusColor: Colors.white,
                    hintText: "Enter your zipcode",
                    hintStyle: TextStyle(
                        color: Colors.grey, fontWeight: FontWeight.normal),
                    border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(20))),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'This field must not be empty';
                  } else {
                    return null;
                  }
                },
              ),
              const SizedBox(
                height: 15,
              ),
              DropdownButtonFormField(
                value: city,
                hint: const Text("Select City"),
                items: userProvider.cityList
                    .map((e) => DropdownMenuItem<String>(
                        value: e.name, child: Text(e.name)))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    city = value.toString();
                  });
                },
                validator: (value) {},
              ),

              SizedBox(height: 15,),
              DropdownButtonFormField(
                value: area,
                hint: const Text("Select area"),
                items: userProvider.getAreaByCity(city)
                    .map((area) => DropdownMenuItem<String>(
                    value: area, child: Text(area)))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    area = value.toString();
                  });
                },
                validator: (value) {},
              ),
             _isLoding? ShowLoading():  SizedBox(height: 50,),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius:
                          BorderRadius.circular(15))),
                  onPressed: (){
                    saveAddress();
                   setState(() {
                     _isLoding = true;
                   });
                  },
                  child: Text("Save Address"))
            ],
          )),
    );
  }

  void saveAddress() {
    if(formKey.currentState!.validate()){
      if(_isLoding){
        _isLoding = true;
      }

      final addressModel = AddressModel(
          streetAddress: addressController.text,
          area: area!,
          city: city!,
          zipCode: int.parse(zipcodeController.text),
      );

      userProvider.updateProfile(AuthService.user!.uid, {"address" : addressModel.toMap()}).then((value) {

        Navigator.pop(context);
    

      })..catchError((error){
        showMsg(context, "Some thing wrong");
        throw error;
      });
    }
  }
}
