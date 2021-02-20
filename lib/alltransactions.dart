import 'package:flutter/material.dart';
import 'customerprofile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AllTransactions extends StatefulWidget {
  @override
  _AllTransactionsState createState() => _AllTransactionsState();
}

class _AllTransactionsState extends State<AllTransactions> {
  TextStyle _passorfail(String status){
    if (status=='Success'){
     return TextStyle(
        fontSize:22, 
        fontWeight: FontWeight.w600, 
        color: Colors.green);
    }
    else{
       return TextStyle(
        fontSize:20, 
        fontWeight: FontWeight.w600, 
        color: Colors.red);
    }
  }

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
            'All Transactions',
            style: (TextStyle(fontSize: 30, fontWeight: FontWeight.w500)),
          ),
          
        ),
        backgroundColor: Colors.white,
        body: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection("transactions")
                .snapshots(),
            builder: (context, snapshot) {
              return !snapshot.hasData
                  ? Center(
                    child: CircularProgressIndicator())
                  : ListView.builder(
                      itemCount: snapshot.data.docs.length,
                      itemBuilder: (context, index) {
                        DocumentSnapshot data = snapshot.data.docs[index];

                        return Container(
                          margin: EdgeInsets.all(5),
                          padding: EdgeInsets.all(3),
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
                            title: Text(
                              data['tname'] + " >> " + data['rname'],
                              style: _textStyle(24),
                            ),
                            subtitle: Text(
                              data['Date'],
                              style: _textStyle(18),
                            ),
                            trailing: Column(
                              children: [
                                Text(
                                  " ₹ "+data['Amount'],
                                  style: _textStyle(22),
                                ),
                                Text(
                                  data['Status'],
                                  style: _passorfail( data['Status']),
                                )
                              ],
                            ),
                          ),
                        );
                      });
            }));
  }
}
