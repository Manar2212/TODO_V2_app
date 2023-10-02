import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_app/theme.dart';
import 'package:get/get.dart';

class NotificationViewBody extends StatefulWidget {
  const NotificationViewBody({super.key, required this.payload});
final String payload;
  @override
  State<NotificationViewBody> createState() => _NotificationViewBodyState();
}

class _NotificationViewBodyState extends State<NotificationViewBody> {
  late String _payload;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _payload = widget.payload;
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Column(
          children: [
            SizedBox(height: 15,),
            Column(
              children: [
                Text('Hello Manar',
                style: GoogleFonts.lato(
                  fontSize: 26,
                  fontWeight: FontWeight.w900,
                  color: Get.isDarkMode ? Colors.white : darkGreyClr,
                )
                ),
                SizedBox(height: 10,),
                Text('You have a new reminder',
                style: GoogleFonts.lato(
                  fontSize: 18,
                  fontWeight: FontWeight.w300,
                  color: Get.isDarkMode ? Colors.grey[100] : darkGreyClr,
                )
                ),
              ],
            ),
            SizedBox(height: 15,),
            Expanded(child: Container(
              padding: EdgeInsets.symmetric(horizontal: 30,vertical: 20),
              margin: EdgeInsets.symmetric(horizontal: 30),
              decoration: BoxDecoration(
                color: primaryClr,
                borderRadius: BorderRadius.circular(30),
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(children: [
                      Icon(Icons.text_format,size: 35,color: Colors.white,),
                      SizedBox(width: 20,),
                      Text('Title',
                      style: GoogleFonts.lato(
                        fontSize: 25,
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                      )
                ),
                    ],),
                    SizedBox(height: 20,),
                    
                    Text(_payload.toString().split('|')[0],
                    textAlign: TextAlign.justify,
                    style: GoogleFonts.lato(fontSize: 16,color: Colors.white),
                    ),
                    SizedBox(height: 20,),
                    Row(children: [
                      Icon(Icons.description,size: 35,color: Colors.white,),
                      SizedBox(width: 20,),
                      Text('Description',
                      style: GoogleFonts.lato(
                        fontSize: 25,
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                      ),
                ),
                    ],),
                    SizedBox(height: 20,),
                    
                    Text(_payload.toString().split('|')[1],
                    textAlign: TextAlign.justify,
                    style: GoogleFonts.lato(fontSize: 16,color: Colors.white),
                    ),
                    SizedBox(height: 20,),
                    Row(children: [
                      Icon(Icons.calendar_today_outlined,size: 35,color: Colors.white,),
                      SizedBox(width: 20,),
                      Text('Date',
                      style: GoogleFonts.lato(
                        fontSize: 25,
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                      ),
                ),
                    ],),
                    SizedBox(height: 20,),
                    Text(_payload.toString().split('|')[2],
                    textAlign: TextAlign.justify,
                    style: GoogleFonts.lato(fontSize: 16,color: Colors.white),
                    ),
                    SizedBox(height: 20,),
                  ],
                ),
              ),
            )),
            SizedBox(height: 15),
          ],
        ),
      );
  }
}