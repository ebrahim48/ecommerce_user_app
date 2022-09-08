import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';

import '../db/db_helper.dart';
import '../models/city_model.dart';
import '../models/user_model.dart';

class UserProvider extends ChangeNotifier {
  List<CityModel> cityList = [];
  UserModel ? userModel;

  getAllCities() {
    DBHelper.getAllCities().listen((event) {
      cityList = List.generate(event.docs.length,
          (index) => CityModel.fromMap(event.docs[index].data()));
      notifyListeners();
    });
  }

  List<String> getAreaByCity(String? city){
    if(city==null) return <String>[];
    final cityModel = cityList.firstWhere((element) => element.name == city);
    return cityModel.area;
  }

  Future<void> addUser(UserModel usersModel) => DBHelper.addUser(usersModel);

  Stream<DocumentSnapshot<Map<String, dynamic>>> getUserByUid(String uid) =>
      DBHelper.getUserByUid(uid);

  Future<void> updateProfile(String uid, Map<String, dynamic> map) =>
      DBHelper.updateProfile(uid, map);

  Future<String> updateImage(XFile xFile) async {
    final imageName = DateTime.now().microsecondsSinceEpoch.toString();
    final photoRef = FirebaseStorage.instance.ref().child("picture/$imageName");
    final uploadTask = photoRef.putFile(File(xFile.path));
    final snapshot = await uploadTask.whenComplete(() => null);
    return snapshot.ref.getDownloadURL();
  }
}
