import 'package:flutter/material.dart';

const kTextFieldConstantEmail = InputDecoration(
  labelText: "Email",
  labelStyle: TextStyle(color: Colors.white),
  prefixIcon: Icon(Icons.email, color: Colors.white),
  enabledBorder: UnderlineInputBorder(
    borderSide: BorderSide(color: Colors.white),
  ),
  focusedBorder: UnderlineInputBorder(
    borderSide: BorderSide(color: Colors.white),
  ),
);
const kTextFieldConstantName = InputDecoration(
  labelText: "Name",
  labelStyle: TextStyle(color: Colors.white),
  prefixIcon: Icon(Icons.person, color: Colors.white),
  enabledBorder: UnderlineInputBorder(
    borderSide: BorderSide(color: Colors.white),
  ),
  focusedBorder: UnderlineInputBorder(
    borderSide: BorderSide(color: Colors.white),
  ),
);
const kTextFieldConstantPassword = InputDecoration(
  labelText: "Password",
  labelStyle: TextStyle(color: Colors.white),
  prefixIcon: Icon(Icons.lock, color: Colors.white),
  enabledBorder: UnderlineInputBorder(
    borderSide: BorderSide(color: Colors.white),
  ),
  focusedBorder: UnderlineInputBorder(
    borderSide: BorderSide(color: Colors.white),
  ),
);
const kContainerDecoration = BoxDecoration(
  gradient: LinearGradient(
    colors: [Color(0xFF332943), Color(0xFF1B2236)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  ),
);
