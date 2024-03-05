import 'package:admin_future/core/flutter_flow/flutter_flow_util.dart';
import 'package:admin_future/manage_users_coaches/business_logic/manage_users_cubit.dart';
import 'package:admin_future/home/presenation/widget/widget/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../core/flutter_flow/flutter_flow_theme.dart';

class EditUsers extends StatelessWidget {
  //const ({super.key});
  final user;
  final isCoach;

  const EditUsers({super.key, required this.user, this.isCoach});
  @override
  Widget build(BuildContext context) {



    return Builder(
      builder: (context) {
        // final manageSalaryCubit = ManageSalaryCubit.get(context);
        // manageSalaryCubit.initControllers(user);
        return Scaffold(
          appBar: const CustomAppBar(text: ''),
          // key: scaffoldKey,
          backgroundColor: Colors.white,
          body: SafeArea(
            top: true,
            child: SingleChildScrollView(

              child: Form(
                key: ManageUsersCubit.get(context).formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    //custom app bar

                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: //user.image.isNull
                          user.image!=null?
                               Image.network(
                            user.image,
                                //??
                                //'https://picsum.photos/seed/1/600',
                            width: 110.h,
                            height: 110.w,
                            fit: BoxFit.cover,
                          ):
                          // SvgPicture.asset(
                          //   //svg
                          //   'assets/images/Ellipse 1.jpg',
                          //   width: 130.h,
                          //   height: 130.w,
                          //   fit: BoxFit.cover,
                          // ),
                          Image.asset(
                              'assets/images/Ellipse 1.jpg',
                              width: 110.h,
                              height: 110.w,
                              fit: BoxFit.cover,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Column(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  'اسم الاول',
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                    fontFamily: 'Readex Pro',
                                    fontSize: 12,
                                  ),
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      height: 50,
                                      decoration: const BoxDecoration(),
                                      child: Align(
                                        alignment: const AlignmentDirectional(1, 0),
                                        child: SizedBox(
                                          width:
                                          MediaQuery.sizeOf(context).width * 0.8,
                                          child: TextFormField(
                                            // initialValue: user.fname??'a',
                                            controller: ManageUsersCubit.get(context)
                                                .firstNameController,
                                            autofocus: true,
                                            obscureText: false,

                                            decoration: InputDecoration(
                                              labelStyle: FlutterFlowTheme.of(context)
                                                  .labelMedium
                                                  .override(
                                                fontFamily: 'Readex Pro',
                                                fontSize: 10,
                                              ),
                                          //    hintText: user.fname??'a',
                                              hintStyle: FlutterFlowTheme.of(context)
                                                  .labelMedium
                                                  .override(
                                                fontFamily: 'Readex Pro',
                                                fontSize: 10,
                                              ),
                                              enabledBorder: OutlineInputBorder(
                                                borderSide: const BorderSide(
                                                  color: Color(0xFFF4F4F4),
                                                  width: 2,
                                                ),
                                                borderRadius:
                                                BorderRadius.circular(8),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderSide: const BorderSide(
                                                  color: Colors.blue,
                                                  width: 2,
                                                ),
                                                borderRadius:
                                                BorderRadius.circular(8),
                                              ),
                                              errorBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: FlutterFlowTheme.of(context)
                                                      .error,
                                                  width: 2,
                                                ),
                                                borderRadius:
                                                BorderRadius.circular(8),
                                              ),
                                              focusedErrorBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: FlutterFlowTheme.of(context)
                                                      .error,
                                                  width: 2,
                                                ),
                                                borderRadius:
                                                BorderRadius.circular(8),
                                              ),
                                            ),
                                            style: FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .override(
                                              fontFamily: 'Readex Pro',
                                              fontSize: 10,
                                            ),
                                            textAlign: TextAlign.end,
                                            keyboardType: TextInputType.name,
                                            cursorColor: const Color(0xFF333333),

                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ]
                                  .divide(const SizedBox(height: 5))
                                  .addToEnd(const SizedBox(height: 10)),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Column(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  'اسم الاخير',
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                    fontFamily: 'Readex Pro',
                                    fontSize: 12,
                                  ),
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      height: 50,
                                      decoration: const BoxDecoration(),
                                      child: Align(
                                        alignment: const AlignmentDirectional(1, 0),
                                        child: SizedBox(
                                          width:
                                          MediaQuery.sizeOf(context).width * 0.8,
                                          child: TextFormField(
                                            controller: ManageUsersCubit.get(context)
                                                .lastNameController,
                                            autofocus: true,
                                            obscureText: false,
                                            decoration: InputDecoration(
                                              labelStyle: FlutterFlowTheme.of(context)
                                                  .labelMedium
                                                  .override(
                                                fontFamily: 'Readex Pro',
                                                fontSize: 10,
                                              ),
                                         //     hintText: user.lname,
                                              hintStyle: FlutterFlowTheme.of(context)
                                                  .labelMedium
                                                  .override(
                                                fontFamily: 'Readex Pro',
                                                fontSize: 10,
                                              ),
                                              enabledBorder: OutlineInputBorder(
                                                borderSide: const BorderSide(
                                                  color: Color(0xFFF4F4F4),
                                                  width: 2,
                                                ),
                                                borderRadius:
                                                BorderRadius.circular(8),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderSide: const BorderSide(
                                                  color: Colors.blue,
                                                  width: 2,
                                                ),
                                                borderRadius:
                                                BorderRadius.circular(8),
                                              ),
                                              errorBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: FlutterFlowTheme.of(context)
                                                      .error,
                                                  width: 2,
                                                ),
                                                borderRadius:
                                                BorderRadius.circular(8),
                                              ),
                                              focusedErrorBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: FlutterFlowTheme.of(context)
                                                      .error,
                                                  width: 2,
                                                ),
                                                borderRadius:
                                                BorderRadius.circular(8),
                                              ),
                                            ),
                                            style: FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .override(
                                              fontFamily: 'Readex Pro',
                                              fontSize: 10,
                                            ),
                                            textAlign: TextAlign.end,
                                            keyboardType: TextInputType.name,
                                            cursorColor: const Color(0xFF333333),

                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ]
                                  .divide(SizedBox(height: 5.h))
                                  .addToEnd(SizedBox(height: 10.h)),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Column(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  'رقم الهاتف',
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                    fontFamily: 'Readex Pro',
                                    fontSize: 12,
                                  ),
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      height: 50,
                                      decoration: const BoxDecoration(),
                                      child: Align(
                                        alignment: const AlignmentDirectional(1, 0),
                                        child: SizedBox(
                                          width:
                                          MediaQuery.sizeOf(context).width * 0.8,
                                          child: TextFormField(
                                            controller: ManageUsersCubit.get(context)
                                                .phoneController,
                                            autofocus: true,
                                            obscureText: false,
                                            decoration: InputDecoration(
                                              labelStyle: FlutterFlowTheme.of(context)
                                                  .labelMedium
                                                  .override(
                                                fontFamily: 'Readex Pro',
                                                fontSize: 10,
                                              ),
                                    //          hintText: user.phone,
                                              hintStyle: FlutterFlowTheme.of(context)
                                                  .labelMedium
                                                  .override(
                                                fontFamily: 'Readex Pro',
                                                fontSize: 10,
                                              ),
                                              enabledBorder: OutlineInputBorder(
                                                borderSide: const BorderSide(
                                                  color: Color(0xFFF4F4F4),
                                                  width: 2,
                                                ),
                                                borderRadius:
                                                BorderRadius.circular(8),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderSide: const BorderSide(
                                                  color: Colors.blue,
                                                  width: 2,
                                                ),
                                                borderRadius:
                                                BorderRadius.circular(8),
                                              ),
                                              errorBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: FlutterFlowTheme.of(context)
                                                      .error,
                                                  width: 2,
                                                ),
                                                borderRadius:
                                                BorderRadius.circular(8),
                                              ),
                                              focusedErrorBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: FlutterFlowTheme.of(context)
                                                      .error,
                                                  width: 2,
                                                ),
                                                borderRadius:
                                                BorderRadius.circular(8),
                                              ),
                                            ),
                                            style: FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .override(
                                              fontFamily: 'Readex Pro',
                                              fontSize: 10,
                                            ),
                                            textAlign: TextAlign.end,
                                            keyboardType: TextInputType.emailAddress,
                                            cursorColor: const Color(0xFF333333),


                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ]
                                  .divide(SizedBox(height: 5.h))
                                  .addToEnd(SizedBox(height: 10.h)),
                            ),
                          ],
                        ),
                        //container which show coach password with icon to copy password to clipboard when click on it
                      //if user is coach
                        if(isCoach)
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    //password
                                    'كلمة المرور',
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                      fontFamily: 'Readex Pro',
                                      fontSize: 12,
                                    ),
                                  ),
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      IconButton(
                                        icon: const Icon(Icons.copy),
                                        onPressed: () {
                                          Clipboard.setData(ClipboardData(
                                            text: ManageUsersCubit.get(context).passwordController.text,
                                          ));
                                          //show snackbar to inform user that password copied to clipboard
                                          ScaffoldMessenger.of(context).showSnackBar(
                                            const SnackBar(
                                              content: Text('تم نسخ كلمة المرور'),
                                              duration: Duration(seconds: 3),
                                            ),
                                          );
                                        },
                                      ),
                                      Container(
                                        height: 50,
                                        decoration: const BoxDecoration(),
                                        child: Align(
                                          alignment: const AlignmentDirectional(1, 0),
                                          child: SizedBox(
                                            width: MediaQuery.sizeOf(context).width * 0.7,
                                            child: TextFormField(
                                              controller: ManageUsersCubit.get(context)
                                                  .passwordController,
                                              autofocus: false,
                                              readOnly: true, // Make the field uneditable
                                              obscureText: false,
                                              decoration: InputDecoration(
                                                labelStyle: FlutterFlowTheme.of(context)
                                                    .labelMedium
                                                    .override(
                                                  fontFamily: 'Readex Pro',
                                                  fontSize: 10,
                                                ),
                                                //          hintText: user.phone,
                                                hintStyle: FlutterFlowTheme.of(context)
                                                    .labelMedium
                                                    .override(
                                                  fontFamily: 'Readex Pro',
                                                  fontSize: 10,
                                                ),
                                                enabledBorder: OutlineInputBorder(
                                                  borderSide: const BorderSide(
                                                    color: Color(0xFFF4F4F4),
                                                    width: 2,
                                                  ),
                                                  borderRadius:
                                                  BorderRadius.circular(8),
                                                ),
                                                focusedBorder: OutlineInputBorder(
                                                  borderSide: const BorderSide(
                                                    color: Colors.blue,
                                                    width: 2,
                                                  ),
                                                  borderRadius:
                                                  BorderRadius.circular(8),
                                                ),
                                                errorBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: FlutterFlowTheme.of(context)
                                                        .error,
                                                    width: 2,
                                                  ),
                                                  borderRadius:
                                                  BorderRadius.circular(8),
                                                ),
                                                focusedErrorBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: FlutterFlowTheme.of(context)
                                                        .error,
                                                    width: 2,
                                                  ),
                                                  borderRadius:
                                                  BorderRadius.circular(8),
                                                ),
                                              ),
                                              style: FlutterFlowTheme.of(context)
                                                  .bodyMedium
                                                  .override(
                                                fontFamily: 'Readex Pro',
                                                fontSize: 10,
                                              ),
                                              textAlign: TextAlign.end,
                                              keyboardType: TextInputType.emailAddress,
                                              cursorColor: const Color(0xFF333333),
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 12.h),

                                    ],
                                  ),
                                ]
                                    .divide(SizedBox(height: 5.h))
                                    .addToEnd(SizedBox(height: 10.h)),
                              ),
                            ],
                          ),

                        Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Align(
                                      alignment: const AlignmentDirectional(0, 1),
                                      child: Container(
                                        width:
                                        MediaQuery.sizeOf(context).width * 0.35,
                                        height: 65,
                                        decoration: BoxDecoration(
                                          color: FlutterFlowTheme.of(context)
                                              .secondaryBackground,
                                        ),
                                        alignment: const AlignmentDirectional(0, 1),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            // FFButtonWidget(
                                            //   onPressed: () {
                                            //     print('Button pressed ...');
                                            //   },
                                            //   text: 'ارسال اشعار',
                                            //   options: FFButtonOptions(
                                            //     width: 150,
                                            //     height: 50,
                                            //     padding:
                                            //     EdgeInsetsDirectional.fromSTEB(
                                            //         0, 0, 0, 0),
                                            //     iconPadding:
                                            //     EdgeInsetsDirectional.fromSTEB(
                                            //         0, 0, 0, 0),
                                            //     color: Color(0xFF198CE3),
                                            //     textStyle:
                                            //     FlutterFlowTheme.of(context)
                                            //         .titleSmall
                                            //         .override(
                                            //       fontFamily: 'Readex Pro',
                                            //       color: Colors.white,
                                            //       fontSize: 1,
                                            //     ),
                                            //     elevation: 3,
                                            //     borderSide: BorderSide(
                                            //       color: Colors.transparent,
                                            //       width: 1,
                                            //     ),
                                            //     borderRadius:
                                            //     BorderRadius.circular(8),
                                            //   ),
                                            // ),
                                            InkWell(
                                            onTap: () async {
                                      String? uid =user.uId;
                                      String? phone =user.phone;
                                      //open whatsapp on number user phone
                                     //  String url = "whatsapp://send?phone=$phone";
                                      //+2 before phone number
                                      String url = 'https://api.whatsapp.com/send?phone=+20${phone}&text= ';
                                       await canLaunch(url)? launch(url):print('can not open whatsapp');
                                      //open whatsapp on number user phone
                                     // Todo: send message to user if made usr app
//                                       await showDialog(
//                                       useSafeArea: true,
//                                       context: context,
//                                       builder: (BuildContext context) {
//                                       return Dialog(
//                                       shape: RoundedRectangleBorder(
//                                       borderRadius: BorderRadius.circular(8),
//                                       ),
//                                       child: Container(
//                                       //height: 500,
//                                       child: Column(
//                                         mainAxisSize: MainAxisSize.min,
//                                         children: [
//                                           Column(
//                                             mainAxisSize: MainAxisSize.max,
//                                             children: [
//                                               Row(
//                                                 mainAxisSize: MainAxisSize.max,
//                                                 mainAxisAlignment: MainAxisAlignment.end,
//                                                 children: [
//                                                   ClipRRect(
//                                                     borderRadius: BorderRadius.circular(8),
//                                                     child: SvgPicture.asset(
//                                                       'assets/images/frame23420.svg',
//                                                       width: 50,
//                                                       height: 50,
//                                                       fit: BoxFit.none,
//                                                     ),
//                                                   ),
//                                                 ],
//                                               ),
//                                               Text(
//                                                 'ارسال رسالة',
//                                                 style: FlutterFlowTheme.of(context).bodyMedium.override(
//                                                   fontFamily: 'Readex Pro',
//                                                   fontSize: 24,
//                                                 ),
//                                               ),
//                                             ],
//                                           ),
//                                           Column(
//                                             mainAxisSize: MainAxisSize.max,
//                                             children: [
//                                               Align(
//                                                 alignment: AlignmentDirectional(0, 0),
//                                                 child: Row(
//                                                   mainAxisSize: MainAxisSize.max,
//                                                   mainAxisAlignment: MainAxisAlignment.end,
//                                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                                   children: [
//                                                     Container(
//                                                       width: 225,
//                                                       height: 100,
//                                                       decoration: BoxDecoration(
//                                                         color: FlutterFlowTheme.of(context)
//                                                             .secondaryBackground,
//                                                       ),
//                                                       child: Align(
//                                                         alignment: AlignmentDirectional(1, 0),
//                                                         child: Container(
//                                                           width: 225,
//                                                           child: TextFormField(
//                                                             controller: ManageUsersCubit.get(context).messageController,
//                                                             autofocus: true,
//                                                             obscureText: false,
//                                                             decoration: InputDecoration(
//                                                               labelStyle: FlutterFlowTheme.of(context)
//                                                                   .labelMedium
//                                                                   .override(
//                                                                 fontFamily: 'Readex Pro',
//                                                                 fontSize: 14,
//                                                               ),
//                                                               hintText: 'اكتب رقم',
//                                                               hintStyle: FlutterFlowTheme.of(context)
//                                                                   .labelMedium
//                                                                   .override(
//                                                                 fontFamily: 'Readex Pro',
//                                                                 fontSize: 12,
//                                                               ),
//                                                               enabledBorder: OutlineInputBorder(
//                                                                 borderSide: BorderSide(
//                                                                   color: Color(0xFFF4F4F4),
//                                                                   width: 2,
//                                                                 ),
//                                                                 borderRadius: BorderRadius.circular(8),
//                                                               ),
//                                                               focusedBorder: OutlineInputBorder(
//                                                                 borderSide: BorderSide(
//                                                                   color: Colors.blue,
//                                                                   width: 2,
//                                                                 ),
//                                                                 borderRadius: BorderRadius.circular(8),
//                                                               ),
//                                                               errorBorder: OutlineInputBorder(
//                                                                 borderSide: BorderSide(
//                                                                   color: FlutterFlowTheme.of(context).error,
//                                                                   width: 2,
//                                                                 ),
//                                                                 borderRadius: BorderRadius.circular(8),
//                                                               ),
//                                                               focusedErrorBorder: OutlineInputBorder(
//                                                                 borderSide: BorderSide(
//                                                                   color: FlutterFlowTheme.of(context).error,
//                                                                   width: 2,
//                                                                 ),
//                                                                 borderRadius: BorderRadius.circular(8),
//                                                               ),
//                                                             ),
//                                                             style: FlutterFlowTheme.of(context)
//                                                                 .bodyMedium
//                                                                 .override(
//                                                               fontFamily: 'Readex Pro',
//                                                               fontSize: 14,
//                                                             ),
//                                                             textAlign: TextAlign.end,
//                                                             maxLines: 9,
//                                                             keyboardType: TextInputType.multiline,
//                                                             cursorColor: Color(0xFF333333),
//                                                           //  validator: _model.textControllerValidator
//                                                          //       .asValidator(context),
//                                                           ),
//                                                         ),
//                                                       ),
//                                                     ),
//                                                     // Text(
//                                                     //   ':الدفع الجزئي',
//                                                     //   style:
//                                                     //   FlutterFlowTheme.of(context).bodyMedium.override(
//                                                     //     fontFamily: 'Readex Pro',
//                                                     //     fontSize: 12,
//                                                     //   ),
//                                                     // ),
//                                                   ]
//                                                       .divide(SizedBox(width: 10))
//                                                       .addToEnd(SizedBox(width: 15)),
//                                                 ),
//                                               ),
//                                               Row(
//                                                 mainAxisSize: MainAxisSize.max,
//                                                 mainAxisAlignment: MainAxisAlignment.center,
//                                                 children: [
//                                                   // FFButtonWidget(
//                                                   //   onPressed: () {
//                                                   //     print('Button pressed ...');
//                                                   //   },
//                                                   //   text: 'ارسال الرسالة',
//                                                   //   options: FFButtonOptions(
//                                                   //   //  width: 150,
//                                                   //  //   height: 50,
//                                                   //     padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
//                                                   //     iconPadding:
//                                                   //     EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
//                                                   //     color: Colors.blue,
//                                                   //     textStyle:
//                                                   //     FlutterFlowTheme.of(context).titleSmall.override(
//                                                   //       fontFamily: 'Readex Pro',
//                                                   //       color: Colors.white,
//                                                   //       fontSize: 12,
//                                                   //     ),
//                                                   //     elevation: 3,
//                                                   //     borderSide: BorderSide(
//                                                   //       color: Colors.transparent,
//                                                   //       width: 1,
//                                                   //     ),
//                                                   //     borderRadius: BorderRadius.circular(8),
//                                                   //   ),
//                                                   // ),
//                                                   BlocBuilder<ManageUsersCubit,ManageUsersState>(
//   builder: (context, state) {
//     return InkWell(
//       onTap: () {
//         //open whatsapp on number user phone
//
//
//         ManageUsersCubit.get(context).sendMessage(
//           //uid
//             uid: uid,
//           context: context,
//           message: ManageUsersCubit.get(context).messageController.text,
//         );
//       },
//       child: Container(
//                                                       height: 50,
//                                                       width: 150,
//                                                       decoration: BoxDecoration(
//                                                         color: Colors.blue,
//                                                         borderRadius: BorderRadius.circular(8),
//                                                       ),
//                                                       child: Align(
//                                                         alignment: AlignmentDirectional(0, 0),
//                                                         child: Text(
//                                                           'ارسال',
//                                                           textAlign: TextAlign.center,
//                                                           style: FlutterFlowTheme.of(context)
//                                                               .titleSmall
//                                                               .override(
//                                                             fontFamily: 'Readex Pro',
//                                                             color: Colors.white,
//                                                             fontSize: 14,
//                                                           ),
//                                                         ),
//                                                       ),
//                                                     ),
//     );
//   },
// ),
//                                                   //15.h
//
//                                                 ].divide(SizedBox(width: 10)),
//                                               ),
//                                               //SizedBox(height: 45),
//                                             ].divide(SizedBox(height: 20)).addToStart(SizedBox(height: 50)),
//                                           ),
//                                         ].divide(SizedBox(height: 0)),
//                                       ),
//                                       ),
//                                       );
//                                       },
//                                       );
                                      },
                                              child: Container(
                                                height: 50,
                                                width: 150,
                                                decoration: BoxDecoration(
                                                  color: Colors.blue,
                                                  borderRadius: BorderRadius.circular(8),
                                                ),
                                                child: Align(
                                                  alignment: const AlignmentDirectional(0, 0),
                                                  child: Text(
                                                    'ارسال اشعار',
                                                    textAlign: TextAlign.center,
                                                    style: FlutterFlowTheme.of(context)
                                                        .titleSmall
                                                        .override(
                                                      fontFamily: 'Readex Pro',
                                                      color: Colors.white,
                                                      fontSize: 14,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),

                                          ],
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: MediaQuery.sizeOf(context).width * 0.4,
                                      height: 80,
                                      decoration: const BoxDecoration(
                                        color: Color(0x00FFFFFF),
                                      ),
                                      alignment: const AlignmentDirectional(0, 1),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        children: [
                                          Text(
                                            isCoach ? 'الراتب بالساعة' : 
                                          //'number of sessions',
                                          //translate(context, 'number of sessions'),
                                          'عدد الحصص',

                                            style: FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .override(
                                              fontFamily: 'Readex Pro',
                                              fontSize: 12,
                                            ),
                                          ),
                                          Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                            MainAxisAlignment.center,
                                            children: [
                                            //isCoach?
                                            Container(
                                                width:
                                                MediaQuery.sizeOf(context).width *
                                                    0.4,
                                                height: 50,
                                                decoration: const BoxDecoration(),
                                                child: Align(
                                                  alignment:
                                                  const AlignmentDirectional(1, 0),
                                                  child: SizedBox(
                                                    width: MediaQuery.sizeOf(context)
                                                        .width *
                                                        0.8,
                                                    child: TextFormField(
                                                      controller: isCoach?
                                                        ManageUsersCubit
                                                          .get(context)
                                                          .salaryPerHourController:
                                                          ManageUsersCubit.get(context).numberOfSessionsController,
                                                      autofocus: true,
                                                      obscureText: false,
                                                      decoration: InputDecoration(
                                                        labelStyle:
                                                        FlutterFlowTheme.of(
                                                            context)
                                                            .labelMedium
                                                            .override(
                                                          fontFamily:
                                                          'Readex Pro',
                                                          fontSize: 10,
                                                        ),
                                                  //      hintText: user.hourlyRate.toString()??'',
                                                        hintStyle:
                                                        FlutterFlowTheme.of(
                                                            context)
                                                            .labelMedium
                                                            .override(
                                                          fontFamily:
                                                          'Readex Pro',
                                                          fontSize: 10,
                                                        ),
                                                        enabledBorder:
                                                        OutlineInputBorder(
                                                          borderSide: const BorderSide(
                                                            color: Color(0xFFF4F4F4),
                                                            width: 2,
                                                          ),
                                                          borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                        ),
                                                        focusedBorder:
                                                        OutlineInputBorder(
                                                          borderSide: const BorderSide(
                                                            color: Colors.blue,
                                                            width: 2,
                                                          ),
                                                          borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                        ),
                                                        errorBorder:
                                                        OutlineInputBorder(
                                                          borderSide: BorderSide(
                                                            color:
                                                            FlutterFlowTheme.of(
                                                                context)
                                                                .error,
                                                            width: 2,
                                                          ),
                                                          borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                        ),
                                                        focusedErrorBorder:
                                                        OutlineInputBorder(
                                                          borderSide: BorderSide(
                                                            color:
                                                            FlutterFlowTheme.of(
                                                                context)
                                                                .error,
                                                            width: 2,
                                                          ),
                                                          borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                        ),
                                                      ),
                                                      style:
                                                      FlutterFlowTheme.of(context)
                                                          .bodyMedium
                                                          .override(
                                                        fontFamily:
                                                        'Readex Pro',
                                                        fontSize: 10,
                                                      ),
                                                      textAlign: TextAlign.end,
                                                      keyboardType:
                                                      TextInputType.emailAddress,
                                                      cursorColor: const Color(0xFF333333),

                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ]
                                            .divide(SizedBox(height: 5.h))
                                            .addToEnd(const SizedBox(height: 0)),
                                      ),
                                    ),
                                  ].divide(const SizedBox(width: 25)),
                                ),
                              ],
                            ),
                            Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [

                                    BlocBuilder<ManageUsersCubit, ManageUsersState>(
                                      builder: (context, state) {
                                        return InkWell(
                                          onTap: () async {
                                            await ManageUsersCubit.get(context)
                                                .updateUserInfo(
                                              uid: user.uId,
                                              fname: ManageUsersCubit.get(context)
                                                  .firstNameController
                                                  .text.toString(),
                                              lname: ManageUsersCubit.get(context)
                                                  .lastNameController
                                                  .text.toString(),
                                              phone: ManageUsersCubit.get(context)
                                                  .phoneController
                                                  .text.toString(),
                                              hourlyRate: ManageUsersCubit.get(context)
                                                  .salaryPerHourController
                                                  .text.toString(),
                                              numberOfSessions: ManageUsersCubit.get(context)
                                                  .numberOfSessionsController
                                                  .text.toString(),
                                            //  password: ManageSalaryCubit.get(context)
                                             //     .passwordController
                                             //     .text.toString(),
                                            );
                                          },
                                          child: state is UpdateUserInfoLoadingState
                                              ? const CircularProgressIndicator()
                                              :
                                          Container(
                                            height: 50,
                                            width: 150,
                                            decoration: BoxDecoration(
                                              color: Colors.blue,
                                              borderRadius: BorderRadius.circular(8),
                                            ),
                                            child: Align(
                                              alignment: const AlignmentDirectional(0, 0),
                                              child: Text(
                                                'حفظ التعديلات',
                                                textAlign: TextAlign.center,
                                                style: FlutterFlowTheme.of(context)
                                                    .titleSmall
                                                    .override(
                                                  fontFamily: 'Readex Pro',
                                                  color: Colors.white,
                                                  fontSize: 14,
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    ),

                                  ],
                                ),
                                SizedBox(height: 15.h),
                                InkWell(
                                  onTap: () async {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: const Text('تأكيد الحذف'),
                                          content: const Text('هل تريد حذف الحساب؟'),
                                          actions: [
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                              children: [
                                                SizedBox(
                                                  width: 100.0,
                                                  child: ElevatedButton(
                                                    onPressed: () {
                                                      Navigator.of(context).pop(false); // Close the dialog and pass false
                                                    },
                                                    style: ElevatedButton.styleFrom(
                                                      primary: Colors.white,
                                                    ),
                                                    child: const Text(
                                                      'لا',
                                                      style: TextStyle(color: Colors.black),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 100.0,
                                                  child: ElevatedButton(
                                                    onPressed: () async {
                                                      Navigator.of(context).pop(true); // Close the dialog and pass true
                                                    },
                                                    style: ElevatedButton.styleFrom(
                                                      primary: Colors.red.shade800,
                                                    ),
                                                    child: const Text(
                                                      'نعم',
                                                      style: TextStyle(color: Colors.white),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        );
                                      },
                                    ).then((confirmed) async {
                                      if (confirmed == true) {
                                        await ManageUsersCubit.get(context).deleteUser(uid: user.uId);
                                     //pop
                                        Navigator.of(context).pop();
                                      }
                                    });
                                  },
                                  child: Text(
                                          'حذف الحساب',
                                          style: FlutterFlowTheme.of(context).bodyMedium.override(
                                            fontFamily: 'Readex Pro',
                                            color: const Color(0xFFD92D20),
                                            fontSize: 12,
                                            decoration: TextDecoration.underline,
                                          ),
                                  ),


                                ),

                              ].divide(const SizedBox(height: 5)),
                            ),
                          ]
                              .divide(SizedBox(height: 10.h))
                              .addToStart(SizedBox(height: 10.h)),
                        ),
                      ].addToStart(SizedBox(height: 20.h)),
                    ),
                  ].addToStart(SizedBox(height: 40.h)),
                ),
              ),
            ),
          ),

        );
      }
    );
  }
}



