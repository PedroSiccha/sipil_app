import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:sipil_app/src/data/api/ApiConfig.dart';
import 'package:sipil_app/src/domain/models/response/AuthResponse.dart';
import 'package:sipil_app/src/domain/utils/Resource.dart';

class AuthService {
  Future<Resource<AuthResponse>> login (String username, String password) async {
    try {
      Uri url = Uri.https(ApiConfig.API_BASE, '/auth/login');
      // Uri url = Uri.http(ApiConfig.API_BASE, '/auth/login');
      print("URL ${url}");
      Map<String, String> headers = {
        "Content-Type": "application/json"
      };
      String body = json.encode({
        'username': username,
        'password': password
      });
      print("Body : $body");
      final response = await http.post(url, headers: headers, body: body);
      print("LOGIN : ${json.decode(response.body)}");
      final data = json.decode(response.body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        AuthResponse authResponse = AuthResponse.fromJson(data);
        return Success(authResponse);
      } else {
        return Error(data['message'], 'ERROR', data['statusCode']);
      }

    } catch (e) {
      print('Error $e');
      if (e is SocketException || e is HttpException) {
        print('Error $e');
      } else {
        print('Error $e');
      }
      return Error(e.toString(), e.toString(), 400);
    }
  }
}