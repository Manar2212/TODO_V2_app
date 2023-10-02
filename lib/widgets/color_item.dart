import 'package:flutter/material.dart';
import 'package:todo_app/theme.dart';
class ColorItem extends StatelessWidget {
    const ColorItem({super.key, required this.color,required this.isSelected});
  final Color color;
  final bool isSelected;

    @override
    Widget build(BuildContext context) {
      return isSelected ? CircleAvatar(
        backgroundColor: color,
        radius: 20,
        child:  Icon(Icons.done,color: Colors.white,),
      ): 
      CircleAvatar(
        backgroundColor: color,
        radius: 20,
      );
    }
}