import 'dart:io';

import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:seminario_02/src/utils/globals.dart' as utils;

import '../providers/api.dart';

class ProductEditPage extends StatefulWidget {
  ProductEditPage({Key key}) : super(key: key);

  @override
  _ProductEditPageState createState() => _ProductEditPageState();
}

class _ProductEditPageState extends State<ProductEditPage> {
  final _formKey = GlobalKey<FormState>();
  final _apiProvider = ApiProvider();
  dynamic _product;
  File _img;
  String _title;
  String _description;
  double _value;

  @override
  Widget build(BuildContext context) {
    _product = ModalRoute.of(context).settings.arguments;
    print(_product);
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: CustomScrollView(
            slivers: [
              _appBar(),
              SliverList(
                delegate: SliverChildListDelegate([
                  _header(),
                  //  _title(_product['title']),
                  // _descriptionPost(_product['description']),
                  _formProduct(_product)
                ]),
              ),
            ],
          ),
        )
        // appBar: AppBar(
        //   title: Text('Detalle'),
        // ),
        // body: Hero(
        //   tag: 'detail',
        //   child: FadeInImage(
        //     fit: BoxFit.cover,
        //     placeholder: AssetImage('assets/loading-animation.gif'),
        //     image: NetworkImage(
        //         'https://cnet2.cbsistatic.com/img/vbaEI3QxmYewrB7lzNkydFyHAVw=/940x0/2019/01/07/74dff4c7-23e1-4b75-aa58-3dbd171bba68/samsung-laptop-notebook-9-pro-ces-2019-0969.jpg'),
        //   ),
        // ),
        );
  }

  Widget _appBar() {
    return SliverAppBar(
      // elevation: 2.0,
      backgroundColor: utils.primaryColor(),
      expandedHeight: 200,
      pinned: true,
      actions: <Widget>[
        /* IconButton(
          icon: Icon(Icons.delete_sweep),
          onPressed: () {
            _api.deleteProduct(_product['_id']);
          },
        ), */
        IconButton(icon: Icon(Icons.camera_alt), onPressed: _takePicture),
        IconButton(icon: Icon(Icons.photo_library), onPressed: _showGallery),
      ],
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Text(
          _product['title'],
        ),
        background: Hero(
          tag: _product['_id'],
          child: FadeInImage(
            fit: BoxFit.cover,
            placeholder: AssetImage('assets/loading-animation.gif'),
            image: _product['img'] != null && _img == null
                ? NetworkImage(
                    "${utils.url}/img/product/${_product['img']}",
                  )
                : _img != null
                    ? FileImage(_img)
                    : AssetImage('assets/not-found.png'),
          ),
        ),
      ),
    );
  }

  Widget _header() {
    return Container(
      // color: Colors.white,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25), topRight: Radius.circular(25))),
      child: Row(
        children: [
          CircleAvatar(
            radius: 28,
            backgroundColor: Colors.grey,
            backgroundImage: NetworkImage(
                '${utils.url}/img/user/${_product['user']['img']}'),
          ),
          Flexible(
            child: Container(
              margin: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(_product['user']['name'],
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  SizedBox(height: 2),
                  Text(_product['user']['email']),
                  Text(_product['date']),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /*  Widget _title(dynamic title) {
    return Container(
        width: double.infinity,
        padding: EdgeInsets.all(10),
        color: Colors.white,
        child: Row(
          children: [
            Icon(Icons.attach_file),
            Flexible(
              child: Text(title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            ),
          ],
        ));
  } */

  /*  Widget _descriptionPost(dynamic description) {
    return Container(
      width: double.infinity,
      color: Colors.white,
      padding: EdgeInsets.all(10),
      child: Text(description,
          textAlign: TextAlign.justify, style: TextStyle(fontSize: 18)),
    );
  } */

  Widget _formProduct(dynamic _product) {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(children: [
          Container(
            margin: EdgeInsets.only(left: 20, right: 20, top: 20),
            child: TextFormField(
              onSaved: (value) => _title = value,
              keyboardType: TextInputType.multiline,
              initialValue: _product['title'],
              maxLines: null,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                  hintText: 'Title',
                  labelText: 'Title'),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 20, right: 20, top: 20),
            child: TextFormField(
              onSaved: (value) => _description = value,
              keyboardType: TextInputType.multiline,
              initialValue: _product['description'],
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
              initialValue: _product['value'].toString(),
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
              onPressed: () {
                _sendForm(_product['_id']);
              },
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

  _sendForm(String id) async {
    print("Este es el " + id);
    _formKey.currentState.save();
    final body = {
      'title': _title,
      'description': _description,
      'value': _value,
    };
    final statusCode = await _apiProvider.putProduct(body, id, _img);
    if (statusCode == 200) {
      Flushbar(
        title: "Succesfully",
        message: "¡Product Updated successfully!",
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
