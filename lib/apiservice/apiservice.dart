import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:videotutorial/helper/PreferenceHelper.dart';
import 'package:videotutorial/model/LoginModel.dart';
import 'package:videotutorial/model/UnAuthorizedModel.dart';

class ApiService {
  static var client = http.Client();
  static PreferenceHelper preferenceHelper = new PreferenceHelper();
  String jwttoken;

  ApiService() {
    // getJwtToken().then((value) {
    //   jwttoken = value;
    //   print(jwttoken);
    // });
  }

  Future<dynamic> UserLogin(String username, String password) async {
    var body = {"username": "${username}", "password": "${password}","twoFactorCode":null};
    var response = await client.post(
        Uri.parse('https://webhooktest61.advanceprotech.com/api/Authenticate/login'),
        body: jsonEncode(body),
        headers: {"Content-Type": "application/json-patch+json"});

    if (response.statusCode == 200) {
      LoginModel loginModel = loginModelFromJson(response.body);
      print(response.body);
      preferenceHelper.setJwtToken(loginModel.successResonse.token);
      preferenceHelper.setIsLoggedIn(true);
      return loginModel;
    } else if(response.statusCode == 401){
      var jsonString = response.body;
      UnAuthorizedModel unAuthorizedModel = unAuthorizedModelFromJson(jsonString);
      preferenceHelper.setJwtToken(null);
      preferenceHelper.setIsLoggedIn(false);
      return unAuthorizedModel;
    }
    else{
      print(response.statusCode);
    }
  }

  }
