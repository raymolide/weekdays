import 'package:flutter/material.dart';

Widget diasUteisTf(int diasUteis, Size size) {
  return SizedBox(
    width: size.width * .8,
    child: TextField(
      enabled: false,
      decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          filled: true,
          hintStyle: TextStyle(color: Colors.white),
          hintText: "Existem $diasUteis dias uteis no intervalo definido",
          fillColor: Colors.blue),
    ),
  );
}
