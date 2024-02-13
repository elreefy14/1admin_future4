import 'package:admin_future/registeration/presenation/widget/component.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../home/presenation/widget/widget/custom_app_bar.dart';
import '../business_logic/auth_cubit/sign_up_cubit.dart';
import '../business_logic/auth_cubit/sign_up_state.dart';

class AddCoachScreen extends StatelessWidget {
//  args = settings.arguments as Map<String, dynamic>;
//   return MaterialPageRoute(builder: (_) => AddCoachScreen(
//     isCoach: (args as Map<String, dynamic>)?['isCoach'],
//   ));
  final bool isCoach ;

  const AddCoachScreen({super.key, required this.isCoach});

  @override
  Widget build(BuildContext context) {
    //clr text fieldsغ
    // SignUpCubit.get(context).firstNameController.clear();
    // SignUpCubit.get(context).lastNameController.clear();
    // SignUpCubit.get(context).phoneController.clear();
    // SignUpCubit.get(context).passwordController.clear();
    // SignUpCubit.get(context).hourlyRateController.clear();


    return BlocBuilder<SignUpCubit, SignUpState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: const CustomAppBar(
            text: '',
          ),
          body: ListView(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //82
              SizedBox(height: 12.h),
              Padding(
                padding: EdgeInsets.only(
                  top: 32.0.h,
                  // horizontal: 145.w,
                ),
                child: Center(
                  child: Container(
                    //   width: 99.w,
                    //   height: 26.h,
                    alignment: Alignment.center,
                    child: isCoach ==true ?Text(
                      'اضافة مدرب',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: const Color(0xFF333333),
                        fontSize: 32.sp,
                        fontFamily: 'Montserrat-Arabic',
                        fontWeight: FontWeight.w400,
                        height: 0.03.h,
                      ),
                    ):Text(
                      'اضافة متدرب',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: const Color(0xFF333333),
                        fontSize: 32.sp,
                        fontFamily: 'Montserrat-Arabic',
                        fontWeight: FontWeight.w400,
                        height: 0.03.h,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 50.0.h),
              Form(
                key: SignUpCubit
                    .get(context)
                    .formKey,
                child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 35.0.w),
                        child: BuildTextFormField2(context: context,

                        'الاسم الاول',
                            SignUpCubit
                                .get(context)
                                .firstNameController,
                            TextInputType.name, 'ادخل الاسم الاول', (value) {
                              if (value!.isEmpty) {
                                return ' الرجاء ادخال الاسم الاول';
                              }
                              return null;
                            }, Icons.person),
                      ),
                      SizedBox(height: 20.0.h),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 35.0.w),
                        child: BuildTextFormField2('الاسم الاخير',
                            SignUpCubit
                                .get(context)
                                .lastNameController,
                            TextInputType.name, 'ادخل الاسم الاخير', (value) {
                              if (value!.isEmpty) {
                                return 'الرجاء ادخال الاسم الاخير';
                              }
                              return null;
                            }, Icons.person),
                      ),
                      const SizedBox(height: 20.0),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 35.0.w),
                        child: BuildTextFormField2('رقم الهاتف',
                          SignUpCubit
                              .get(context)
                              .phoneController,
                          TextInputType.phone, 'ادخل رقم الهاتف', (value) {
                            if (value!.isEmpty) {
                              return 'الرجاء ادخال رقم الهاتف';
                            }
                            return null;
                          }, Icons.phone,),
                      ),
                      SizedBox(height: 20.0.h),
                      if(isCoach ==true)
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 35.0.w),
                        child: BuildTextFormField2('كلمة المرور',
                          SignUpCubit
                              .get(context)
                              .passwordController
                          , TextInputType.text, 'ادخل كلمة المرور', (value) {
                            if (value!.isEmpty) {
                              return 'الرجاء ادخال كلمة المرور';
                            }
                            else if (value.length < 6) {
                              return 'يجب ادخال كلمة مرور اكثر من ٦ أحرف او ارقام';
                            }
                            return null;
                          }, Icons.lock,
                          context: context,
                        ),
                      ),
                      if(isCoach ==true)
                        const SizedBox(height: 20.0),
                      if(isCoach ==true)
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 35.0.w),
                          child: BuildTextFormField2(//hourlyRate
                            //salaty per hour
                            'الراتب لكل ساعة',
                            SignUpCubit
                                .get(context)
                                .hourlyRateController,
                            TextInputType.phone,
                            'ادخل الراتب لكل ساعة', (value) {
                            if (value!.isEmpty) {
                              return 'الرجاء ادخال الراتب لكل ساعة';
                            }
                            return null;
                          }, Icons.monetization_on,),
                        ),

                      SizedBox(height: 10.0.h),
                      //10.0.h
                      SizedBox(height: 10.0.h),
                      // if state is UpdateSelectedItemsState update this widget
                      // BlocConsumer<SignUpCubit, SignUpState>(
                      //   listener: (context, state) {
                      //     // TODO: implement listener
                      //   },
                      //   builder: (context, state) {
                      //     return Column(
                      //       crossAxisAlignment: CrossAxisAlignment.start,
                      //       children: [
                      //         //             Padding(
                      //         //               padding: EdgeInsets.symmetric(horizontal: 35.0.w),
                      //         //               child:
                      //         //               //flutterFlow button to select branches
                      //         //               FFButtonWidget(
                      //         //                 onPressed: _showMultiSelect,
                      //         //                 text: 'اختر مكان التدريب',
                      //         //         options: FFButtonOptions(
                      //         //     height: 40,
                      //         //     padding: EdgeInsetsDirectional.fromSTEB(24, 0, 24, 0),
                      //         //     iconPadding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                      //         //     color: Color(0xFF198CE3),
                      //         //     textStyle:
                      //         //     FlutterFlowTheme.of(context).titleSmall.override(
                      //         //       fontFamily: 'Readex Pro',
                      //         //       color: Colors.white,
                      //         //     ),
                      //         //     elevation: 3,
                      //         //     borderSide: BorderSide(
                      //         //       color: Colors.transparent,
                      //         //       width: 1,
                      //         //     ),
                      //         //     borderRadius: BorderRadius.circular(8),
                      //         //   ),
                      //         // ),
                      //         //               ),
                      //         InkWell(
                      //           onTap: _showMultiSelect,
                      //           child: Padding(
                      //             padding: EdgeInsets.symmetric(horizontal: 35.0.w),
                      //             child: Container(
                      //               padding: EdgeInsets.all(5),
                      //               decoration: BoxDecoration(
                      //                 color: Color(0xFFF4F4F4),
                      //                 border: Border.all(
                      //                   color: Color(0xFF2196F3),
                      //                   width: 0.75,
                      //                 ),
                      //                 borderRadius: BorderRadius.circular(4),
                      //               ),
                      //               child: Row(
                      //                 children: [
                      //                   SizedBox(width: 5.w),
                      //                   SizedBox(

                      //                     child: Text(
                      //                       'اختر اماكن التدريب المسؤول عنها',
                      //                       textAlign: TextAlign.right,
                      //                       style: TextStyle(
                      //                         color: Colors.black,
                      //                         fontSize: 16,
                      //                         fontFamily: 'IBM Plex Sans Arabic',
                      //                         fontWeight: FontWeight.w400,
                      //                       ),
                      //                     ),
                      //                   ),
                      //                   Spacer(),
                      //                   Icon(
                      //                     Icons.location_on_outlined,
                      //                     color: Color(0xFF2196F3),
                      //                     size: 24,
                      //                   ),
                      //                   SizedBox(width: 5.w),

                      //                 ],
                      //               ),
                      //             ),
                      //           ),
                      //         ),
                      //         Divider(height: 5.h),
                      //         if (SignUpCubit
                      //             .get(context)
                      //             .selectedItems != null &&
                      //             SignUpCubit
                      //                 .get(context)
                      //                 .selectedItems!
                      //                 .isNotEmpty)
                      //           Padding(
                      //             padding: //20 from left
                      //             EdgeInsets.only(right: 20.w),
                      //             child: Wrap(
                      //               children: SignUpCubit
                      //                   .get(context)
                      //                   .selectedItems!
                      //                   .map((e) =>
                      //                   Chip(
                      //                     label: Text(e),
                      //                   ))
                      //                   .toList(),
                      //             ),
                      //           ),
                      //       ],
                      //     );
                      //   },
                      // ),


                      // BlocConsumer<OtpCubit,OtpState >(
                      BlocConsumer<SignUpCubit, SignUpState>(
                        listener: (context, state) {
                          // if (state is PhoneNumberSubmittedloaded) {
                          // Navigator.pushNamed(
                          //         context,
                          //         AppRoutes.otpVerification,
                          //         arguments: {
                          //           'phone': phoneController.text,
                          //           'lName': lastNameController.text,
                          //           'fName': firstNameController.text,
                          //           'password': passwordController.text,
                          //         },
                          //       );
                          // }
                          //show toast in case of error and success
                          // if (state is SignUpErrorState) {
                          //   showToast(
                          //     msg: state.error ?? 'حدث خطأ ما',
                          //     state: ToastStates.ERROR,
                          //   );
                          // } else if (state is SignUpSuccessState) {
                          //   //show toast in case of success
                          //   showToast(
                          //     msg: 'تم التسجيل بنجاح',
                          //     state: ToastStates.SUCCESS,
                          //   );
                          //   //navigate to home screen
                          // //  Navigator.pushReplacementNamed(
                          // //      context, AppRoutes.manageCoaches);
                          // }
                        },
                        builder: (context, state) {
                          return ConditionalBuilder(
                            condition: state is SignUpSuccessState || state is SignUpErrorState || state is! SignUpLoadingState,
                            builder: (context) {
                              return Padding(
                                padding: EdgeInsets.only(
                                    left: 31.w,
                                    right: 31.w,
                                    top: 10.h
                                ),
                                child: ElevatedButton(
                                  onPressed: () {
                                    if (
                                    SignUpCubit
                                        .get(context)
                                        .formKey
                                        .currentState!
                                        .validate()) {
                                      if(isCoach == true){
                                        //signUp
                                        SignUpCubit.get(context).addUser(
                                          role: 'coach',
                                          fName: SignUpCubit
                                              .get(context)
                                              .firstNameController
                                              .text,
                                          lName: SignUpCubit
                                              .get(context)
                                              .lastNameController
                                              .text,
                                          phone:  SignUpCubit
                                              .get(context)
                                              .phoneController
                                              .text.trim(),
                                          password: SignUpCubit
                                              .get(context)
                                              .passwordController
                                              .text,
                                          hourlyRate: SignUpCubit
                                              .get(context)
                                              .hourlyRateController
                                              .text,
                                        );
                                      }
                                      else {
                                        //signUp
                                        SignUpCubit.get(context).addTrainee(
                                          //role: 'user',
                                          fname: SignUpCubit
                                              .get(context)
                                              .firstNameController
                                              .text,
                                          lname: SignUpCubit
                                              .get(context)
                                              .lastNameController
                                              .text,
                                          phone:
                                          // SignUpCubit
                                          //     .get(context)
                                          //     .phoneController
                                          //     .text,
                                          //trim all spaces from phone number from mid or start or end

                                          SignUpCubit
                                              .get(context)
                                              .phoneController
                                              .text.trim(),
                                          password: SignUpCubit
                                              .get(context)
                                              .passwordController
                                              .text,
                                        );
                                      }
                                      // OtpCubit.get(context).phoneNumberSubmitted(phoneController.text);
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFF2196F3),
                                    // Background color
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16, vertical: 9),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    textStyle: const TextStyle(
                                      fontSize: 18, // Adjust the font size if needed
                                    ),
                                  ),
                                  child: const Text(
                                    'تسجيل حساب جديد',
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
                                ),

                              );
                            },
                            fallback: (context) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}