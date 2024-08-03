import 'package:flutter/material.dart';
import 'package:platform_changer_app/model/profile_model.dart';

class ProfileProvider with ChangeNotifier {
  ProfileModel _profileModel = ProfileModel(
      name: '',
      phone: '',
      email: '',
      dob: '',
      gender: '',);

  ProfileModel get profileModel => _profileModel;

  void updateDate(String date){
    _profileModel.dob = date;
    notifyListeners();
  }

  void handleGenderChange(String? value) {
    _profileModel.gender = value!;
    notifyListeners();
  }
  void updateProfile(String name, String email, String phone,
      String dob, String gender) {
    _profileModel = ProfileModel(
      name: name,
      phone: phone,
      email: email,
      dob: dob,
      gender: gender,
    );
    notifyListeners();
  }
}
