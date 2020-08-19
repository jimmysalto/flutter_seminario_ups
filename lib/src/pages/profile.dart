import 'dart:io';

import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:seminario_02/src/providers/preferences.dart';
import 'package:seminario_02/src/providers/api.dart';

import 'package:seminario_02/src/utils/globals.dart' as utils;

import '../providers/preferences.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({Key key, this.user}) : super(key: key);
  final user;
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _apiProvider = ApiProvider();
  final _formKey = GlobalKey<FormState>();
  final Preferences _preferences = Preferences();
  final _api = ApiProvider();

  String _name;
  String _email;
  String _phone;
  String _password;

  File _img;

  DateTime _fecha;

  String date(String date) {
    const monthNames = [
      "January",
      "February",
      "March",
      "April",
      "May",
      "June",
      "July",
      "August",
      "September",
      "October",
      "November",
      "December"
    ];
    _fecha = DateTime.parse(date);
    print("_fecha" + _fecha.toIso8601String());
    return '${_fecha.day} de ${monthNames[_fecha.month - 1]} del ${_fecha.year} a las ${_fecha.hour}:0${_fecha.minute}:${_fecha.second}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Perfil'),
        actions: <Widget>[
          GestureDetector(
            child: Center(
              child: Text("Cerrar Sesión"),
            ),
            onTap: () {
              _preferences.token = '';
              Navigator.popAndPushNamed(context, 'login');
            },
          ),
        ],
      ),
      body: FutureBuilder(
          future: _api.getSession(),
          builder: (context, snap) {
            if (snap.hasData) {
              return _formUser(snap.data);
            } else {
              return Center(child: CircularProgressIndicator());
            }
          }),
      //_formUser(),
    );
  }

  Widget _formUser(dynamic _user) {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(children: [
          Stack(
            children: <Widget>[
              CircleAvatar(
                maxRadius: 80.0,
                backgroundImage: _user['img'] != null && _img == null
                    ? NetworkImage(
                        "http://157.245.116.71:3020/img/user/${_user['img']}",
                      )
                    : _img != null
                        ? FileImage(_img)
                        : AssetImage('assets/not-found.png'),
              ),
              Positioned(
                top: 30.0,
                left: 125.0,
                child: IconButton(
                  onPressed: () {
                    _takePicture();
                  },
                  icon: Icon(Icons.photo_camera),
                  iconSize: 30.0,
                  color: Colors.yellow,
                ),
              ),
              Positioned(
                top: 80.0,
                left: 125.0,
                child: IconButton(
                  onPressed: () {
                    _showGallery();
                  },
                  icon: Icon(Icons.add_photo_alternate),
                  iconSize: 30.0,
                  color: Colors.yellow,
                ),
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.only(left: 20, right: 20, top: 20),
            child: TextFormField(
              onSaved: (value) => _name = value,
              initialValue: _user['name'],
              decoration: InputDecoration(
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                hintText: "Name",
                labelText: "Name",
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 20, right: 20, top: 20),
            child: TextFormField(
              onSaved: (value) => _email = value,
              keyboardType: TextInputType.multiline,
              maxLines: null,
              initialValue: _user['email'],
              decoration: InputDecoration(
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                hintText: 'Email',
                labelText: 'Email',
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 20, right: 20, top: 20),
            child: TextFormField(
              onSaved: (value) => _phone = value,
              keyboardType: TextInputType.number,
              initialValue: _user['phone'],
              decoration: InputDecoration(
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                hintText: 'Phone',
                labelText: 'Phone',
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 20, right: 20, top: 20),
            child: TextFormField(
              onSaved: (value) => _password = value,

              initialValue: _user['password'],
              keyboardType: TextInputType.visiblePassword,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  labelText: 'Password'),
              //obscureText: true,
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 20, right: 20, top: 20),
            child: TextFormField(
              keyboardType: TextInputType.number,
              enabled: false,
              readOnly: true,
              initialValue: date(_user['date']),
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                  labelText: "Date Creation"),
            ),
          ),
          Container(
            margin: EdgeInsets.all(20),
            child: FlatButton(
              child: Text(
                'GUARDAR',
                style: TextStyle(fontSize: 15, color: utils.primaryColor()),
              ),
              onPressed: () {
                _sendForm();
              },
            ),
          ),
        ]),
      ),
    );
  }

  _takePicture() async {
    _selectImage(ImageSource.camera);
  }

  _showGallery() async {
    _selectImage(ImageSource.gallery);
  }

  _selectImage(ImageSource type) async {
    _img = await ImagePicker.pickImage(source: type);
    print(_img);
    setState(() => {});
  }

  _sendForm() async {
    _formKey.currentState.save();
    final body = {
      'name': _name,
      'email': _email,
      'phone': _phone,
      'password': _password,
    };
    final statusCode = await _apiProvider.putUser(body, _img);
    if (statusCode == 200) {
      Flushbar(
        title: "Succesfully",
        message: "¡Profile Updated successfully!",
        icon: Icon(
          Icons.thumb_up,
          color: Colors.white,
        ),
        duration: Duration(seconds: 1),
        onStatusChanged: (status) {
          if (status == FlushbarStatus.DISMISSED) {
            setState(() {});
          }
        },
      )..show(context);
    } else {
      Flushbar(
        title: "¡Error!",
        message: "¡Something went wrong!",
        icon: Icon(
          Icons.thumb_up,
          color: Colors.white,
        ),
        duration: Duration(seconds: 1),
        onStatusChanged: (status) {
          if (status == FlushbarStatus.DISMISSED) {
            setState(() {});
          }
        },
      )..show(context);
    }
  }
}
