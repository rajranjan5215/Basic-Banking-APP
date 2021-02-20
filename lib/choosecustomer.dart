
import 'package:basicbankingapp/transfermoney.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'models/customermodel.dart';

class ChooseCustomer extends StatefulWidget {
  final String tname;
  final String temail;
  final int tcurrentbalance;
  final int tcustomerid;
  final tid;
  ChooseCustomer(
      {this.tname, this.tcustomerid, this.temail, this.tcurrentbalance,this.tid});
  @override
  _ChooseCustomerState createState() => _ChooseCustomerState();
}

class _ChooseCustomerState extends State<ChooseCustomer> {
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
            'Choose Customers',
            style: (TextStyle(fontSize: 30, fontWeight: FontWeight.w500)),
          ),
        ),
        backgroundColor: Colors.white,
        body: StreamBuilder<QuerySnapshot>(
            stream:
                FirebaseFirestore.instance.collection("customers").snapshots(),
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
                              return Transfermoney(
                                  widget.tname,
                                  widget.tcustomerid,
                                  widget.tcurrentbalance,
                                  widget.tid,
                                  data['name'],
                                  data['customerid'],
                                  data['currentbalance'],
                                  data.id);
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
            }));
  }
}
