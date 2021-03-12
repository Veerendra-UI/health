import 'dart:convert';
import 'package:YOURDRS_FlutterAPP/common/app_strings.dart';
import 'package:YOURDRS_FlutterAPP/network/models/login/user_class.dart';
import 'package:http/http.dart' as http;

class ApiServices {
  /// passing the controller valued in service
  Future<AuthenticateUser> postApiMethod(String name, String password) async {
    String apiUrl = ApiUrlConstants.getUser;
    print('requestUrl $apiUrl');

    final json = {
      "userName": name,
      "password": password,
      "deviceCode": "string",
      "encryptionKey": "string"
    };

    http.Response response = await http.post(
      apiUrl,
      body: jsonEncode(json),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    print(response);

    var jsonResponse = jsonDecode(response.body);
    print(jsonResponse);
    return AuthenticateUser.fromJson(jsonResponse);
  }
}
