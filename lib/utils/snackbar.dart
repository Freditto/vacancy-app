import 'package:flutter/material.dart';

void showSnack(context, message) {
  if (context != null) {
    final snackBar = SnackBar(
      content: Text(message.toString()),
      backgroundColor: (Colors.black),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
