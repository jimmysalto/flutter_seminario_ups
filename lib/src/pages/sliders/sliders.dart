import 'package:flutter/material.dart';
import 'package:seminario_02/src/utils/globals.dart' as utils;

class SlidersPage extends StatefulWidget {
  SlidersPage({Key key}) : super(key: key);

  @override
  _SlidersPageState createState() => _SlidersPageState();
}

class _SlidersPageState extends State<SlidersPage> {
  PageController _pageController = PageController();
  int _index = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [_sliders(), _bottomButtons(_index)],
        ));
  }

  Widget _sliders() {
    return PageView(
      controller: _pageController,
      onPageChanged: (index) {
        setState(() {
          _index = index;
        });
      },
      children: [
        _bodySlider('assets/1.png', 'Title 1',
            'Sunt ut mollit labore consectetur consequat aute pariatur veniam voluptate ipsum mollit Lorem. Deserunt dolore veniam ad irure do ex ut esse. Cillum minim voluptate aliquip in aute aliquip deserunt quis qui ex sit commodo. Enim commodo qui do sint magna ullamco consectetur cillum consectetur adipisicing quis eiusmod. Mollit incididunt occaecat duis laborum mollit ad est elit consectetur id.'),
        _bodySlider('assets/2.png', 'Title 2',
            'Sunt ut mollit labore consectetur consequat aute pariatur veniam voluptate ipsum mollit Lorem. Deserunt dolore veniam ad irure do ex ut esse. Cillum minim voluptate aliquip in aute aliquip deserunt quis qui ex sit commodo. Enim commodo qui do sint magna ullamco consectetur cillum consectetur adipisicing quis eiusmod. Mollit incididunt occaecat duis laborum mollit ad est elit consectetur id.'),
        _bodySlider('assets/3.png', 'Title 3',
            'Sunt ut mollit labore consectetur consequat aute pariatur veniam voluptate ipsum mollit Lorem. Deserunt dolore veniam ad irure do ex ut esse. Cillum minim voluptate aliquip in aute aliquip deserunt quis qui ex sit commodo. Enim commodo qui do sint magna ullamco consectetur cillum consectetur adipisicing quis eiusmod. Mollit incididunt occaecat duis laborum mollit ad est elit consectetur id.'),
      ],
    );
  }

  Widget _bodySlider(String assetUrl, String title, String subtitle) {
    return Container(
      margin: EdgeInsets.only(left: 80, right: 80),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(image: AssetImage(assetUrl)),
            Text(
              title,
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(subtitle,
                textAlign: TextAlign.center, style: TextStyle(fontSize: 15))
          ],
        ),
      ),
    );
  }

  Widget _bottomButtons(int index) {
    switch (index) {
      case 0:
        return Align(
          alignment: Alignment.bottomRight,
          child: Container(
            margin: EdgeInsets.all(10),
            child: FlatButton(
              onPressed: () => _moveSliders(1),
              child: Text('SIGUIENTE',
                  style: TextStyle(color: utils.primaryColor())),
            ),
          ),
        );
        break;
      case 1:
        return Align(
          alignment: Alignment.bottomRight,
          child: Container(
            margin: EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                FlatButton(
                  onPressed: () => _moveSliders(0),
                  child: Text('ANTERIOR',
                      style: TextStyle(color: utils.primaryColor())),
                ),
                FlatButton(
                  onPressed: () => _moveSliders(2),
                  child: Text('SIGUIENTE',
                      style: TextStyle(color: utils.primaryColor())),
                ),
              ],
            ),
          ),
        );
        break;
      case 2:
        return Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            margin: EdgeInsets.only(bottom: 20),
            child: ButtonTheme(
              minWidth: 300,
              height: 40,
              child: FlatButton(
                color: utils.primaryColor(),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                onPressed: () => Navigator.popAndPushNamed(context, 'login'),
                child: Text(
                  'EMPEZAR',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
        );
        break;
      default:
        return Container();
    }
  }

  _moveSliders(int index) {
    setState(() {
      _pageController.animateToPage(index,
          duration: Duration(milliseconds: 250), curve: Curves.easeOut);
    });
  }
}
