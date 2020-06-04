import 'dart:convert';

import 'package:http/http.dart';

import '../models/user_model.dart';
import 'requests.dart';

class AuthProvider {
  Client client = Client();
  final _register = "/user/register";
  final _login = "/user/login";
  final _logout = "/user/logout/";
  final _getProfile = "/users/";

  login(String email, String password) async {
    Map<String, String> data = {'email': email, 'password': password};
    var response = await req.postRequest(data, _login);
    return response;
  }

  register(String name, String email, String password, String phoneNo) async {
    Map<String, String> data = {
      'name': name,
      'email': email,
      'password': password,
      'phone_no': phoneNo
    };
    var response = await req.postRequest(data, _register);
    return response;
  }

  update(String name, String password, String phoneNo, String description,
      String email, String picture, String token, int id) async {
    Map<String, String> data = {
      'name': name,
      'email': email,
      'password': password,
      'phone_no': phoneNo,
      'description': description,
      'picture': picture
    };
    var response = await req.putRequest(data, _getProfile + '$id', token);
    return response;
  }

  logout(id, token) async {
    var data;
    var response = await req.authPostRequest(data, _logout + '$id', token);
    return response;
  }

  Future<UserModel> getUserProfile(_id) async {
    try {
      final response = await req.getRequest(_getProfile + '$_id');
      final organizer = json.decode(response.body);
      return UserModel.fromJson(organizer);
    } catch (e) {
      return null;
    }
  }
}
