import 'dart:convert';
import 'dart:developer';
import 'package:contacts_app/global/constants.dart';
import 'package:contacts_app/model/user_model.dart';
import 'package:contacts_app/screens/login_screen.dart';
import 'package:contacts_app/screens/profile_screen.dart';
import 'package:contacts_app/services/registration_service.dart';
import 'package:contacts_app/widgets/dropdown.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:xrandom/xrandom.dart';

import '../widgets/common_textfeild.dart';

class RegisterScreen extends StatefulWidget {
  RegisterScreen({this.email, this.dob,this.name, this.mobile, this.gender, this.fors});
  final String? name;
  final String? mobile;
  final String? dob;
  final String? email;
  final String? gender;
  final String? fors;


  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {

  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController conPasswordController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  Map<String, dynamic> userDecodeData = {};
  List<String> itemsList = ["MALE","FEMALE"];
  String? itvalue;
  String Gender = "";


  @override
  void initState() {
   nameController.text = widget.name == null ? "": widget.name!;
   mobileController.text = widget.mobile == null ? "":widget.mobile!;
   dobController.text =widget.dob == null ? "" :widget.dob!;
   emailController.text =widget.email == null ? "" :widget.email!;
   Gender = widget.gender == null ? "": widget.gender!;

  }


  Future<SharedPreferences> getShared() async{
    return await SharedPreferences.getInstance();
  }

  void getPrefsData() async{
    SharedPreferences pRefs = await getShared();
    String encodeMap  = pRefs.getString("UserData") ?? "";
    if(encodeMap != "") {
      setState(() {
        userDecodeData = json.decode(encodeMap);
      });
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: Colors.orange,
        automaticallyImplyLeading: false,
        title: Text(widget.fors == "update"?"Update Screen":"Registration Screen"),
      ),

      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              CommonTextFeild(hint: "Full name", textEditingController: nameController),
              CommonTextFeild(hint: "Email", textEditingController: emailController),
              Visibility(
                visible: widget.fors == "update"? false : true,
                  child: CommonTextFeild(hint: "password", textEditingController: passwordController, obscure: true,)),
              Visibility(
                  visible: widget.fors == "update"? false : true,
                  child: CommonTextFeild(hint: "Confirm password", textEditingController: conPasswordController, obscure: true,)),
              CommonTextFeild(hint: "Mobile no", textEditingController: mobileController),
              CommonTextFeild(hint: "Date of birth", textEditingController: dobController),
              DropDownWidget(
                itemValue: itvalue, itemsList: itemsList, changed: (value) {
                setState(() {
                  itvalue = value;
                  if(itvalue != null){
                     Gender = itvalue!;
                  }
                });
              },),

              Padding(
                padding: const EdgeInsets.only(top: 28.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.orange,
                    borderRadius: BorderRadius.circular(30.0)
                  ),
                  child: MaterialButton(
                    child: Text(widget.fors == "update"?"Update" : "Register user"),
                    onPressed: () async  {
                      if(widget.fors == "update") {
                          makeUpdationProcess();
                      }else{
                        makeRegistrationProcess();
                      }

                    },

                  ),
                ),
              ),
              Visibility(
                visible: widget.fors == "update"? false : true,
                child: Container(
                  padding: EdgeInsets.only(top: 35.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Already have an account?",style: GoogleFonts.overpass(fontWeight: FontWeight.w500, fontSize: 18)),
                      InkWell(
                         onTap: () {
                           Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen() ));
                         },
                          child: Text(" Login ", style: GoogleFonts.overpass(fontWeight: FontWeight.w500, fontSize: 18),)
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }



  void makeRegistrationProcess() async {
    SharedPreferences shared = await SharedPreferences.getInstance();
    UserModel addModel = UserModel(fullName: nameController.text,
        email: emailController.text,
        mobileNo: mobileController.text,
        password: passwordController.text,
        gender: Gender,
        cPassword: conPasswordController.text,
        dob: dobController.text);
    final xrandom = Xrandom();
    int randomNumber = xrandom.nextInt(1000);
    Map<String, dynamic> prefsData= {
      "name": nameController.text,
      "email":  emailController.text,
      "mobile": mobileController.text,
      "dob": dobController.text,
      "gender": Gender,
      "password": conPasswordController.text,
      "id": randomNumber
    };
    int token = (randomNumber + randomNumber) * randomNumber;
    bool isData = false;
    RegistrationService apiService = RegistrationService();
    await apiService.registerUser(addModel).then((value) {
      if(value.success) {
        log("here data is ${value.data}");

      }else if(value.data == null){
        isData = true;
        List<dynamic> msgs = value.errordata!.values.toList();
        log("list are ${msgs}");
        showPopUpDialog(context: context, textTitle: "Alert", msgText: msgs, pressed: () {
          Navigator.pop(context);
        });
        log("here data is ${value.data} and ${value.errordata}  message ${value.message}");
      }
    }).onError((error, stackTrace) {
      log("here i am in an error with ${error} and ${stackTrace}");
    });

    String encodeMap = json.encode(prefsData);
    shared.setString("UserData", encodeMap);
    shared.setInt("sessionToken", token);
    if(!isData){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => ProfileScreen()));
    }
  }

  void makeUpdationProcess() async {
    SharedPreferences shared = await SharedPreferences.getInstance();

    String encodeMap  = shared.getString("UserData") ?? "";
    if(encodeMap != "") {
      setState(() {
        userDecodeData = json.decode(encodeMap);
      });
    }
    UserModel addModel = UserModel(fullName: nameController.text.isEmpty? userDecodeData["name"] :nameController.text,
        email: emailController.text.isEmpty ? userDecodeData["email"]:emailController.text,
        mobileNo: mobileController.text.isEmpty ?userDecodeData["mobile"]:mobileController.text ,
        password: userDecodeData["password"],
        gender: Gender.isEmpty? userDecodeData["gender"]:Gender,
        cPassword: userDecodeData["password"],
        dob: dobController.text.isEmpty ? userDecodeData["dob"] : dobController.text);
    final xrandom = Xrandom();
    int randomNumber = xrandom.nextInt(1000);
    Map<String, dynamic> prefsData= {
      "name": nameController.text.isEmpty? userDecodeData["name"] :nameController.text,
      "email": emailController.text.isEmpty ? userDecodeData["email"]:emailController.text,
      "mobile": mobileController.text.isEmpty ?userDecodeData["mobile"]:mobileController.text ,
      "dob": dobController.text.isEmpty ? userDecodeData["dob"] : dobController.text,
      "gender": Gender.isEmpty? userDecodeData["gender"]:Gender,
      "password": userDecodeData["password"],
      "id": userDecodeData["id"]
    };

    bool isData = false;
    RegistrationService apiService = RegistrationService();
    await apiService.updateUser(addModel).then((value) {
      if(value.success) {
        log("here data is ${value.data}");
      }else if(value.data == null){
        isData = true;
        List<dynamic> msgs = value.errordata!.values.toList();
        log("list are ${msgs}");
        showPopUpDialog(context: context, textTitle: "Alert", msgText: msgs, pressed: () {
          Navigator.pop(context);
        });
        log("here data is ${value.data} and ${value.errordata}  message ${value.message}");
      }
    }).onError((error, stackTrace) {
      log("here i am in an error with ${error} and ${stackTrace}");
    });

    String encodeUpdateMap = json.encode(prefsData);
    shared.setString("UserData", encodeUpdateMap);
    //shared.setInt("sessionToken", token);
    if(!isData){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => ProfileScreen()));
    }

  }
}
