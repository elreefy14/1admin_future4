import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/constants/routes_manager.dart';


class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 45.0.h),
                Image.asset(
                  'assets/images/photo_5814288303556509507_y.jpg', // Replace with your logo asset path
                  height: 350.0.h,
                  width: double.infinity,
                  fit: BoxFit.fitHeight
                ),
                SizedBox(height: 5.0.h),
                Container(

                  //height: 30,
                  alignment: Alignment.center,
                  child: Text(
                    'مرحبا في اكاديمية',
                    style: TextStyle(
                      fontFamily: 'Montserrat-Arabic',
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w400,
                      fontSize: 24,
                      height: 29 / 24,
                      color: Color(0xFF333333),
                    ),
                  ),
                ),
                Container(
                  //height: 30,
                  alignment: Alignment.center,
                  child: Text(
                    'Future Trainers Academy',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'IBM Plex Sans Devanagari',
                      fontWeight: FontWeight.w600,
                      fontSize: 24,
                      height: 37 / 24,
                      color: Color(0xFF2196F3),
                    ),
                  ),
                ),
                SizedBox(height: 10.0.h),
                Image.asset(
                  'assets/images/photo_5814288303556509506_m.jpg', // Replace with your logo asset path
                  height: 50.0.h,
                  width: 45.0.w,
                ),
                SizedBox(height: 30.0.h),

            Padding(
              padding: EdgeInsets.only(
                  left: 31.w,
                  right: 31.w,

              ),
              child: Container(
                width: double.infinity,
                child: ElevatedButton(

                  onPressed: () {
                    Navigator.pushNamed(context, AppRoutes.login);
                  },
                  child: Text(
                    'تسجيل دخول',
                    style: TextStyle(
                      fontFamily: 'Montserrat-Arabic',
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w400,
                      fontSize: 18,
                      height: 26 / 18,
                      color: Color(0xFFFFFFFF),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  style: ElevatedButton.styleFrom(
                    //use this colot background: #F4F4F4;
                   primary: Color(0xFF2196F3), // Background color
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 9),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    textStyle: TextStyle(
                      fontSize: 18, // Adjust the font size if needed
                    ),
                  ),
                ),
              ),

            ),
            Padding(
              padding: EdgeInsets.only(
                top: 10.h,
                  left: 31.w,
                  right: 31.w,

              ),
              child: Container(
                width: double.infinity,
                child: ElevatedButton(

                  onPressed: () {
                    Navigator.pushNamed(context, AppRoutes.signUp);
                  },
                  child:Text(
                    'تسجيل حساب جديد',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFF333333),
                      fontSize: 18,
                      fontFamily: 'Montserrat-Arabic',
                      fontWeight: FontWeight.w400,
                      height: 1.44,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    //use this colot background: #F4F4F4;
                   primary: Color(0xFFF4F4F4), // Background color
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 9),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    textStyle: TextStyle(
                      fontSize: 18, // Adjust the font size if needed
                    ),
                  ),
                ),
              ),

            ),

              ],
            ),
          ),
        ));


  }
}

