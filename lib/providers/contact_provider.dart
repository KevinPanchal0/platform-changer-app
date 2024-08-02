import 'package:flutter/material.dart';
import 'package:platform_changer_app/model/contact_model.dart';

class ContactProvider with ChangeNotifier {
  List<ContactModel> _contactList = [];

  List<ContactModel> get contactList => _contactList;

  void addContact(ContactModel data) {
    _contactList.add(data);
    notifyListeners();
  }

  Future<void> removeContact({required ContactModel data}) async {
    _contactList.remove(data);
    notifyListeners();
  }

  void updateContact(ContactModel updatedContact) {
    int index = _contactList.indexWhere((c) => c.phone == updatedContact.phone);

    if (index != -1) {
      _contactList[index] = updatedContact;
    }

    notifyListeners();
  }
}
