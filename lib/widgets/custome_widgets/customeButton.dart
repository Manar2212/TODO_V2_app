import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_app/theme.dart';

class CustomeButton extends StatelessWidget {
  const CustomeButton({Key? key,required this.label,required this.onTap}) : super(key: key);
  final String label;
  final Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        height: 45,
        width: 100,
        child: Text(label,
        textAlign: TextAlign.center,
        style: GoogleFonts.lato(color: Colors.white),
        ),
        decoration: BoxDecoration(
          color: primaryClr,
          borderRadius: BorderRadius.circular(10),
        ),
      ));
  }
}
