import 'package:flutter/material.dart';
import 'package:seminario_02/src/providers/api.dart';
import 'package:seminario_02/src/utils/globals.dart' as utils;

class CardsPage extends StatefulWidget {
  CardsPage({Key key}) : super(key: key);

  @override
  _CardsPageState createState() => _CardsPageState();
}

class _CardsPageState extends State<CardsPage> {
  final _api = ApiProvider();
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
    return '${_fecha.day} de ${monthNames[_fecha.month - 1]} del ${_fecha.year}  ';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: FutureBuilder(
              future: _api.getProductList(),
              builder: (context, snap) {
                if (snap.hasData) {
                  return ListView.builder(
                      itemCount: snap.data.length,
                      itemBuilder: (context, i) {
                        return _body(snap.data[i]);
                      });
                } else {
                  return Center(
                    child: CircularProgressIndicator(
                      backgroundColor: Colors.black,
                    ),
                  );
                }
              }),
        ),
        // appBar: AppBar(title: Text('Tarjetas')),
        // body: ListView(
        // physics: BouncingScrollPhysics(),
        // children: [
        // _body(),
        // Container(
        //   height: 100,
        //   margin: EdgeInsets.only(left: 20, right: 20),
        //   decoration: BoxDecoration(
        //       color: Colors.red,
        //       borderRadius: BorderRadius.all(Radius.circular(25)),
        //       boxShadow: [
        //         BoxShadow(
        //             color: Colors.red.withOpacity(0.5),
        //             spreadRadius: 3,
        //             blurRadius: 20,
        //             offset: Offset(0, 5))
        //       ]),
        // ),
        // ],
        // ),
        backgroundColor: Colors.grey[200]);
  }

  Widget _body(dynamic product) {
    return GestureDetector(
        child: Column(children: [
          _header(product),
          _title(product['title'], product),
          _imgPost(product['img'], product['_id']),
          _descriptionPost(product['description']),
          SizedBox(height: 10)
        ]),
        onTap: () {
          Navigator.pushNamed(context, 'product_detail', arguments: product);
        });
  }

  Widget _header(dynamic product) {
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
            backgroundImage:
                NetworkImage('${utils.url}/img/user/${product['user']['img']}'),
          ),
          Flexible(
            child: Container(
              margin: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(product['user']['name'],
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  SizedBox(height: 2),
                  Text(product['user']['email']),
                  Text(date(product['date'])),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _title(dynamic title, dynamic product) {
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
            IconButton(
              icon: Icon(Icons.edit),
              onPressed: () {
                Navigator.pushNamed(context, 'product_edit',
                    arguments: product);
              },
            ),
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                setState(() {
                  _api.deleteProduct(product['_id']);
                });
              },
            ),
          ],
        ));
  }

  Widget _imgPost(dynamic img, dynamic id) {
    return Container(
      height: 200,
      width: double.infinity,
      child: Hero(
        tag: id,
        child: FadeInImage(
          fit: BoxFit.cover,
          placeholder: AssetImage('assets/loading-animation.gif'),
          image: NetworkImage('${utils.url}/img/product/$img'),
        ),
      ),
    );
  }

  Widget _descriptionPost(dynamic description) {
    return Container(
      width: double.infinity,
      color: Colors.white,
      padding: EdgeInsets.all(10),
      child: Text(description,
          textAlign: TextAlign.justify, style: TextStyle(fontSize: 18)),
    );
  }
}
