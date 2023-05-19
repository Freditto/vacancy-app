import 'package:flutter/material.dart';

class IconText extends StatelessWidget {
  const IconText({Key? key, required this.icon, required this.text}) : super(key: key);

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          color: Colors.yellow,
        ),
        const SizedBox(
          width: 15,
        ),
        Text(
          text,
          style: const TextStyle(fontSize: 12, color: Colors.grey),
        )
      ],
    );
  }
}