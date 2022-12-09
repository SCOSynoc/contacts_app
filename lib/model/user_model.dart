import 'package:contacts_app/model/data_model.dart';

class UserModel {
  final String fullName;
  final String email;
  final String mobileNo;
  final String password;
  final String cPassword;
  final String gender;
  final String dob;
  final String? name;
  final String? id;
  final String? emailVerifiedAt;


  UserModel( {
    required this.fullName,
    required this.email,
    required this.mobileNo,
    required this.password,
    required this.gender,
     this.name,
    required this.cPassword ,
    required this.dob,
     this.id,
     this.emailVerifiedAt,
  }
    );

  Map<String, dynamic> toJson() {
    Map<String , dynamic> map = {
    "full_name":fullName,
    "email": email,
    "mobile_no": mobileNo,
    "password": password,
    "c_password": cPassword,
    "gender": gender,
    "dob": dob,
    };
    return map;
  }


  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
        fullName: json["full_name"] ?? "",
        email: json["email"] ?? "",
        mobileNo: json["mobile_no"] ?? "",
        password: json["password"] ?? "",
        gender: json["gender"] ?? "",
        name: json["name"] ?? "",
        cPassword: json["c_password"] ?? "",
        dob: json["dob"] ?? "", id: json["id"] ?? "", emailVerifiedAt: json["email_verified_at"]??"",
    );
  }

}


class UserResponseModel {
  final bool success;
  final DataModel? data;
  final Map<String, dynamic>? errordata;
  final String message;
  
  UserResponseModel( { this.data,required this.message,required this.success, this.errordata,});
  
  factory UserResponseModel.fromJson(Map<String, dynamic> json) {
    if(json["success"] == false) {
      return UserResponseModel(errordata: json["data"] , message: json["message"], success: json["success"]);
    }else{
      return UserResponseModel(data: json["data"] , message: json["message"], success: json["success"]);
    }

  }

}

