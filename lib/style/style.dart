import 'package:flutter/material.dart';

final Color busblackBlue = Color(0xff03071E);
final Color busyellow = Color(0xffF9AE5D);
final Color busclay = Color(0xff2B2942);
final Color busBackground = Color(0xffF7F9FF);
final Color busIcon = Color(0xff608DF7);
final Color busbottom = Color(0xff  );
final Color test = Color(0xffA8AABC);
final Color busExpand = Color(0xffD2A517);
final Color busWhite = Color(0xffffffff);


final firstButton = ElevatedButton.styleFrom(
  primary: Colors.white,
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(5),
  ),
  side: BorderSide(width: 1, color: test),
  minimumSize: Size.fromHeight(60),
);

final secondButton = ElevatedButton.styleFrom(
  primary: test,
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(5),
  ),
  side: const BorderSide(width: 1, color: Colors.white),
  minimumSize: const Size.fromHeight(60),
);
// style: TextStyle(fontSize: 24, color: busblackBlue),

final bText =
    TextStyle(fontSize: 24, color: busblackBlue);
