// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
//
// import '../../business_logic/auth_cubit/otp_cubit.dart';
//
// class ResendOtp extends StatelessWidget {
//   final String phoneNumber;
//
//   const ResendOtp({Key? key, required this.phoneNumber}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Directionality(
//       textDirection: TextDirection.rtl,
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Text(
//             'الم تستلم رمز التفعيل؟',
//             style: TextStyle(
//               fontSize: 16.0,
//               color: Colors.grey[700],
//             ),
//           ),
//           SizedBox(width: 8.0),
//           BlocConsumer<OtpCubit, OtpState>(
//             listener: (context, state) {
//               if (state is  OtpVerificationFailed) {
//                 if (state.canResendOtp == false) {
//                   // The user can resend the OTP now
//                   final duration = state.resendOtpDuration;
//                   ScaffoldMessenger.of(context).showSnackBar(
//                     SnackBar(
//                       // content: Text('You can resend the OTP in $duration seconds.'),
//                       content: Text('يمكنك اعادة الارسال بعد $duration ثانية'),
//
//                     ),
//                   );
//                 } }  if (state is OTPReSent) {
//                   // The user has to wait for the resend timer to finish
//                   ScaffoldMessenger.of(context).showSnackBar(
//                     SnackBar(
//                       //in arabic
//                       // content: Text('we will send you another OTP code now'),
//                       content: Text('سوف نرسل لك رمز تفعيل اخر الان'),
//
//                     ),
//                   );
//
//                 }
//               },
//
//             builder: (context, state) {
//               return TextButton(
//                 onPressed: () {
//                   BlocProvider.of<OtpCubit>(context).resendOtpCode(
//                     phone: phoneNumber,
//                   );
//                 },
//                 child: Text(
//                   'اعادة الارسال',
//                   style: TextStyle(
//                     fontSize: 16.0,
//                     color: Colors.lightBlueAccent,
//                   ),
//                 ),
//               );
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }