import 'package:flutter/material.dart';
import 'home.dart';


class Success extends StatelessWidget {
  @override
  Widget build(context) {
     return Scaffold(
        backgroundColor: Colors.black,
        body: Column(
           mainAxisAlignment: MainAxisAlignment.center,
           crossAxisAlignment: CrossAxisAlignment.center,
          
           children: <Widget>[ 
           Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[ 
                Text("Payment successful", style: TextStyle(color: Colors.green,))
           ]),
           
           SizedBox(height: 10),
           Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                 FlatButton.icon(onPressed: (){ Navigator.pushAndRemoveUntil(context,MaterialPageRoute(builder: (context) => Home()),(route) => false);},
                 icon: Icon(Icons.person,color: Colors.white), 
                 label: Text("Back to Profile",style: TextStyle( color: Colors.white)))
            ])
          ],
        ),
    );
  }
}