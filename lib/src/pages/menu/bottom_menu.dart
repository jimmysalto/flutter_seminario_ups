import 'package:flutter/material.dart';
import 'package:seminario_02/src/pages/cards.dart';
import 'package:seminario_02/src/pages/profile.dart';
import 'package:seminario_02/src/utils/globals.dart' as utils;

class BottomMenuPage extends StatefulWidget {
  BottomMenuPage({Key key}) : super(key: key);

  @override
  _BottomMenuPageState createState() => _BottomMenuPageState();
}

class _BottomMenuPageState extends State<BottomMenuPage> {
  int _currentIndex = 0;
  PageController _pageController = PageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages(),
      bottomNavigationBar: _bottomNavigationBar(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, 'product'),
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget _pages() {
    return PageView(
      physics: NeverScrollableScrollPhysics(),
      controller: _pageController,
      children: [
        CardsPage(),
        ProfilePage(),
      ],
    );
  }

  Widget _bottomNavigationBar() {
    return Theme(
      data: Theme.of(context).copyWith(
        // canvasColor: Colors.indigo,
        // primaryColor: Colors.pink,
        canvasColor: utils.primaryColor(),
        primaryColor: utils.accentColor(),
        // textTheme: Theme.of(context).textTheme.copyWith(
        //         caption: TextStyle(
        //       color: Colors.teal[100],
        //       fontWeight: FontWeight.bold,
        //     ))
      ),
      child: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
            _pageController.animateToPage(_currentIndex,
                duration: Duration(milliseconds: 250), curve: Curves.easeOut);
          });
        },
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.home), title: Text('Inicio')),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_circle), title: Text('Perfil')),
        ],
      ),
    );
  }
}
