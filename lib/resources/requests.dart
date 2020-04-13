import 'package:http/http.dart' as http;
import 'dart:convert';

class Requests {
  final _url = "http://192.168.100.70:8000/api"; //instantiate the root url
  postRequest(Map<String, dynamic> data, apiUrl) async {
    final fullUrl = _url + apiUrl;
    try {
      final http.Response response = await http.post(fullUrl,
          body: jsonEncode(data), headers: _setHeaders());
      return response.body;
    } catch (e) {
      print(e);
      return null;
    }
  }

  authPostRequest(Map<String, dynamic> data, apiUrl, token) async {
    final fullUrl = _url + apiUrl;
    try {
      final http.Response response = await http.post(fullUrl,
          body: jsonEncode(data), headers: _setAuthHeaders(token));
      return response.body;
    } catch (e) {
      print(e);
      return null;
    }
  }

  getRequest(apiUrl) async {
    try {
      final fullUrl = _url + apiUrl;

      final http.Response response =
          await http.get(fullUrl, headers: _setHeaders());

      return response;
    } catch (e) {
      print(e);
      return null;
    }
  }

  authGetRequest(apiUrl, token) async {
    try {
      final fullUrl = _url + apiUrl;
      print(fullUrl);
      final http.Response response =
          await http.get(fullUrl, headers: _setAuthHeaders(token));
      return response;
    } catch (e) {
      print(e);
      return null;
    }
  }

  delRequest(apiUrl, token) async {
    final fullUrl = _url + apiUrl;
    final http.Response response =
        await http.delete(fullUrl, headers: _setAuthHeaders(token));
    return response;
  }

  putRequest(Map<String, dynamic> data, apiUrl, token) async {
    final fullUrl = _url + apiUrl;
    try {
      final http.Response response = await http.put(fullUrl,
          body: jsonEncode(data), headers: _setAuthHeaders(token));
      return response.body;
    } catch (e) {
      print(e);
      return null;
    }
  }

  _setAuthHeaders(String authToken) => {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer' + " " + "$authToken"
      };
  _setHeaders() =>
      {'Content-type': 'application/json', 'Accept': 'application/json'};
}

final req = Requests();
