import 'dart:convert';
import 'dart:developer';
import 'package:contacts_app/screens/profile_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:xrandom/xrandom.dart';

import '../global/constants.dart';
import '../services/registration_service.dart';
import '../widgets/common_textfeild.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  Map<String, dynamic> decodedUserData = {};


  Future<SharedPreferences> getShared() async{
    return await SharedPreferences.getInstance();
  }

  void getPrefsData() async{
    SharedPreferences pRefs = await getShared();
    String encodeMap  = pRefs.getString("UserData") ?? "";
    if(encodeMap != "") {
      decodedUserData = json.decode(encodeMap);
    }
  }


  @override
  void initState() {
    super.initState();
    getPrefsData();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.orange,
        title: Text("Login screen"),
      ) ,
      body:Container(
        child: Column(
          children: [
            CommonTextFeild(hint: "Email", textEditingController: emailController),
            CommonTextFeild(hint: "Password", textEditingController: passwordController, obscure: true,),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.orange,
                    borderRadius: BorderRadius.circular(30.0)
                ),
                child: MaterialButton(
                  child: Text("Login"),
                  onPressed: () async  {
                    makeLoginProcess();
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void makeLoginProcess() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final xrandom = Xrandom();
    int randomNumber = xrandom.nextInt(1000);
    int token = (randomNumber + randomNumber) * randomNumber * randomNumber;
    RegistrationService apiService = RegistrationService();
    await apiService.loginUser(emailController.text, passwordController.text ).then((value) {
      if(value.success) {
        log("here data is ${value.data}");
      }else if(value.data == null){
        List<dynamic> msgs = value.errordata!.values.toList();
        log("list are ${msgs}");
        showPopUpDialog(context: context, textTitle: "Alert", msgText: msgs, pressed: () {
          Navigator.pop(context);
        });
        log("here data is ${value.data} and ${value.errordata}  message ${value.message}");
      }
    }).onError((error, stackTrace) {
      log("here i am in an error with ${error} and ${stackTrace}");

      if(emailController.text == decodedUserData["email"] && passwordController.text == decodedUserData["password"]) {
        prefs.setInt("sessionToken", token);
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => ProfileScreen()));
      }else{
        List<String> errorMSGS = ["Authentication error", "Try Again"];
        showNormalPopUpDialog(context: context, textTitle: "Failed", msgText: "Authentication error try Again", pressed: () {
          Navigator.pop(context);
        });
      }
    });
  }
}
