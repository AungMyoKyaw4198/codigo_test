import 'package:flutter/material.dart';

Widget IconWithTextWidget(String iconName, String text) {
  return Column(
    children: [
      Image.asset(iconName),
      Text(
        text,
        style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w500),
      ),
    ],
  );
}

// Widget ByRoom(){

// }
