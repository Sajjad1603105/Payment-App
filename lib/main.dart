import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:payment_app/login.dart';
import 'package:provider/provider.dart';
import 'auth.dart';
import 'home.dart';

void main() async {
WidgetsFlutterBinding.ensureInitialized();
await Firebase.initializeApp();
runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<String>.value(
      value: AuthService().user,
      child: MaterialApp(
        home: Wrapper(),
      ),
    );
  }
}

class Wrapper extends StatelessWidget{
  Widget build (BuildContext context){
    final uid = Provider.of<String>(context) ?? '';
    return uid == '' ? Login() : Home(val:'');   
  }
}

