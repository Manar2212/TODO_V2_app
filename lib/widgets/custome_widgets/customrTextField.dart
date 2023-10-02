import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/size_config.dart';
import 'package:todo_app/theme.dart';
class CustomeTextField extends StatelessWidget {
  const CustomeTextField({Key? key,required this.title,required this.hint,this.controller,this.widget}) : super(key: key);
final String title;
final String hint;
final TextEditingController? controller;
final Widget? widget;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,style: titleStyle,),
          SizedBox(height: 15,),
          Container(
            height: 52,
            width: SizeConfig.screenWidth,
            padding: EdgeInsets.only(left: 14),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey)
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: controller,
                    autofocus: false,
                    cursorColor: Get.isDarkMode ? Colors.grey[100] : Colors.grey[700],
                    readOnly: widget != null ? true : false,
                    style: subTitleStyle,
                    decoration: InputDecoration(
                      hintText: hint,
                    hintStyle: subTitleStyle,
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: context.theme.backgroundColor,
                        width: 0,
                      )
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: context.theme.backgroundColor,
                        width: 0,
                      )
                    )
                    ),
                  ),
                ),
                widget ?? Container(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
