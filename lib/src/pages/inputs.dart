import 'package:flutter/material.dart';

class InputsPage extends StatefulWidget {
  InputsPage({Key key}) : super(key: key);

  @override
  _InputsPageState createState() => _InputsPageState();
}

class _InputsPageState extends State<InputsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Inputs')),
    );
  }
}
