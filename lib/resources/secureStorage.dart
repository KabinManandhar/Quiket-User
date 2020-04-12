import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final secureStorage = new FlutterSecureStorage();

// class SecureStorage {
//   getCreds() async {
//     String _valueOfId = await secureStorage.read(key: 'id');
//     String _token = await secureStorage.read(key: 'token');
//     int _id = int.parse(_valueOfId);
//     Map<String, dynamic> values = {'id': _id, 'token': _token};
//     return values;
//   }
// }

// final storage = SecureStorage();

// class SecureStorage {
//   static int _id;
//   static String _token;

//   static getValues() async {
//    _valueOfId = await secureStorage.read(key: 'id');
//       _token = await secureStorage.read(key: 'token');
//       _id = int.parse(_valueOfId);
//   }

//   deleteValues() {
//     secureStorage.deleteAll();
//   }
// }
