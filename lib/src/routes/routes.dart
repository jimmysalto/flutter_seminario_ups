import 'package:flutter/material.dart';
import 'package:seminario_02/src/pages/alerts.dart';
import 'package:seminario_02/src/pages/cards.dart';
import 'package:seminario_02/src/pages/home.dart';
import 'package:seminario_02/src/pages/inputs.dart';
import 'package:seminario_02/src/pages/login.dart';
import 'package:seminario_02/src/pages/menu/bottom_menu.dart';
import 'package:seminario_02/src/pages/product.dart';
import 'package:seminario_02/src/pages/product_detail.dart';
import 'package:seminario_02/src/pages/product_edit.dart';
import 'package:seminario_02/src/pages/profile.dart';
import 'package:seminario_02/src/pages/register.dart';
import 'package:seminario_02/src/pages/sliders/sliders.dart';
import 'package:seminario_02/src/pages/swipe/swipe_items.dart';

Map<String, WidgetBuilder> getApplicationRoutes() {
  return <String, WidgetBuilder>{
    'home': (BuildContext context) => HomePage(),
    'alerts': (BuildContext context) => AlertsPage(),
    'inputs': (BuildContext context) => InputsPage(),
    'bottom_menu': (BuildContext context) => BottomMenuPage(),
    'cards': (BuildContext context) => CardsPage(),
    'profile': (BuildContext context) => ProfilePage(),
    'login': (BuildContext context) => LoginPage(),
    'register': (BuildContext context) => RegisterPage(),
    'sliders': (BuildContext context) => SlidersPage(),
    'product_detail': (BuildContext context) => ProductDetailPage(),
    'product_edit': (BuildContext context) => ProductEditPage(),
    'product': (BuildContext context) => ProductPage(),
    'swipe': (BuildContext context) => SwipeExamplePage(),
  };
}
