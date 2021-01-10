import 'package:flutter/material.dart';

const textInputDecoration = InputDecoration(
   focusedBorder: OutlineInputBorder( 
      borderSide: BorderSide(color: Colors.blue),
   ),
   enabledBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.white54),
   ),
   labelStyle: TextStyle(color: Colors.white54,fontSize: 17),
);