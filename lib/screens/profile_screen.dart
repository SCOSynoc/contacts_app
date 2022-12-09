import 'dart:convert';

import 'package:contacts_app/screens/add_contacts_form.dart';
import 'package:contacts_app/screens/register_screen.dart';
import 'package:contacts_app/screens/splash_screen.dart';
import 'package:contacts_app/screens/view_contact_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../global/globals.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  Map<String, dynamic> decodedUserData = {};

  Future<SharedPreferences> getShared() async{
    return await SharedPreferences.getInstance();
  }

  void getPrefsData() async{
    SharedPreferences pRefs = await getShared();
    String encodeMap  = pRefs.getString("UserData") ?? "";
    if(encodeMap != "") {
      setState(() {
        decodedUserData = json.decode(encodeMap);
      });
    }
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPrefsData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Profile Screen"),
            InkWell(
                 onTap: () async{
                   SharedPreferences prefs = await SharedPreferences.getInstance();
                   prefs.remove("sessionToken");
                   Navigator.pushAndRemoveUntil(context, MaterialPageRoute( builder: (BuildContext context) => SplashScreen()), (route) => false);

                 },
                child: Icon(CupertinoIcons.power, color: Colors.white, size: 25,)
            )
          ],
        ),


      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(28.0),
                child: Card(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                          Text("Update profile",style:Global.commonTextStyle,),
                          IconButton(onPressed:() {
                              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>
                                  RegisterScreen(
                                    name:decodedUserData["name"],
                                    email: decodedUserData["email"],
                                    mobile: decodedUserData["mobile"],
                                    gender: decodedUserData["gender"],
                                    dob: decodedUserData["dob"],
                                    fors: "update",

                                  )
                              )
                              );
                            }, icon: Icon(IconlyBold.edit, color: Colors.orange,)
                          )
                        ],),
                      ),
                      ListTile(leading: Text("Name",style: Global.commonTextStyle,),
                        trailing: Text("${decodedUserData["name"]}",style: Global.commonTextStyle,), ),
                      ListTile(leading: Text("Email",style: Global.commonTextStyle,),
                        trailing: Text("${decodedUserData["email"]}",style: Global.commonTextStyle,), ),
                      ListTile(leading: Text("Mobile",style: Global.commonTextStyle,),
                        trailing: Text("${decodedUserData["mobile"]}",style: Global.commonTextStyle,), ),
                      ListTile(leading: Text("Gender",style: Global.commonTextStyle,),
                        trailing: Text("${decodedUserData["gender"]}",style: Global.commonTextStyle,), ),
                      ListTile(leading: Text("Date of birth",style: Global.commonTextStyle,),
                        trailing: Text("${decodedUserData["dob"]}",style: Global.commonTextStyle,), ),
                    ],
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(28.0),
                child: Container(
                  width: Global.getSizeWidth(context),
                  decoration: BoxDecoration(
                      color: Colors.orange,
                      borderRadius: BorderRadius.circular(30.0)
                  ),
                  child: MaterialButton(
                    child: Text("Add contacts"),
                    onPressed: () async  {
                       Navigator.push(context, MaterialPageRoute(builder: (context) => AddContactsForm(userId: decodedUserData["id"].toString(),
                         name: decodedUserData["name"],)));
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(28.0),
                child: Container(
                  width: Global.getSizeWidth(context),
                  decoration: BoxDecoration(
                      color: Colors.orange,
                      borderRadius: BorderRadius.circular(30.0)
                  ),
                  child: MaterialButton(
                    child: Text("view contacts"),
                    onPressed: () async  {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => ContactsList(userId: decodedUserData["id"].toString(),)));
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
