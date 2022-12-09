import 'package:contacts_app/model/user_model.dart';

class DataModel {
  final UserModel userDetails;
  final String token;

  DataModel({required this.userDetails, required this.token});

  factory DataModel.fromJson(Map<String, dynamic> json) {
    return DataModel(userDetails: json["user_details"], token: json["token"]);
  }
}

class ErrorDataModel {
  final Map<String, dynamic> data;


  ErrorDataModel({required this.data});

  factory ErrorDataModel.fromJson(Map<String, dynamic> json) {
    return ErrorDataModel(data: json["data"]);
  }
}