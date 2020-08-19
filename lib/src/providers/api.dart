import 'dart:io';

//import 'package:provider/provider.dart';
import 'package:seminario_02/src/providers/preferences.dart';
import 'package:seminario_02/src/providers/user.dart';
import 'package:seminario_02/src/utils/globals.dart' as utils;
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';

class ApiProvider {
  Preferences _preferences = Preferences();

  Future<dynamic> login(dynamic body, User _user) async {
    final response = await http.post('${utils.url}/login', body: body);
    // print('${utils.url}/login');
    // print(body);
    final statusCode = response.statusCode;
    if (statusCode == 200) {
      final data = json.decode(response.body);
      _preferences.token = data['token'];
      return 200;
    } else {
      return 400;
    }
    /* if (statusCode == 404) {
      return 'Not Found';
    } else if (statusCode == 401) {
      return 'Usuario o contraseña incorrectos';
    } else if (statusCode == 200) {
      final data = json.decode(response.body);
      _preferences.token = data['token'];
      return 'OK';
    } */
  }

  Future<dynamic> postUser(dynamic body, User _user) async {
    final response = await http.post('${utils.url}/login', body: body);
    // print('${utils.url}/login');
    // print(body);
    final statusCode = response.statusCode;
    if (statusCode == 200) {
      final data = json.decode(response.body);
      _preferences.token = data['token'];

      return 200;
    } else {
      return 400;
    }
    /* if (statusCode == 404) {
      return 'Not Found';
    } else if (statusCode == 401) {
      return 'Usuario o contraseña incorrectos';
    } else if (statusCode == 200) {
      final data = json.decode(response.body);
      _preferences.token = data['token'];
      return 'OK';
    } */
  }

  Future<dynamic> getSession() async {
    final headers = {'Authorization': '${_preferences.token}'};
    final response = await http.get('${utils.url}/session', headers: headers);

    final statusCode = response.statusCode;
    if (statusCode == 200) {
      final data = json.decode(response.body);
      print(data['user']);
      return data['user'];
    } else {
      return [];
    }
  }

  Future<dynamic> putUser(dynamic body, File image) async {
    Dio dio = Dio();
    dio.options.headers['Authorization'] = '${_preferences.token}';

    if (image != null) {
      String fileName = image.path.split('/').last;
      FormData formData = FormData.fromMap({
        'name': body['name'],
        'email': body['email'],
        'phone': body['phone'],
        'password': body['password'],
        'img': await MultipartFile.fromFile(image.path, filename: fileName),
      });
      final response = await dio.put('${utils.url}/user', data: formData);
      if (response.statusCode == 200) {
        return 200;
      } else {
        return 400;
      }
    } else {
      FormData formData = FormData.fromMap({
        'name': body['name'],
        'email': body['email'],
        'phone': body['phone'],
        'password': body['password'],
      });
      final response = await dio.put('${utils.url}/user', data: formData);
      if (response.statusCode == 200) {
        return 200;
      } else {
        return 400;
      }
    }
  }

  Future<dynamic> getProductList() async {
    // final headers = {'Authorization': '${_preferences.token}'};
    // final response = await http.get('${utils.url}/products', headers: headers);
    final response = await http.get('${utils.url}/products/desc');
    final statusCode = response.statusCode;
    if (statusCode == 200) {
      final data = json.decode(response.body);
      return data['list'];
    } else {
      return [];
    }
  }

  Future<dynamic> postProduct(dynamic body, File image) async {
    Dio dio = Dio();
    dio.options.headers['Authorization'] = '${_preferences.token}';
    if (image != null) {
      String fileName = image.path.split('/').last;
      FormData formData = FormData.fromMap({
        'title': body['title'],
        'description': body['description'],
        'value': body['value'],
        'img': await MultipartFile.fromFile(image.path, filename: fileName),
      });
      final response = await dio.post('${utils.url}/product', data: formData);
      if (response.statusCode == 200) {
        return 200;
      } else {
        return 400;
      }
    } else {
      FormData formData = FormData.fromMap({
        'title': body['title'],
        'description': body['description'],
        'value': body['value'],
      });
      final response = await dio.post('${utils.url}/product', data: formData);
      if (response.statusCode == 200) {
        return 200;
      } else {
        return 400;
      }
    }
  }

  Future<dynamic> deleteProduct(String id) async {
    final headers = {'Authorization': '${_preferences.token}'};
    final response =
        await http.delete('${utils.url}/product/$id', headers: headers);
    print('${utils.url}/$id');
    if (response.statusCode == 200) {
      print("TODO BIEN");
      return 200;
    } else {
      print("SALIOMAL");
      return 400;
    }
  }

  Future<dynamic> putProduct(dynamic body, String id, File image) async {
    Dio dio = Dio();
    dio.options.headers['Authorization'] = '${_preferences.token}';
    print('${utils.url}/product/$id');
    if (image != null) {
      print("Entra con gfoto");
      String fileName = image.path.split('/').last;
      FormData formData = FormData.fromMap({
        'title': body['title'],
        'description': body['description'],
        'value': body['value'],
        'img': await MultipartFile.fromFile(image.path, filename: fileName),
      });
      print('${utils.url}/product/$id');
      print(formData.toString());
      final response =
          await dio.put('${utils.url}/product/$id', data: formData);
      if (response.statusCode == 200) {
        return 200;
      } else {
        return 400;
      }
    } else {
      print("Entra sin gfoto");
      FormData formData = FormData.fromMap({
        'title': body['title'],
        'description': body['description'],
        'value': body['value'],
      });
      print('${utils.url}/product/$id');
      final response =
          await dio.put('${utils.url}/product/$id', data: formData);
      if (response.statusCode == 200) {
        return 200;
      } else {
        return 400;
      }
    }
  }
}
