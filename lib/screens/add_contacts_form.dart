import 'package:contacts_app/firebase/firebase.dart';
import 'package:contacts_app/model/contacts_model.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:xrandom/xrandom.dart';

import '../global/globals.dart';
import '../widgets/common_textfeild.dart';

class AddContactsForm extends StatefulWidget {
  final String userId;
  final String name;
  AddContactsForm({required this.userId, required this.name});

  @override
  _AddContactsFormState createState() => _AddContactsFormState();
}

class _AddContactsFormState extends State<AddContactsForm> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController contactsController = TextEditingController();


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        automaticallyImplyLeading: false,
        title: Text("Add contaacts"),
      ),
      body: Column(
        children: [
          CommonTextFeild(hint: "Email", textEditingController: emailController),
          CommonTextFeild(hint: "Fullname", textEditingController: fullNameController),
          CommonTextFeild(hint: "Contacts", textEditingController: contactsController),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.orange,
                borderRadius: BorderRadius.circular(25)
              ),
              child: MaterialButton(
                child: Text("Add"),
                onPressed: () async{
                  final xrandom = Xrandom();
                  int randomNumber = xrandom.nextInt(1000000);
                  AddContacts contacts = AddContacts(
                      fullName: fullNameController.text,
                      email: emailController.text,
                      contactNumber: contactsController.text,
                      createdby: widget.userId
                  );
                  Firestore firebase = Firestore() ;
                  await firebase.createFirebaseCollection(contacts, widget.userId, randomNumber.toString(), context);

                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
