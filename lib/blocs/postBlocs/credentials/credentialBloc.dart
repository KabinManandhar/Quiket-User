import 'dart:async';
import 'dart:convert';

import 'package:rxdart/rxdart.dart';

import '../../../resources/authProvider.dart';
import '../../../resources/secureStorage.dart';
import '../../validators.dart';

class CredentialsBloc extends Object with Validators {
  final _auth = AuthProvider();
  final _email = BehaviorSubject<String>();
  final _password = BehaviorSubject<String>();
  final _name = BehaviorSubject<String>();
  final _phoneNo = BehaviorSubject<String>();
  final _picture = BehaviorSubject<String>();
  final _description = BehaviorSubject<String>();

  // Add data to stream
  Stream<String> get email => _email.stream.transform(validateEmail);
  Stream<String> get password => _password.stream.transform(validatePassword);
  Stream<String> get name => _name.stream.transform(validateName);
  Stream<String> get phoneNo => _phoneNo.stream.transform(validatePhoneNo);
  Stream<String> get picture => _picture.stream;
  Stream<String> get description => _description.stream;
  Stream<bool> get submitValid =>
      Rx.combineLatest2(email, password, (e, p) => true);
  Stream<bool> get registerValid =>
      Rx.combineLatest4(email, password, name, phoneNo, (e, p, n, ph) => true);
  Stream<bool> get updateValid => email.map((email) => true);

  // Change data
  Function(String) get changeEmail => _email.sink.add;
  Function(String) get changePassword => _password.sink.add;
  Function(String) get changeName => _name.sink.add;
  Function(String) get changePhoneNo => _phoneNo.sink.add;
  Function(String) get changeDescription => _description.sink.add;
  Function(String) get changePicture => _picture.sink.add;

  login() async {
    String validEmail = _email.value;
    String validPassword = _password.value;
    var jsonResponse = await _auth.login(validEmail, validPassword);
    var results = json.decode(jsonResponse);
    if (results['success']) {
      secureStorage.deleteAll();
      secureStorage.write(key: 'id', value: results['id'].toString());
      secureStorage.write(key: 'token', value: results['token']);

      return true;
    }
    return false;
  }

  register() async {
    final validEmail = _email.value;
    final validPassword = _password.value;
    final validName = _name.value;
    final validPhoneNo = _phoneNo.value;

    var jsonResponse = await _auth.register(
        validName, validEmail, validPassword, validPhoneNo);
    var results = json.decode(jsonResponse);

    return (results['success']);
  }

  logout() async {
    String valueOfId = await secureStorage.read(key: 'id');
    String token = await secureStorage.read(key: 'token');
    int id = int.parse(valueOfId);
    var jsonResponse = await _auth.logout(id, token);
    var results = json.decode(jsonResponse);
    if (results['success']) {
      secureStorage.deleteAll();
      return results['success'];
    }
  }

  update(id, user) async {
    var validPassword = _password.value;
    var validName = _name.value;
    var validPhoneNo = _phoneNo.value;
    var validDescription = _description.value;
    var validEmail = _email.value;
    var validPicture = _picture.value;
    if (validName == '' || validName == null) {
      validName = user.name;
    }
    if (validDescription == '' || validDescription == null) {
      validDescription = user.description;
    }
    if (validPhoneNo == '' || validPhoneNo == null) {
      validPhoneNo = user.phoneNo;
    }

    String token = await secureStorage.read(key: 'token');

    var jsonResponse = await _auth.update(validName, validPassword,
        validPhoneNo, validDescription, validEmail, validPicture, token, id);

    var results = json.decode(jsonResponse);

    if (results['success']) {
      return true;
    } else {
      return false;
    }
  }

  removeValues() {
    _email.value = '';
    _password.value = '';
    _name.value = '';
    _phoneNo.value = '';
  }

  disposeStreams() {
    _email.drain();
    _email.close();
    _picture.drain();
    _picture.close();
    _description.drain();
    _description.close();
    _password.drain();
    _password.close();
    _name.drain();
    _name.close();
    _phoneNo.drain();
    _phoneNo.close();
  }
}

CredentialsBloc blocCredential = CredentialsBloc();
