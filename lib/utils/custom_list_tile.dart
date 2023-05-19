// ignore: must_be_immutable
import 'package:flutter/material.dart';

class CustomListTile extends StatelessWidget {
  String title;
  IconData icon;
  IconData traling;

  CustomListTile(this.title, this.icon, this.traling, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: ListTile(
        // tileColor: Colors.grey.shade50,
        leading: Padding(
          padding: const EdgeInsets.only(left: 5.0),
          child: (Icon(
            icon,
            size: 18,
          )),
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
        trailing: Icon(
          traling,
          size: 18,
        ),
      ),
    );
  }
}
