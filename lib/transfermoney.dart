
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class Transfermoney extends StatefulWidget {
  String tname;
  int tcustomerid;
  int tcurrentbalance;
  String rname;
  int rcustomerid;
  int rcurrentbalance;
  var tid;
  var rid;

  Transfermoney(this.tname, this.tcustomerid, this.tcurrentbalance, this.tid,
      this.rname, this.rcustomerid, this.rcurrentbalance, this.rid);

  @override
  _TransfermoneyState createState() => _TransfermoneyState();
}

class _TransfermoneyState extends State<Transfermoney> {
  showAlertDialog(BuildContext context, String content) {
    // set up the button
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () {
        amountcontroller.text = '';
        Navigator.of(context).pop();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Alert"),
      content: Text(content),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  TextStyle _textStyle(double x) {
    return TextStyle(
        fontSize: x, fontWeight: FontWeight.w600, color: Colors.white);
  }

  TextEditingController amountcontroller = new TextEditingController();
  var trans = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(32, 132, 113, 1),
        title: Text('Transfer Money',
            style: (TextStyle(fontSize: 30, fontWeight: FontWeight.w500))),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
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
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Text(
                        '${widget.tname}',
                        maxLines: 1,
                        style: _textStyle(23),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Icon(
                        Icons.double_arrow,
                        color: Colors.white,
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Text(
                        '${widget.rname}',
                        maxLines: 2,
                        style: _textStyle(22),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'Current Balance : ${widget.tcurrentbalance}',
              style: TextStyle(
                  color: Color.fromRGBO(32, 132, 113, 1), fontSize: 24),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'Enter amount:',
              style: TextStyle(
                  color: Color.fromRGBO(32, 132, 113, 1),
                  fontSize: 35,
                  fontWeight: FontWeight.w800),
            ),
            Container(
              margin: EdgeInsets.all(30),
              child: TextField(
                keyboardType: TextInputType.number,
                
                controller: amountcontroller,
                decoration: InputDecoration(
                    labelText: 'Amount',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(2),
                    )),
                onSubmitted: (value) {
                  Widget yesButton = FlatButton(
                    color: Colors.blue,
                    child: Text(
                      "Yes",
                      style: TextStyle(fontSize: 15),
                    ),
                    onPressed: () {
                      trans++;
                      FirebaseFirestore.instance.collection("transactions").
                      doc().set(
                          { "tname": widget.tname,
                        "rname": widget.rname,
                        "Date": DateFormat().format(DateTime.now()),
                        "Amount": amountcontroller.text.toString(),
                        "Status": "Success"});
                     
                      FirebaseFirestore.instance
                          .collection("customers")
                          .doc(widget.rid)
                          .update({
                        "currentbalance": widget.rcurrentbalance +
                            int.parse(amountcontroller.text)
                      });
                      FirebaseFirestore.instance
                          .collection("customers")
                          .doc(widget.tid)
                          .update({
                        "currentbalance": widget.tcurrentbalance -
                            int.parse(amountcontroller.text)
                      });

                      Navigator.popAndPushNamed(context, '/all');
                      AlertDialog al = AlertDialog(
                          title: Text("Alert"),
                          content: Text('Transaction Succesfull.'));
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return al;
                        },
                      );
                    },
                  );
                  Widget noButton = FlatButton(
                    color: Colors.blue,
                    child: Text(
                      "No",
                      style: TextStyle(fontSize: 15),
                    ),
                    onPressed: () {
                       trans++;
                      FirebaseFirestore.instance.collection("transactions").
                      doc().set(
                          { "tname": widget.tname,
                        "rname": widget.rname,
                        "Date": DateFormat().format(DateTime.now()),
                        "Amount": amountcontroller.text.toString(),
                        "Status": "Failed"});
                      
                      AlertDialog al = AlertDialog(
                          title: Text("Alert"),
                          content: Text('Transaction Cancelled.'));
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return al;
                        },
                      );
                      Navigator.popAndPushNamed(context, '/all');
                    },
                  );
                  AlertDialog alert = AlertDialog(
                    title: Text("Alert"),
                    content: Text('Are you sure?'),
                    actions: [yesButton, noButton],
                  );

                  // show the dialog
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return alert;
                    },
                  );
                },
                onChanged: (value) {
                  if (int.parse(value) > widget.tcurrentbalance) {
                    return showAlertDialog(context,
                        "Insufficient Balance.\n You have ${widget.tcurrentbalance}");
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
