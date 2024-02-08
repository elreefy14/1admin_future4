// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:swimmer_app/core/constants/routes_manager.dart';
// import 'package:swimmer_app/registeration/business_logic/auth_cubit/otp_cubit.dart';
// import 'package:swimmer_app/registeration/presenation/widget/PinCodeFields.dart';
// import 'package:swimmer_app/registeration/presenation/widget/ResendOtp.dart';
// import 'package:swimmer_app/registeration/presenation/widget/intro_text.dart';
// import '../business_logic/auth_cubit/sign_up_cubit.dart';
// import '../business_logic/auth_cubit/sign_up_state.dart';
//
// // ignore: must_be_immutable
// class OtpVerificationScreen extends StatelessWidget {
//   final phoneNumber;
//   final fName;
//   final lName;
//   final password;
//
//   OtpVerificationScreen({
//     Key? key,
//     this.phoneNumber,
//     this.fName,
//     this.lName,
//     this.password,
//   }) : super(key: key);
//   late String otpCode;
//
//   void showProgressIndicator(BuildContext context) {
//     AlertDialog alertDialog = AlertDialog(
//       backgroundColor: Colors.transparent,
//       elevation: 0,
//       content: Center(
//         child: CircularProgressIndicator(
//           valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
//         ),
//       ),
//     );
//
//     showDialog(
//       barrierColor: Colors.white.withOpacity(0),
//       barrierDismissible: false,
//       context: context,
//       builder: (context) {
//         return alertDialog;
//       },
//     );
//   }
//   // Widget showProgressIndicator(BuildContext context) {
//   //   return Material(
//   //     color: Colors.transparent,
//   //     child: Center(
//   //       child: AlertDialog(
//   //         backgroundColor: Colors.transparent,
//   //         elevation: 0,
//   //         content: Center(
//   //           child: CircularProgressIndicator(
//   //             valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
//   //           ),
//   //         ),
//   //       ),
//   //     ),
//   //   );
//   // }
//
//   void _login(BuildContext context) {
//     BlocProvider.of<OtpCubit>(context).otpSubmitted(otp: otpCode).then((
//         value) =>
//         BlocProvider.of<SignUpCubit>(context).signUp(
//           phone: phoneNumber,
//           fName: fName,
//           lName: lName,
//           password: password,
//         )
//     );
//   }
//
// //solve this error The return type 'void' isn't a 'Widget', as required by the closure's context.
//   Widget _buildVrifyButton(BuildContext context) {
//     return Align(
//       alignment: Alignment.centerRight,
//       child: BlocConsumer<OtpCubit, OtpState>(
//         listener: (context, state) {
//           //OTPLoading
//           if (state is OTPLoading && state is! VerificationFailed && state is! AuthErrorOccur && state is! OtpVerificationFailed) {
//             showProgressIndicator(context);
//           }
//           else if (state is AuthErrorOccur){
//             ScaffoldMessenger.of(context).showSnackBar(
//               SnackBar(
//                 content: Text(
//                     state.error ??
//                    'otp not correct'),
//               ),
//             );
//           }
//         },
//         builder: (context, state) {
//           return BlocConsumer<SignUpCubit, SignUpState>(
//             listener: (context, state) {
//              //if state is signup loading
//               if (state is SignUpLoadingState && state is! SignUpErrorState) {
//                 showProgressIndicator(context);
//               }
//             },
//             builder: (context, state) {
//               return ElevatedButton(
//                 onPressed: () {
//                 // showProgressIndicator(context);
//
//                   _login(context);
//                 },
//                 child: Text(
//                   'Verify',
//                   style: TextStyle(color: Colors.white, fontSize: 16),
//                 ),
//                 style: ElevatedButton.styleFrom(
//                   minimumSize: Size(110, 50),
//                   primary: Colors.black,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(6),
//                   ),
//                 ),
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
//
// //edit this code to handle that if state is SignUpSuccessState(in signUPCubit) //and state is OtpVerified(in OtpCubit) // Navigator.pop(context); // Navigator.pushNamed(context, AppRoutes.home); //else show error message for sign up error //else if VerificationFailed show error message for otp error //and navigate to sign up screen again
//   Widget _buildPhoneVerificationBloc() {
//     var otpVerified = false;
//     var signUpSuccess = false;
//     return BlocListener<OtpCubit, OtpState>(
//       listener: (context, state) async {
//         if (state is OtpVerified) {
//           otpVerified = true;
//         } else if (state is VerificationFailed) {
//           // If the verification fails, show a toast
//           // and navigate to the sign up screen again
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(
//               content: Text(
//                  '${state.error}' ??
//                   'An error occurred while verifying the OTP. Please try again.'),
//             ),
//           );
//           Navigator.pushNamed(context, AppRoutes.signUp);
//         }
//       },
//       child: BlocListener<SignUpCubit, SignUpState>(
//           listener: (context, state) async {
//             if (state is SignUpSuccessState) {
//               signUpSuccess = true;
//             } else if (state is SignUpErrorState) {
//               // If there is an error, show a toast
//               // and navigate to the sign up screen again
//               ScaffoldMessenger.of(context).showSnackBar(
//                 SnackBar(
//                   content: Text(state.error ??
//                       'An error occurred while signing up. Please try again.'),
//                 ),
//               );
//               Navigator.pushNamed(context, AppRoutes.signUp);
//             }
//           },
//           child: Builder(
//             builder: (context) {
//               // Check if both events have occurred and navigate to the home screen
//               if (otpVerified && signUpSuccess) {
//                 WidgetsBinding.instance.addPostFrameCallback((_) {
//                   Navigator.pop(context);
//                   Navigator.pushNamed(context, AppRoutes.home);
//                 });
//               }
//               return Container(); // your existing child widget here
//             },
//           )
//       ),
//     );
//   }
//
//
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         backgroundColor: Colors.white,
//         body: Container(
//           margin: EdgeInsets.symmetric(horizontal: 32, vertical: 88),
//           child: SingleChildScrollView(
//             child: Column(
//               children: [
//                 IntroTexts(phoneNumber: phoneNumber),
//                 SizedBox(
//                   height: 88,
//                 ),
//                 PinCodeFields(
//                   onCompleted: (submitedCode) {
//                     otpCode = submitedCode;
//                     print("Completed");
//                   },
//                 ),
//                 SizedBox(
//                   height: 60,
//                 ),
//                 _buildVrifyButton(context),
//                 _buildPhoneVerificationBloc(),
//                 ResendOtp(phoneNumber: phoneNumber),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
//
