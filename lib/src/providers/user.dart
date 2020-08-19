import 'package:flutter/material.dart';

class User with ChangeNotifier {
  String _img = "";
  String _id = "";
  //String _password = "";
  String _name = "";
  String _email = "";
  String _phone = "";
  String _date = "";

  get img {
    return _img;
  }

  set img(String img) {
    this._img = img;
    notifyListeners();
  }

  get id {
    return _id;
  }

  set id(String id) {
    this._id = id;
    notifyListeners();
  }

  get name {
    return _name;
  }

  set name(String name) {
    this._name = name;
    notifyListeners();
  }

  get email {
    return _email;
  }

  set email(String email) {
    this._email = email;
    notifyListeners();
  }

  get phone {
    return _phone;
  }

  set phone(String phone) {
    this._phone = phone;
    notifyListeners();
  }

  get date {
    return _date;
  }

  set date(String date) {
    this._date = date;
    notifyListeners();
  }

  /* get password {
    return _password;
  }

  set password(String password) {
    this._password = password;
    notifyListeners();
  } */
}
