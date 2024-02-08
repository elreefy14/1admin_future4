// import 'dart:async';
// import 'package:bloc/bloc.dart';
// import 'package:dio/dio.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:meta/meta.dart';
//
// part 'otp_state.dart';
//
// class OtpCubit extends Cubit<OtpState> {
//   OtpCubit() : super(AuthInitial());
//
//   static OtpCubit get(context) => BlocProvider.of(context);
//   static String? verificationIdd;
//   static UserCredential? user;
//   late Timer _resendOtpTimer;
//   int _resendOtpTimerDuration = 60;
//
//   Future<void> phoneNumberSubmitted(String phoneNumber) async {
//     emit(phoneNumberSubmittedLoading());
//     await FirebaseAuth.instance.verifyPhoneNumber(
//       phoneNumber: '+2$phoneNumber',
//       verificationCompleted: _verificationCompleted(),
//       verificationFailed: _verificationFailed(),
//       codeSent: await _codeSent(),
//       codeAutoRetrievalTimeout: _codeAutoRetrievalTimeout(),
//     );
//     emit(PhoneNumberSubmittedloaded());
//   }
//
//   // Future<void> otpSubmitted({required String otp}) async {
//   //   emit(OTPLoading());
//   //   final AuthCredential credential = PhoneAuthProvider.credential(
//   //     verificationId: verificationIdd!,
//   //     smsCode: otp,
//   //   );
//   //   user = await FirebaseAuth.instance.signInWithCredential(
//   //     credential,
//   //   );
//   //   emit(OtpVerified());
//   // } catch error in otpSubmitted
//   Future<void> otpSubmitted({required String otp}) async {
//     emit(OTPLoading());
//     try {
//       final AuthCredential credential = PhoneAuthProvider.credential(
//         verificationId: verificationIdd!,
//         smsCode: otp,
//       );
//       user = await FirebaseAuth.instance.signInWithCredential(
//         credential,
//       ).catchError((e) {
//         print('ERROR');
//         print(e);
//         emit(VerificationFailed(e.message));
//         emit(AuthErrorOccur(e.message));
//       });
//       emit(OtpVerified());
//     } on DioError catch (e) {
//       print('DIO ERROR');
//
//       print(e.message);
//       emit(AuthErrorOccur(e.message??''));
//     }
//   }
//
//   _codeSent() async {
//     return (String verificationId, [int? forceResendingToken]) {
//       print('MY code sent');
//       print(verificationId);
//       print('MY TOKEN');
//       print(forceResendingToken);
//       verificationIdd = verificationId;
//       startResendOtpTimer();
//       emit(OTPSent());
//     };
//   }
//
//   _verificationCompleted() {
//     return (AuthCredential credential) {
//       print('My verification completed');
//       print(credential);
//       emit(OtpVerified());
//     };
//   }
//
//   _verificationFailed() {
//     return (exception) {
//       print('My verification failed');
//       print(exception);
//       emit(VerificationFailed(
//         exception.message,
//       //    exception.message, canResendOtp: true, resendOtpDuration: _resendOtpTimerDuration
//             )
//       );
//     };
//   }
//
//   _codeAutoRetrievalTimeout() {
//     return (String verificationId) {
//       print('MY code auto retrieval timeout');
//       print(verificationId);
//       stopResendOtpTimer();
//       emit(AuthErrorOccur('MY code auto retrieval timeout'));
//     };
//   }
//
//   User getloggedInUser() {
//     User user = FirebaseAuth.instance.currentUser!;
//     return user;
//   }
//
//   void startResendOtpTimer() {
//     _resendOtpTimer = Timer.periodic(Duration(seconds: 1), (timer) {
//       if (_resendOtpTimerDuration == 0) {
//         stopResendOtpTimer();
//         emit(OTPSent());
//         emit(OtpVerificationFailed('', canResendOtp: true, resendOtpDuration: _resendOtpTimerDuration));
//       } else {
//         _resendOtpTimerDuration--;
//        // emit(OtpVerificationFailed('', canResendOtp: false, resendOtpDuration: _resendOtpTimerDuration));
//       }
//     });
//   }
//
//   void stopResendOtpTimer() {
//     _resendOtpTimer.cancel();
//     _resendOtpTimerDuration = 60;
//   }
//   void resendOtpCode({required phone}) async {
//     if (_resendOtpTimerDuration == 60) {
//       // Resend the OTP immediately
//       emit(phoneNumberSubmittedLoading());
//       await FirebaseAuth.instance.verifyPhoneNumber(
//         phoneNumber: '+2$phone',
//         verificationCompleted: _verificationCompleted(),
//         verificationFailed: _verificationFailed(),
//         codeSent: await _codeSent(),
//         codeAutoRetrievalTimeout: _codeAutoRetrievalTimeout(),
//       );
//     //  emit(OtpVerificationFailed('', canResendOtp: true, resendOtpDuration: _resendOtpTimerDuration));
//      emit(OTPReSent());
//     } else {
//       // Show the remaining time left in the resend OTP timer
//       emit(OtpVerificationFailed('', canResendOtp: false, resendOtpDuration: _resendOtpTimerDuration));
//     }
//   }
//
// }
//
