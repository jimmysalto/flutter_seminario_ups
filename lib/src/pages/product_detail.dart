import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:seminario_02/src/utils/globals.dart' as utils;
import 'package:url_launcher/url_launcher.dart';

class ProductDetailPage extends StatefulWidget {
  ProductDetailPage({Key key}) : super(key: key);

  @override
  _ProductDetailPageState createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  dynamic _product;

  void launchWhatsApp({
    @required String phone,
    @required String message,
  }) async {
    if (await canLaunch(
        'https://api.whatsapp.com/send?phone=$phone&text=Hola%20vi%20tu%20anuncio')) {
      await launch(
          'https://api.whatsapp.com/send?phone=$phone&text=Hola%20vi%20tu%20anuncio');
    } else {
      throw 'Could not launch  https://api.whatsapp.com/send?phone=$phone&text=Hola%20vi%20tu%20anuncio';
    }
  }

  @override
  Widget build(BuildContext context) {
    _product = ModalRoute.of(context).settings.arguments;
    return Scaffold(
        backgroundColor: Colors.white,
        body: CustomScrollView(
          slivers: [
            _appBar(),
            SliverList(
              delegate: SliverChildListDelegate([
                _header(),
                _title(_product['title'], _product['user']['phone']),
                _descriptionPost(_product['description'])
              ]),
            ),
          ],
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
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Text(_product['title']),
        background: Hero(
          tag: _product['_id'],
          child: FadeInImage(
            fit: BoxFit.cover,
            placeholder: AssetImage('assets/loading-animation.gif'),
            image: NetworkImage('${utils.url}/img/product/${_product['img']}'),
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

  Widget _title(dynamic title, dynamic phone) {
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
              icon: FaIcon(FontAwesomeIcons.whatsapp),
              onPressed: () {
                launchWhatsApp(message: "Hola vi tu anuncion", phone: phone);
              },
            )
          ],
        ));
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
