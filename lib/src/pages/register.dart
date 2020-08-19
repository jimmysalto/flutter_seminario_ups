import 'package:flutter/material.dart';
import 'package:seminario_02/src/utils/globals.dart' as utils;

class RegisterPage extends StatefulWidget {
  RegisterPage({Key key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  double _sizeHeight;
  double _sizeWidth;
  String _email;
  String _password;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    _sizeHeight = MediaQuery.of(context).size.height;
    _sizeWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: utils.primaryColor(),
        body: SafeArea(
          bottom: false,
          child: Stack(
            children: [_topBody(), _bottomBody()],
          ),
        ),
      );
  }

  Widget _topBody() {
    return Container(
      margin: EdgeInsets.only(top: 40),
      child: Align(
        alignment: Alignment.topCenter,
        child: Icon(Icons.account_circle,
            size: 150, color: Color.fromRGBO(255, 255, 255, 0.8)),
      ),
    );
  }

  Widget _bottomBody() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        margin: EdgeInsets.only(
            left: _sizeWidth * 0.0243331, right: _sizeWidth * 0.0243331),
        width: double.infinity,
        height: _sizeHeight * 0.585652,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20))),
        child: _formInputs(),
      ),
    );
  }

  Widget _formInputs() {
    return Container(
      margin: EdgeInsets.only(left: 50, right: 50, top: 30),
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(children: [
            Text('REGÍSTRATE',
                style: TextStyle(fontSize: 20, color: Colors.grey)),
            SizedBox(height: 20),
            // TextFormField(
            // keyboardType: TextInputType.emailAddress,
            // cursorColor: utils.accentColor(),
            // textCapitalization: TextCapitalization.words,
            // decoration: InputDecoration(
            // border:
            //     OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            // hintText: 'Correo',
            // labelText: 'Correo',
            // helperText: 'Ingrese Su Correo',
            // suffixIcon: Icon(Icons.email),
            // prefixIcon: Icon(Icons.email),
            // icon: Icon(Icons.email)),
            // ),
            TextFormField(
              // onChanged: (char) => {print(char)},
              // onFieldSubmitted: (char) => {print(char)},
              onSaved: (value) {
                _email = value;
              },
              keyboardType: TextInputType.emailAddress,
              // textCapitalization: TextCapitalization.words,
              decoration: InputDecoration(
                  hintText: 'Correo', prefixIcon: Icon(Icons.email)),
            ),
            SizedBox(height: 30),
            TextFormField(
              onSaved: (value) {
                _password = value;
              },
              obscureText: true,
              keyboardType: TextInputType.emailAddress,
              // textCapitalization: TextCapitalization.words,
              decoration: InputDecoration(
                  hintText: 'Contraseña', prefixIcon: Icon(Icons.lock)),
            ),
            SizedBox(height: 30),
            ButtonTheme(
              minWidth: double.infinity,
              height: 50,
              child: FlatButton(
                color: utils.primaryColor(),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                onPressed: _sendForm,
                child: Text(
                  'REGISTRARME',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }

  _sendForm() {
    _formKey.currentState.save();
    final body = {
      'email': _email,
      'password': _password,
    };
    print(body);
  }
}
