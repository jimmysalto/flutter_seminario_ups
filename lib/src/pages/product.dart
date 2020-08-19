import 'dart:io';

import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:seminario_02/src/providers/api.dart';
import 'package:seminario_02/src/utils/globals.dart' as utils;

class ProductPage extends StatefulWidget {
  ProductPage({Key key}) : super(key: key);

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  final _formKey = GlobalKey<FormState>();
  final _apiProvider = ApiProvider();

  File _img;
  String _title;
  String _description;
  double _value;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Crear Producto'),
          actions: [
            IconButton(icon: Icon(Icons.camera_alt), onPressed: _takePicture),
            IconButton(
                icon: Icon(Icons.photo_library), onPressed: _showGallery),
          ],
        ),
        body: _formProduct());
  }

  Widget _formProduct() {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(children: [
          Container(
              color: Colors.grey[400],
              height: 250,
              width: double.infinity,
              child: Image(
                  image: _img != null
                      ? FileImage(_img)
                      : AssetImage('assets/not-found.png'),
                  fit: BoxFit.cover)),
          Container(
            margin: EdgeInsets.only(left: 20, right: 20, top: 20),
            child: TextFormField(
              onSaved: (value) => _title = value,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                  hintText: 'Título',
                  labelText: 'Título'),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 20, right: 20, top: 20),
            child: TextFormField(
              onSaved: (value) => _description = value,
              keyboardType: TextInputType.multiline,
              maxLines: null,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                  hintText: 'Descripción',
                  labelText: 'Descripción'),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 20, right: 20, top: 20),
            child: TextFormField(
              onSaved: (value) => _value = double.parse(value),
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                  hintText: 'Valor',
                  labelText: 'Valor'),
            ),
          ),
          Container(
            margin: EdgeInsets.all(20),
            child: FlatButton(
              child: Text(
                'GUARDAR',
                style: TextStyle(fontSize: 15, color: utils.primaryColor()),
              ),
              onPressed: _sendForm,
            ),
          )
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
    setState(() => {});
  }

  _sendForm() async {
    _formKey.currentState.save();
    final body = {
      'title': _title,
      'description': _description,
      'value': _value
    };
    final statusCode = await _apiProvider.postProduct(body, _img);
    if (statusCode == 200) {
      // Navegar Menu bottom
      Flushbar(
        title: "Succesfully",
        message: "¡Product Created successfully!",
        icon: Icon(
          Icons.thumb_up,
          color: Colors.white,
        ),
        duration: Duration(seconds: 1),
        onStatusChanged: (status) {
          if (status == FlushbarStatus.DISMISSED) {
            Navigator.pop(context);
          }
        },
      )..show(context);
    } else {
      print('Algo salio mal');
    }
  }
}
