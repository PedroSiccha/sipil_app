import 'dart:convert';
import 'dart:io';

import 'package:path/path.dart';
import 'package:sipil_app/src/data/api/ApiConfig.dart';
import 'package:sipil_app/src/domain/models/SearchUnsafeAction.dart';
import 'package:sipil_app/src/domain/models/UnsafeAction.dart';
import 'package:sipil_app/src/domain/models/response/UnsafeActionResponse.dart';
import 'package:sipil_app/src/domain/models/response/UnsafeUniqueActionResponse.dart';
import 'package:sipil_app/src/domain/utils/ListToString.dart';
import 'package:sipil_app/src/domain/utils/Resource.dart';
import 'package:http_parser/http_parser.dart' show MediaType;
import 'package:http/http.dart' as http;

class UnsafeActionService {

  Future<Resource<UnsafeUniqueActionResponse>> register(UnsafeAction unsafeAction) async {
    try {
      Uri url = Uri.https(ApiConfig.API_BASE, '/unsafe-act/register');
      // Uri url = Uri.http(ApiConfig.API_BASE, '/unsafe-act/register');
      Map<String, String> headers = {
        "Content-Type": "application/json"
      };
      String body = jsonEncode(unsafeAction.toJson());
      print('URL si ${url}');
      print('BODY ${body}');
      final response = await http.post(url, headers: headers, body: body);
      final data = json.decode(response.body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        UnsafeUniqueActionResponse authResponse = UnsafeUniqueActionResponse.fromJson(data);
        return Success(authResponse);
      } else {
        return Error(listToString(data['message']), 'Error', data['statusCode']);
      }
    } catch (e) {
      return Error(e.toString(), e.toString(), 400);
    }
  }

  Future<Resource<UnsafeUniqueActionResponse>> registerImage(UnsafeAction unsafeAction, File file) async {
    try {
      Uri url = Uri.https(ApiConfig.API_BASE, '/unsafe-act/register-img');
      // Uri url = Uri.http(ApiConfig.API_BASE, '/unsafe-act/register-img');
      final request = http.MultipartRequest('POST', url);

      request.files.add(http.MultipartFile(
        'file',
        http.ByteStream(file.openRead().cast()),
        await file.length(),
        filename: basename(file.path),
        contentType: MediaType('image', 'jpeg'),
      ));

      request.fields['date'] = unsafeAction.date!.toIso8601String();
      request.fields['hour'] = unsafeAction.hour!;
      request.fields['location'] = unsafeAction.location!;
      request.fields['repAct1'] = unsafeAction.repAct1.toString();
      request.fields['repAct2'] = unsafeAction.repAct2.toString();
      request.fields['repAct3'] = unsafeAction.repAct3.toString();
      request.fields['repAct4'] = unsafeAction.repAct4.toString();
      request.fields['repAct5'] = unsafeAction.repAct5.toString();
      request.fields['repAct6'] = unsafeAction.repAct6.toString();
      request.fields['repAct7'] = unsafeAction.repAct7.toString();
      request.fields['repAct8'] = unsafeAction.repAct8.toString();
      request.fields['repAct9'] = unsafeAction.repAct9.toString();
      request.fields['repAct10'] = unsafeAction.repAct10.toString();
      request.fields['repAct11'] = unsafeAction.repAct11.toString();
      request.fields['repAct12'] = unsafeAction.repAct12.toString();
      request.fields['repAct13'] = unsafeAction.repAct13.toString();
      request.fields['immediate_action'] = unsafeAction.immediateAction!;
      request.fields['suggestion_improvement'] = unsafeAction.suggestionImprovement!;
      request.fields['status'] = unsafeAction.status.toString();
      request.fields['answer'] = unsafeAction.answer!;
      request.fields['userId'] = unsafeAction.userId.toString();

      print('URL: Img ${url}');
      print('BODY Img: ${jsonEncode(unsafeAction.toJson())}');
      print('File: ${file.path}');

      final response = await request.send();

      final data = json.decode(await response.stream.transform(utf8.decoder).first);
      print('response ${data}');
      if (response.statusCode == 200 || response.statusCode == 201) {
        UnsafeUniqueActionResponse authResponse = UnsafeUniqueActionResponse.fromJson(data);
        return Success(authResponse);
      } else {
        return Error(listToString(data['message']), 'Error', data['statusCode']);
      }
    } catch (e) {
      return Error(e.toString(), "Error inesperado ${e.toString()}", 400);
    }
  }

  Future<Resource<UnsafeUniqueActionResponse>> updateUnsafeAct(int id, UnsafeAction unsafeAction) async {
    try {
      Uri url = Uri.https(ApiConfig.API_BASE, '/unsafe-act/$id');
      Map<String, String> headers = {
        "Content-Type": "application/json"
      };
      String body = jsonEncode(unsafeAction.toJson());

      print('URL: $url');
      print('BODY: $body');

      final response = await http.put(url, headers: headers, body: body);
      final data = json.decode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        UnsafeUniqueActionResponse authResponse = UnsafeUniqueActionResponse.fromJson(data);
        return Success(authResponse);
      } else {
        return Error(listToString(data['message']), 'Error', data['statusCode']);
      }
    } catch (e) {
      return Error(e.toString(), e.toString(), 400);
    }
  }


  Future<Resource<UnsafeUniqueActionResponse>> updateUnsafeActWithImage(int id, UnsafeAction unsafeAction, File file) async {
    try {
      Uri url = Uri.https(ApiConfig.API_BASE, '/unsafe-act/update-img/$id');
      final request = http.MultipartRequest('PUT', url);

      if (file != null) {
        request.files.add(http.MultipartFile(
          'file',
          http.ByteStream(file.openRead().cast()),
          await file.length(),
          filename: basename(file.path),
          contentType: MediaType('image', 'jpeg'),
        ));
      }

      request.fields['date'] = unsafeAction.date!.toIso8601String();
      request.fields['hour'] = unsafeAction.hour!;
      request.fields['location'] = unsafeAction.location!;
      request.fields['repAct1'] = unsafeAction.repAct1.toString();
      request.fields['repAct2'] = unsafeAction.repAct2.toString();
      request.fields['repAct3'] = unsafeAction.repAct3.toString();
      request.fields['repAct4'] = unsafeAction.repAct4.toString();
      request.fields['repAct5'] = unsafeAction.repAct5.toString();
      request.fields['repAct6'] = unsafeAction.repAct6.toString();
      request.fields['repAct7'] = unsafeAction.repAct7.toString();
      request.fields['repAct8'] = unsafeAction.repAct8.toString();
      request.fields['repAct9'] = unsafeAction.repAct9.toString();
      request.fields['repAct10'] = unsafeAction.repAct10.toString();
      request.fields['repAct11'] = unsafeAction.repAct11.toString();
      request.fields['repAct12'] = unsafeAction.repAct12.toString();
      request.fields['repAct13'] = unsafeAction.repAct13.toString();
      request.fields['immediate_action'] = unsafeAction.immediateAction!;
      request.fields['suggestion_improvement'] = unsafeAction.suggestionImprovement!;
      request.fields['status'] = unsafeAction.status.toString();
      request.fields['answer'] = unsafeAction.answer!;
      request.fields['userId'] = unsafeAction.userId.toString();

      print('URL: $url');
      print('BODY: ${jsonEncode(unsafeAction.toJson())}');
      print('File: ${file.path}');

      final response = await request.send();

      final data = json.decode(await response.stream.transform(utf8.decoder).first);
      print('response $data');
      if (response.statusCode == 200 || response.statusCode == 201) {
        UnsafeUniqueActionResponse authResponse = UnsafeUniqueActionResponse.fromJson(data);
        return Success(authResponse);
      } else {
        return Error(listToString(data['message']), 'Error', data['statusCode']);
      }
    } catch (e) {
      return Error(e.toString(), "Error inesperado ${e.toString()}", 400);
    }
  }


  Future<Resource<UnsafeActionResponse>> search(SearchUnsafeAction searchUnsafeAction) async {
    try {
      Uri url = Uri.https(ApiConfig.API_BASE, '/unsafe-act/search');
      // Uri url = Uri.http(ApiConfig.API_BASE, '/unsafe-act/search');
      Map<String, String> headers = {
        "Content-Type": "application/json"
      };
      print('URL ${url}');
      print('BODY ${jsonEncode(searchUnsafeAction.toJson())}');
      final response = await http.post(url, headers: headers, body: jsonEncode(searchUnsafeAction.toJson()));
      final data = json.decode(response.body);
      print('RESPONSE ${data}');
      if (response.statusCode == 200 || response.statusCode == 201) {
        UnsafeActionResponse searchUnsafeAction = UnsafeActionResponse.fromJson(data);
        return Success(searchUnsafeAction);
      } else {
        return Error(data['message'], 'Error', data['statusCode']);
      }

    } catch (e) {
      return Error(e.toString(), e.toString(), 400);
    }
  }

}