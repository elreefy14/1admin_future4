
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String text;

  const CustomAppBar({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(

      backgroundColor: Colors.white,
      shadowColor: Colors.transparent,
      leading: InkWell(
        onTap: () async {
          Navigator.pop(context);
        },
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.asset(
            'assets/images/back.png',
            width: 50,
            height: 50,
            fit: BoxFit.none,
          ),
        ),
      ),
      actions: [
        Padding(
          padding: EdgeInsets.only(
            top: 40.h,
            right: 12.w,
          ),
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0xFF333333),
              fontSize: 24,
              fontFamily: 'Montserrat-Arabic',
              fontWeight: FontWeight.w400,
              height: 0.04,
            ),
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}