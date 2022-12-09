import 'dart:convert';
import 'dart:developer';

import 'package:contacts_app/global/globals.dart';
import 'package:contacts_app/model/user_model.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;

class RegistrationService {


  Future<UserResponseModel> registerUser(UserModel model) async {
    String kbaseUrl = Global.url + "register";
    var headers = {
      'Content-Type': 'application/x-www-form-urlencoded'
    };

    Response response;

    try {
      response = await http.post(Uri.parse(kbaseUrl), headers: headers, body: model.toJson());
      if(response.statusCode == 200) {
        log("here response is ${json.decode(response.body)}");
        return UserResponseModel.fromJson(json.decode(response.body));
      }else if(response.statusCode == 500) {
        return UserResponseModel.fromJson(json.decode(response.body));
      }else {
        log("here response is ${json.decode(response.body)}");
        return UserResponseModel.fromJson(json.decode(response.body));
      }
    }catch(e) {
      throw Exception(e);
    }
  }

   Future<UserResponseModel> loginUser(String email, String password) async {
     String kbaseUrl = Global.url + "login";
     var headers = {
       'Content-Type': 'application/x-www-form-urlencoded'
     };
     Map<String, dynamic> map = {
       "email": email,
       "password": password
     };

     Response response;

     try {
       response = await http.post(Uri.parse(kbaseUrl), headers: headers, body: map);
       if(response.statusCode == 200) {
         log("here response is ${json.decode(response.body)}");
         return UserResponseModel.fromJson(json.decode(response.body));
       }else if(response.statusCode == 500) {
         log("here response is ${json.decode(response.body)}");
         return UserResponseModel.fromJson(json.decode(response.body));
       }else {
         log("here response is ${json.decode(response.body)}");
         return UserResponseModel.fromJson(json.decode(response.body));
       }
     }catch(e) {
       throw Exception(e);
     }
   }

  Future<UserResponseModel> updateUser(UserModel model) async {
    String kbaseUrl = Global.url + "register";
    var headers = {
      'Content-Type': 'application/x-www-form-urlencoded'
    };

    Response response;

    try {
      response = await http.post(Uri.parse(kbaseUrl), headers: headers, body: model.toJson());
      if(response.statusCode == 200) {
        log("here response is ${json.decode(response.body)}");
        return UserResponseModel.fromJson(json.decode(response.body));
      }else if(response.statusCode == 500) {
        return UserResponseModel.fromJson(json.decode(response.body));
      }else {
        log("here response is ${json.decode(response.body)}");
        return UserResponseModel.fromJson(json.decode(response.body));
      }
    }catch(e) {
      throw Exception(e);
    }
  }


}