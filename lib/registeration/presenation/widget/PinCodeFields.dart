// import 'package:flutter/material.dart';
// import 'package:pin_code_fields/pin_code_fields.dart';
//
// import '../../../core/constants/my_color.dart';
//
// class PinCodeFields extends StatelessWidget {
//   final Function(String) onCompleted;
//
//   const PinCodeFields({Key? key, required this.onCompleted}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: PinCodeTextField(
//         appContext: context,
//         autoFocus: true,
//         cursorColor: Colors.black,
//         keyboardType: TextInputType.number,
//         length: 6,
//         obscureText: false,
//         animationType: AnimationType.scale,
//         pinTheme: PinTheme(
//           shape: PinCodeFieldShape.underline,
//           // set the shape to underline
//           fieldHeight: 50,
//           fieldWidth: 40,
//           activeColor: MyColors.blue,
//           inactiveColor: Colors.grey,
//           selectedColor: MyColors.blue,
//           selectedFillColor: Colors.white,
//           activeFillColor: Colors.white,
//           inactiveFillColor: Colors.white,
//         ),
//         animationDuration: Duration(milliseconds: 300),
//         backgroundColor: Colors.white,
//         enableActiveFill: true,
//         onCompleted: onCompleted,
//         onChanged: (value) {
//           print(value);
//         },
//       ),
//     );
//   }
// }