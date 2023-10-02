import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:todo_app/theme.dart';

class SVGPicture extends StatelessWidget {
  const SVGPicture({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: BouncingScrollPhysics(),
      children: [
        SizedBox(height: 200,),
        SvgPicture.asset('assets/images/task.svg',
        height: 100,
        color: primaryClr.withOpacity(0.5),
        ),
        Padding(
          padding: const EdgeInsets.all(20),
          child: Text('You don\'t have any tasks yet\n Add new tasks to make your days productive.',
          style: subTitleStyle,
          textAlign: TextAlign.center,
          ),
        ),
        SizedBox(height: 100,),
      ],
    );
  }
}
