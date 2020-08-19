import 'package:flutter/material.dart';

class SwipeExamplePage extends StatefulWidget {
  SwipeExamplePage({Key key}) : super(key: key);

  @override
  _SwipeExamplePageState createState() => _SwipeExamplePageState();
}

class _SwipeExamplePageState extends State<SwipeExamplePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(title: Text('Swipe Example')),
      body: ListView(
        children: [
          _item(),
          _item(),
          _item(),
        ],
      )
    );
  }

  Widget _item() {
    return Dismissible(
      key: UniqueKey(),
      confirmDismiss: (direction) async {
        print(direction);
        if (direction == DismissDirection.startToEnd) {
          // Consumir el webservice de editar
          print('Editar');
          return false;
        } else {
          return true;
        }
      },
      onDismissed: (direction) async {
        if (direction == DismissDirection.endToStart) {
          // Consumir el web service de eliminar
        }
      },
      background: Container(
        margin: EdgeInsets.only(top: 10),
        color: Colors.orangeAccent[200],
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(8),
              child: Icon(
                Icons.edit,
                color: Colors.white
              ),
            ),
            Text(
              'EDITAR',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold
              ),
            )
          ],
        ),
      ),
      secondaryBackground: Container(
        margin: EdgeInsets.only(top: 10),
        color: Colors.redAccent[200],
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Text(
              'ELIMINAR',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8),
              child: Icon(
                Icons.delete,
                color: Colors.white
              ),
            )
          ],
        ),
      ),
      child: Container(
        color: Colors.white,
        margin: EdgeInsets.only(top: 10),
        width: double.infinity,
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.all(10),
              child: Text('Image Title',
              style: TextStyle(fontSize: 20)),
            ),
            Container(
              height: 250,
              width: double.infinity,
              child: FadeInImage(
                  fit: BoxFit.cover,
                  placeholder: AssetImage('assets/loading-animation.gif'),
                  image: NetworkImage('https://i2.wp.com/www.itwarelatam.com/wp-content/uploads/2020/01/CES_2020_Laptops.jpg?fit=696%2C418&ssl=1'),
                ),
            ),
          ],
        ),
      ),
    );
  }
}