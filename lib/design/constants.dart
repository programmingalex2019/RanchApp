import 'package:flutter/material.dart';

const kTextFieldDesign = InputDecoration(
  
  hintText: 'Enter the given password...',

  fillColor: Colors.lightBlue,
  filled: true,
  errorStyle: TextStyle(fontSize: 14.0),
  hintStyle: TextStyle(color: Colors.grey, fontSize: 18.0),
  contentPadding: EdgeInsets.symmetric(vertical: 30.0, horizontal: 20.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.grey, width: 5.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.grey, width: 5.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  focusedErrorBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.red, width: 3.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  errorBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.red, width: 3.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
);
