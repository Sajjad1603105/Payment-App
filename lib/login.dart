import 'package:flutter/material.dart';
import 'package:payment_app/home.dart';
import 'constant.dart';
import 'registration.dart';
import 'auth.dart';
import 'loading.dart';

class Login extends StatelessWidget{
    Widget build(context){     
        return MaterialApp(
              home: Scaffold(
                  body: LoginScreen(),
                  backgroundColor: Colors.grey[900],
                  resizeToAvoidBottomInset: false,
              ),
              
        );
    }
}

class LoginScreen extends StatefulWidget{
  @override
  createState() {
    return LoginScreenState();
  }
}

class LoginScreenState extends State<LoginScreen> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  String error = '';
  bool loading = false;

 // String email = 'sajjad@gmail.com';
 // String password = '123456';

 String email = '';
 String password = '';

  Widget build(context){
      return loading ? Loading() : Container(
          margin: EdgeInsets.all(30.0),
          child: Form(
             key : _formKey,
             child: SingleChildScrollView( 
                 child: Column(
                     children:[
                          SizedBox(height: 150.0),
                          Text( "Sign In",style: TextStyle(color:Colors.white,fontWeight: FontWeight.bold,fontSize: 20)),
                          
                          SizedBox(height: 25.0),
                          emailField(),
                          
                          SizedBox(height: 25.0),
                          passField(),
                          
                          SizedBox(height: 12.0),
                          Text(error,style: TextStyle(color: Colors.red, fontSize: 14.0)),
                          
                          SizedBox(height: 15.0),
                          signInButton(),
                          
                          SizedBox(height: 100.0),
                          Text("Don't have an account?",style: TextStyle(color:Colors.white,fontWeight: FontWeight.bold,fontSize: 17)),
                          
                          SizedBox(height: 8.0),
                          registerButton(),
                      ],
                   ),
                ),
             ),
        );    
    }
  
  Widget emailField(){
      return TextFormField(
          style: TextStyle(color: Colors.white,fontSize: 19,fontWeight: FontWeight.normal),     
          decoration: textInputDecoration.copyWith(labelText: 'Email'),
          validator: (value) {
             if (value.isEmpty) return 'Please enter your email';
             return null;
          },
          onChanged: (val) { setState(() => email = val); },
      );
  }
  
  Widget passField(){
      return TextFormField(
           style: TextStyle(color: Colors.white,fontSize: 19,fontWeight: FontWeight.normal),     
           decoration: textInputDecoration.copyWith(labelText: 'Password'),
           obscureText: true,
         validator: (value) {
               if (value.length < 3) return 'Please enter your password!';
               return null;
         },
           onChanged: (val) { setState(() => password = val); },
       );
   }
    
   Widget signInButton(){
       return RaisedButton(
           child: Text('Submit', style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15)),
           color: Colors.blue[500],
           onPressed: () async {
              if(_formKey.currentState.validate()){
                   setState(() => loading = true);                    
                   dynamic result = await _auth.signInWithEmailAndPassword(email, password);
                   if(result == null) {
                       setState(() {
                          loading = false;
                          error = 'Please enter valid email & password!!!';
                       });
                   }
                   else {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
                    }
                }
            }
        ); 
    }
    
  Widget registerButton(){
        return RaisedButton(
            child: Text('Register',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15)),
            color: Colors.blue[500],
            onPressed: () { Navigator.push(context,MaterialPageRoute(builder: (context) => Registration()));}
        ); 
   }
}