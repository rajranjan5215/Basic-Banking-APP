import 'package:flutter/material.dart';
import 'allcustomers.dart';
class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(32, 132, 113, 1),
      body: SingleChildScrollView(
              child: Center(
          child: Column(
            children: [
              SizedBox(
                height: 100,
              ),
              Container(
                height: 250,
                width: 250,
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(122.5)),
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  onBackgroundImageError: (exception, stackTrace) => Text(
                    'BBA',
                    style: TextStyle(
                        fontSize: 15, color: Color.fromRGBO(32, 132, 113, 1)),
                  ),
                  backgroundImage: AssetImage(
                    "assets/images/HomeScreen.jpg",
                  ),
                ),
              ),
              SizedBox(height: 50),
              Text(
                " Basic Banking",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 50,
                  foreground: Paint()
                    ..style = PaintingStyle.stroke
                    ..strokeWidth = 2
                    ..color = Colors.white,
                ),
              ),
              Text(
                'App',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 50,
                  foreground: Paint()
                    ..style = PaintingStyle.stroke
                    ..strokeWidth = 2
                    ..color = Colors.white,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Card(
                elevation: 10,
                color: Colors.white,
                child: IconButton(
                    icon: Icon(Icons.arrow_forward),
                    iconSize: 50,
                    color: Color.fromRGBO(32, 132, 113, 1),
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return Allcustomers();
                      }));
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
