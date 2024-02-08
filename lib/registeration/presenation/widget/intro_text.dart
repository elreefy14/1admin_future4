import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class IntroTexts extends StatelessWidget {
  final String phoneNumber;

  const IntroTexts({Key? key, required this.phoneNumber}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Image.asset(
            'assets/images/opt.jpg',
            height: 200,
            fit: BoxFit.contain,
          ),
          SizedBox(height: 16.0),
          Text(
            'التحقق من رقم الهاتف',
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
              color: Colors.grey[700],
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 16.0),
          Text(
            'لقد ارسلنا رسالة قصيرة تحتوي علي رمز التفعيل الي الرقم $phoneNumber',
            style: TextStyle(
              fontSize: 16.0,
              color: Colors.grey[700],
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}