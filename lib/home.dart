import 'package:firebase_image/firebase_image.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:payment_app/menubar.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'database.dart';
import 'dart:io';


class Home extends StatelessWidget{
  final String val;
  Home ({this.val});
  @override
  Widget build(BuildContext context) {
          final uid = Provider.of<String>(context) ?? '';
          return StreamProvider<UserData>.value(
              value: DatabaseService(uid: uid).userData ,
              child: Scaffold(
                  
                  drawer: NavDrawer(),
                  backgroundColor: Colors.black,
                  body: HomeScreen(uid: uid,val:val),
                  resizeToAvoidBottomInset: false,
                  resizeToAvoidBottomPadding: true,

                  appBar: AppBar(
                  title: Text('                  Profile' , style: TextStyle(color: Colors.blueAccent,
                  fontWeight: FontWeight.bold ) ),
                  backgroundColor: Colors.grey[900],
                  elevation: 0.0,
             ),
           ),
        );
    }
}

class HomeScreen extends StatefulWidget{
  final String uid,val;
  HomeScreen({this.uid,this.val});
  @override
  createState() {
    return HomeScreenState(uid: uid,val:val);
  }
}

class HomeScreenState extends State<HomeScreen>{
   final String uid,val;
   HomeScreenState({this.uid,this.val});
   @override
   Widget build(BuildContext context){
       final UserData obj = UserData(name: '',roll: '',department: '',series: '',bloodgroup: '');
       final UserData data = Provider.of< UserData >(context) ?? obj;

       return  Container(
            margin: EdgeInsets.all(30.0),
            child: Center( 
              child: SingleChildScrollView( 
                child: Column(
                  children: [

                      Img(context),

                      SizedBox(height:40.0),            
                      Text(data.name, style: TextStyle(color: Colors.white,fontWeight: FontWeight.w500  ,fontSize: 30.0)),

                      SizedBox(height:25.0),
                      Text('Department: ${data.department}', style: TextStyle(color: Colors.white,fontWeight: FontWeight.normal,fontSize: 25.0)),

                      SizedBox(height:15.0),
                      Text('Roll: ${data.roll}', style: TextStyle(color: Colors.white,fontWeight: FontWeight.normal,fontSize: 25.0)),

                      SizedBox(height:15.0),
                      Text('Series: ${data.series}', style: TextStyle(color: Colors.white,fontWeight: FontWeight.normal,fontSize: 25.0)),
                                    
                      SizedBox(height:15.0),
                      Text('Blood-Group: ${data.bloodgroup}', style: TextStyle(color: Colors.white,fontWeight: FontWeight.normal,fontSize: 25.0)),
                 ],
              ),
            ),
          ),
        );
     }
 
   FirebaseImage _image; 
 //   FirebaseImage _image = FirebaseImage('gs://payment-app-20cdb.appspot.com/Images/1gojxZNqe3dLalTAycYlk8HOYdt2');
    // ignore: non_constant_identifier_names
    _imgFromCamera() async {
    // ignore: deprecated_member_use
    File image = await ImagePicker.pickImage(
      source: ImageSource.camera, imageQuality: 50
       );
 
     StorageReference ref = FirebaseStorage.instance.ref();
     StorageTaskSnapshot addImg =
        await ref.child("Images/$uid").putFile(image).onComplete;
        if (addImg.error == null) {
          print("added to Firebase Storage");
        }

       setState(() {
        _image = FirebaseImage('gs://payment-app-20cdb.appspot.com/Images/$uid');
      });
    }

  _imgFromGallery() async {
    // ignore: deprecated_member_use
    File image = await  ImagePicker.pickImage(
        source: ImageSource.gallery, imageQuality: 50
       );

     StorageReference ref = FirebaseStorage.instance.ref();
     StorageTaskSnapshot addImg =
        await ref.child("Images/$uid").putFile(image).onComplete;
        if (addImg.error == null) {
          print("added to Firebase Storage");
        }

       setState(() {
        _image = FirebaseImage('gs://payment-app-20cdb.appspot.com/Images/$uid');
       });
     }

  void _showPicker(context) {
  showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return SafeArea(
          child: Container(
            child: new Wrap(
              children: <Widget>[
                new ListTile(
                    leading: new Icon(Icons.photo_library),
                    title: new Text('Photo Library'),
                    onTap: () {
                      _imgFromGallery();
                      Navigator.of(context).pop();
                    }),
                new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
                    onTap: () {
                       _imgFromCamera();
                       Navigator.of(context).pop();
                    },
                 ),
               ],
            ),
          ),
        );
      }
    );
  }

  // ignore: non_constant_identifier_names
  Widget Img(context){
      if(val == null) _image = FirebaseImage('gs://payment-app-20cdb.appspot.com/Images/$uid');
      return  GestureDetector(
            onTap: () {
              _showPicker(context);
            },
            child: CircleAvatar(
              radius: 135,
              backgroundColor: Colors.black,
              child: _image != null
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(125),
                      child: Image(
                        image: _image,
                        height: 350,
                        width: 350,
                        fit: BoxFit.cover,
                      ),
                    )
                  : Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(125)),
                      width: 350,
                      height: 350,
                      child: Icon(
                        Icons.person,
                        color: Colors.white,
                        size: 180.0,
                      ),
                  ),
              ),
          );
    }
}