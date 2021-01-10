import 'package:flutter/material.dart';
import 'package:payment_app/history.dart';
import 'package:payment_app/home.dart';
import 'package:payment_app/login.dart';
import 'CardScreen.dart';
import 'auth.dart';

class NavDrawer extends StatelessWidget {
  
  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    return Drawer(
        elevation: 0.0,
        child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
        DrawerHeader(
            child: Column( children:[ 
               Text(' Payment App',style: TextStyle(color: Colors.white, fontSize: 25)),
               SizedBox(height:10),
               Text('Developd by Sajjad',style: TextStyle(color: Colors.grey, fontSize: 15,fontWeight: FontWeight.normal)),
               SizedBox(height:10),
               Text('Email: 1603105@student.ruet.ac.bd',style: TextStyle(color: Colors.grey, fontSize: 15,fontWeight: FontWeight.normal)),
             ]
            ),
            decoration: BoxDecoration( color: Colors.blueGrey[900]),
         ),
  
           ListTile(
           leading: Icon(Icons.person),
           title: Text('Profile'),
           onTap: ()  { Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));}             
           ),

           ListTile(
           leading: Icon(Icons.payment),
           title: Text('Pay Fees'),
           onTap: () { Navigator.push(context, MaterialPageRoute(builder: (context) => Cards()));}
           ),

           ListTile(
           leading: Icon(Icons.history),
           title: Text('Payment History'),
           onTap: () { Navigator.push(context, MaterialPageRoute(builder: (context) => History()));} 
           ),

           ListTile(
           leading: Icon(Icons.settings),
           title: Text('Settings'),
           onTap: () => {Navigator.of(context).pop()},
           ),
          
           ListTile(
           leading: Icon(Icons.border_color),
           title: Text('Feedback'),
           onTap: () => {Navigator.of(context).pop()},
           ),
          
          ListTile(
           leading: Icon(Icons.exit_to_app),
           title: Text('Sign Out'),
           onTap: ()  async{
               await _auth.signOut();
               Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => Login()),(route) => false);
           },
          ),
        ],
      ),
     );
    }
  }