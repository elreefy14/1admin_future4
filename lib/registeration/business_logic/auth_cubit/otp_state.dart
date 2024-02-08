// part of 'otp_cubit.dart';
//
// @immutable
// abstract class OtpState {}
//
// class AuthInitial extends OtpState {}
// class phoneNumberSubmittedLoading extends OtpState {}
// class AuthErrorOccur extends OtpState {
//   final String error;
//   AuthErrorOccur(this.error);
// }
// class PhoneNumberSubmittedloaded extends OtpState {}
// class OtpVerified extends OtpState {}
// class OTPLoading extends OtpState {}
//  class OTPSent extends OtpState {}
// //AuthLoading
// class AuthLoading extends OtpState {}
// //AuthSuccess
// class AuthSuccess extends OtpState {
//  // final RegisterationResponse? response;
//   //AuthSuccess(this.response);
// }
// //AuthError
// class AuthError extends OtpState {
//   final String? error;
//   AuthError(this.error);
// }
// //(OtpVerificationFailed(
// //           exception.message, canResendOtp: true, resendOtpDuration: _resendOtpTimerDuration));
// //
// class OtpVerificationFailed extends OtpState {
//   final String? error;
//   final bool canResendOtp;
//   final int resendOtpDuration;
//   OtpVerificationFailed(this.error, {this.canResendOtp = false, this.resendOtpDuration = 0});
// }
// //VerificationFailed
// class VerificationFailed extends OtpState {
//   final String? error;
//   VerificationFailed(this.error);
// }
// //OTPReSent
// class OTPReSent extends OtpState {}