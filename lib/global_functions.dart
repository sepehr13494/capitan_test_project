import 'package:flutter/material.dart';

class GlobalFunctions{
  static showSnackBar(context, content,{color = Colors.red}){
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(content),backgroundColor: color,)
    );
  }
}