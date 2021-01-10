import 'package:flutter/material.dart';
import 'auth.dart';
import 'constant.dart';
import 'home.dart';
import 'loading.dart';
import 'database.dart';

class Registration extends StatelessWidget{
    Widget build(context){
        return MaterialApp(
              home: Scaffold(
                  backgroundColor: Colors.grey[900],
                  body: RegistrationScreen(),
                  resizeToAvoidBottomInset: false,
              ),

        );
    }
}

class RegistrationScreen extends StatefulWidget{
  @override
  createState() {
    return RegistrationScreenState();
  }
}

class RegistrationScreenState extends State<RegistrationScreen>{
    final AuthService _auth = AuthService();
    final _formKey = GlobalKey<FormState>();
    bool loading = false;
    String error = '';
    String email = '';
    String password = '';
    String name = '';
    String roll = '';
    String department = '';
    String series = '' ;
    String bloodGroup = '';

    Widget build(context){
        return loading ? Loading() : Container(
              margin: EdgeInsets.all(30.0),
              padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom),
              child: Form(
                  key : _formKey,
                  child:SingleChildScrollView(
                  child: Column(
                      children:[
                            SizedBox(height: 40.0),
                            Text("Create your account",style: TextStyle(color:Colors.white,fontWeight: FontWeight.bold,fontSize: 20)),
                            SizedBox(height:20.0),
                            nameField(),
                            SizedBox(height:20.0),
                            rollField(),
                            SizedBox(height:20.0),
                            departmentField(),
                            SizedBox(height:20.0),
                            seriesField(),
                            SizedBox(height:20.0),
                            bloodField(),    
                            SizedBox(height:20.0),
                            emailField(),
                            SizedBox(height:20.0),
                            passField(),    
                            SizedBox(height:20.0),
                            submitButton(),
                            SizedBox(height: 12.0),
                            Text(error,style: TextStyle(color: Colors.red, fontSize: 15.0)),                             
                      ],
                    ),
                ),
              ),
          );    
    }
    Widget nameField(){
        return TextFormField(
           style: TextStyle(color: Colors.white,fontSize: 19,fontWeight: FontWeight.normal),     
           decoration: textInputDecoration.copyWith(labelText: 'Name'),
           onChanged: (val) { setState(() => name = val); },
           validator: (value) {
              if (value.isEmpty) return 'Please enter your name';
              return null;
           }
        );
    }

    Widget rollField(){
        return TextFormField(
            style: TextStyle(color: Colors.white,fontSize: 19,fontWeight: FontWeight.normal),     
            decoration: textInputDecoration.copyWith(labelText: 'Roll'),
            onChanged: (val) { setState(() => roll = val); },
            validator: (value) {
               if (value.isEmpty) return 'Please enter your roll';
               return null;
            }
        );
    }

    Widget departmentField(){
        return TextFormField(
           style: TextStyle(color: Colors.white,fontSize: 19,fontWeight: FontWeight.normal),     
           decoration: textInputDecoration.copyWith(labelText: 'Department'),
           onChanged: (val) { setState(() => department = val); },
           validator: (value) {
              if (value.isEmpty) return 'Please enter your department';
              return null;
           }
       );
    }

    Widget seriesField(){
        return TextFormField(
            style: TextStyle(color: Colors.white,fontSize: 19,fontWeight: FontWeight.normal),     
            decoration: textInputDecoration.copyWith(labelText: 'Series'),
            onChanged: (val) { setState(() => series = val); },
            validator: (value) {
              if (value.isEmpty) return 'Please enter your series';
              return null;
            }
        );
    }

    Widget bloodField(){
        return TextFormField(
           style: TextStyle(color: Colors.white,fontSize: 19,fontWeight: FontWeight.normal),     
           decoration: textInputDecoration.copyWith(labelText: 'Blood-Group'),
           onChanged: (val) { setState(() => bloodGroup = val); },
           validator: (value) {
              if (value.isEmpty) return 'Please enter your Blood-group';
              return null;
           }
        );
    }

    Widget emailField(){
        return TextFormField(
            style: TextStyle(color: Colors.white,fontSize: 19,fontWeight: FontWeight.normal),     
            decoration: textInputDecoration.copyWith(labelText: 'Email'),
            onChanged: (val) { setState(() => email = val); },
            validator: (value) {
               if (value.isEmpty) return 'Please enter an email';
               return null;
            }
        );
    }

     Widget passField(){
        return TextFormField(
            style: TextStyle(color: Colors.white,fontSize: 19,fontWeight: FontWeight.normal),     
            decoration: textInputDecoration.copyWith(labelText: 'Password'),
            onChanged: (val) { setState(() => password = val); },
            validator: (value) {
               if (value.length < 6) return 'Please enter password with at least 6 characters';
               return null;
            } 
        );
    }
    
    Widget submitButton(){
        return RaisedButton(
             child: Text('Submit',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15)),
             color: Colors.blue[500],
             onPressed: () async {
                if(_formKey.currentState.validate()){
                     setState(() => loading = true);
                     dynamic result = await _auth.registerWithEmailAndPassword(email, password);
                      if(result == null) {
                          setState(() {
                             loading = false;
                             error = 'Could not Register!!! Please Try again ';
                      });}
                     else {
                         await DatabaseService(uid: result.uid).addStudent(name,roll, department, series ,bloodGroup);
                         Navigator.pushAndRemoveUntil(context,MaterialPageRoute(builder: (context) => Home(val: '',)),(route) => false);
                     }
                 }
             },
        ); 
    }
}