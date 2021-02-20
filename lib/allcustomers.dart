

import 'package:basicbankingapp/alltransactions.dart';
import 'package:flutter/material.dart';
import 'customerprofile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Allcustomers extends StatefulWidget {
  @override
  _AllcustomersState createState() => _AllcustomersState();
}

class _AllcustomersState extends State<Allcustomers> {
  TextStyle _textStyle(double x) {
    return TextStyle(
        fontSize: x, fontWeight: FontWeight.w600, color: Colors.white);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(32, 132, 113, 1),
          centerTitle: true,
          title: Text(
            'All Customers',
            style: (TextStyle(fontSize: 30, fontWeight: FontWeight.w500)),
          ),
          actions: [
            IconButton(
                padding: EdgeInsets.only(right: 20),
                icon: Icon(
                  Icons.fast_forward_outlined,
                  size: 30,
                ),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return AllTransactions();
                  }));
                })
          ],
        ),
        backgroundColor: Colors.white,
        body: WillPopScope(
          onWillPop: () {
            return
            Navigator.popAndPushNamed(context, '/home');
          },
          child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection("customers")
                  .snapshots(),
              builder: (context, snapshot) {
                return !snapshot.hasData
                    ? Center(child: CircularProgressIndicator())
                    : ListView.builder(
                        itemCount: snapshot.data.docs.length,
                        itemBuilder: (context, index) {
                          DocumentSnapshot data = snapshot.data.docs[index];

                          return GestureDetector(
                            onTap: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return CustomerProfile(
                                  name: data['name'],
                                  email: data['email'],
                                  customerid: data['customerid'],
                                  currentbalance: data['currentbalance'],
                                  tid: data.id,
                                  accountno: data['account'],
                                );
                              }));
                            },
                            child: Container(
                              margin: EdgeInsets.all(30),
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: Color.fromRGBO(32, 132, 113, 1),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black38,
                                    // soften the shadow
                                    spreadRadius: 5.0, //extend the shadow
                                    offset: Offset(
                                      8.0, // Move to right 10  horizontally
                                      9.0, // Move to bottom 10 Vertically
                                    ),
                                  )
                                ],
                              ),
                              child: ListTile(
                                leading:
                                    Icon(Icons.view_list, color: Colors.white),
                                title: Text(
                                  data['name'],
                                  maxLines: 1,
                                  style: _textStyle(25),
                                ),
                                subtitle: Text(
                                  data['email'],
                                  style: _textStyle(15),
                                ),
                                trailing: Text(
                                    "₹ " + data['currentbalance'].toString(),
                                    style: _textStyle(20)),
                              ),
                            ),
                          );
                        });
              }),
        ));
  }
}
