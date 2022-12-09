
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:contacts_app/global/constants.dart';
import 'package:contacts_app/model/contacts_model.dart';
import 'package:contacts_app/screens/view_contact_list.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';




class Firestore {
 final FirebaseFirestore _firebase = FirebaseFirestore.instance;

  List<String> msgList = ["Contact added successfully"];
  createFirebaseCollection(AddContacts contacts, String userId, String docId, BuildContext context)async {
    CollectionReference userCollections = _firebase.collection("contacts");

    await userCollections.add({
        "name":contacts.fullName,
        "contactNumber": contacts.contactNumber,
        "email":contacts.email,
        "createdBy": contacts.createdby,
    }).then((value) => {
      showNormalPopUpDialog(context: context, textTitle: "Success", msgText: "Contact added successfully", pressed: () {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ContactsList(userId: userId)) );
      })
    });
  }


/* getFirebaseCollection(AddContacts contacts, String userId, String docId)async {
   var userCollections = _firebase.collection("contacts");

 }*/



}

