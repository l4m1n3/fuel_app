// // TODO Implement this library.
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';

// class AuthService with ChangeNotifier {
//   final _storage = FlutterSecureStorage();
//   String? _token;

//   Future<bool> login(String email, String password) async {
//     final response = await http.post(
//       Uri.parse('http://your-api-url/api/login'),
//       headers: {'Content-Type': 'application/json'},
//       body: jsonEncode({'email': email, 'password': password}),
//     );

//     if (response.statusCode == 200) {
//       _token = jsonDecode(response.body)['token'];
//       await _storage.write(key: 'jwt_token', value: _token);
//       notifyListeners();
//       return true;
//     }
//     return false;
//   }

//   Future<void> logout() async {
//     await _storage.delete(key: 'jwt_token');
//     _token = null;
//     notifyListeners();
//   }
// }