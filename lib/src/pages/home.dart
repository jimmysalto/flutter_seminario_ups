import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text('Home')), body: _menuItems());
  }

  Widget _menuItems() {
    return ListView(
      physics: BouncingScrollPhysics(),
      children: <Widget>[
        _menuItem(Icon(Icons.add_alert), 'Alertas',
            'Acceder al ejemplo de las alertas', 'alerts'),
        Divider(),
        _menuItem(Icon(Icons.account_balance_wallet), 'Tarjetas',
            'Acceder al ejemplo de las tarjetas', 'cards'),
        Divider(),
        _menuItem(Icon(Icons.settings_input_svideo), 'Inputs',
            'Acceder al ejemplo de los inputs', 'inputs'),
        Divider(),
      ],
    );
  }

  Widget _menuItem(Icon icon, String title, String subtitle, String route) {
    return ListTile(
      title: Text(title),
      subtitle: Text(subtitle,
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
          style: TextStyle(color: Colors.red, fontSize: 20)),
      leading: icon,
      trailing: Icon(Icons.arrow_forward_ios),
      onTap: () => Navigator.pushNamed(context, route),
    );
  }
}
