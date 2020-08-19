import 'package:flutter/material.dart';

class AlertsPage extends StatefulWidget {
  AlertsPage({Key key}) : super(key: key);

  @override
  _AlertsPageState createState() => _AlertsPageState();
}

class _AlertsPageState extends State<AlertsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Alertas')),
    );
  }
}
