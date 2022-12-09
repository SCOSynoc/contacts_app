import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ContactsList extends StatefulWidget {
  final String userId;
  ContactsList({required this.userId});

  @override
  _ContactsListState createState() => _ContactsListState();
}

class _ContactsListState extends State<ContactsList> {
  @override
  Widget build(BuildContext context) {
    Stream<QuerySnapshot> contacts = FirebaseFirestore.instance.collection('contacts').snapshots();
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.orange,
        title: Text("Contacts list"),
      ),
      body: Container(
        height: 250,
        padding: EdgeInsets.symmetric(vertical: 20),
        child: StreamBuilder<QuerySnapshot>(
          stream: contacts,
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if(snapshot.hasError){
              return Text("Something with wrong");
            }
            if(snapshot.connectionState == ConnectionState.waiting){
              return Column(
                children:[
                  Center(child: CircularProgressIndicator(color: Colors.orange,),)
                ],
              );
            }
            final data = snapshot.requireData;
            List<dynamic> queryList = data.docs;
            List<dynamic> dataList = [];
            for(var data in queryList) {
              if(data["createdBy"] == widget.userId) {
                log(data["createdBy"]);
                dataList.add(data);
              }
            }

            log("here data list is ${dataList}");

            return dataList.isEmpty ? Center(child: Text("You haven't added any contact",
              style: GoogleFonts.overpass(fontSize: 24, fontWeight: FontWeight.w500,color: Colors.orange),)):ListView.builder(
                itemCount: dataList.length,
                itemBuilder: (context, index) {
                return ListTile(title: Text("${dataList[index]['name']}",
                  style:GoogleFonts.overpass(fontSize: 18, fontWeight: FontWeight.w500,color: Colors.black54) ,),
                  subtitle: Text("${dataList[index]["email"]}",
                      style:GoogleFonts.overpass(fontSize: 18, fontWeight: FontWeight.w500,color: Colors.black54) ),);
            });
          },
        ),
      ),
    );
  }
}
