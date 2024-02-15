import 'package:admin_future/core/flutter_flow/flutter_flow_util.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:ui' as ui;
// import 'package:easy_localization/easy_localization.dart' hide
// TextDirection;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:logger/logger.dart';
import '../../core/constants/routes_manager.dart';
import '../../core/flutter_flow/flutter_flow_theme.dart';
import '../../manage_users_coaches/business_logic/manage_users_cubit.dart';
import '../../registeration/data/userModel.dart';
import 'onboarding_screen.dart';
class ShowCoachesInDialog extends StatelessWidget {
  final bool? isCoachInfoList;
  final bool? isUserInfoList;
  final List<UserModel> selectedUsers;
  final Function(List<UserModel>) onSelectedUsersChanged;
  final bool isCoach;

  const ShowCoachesInDialog({
    Key? key,
    this.isUserInfoList,
    this.isCoachInfoList,
    required this.selectedUsers,
    required this.onSelectedUsersChanged,
    required this.isCoach,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {

    return BlocBuilder<AddGroupCubit, AddGroupState>(
      builder: (context, state) {
        final logger = Logger();
        final addGroupCubit = context.read<AddGroupCubit>();
        final query = addGroupCubit.usersQuery;
        bool isSearch = addGroupCubit.isSearch;
        return
          //if isCoachInfoList is true then dont show parent diakog
          //instead show the child column of the dialog
          //else show the parent dialog

          isCoachInfoList ??false ?
          //coach screen
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              isCoachInfoList ?? false ?
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                      margin: EdgeInsets.only(right: 10.w
                          ,bottom: 15.h),
                      decoration: ShapeDecoration(
                        color: const Color(0xFFFAFAFA),
                        shape: RoundedRectangleBorder(
                          side: const BorderSide(width: 1, color: Color(0xFFB9B9B9)),
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                      height: 40.h,
                      width: 290.w,
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child:TextField(
                        onTap: //_showClearButton = false; /
                            () {
                          //  addGroupCubit.isSearch = true;
                          //make it using update funvtion
                          addGroupCubit.updateIsSearch(true);
                        },
                        //arabic
                        textAlign: TextAlign.right,
                        controller: addGroupCubit.searchController,
                        textInputAction: TextInputAction.search,
                        onSubmitted: (_) => addGroupCubit.onSearchSubmitted(addGroupCubit.searchController.text.trim(),isCoach),
                        decoration:InputDecoration(
                          border: InputBorder.none,

                          contentPadding: const EdgeInsets.only(right: 20),
                          //manage users
                          hintText: 'رقم الهاتف او الاسم ',
                          //trensform to arabic
                          suffixIcon: IconButton(
                            icon: const Icon(Icons.search),
                            onPressed: () => addGroupCubit.onSearchSubmitted(addGroupCubit.searchController.text.trim(),isCoach),
                          ),
                          prefixIcon:
                          isSearch? IconButton(
                              icon: const Icon(Icons.close),
                              onPressed: () {
                                addGroupCubit.searchController.clear();
                                //query ==null
                                //  addGroupCubit.usersQuery =null;
                                //make it using update funvtion
                                addGroupCubit.updateUsersQuery(
                                  //if is coach then show only coaches
                                  isCoach ? FirebaseFirestore.instance.collection('users').where(
                                      'role', isEqualTo: 'coach')
                                      .where('pid',isEqualTo: FirebaseAuth.instance.currentUser!.uid)
                                      :FirebaseFirestore.instance.collection('users').where(
                                      'role', isEqualTo: 'user')
                                      .where('pid',isEqualTo: FirebaseAuth.instance.currentUser!.uid),
                                );

                                //update isSearch
                                addGroupCubit.updateIsSearch(false);
                                FocusScope.of(context).unfocus();

                              }
                          ):null,
                        ),
                      )
                  ),
                ],
              ) :
              Padding(
                padding: const EdgeInsets.all(8.0),
                child:TextField(
                  controller: addGroupCubit.searchController,
                  textInputAction: TextInputAction.search,
                  onSubmitted: (_) => addGroupCubit.onSearchSubmitted(addGroupCubit.searchController.text.trim(),isCoach),
                  decoration: InputDecoration(
                    hintText: 'Search by name or phone number',
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.search),
                      onPressed: () => addGroupCubit.onSearchSubmitted(addGroupCubit.searchController.text.trim(),isCoach),
                    ),
                  ),
                ),
              ),
              isCoachInfoList??false?
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    width:
                    MediaQuery.sizeOf(context).width * 0.2,
                    height: 35,
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context)
                          .secondaryBackground,
                      border: Border.all(
                        color: const Color(0xFFB4B4B4),
                        width: 1,
                      ),
                    ),
                    child: Align(
                      alignment: const AlignmentDirectional(0, 0),
                      child: Text(
                        //reduce sessions
                        'المزيد',
                        textAlign: TextAlign.end,
                        style: FlutterFlowTheme.of(context)
                            .bodyMedium
                            .override(
                          fontFamily: 'Readex Pro',
                          color: Colors.black,
                          fontSize: 10,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width:
                    MediaQuery.sizeOf(context).width * 0.2,
                    height: 35,
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context)
                          .secondaryBackground,
                      border: Border.all(
                        color: const Color(0xFFB4B4B4),
                        width: 1,
                      ),
                    ),
                    child: Align(
                      alignment: const AlignmentDirectional(0, 0),
                      child: Text(
                        //reduce sessions
                        'دفع الراتب',
                        textAlign: TextAlign.end,
                        style: FlutterFlowTheme.of(context)
                            .bodyMedium
                            .override(
                          fontFamily: 'Readex Pro',
                          color: Colors.black,
                          fontSize: 10,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width:
                    MediaQuery.sizeOf(context).width * 0.2,
                    height: 35,
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context)
                          .secondaryBackground,
                      border: Border.all(
                        color: const Color(0xFFB4B4B4),
                        width: 1,
                      ),
                    ),
                    child: Align(
                      alignment: const AlignmentDirectional(0, 0),
                      child: Text(

                        //'add sessions',
                        //  مكافاه
                        'المكافأة',
                        textAlign: TextAlign.end,
                        style: FlutterFlowTheme.of(context)
                            .bodyMedium
                            .override(
                          fontFamily: 'Readex Pro',
                          color: Colors.black,
                          fontSize: 10,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width:
                    MediaQuery.sizeOf(context).width * 0.2,
                    height: 35,
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context)
                          .secondaryBackground,
                      border: Border.all(
                        color: const Color(0xFFB4B4B4),
                        width: 1,
                      ),
                    ),
                    child: Align(
                      alignment: const AlignmentDirectional(0, 0),
                      child: Text(
                        //number of sessions
                        'اجمالي المرتب',
                        textAlign: TextAlign.end,
                        style: FlutterFlowTheme.of(context)
                            .bodyMedium
                            .override(
                          fontFamily: 'Readex Pro',
                          color: Colors.black,
                          fontSize: 10,
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: const AlignmentDirectional(1, 0),
                    child: Container(
                      width: MediaQuery.sizeOf(context).width *
                          0.2,
                      height: 35,
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context)
                            .secondaryBackground,
                        border: Border.all(
                          color: const Color(0xFFB4B4B4),
                          width: 1,
                        ),
                      ),
                      child: Align(
                        alignment: const AlignmentDirectional(0, 0),
                        child: Text(
                          'الاسم',
                          textAlign: TextAlign.end,
                          style: FlutterFlowTheme.of(context)
                              .bodyMedium
                              .override(
                            fontFamily: 'Readex Pro',
                            fontSize: 10,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ) :Container(),

              Expanded(
                child: FirestoreListView(
                  shrinkWrap: true,
                  cacheExtent: 5000,
                  pageSize: 5,
                  query: query ??FirebaseFirestore.instance.collection('users').where(
                      'role', isEqualTo: isCoachInfoList??false ? 'coach' : 'user')
                    .where('pid',isEqualTo: FirebaseAuth.instance.currentUser!.uid),
                  itemBuilder: (context, document) {
                    final data = document.data() as Map<String, dynamic>;
                    final user = UserModel.fromJson(data);
                    return isCoachInfoList ??
                        false ?   Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          width: MediaQuery.sizeOf(context).width * 0.2,
                          height: 35,
                          decoration: BoxDecoration(
                            color: FlutterFlowTheme.of(context)
                                .secondaryBackground,
                            border: Border.all(
                              color: const Color(0xFFB4B4B4),
                              width: 1,
                            ),
                          ),
                          child: InkWell(
                            onTap: () async {
                              final manageSalaryCubit = ManageUsersCubit.get(context);
                              //manageSalaryCubit.initControllers(ManageUsersCubit.get(context).coaches[index]);
                              manageSalaryCubit.initControllers(user);
                              await Navigator.pushNamed(context,
                                  AppRoutes.editProfile,
                                  arguments: user
                                  as UserModel
                              ) ;


                            },
                            child: Align(
                              alignment: const AlignmentDirectional(0, 0),
                              child: InkWell(
                                child: Text(
                                  '...المزيد ',
                                  textAlign: TextAlign.end,
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                    fontFamily: 'Readex Pro',
                                    color: Colors.blue,
                                    fontSize: 10.sp,
                                    decoration:
                                    TextDecoration.underline,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        BlocBuilder<ManageUsersCubit, ManageUsersState>(
                          builder: (context, state) {
                            return Container(
                              width: MediaQuery.sizeOf(context).width * 0.2,
                              height: 35,
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context)
                                    .secondaryBackground,
                                border: Border.all(
                                  color: const Color(0xFFB4B4B4),
                                  width: 1,
                                ),
                              ),
                              child: InkWell(
                                onTap: () async {
                                  //      String? uid =ManageUsersCubit.get(context).coaches[index].uId;
                                  String? uid =user.uId;
                                  int? userSalary = user.totalSalary;
                                  //updateShowRollbackButtonSession
                                  //  ManageUsersCubit.get(context).updateShowRollbackButtonSession(true);
                                  //show dialog
                                  await showDialog(
                                    useSafeArea: true,
                                    context: context,
                                    builder: (BuildContext context) {
                                      return Dialog(
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                        child: Container(
                                          //height: 500,
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Column(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  Row(
                                                    mainAxisSize: MainAxisSize.max,
                                                    mainAxisAlignment: MainAxisAlignment.end,
                                                    children: [
                                                      InkWell(
                                                         onTap: () {
                                                          Navigator.pop(context);
                                                        },
                                                        child: ClipRRect(
                                                          borderRadius: BorderRadius.circular(8),
                                                          child: SvgPicture.asset(
                                                            'assets/images/frame23420.svg',
                                                            width: 50,
                                                            height: 50,
                                                            fit: BoxFit.none,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Text(
                                                    'دفع المرتب',
                                                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                      fontFamily: 'Readex Pro',
                                                      fontSize: 24,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Column(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  Align(
                                                    alignment: const AlignmentDirectional(0, 0),
                                                    child: Row(
                                                      mainAxisSize: MainAxisSize.max,
                                                      mainAxisAlignment: MainAxisAlignment.end,
                                                      children: [
                                                        Expanded(
                                                          child: Align(
                                                            alignment: const AlignmentDirectional(1, 0),
                                                            child: SizedBox(
                                                              width: 100,
                                                              child: TextFormField(
                                                                controller: ManageUsersCubit.get(context).salaryController,
                                                                autofocus: true,
                                                                obscureText: false,
                                                                decoration: InputDecoration(
                                                                  labelStyle: FlutterFlowTheme.of(context)
                                                                      .labelMedium
                                                                      .override(
                                                                    fontFamily: 'Readex Pro',
                                                                    fontSize: 10,
                                                                  ),
                                                                  hintText: 'اكتب رقم',
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
                                                                    borderRadius: BorderRadius.circular(8),
                                                                  ),
                                                                  focusedBorder: OutlineInputBorder(
                                                                    borderSide: const BorderSide(
                                                                      color: Colors.blue,
                                                                      width: 2,
                                                                    ),
                                                                    borderRadius: BorderRadius.circular(8),
                                                                  ),
                                                                  errorBorder: OutlineInputBorder(
                                                                    borderSide: BorderSide(
                                                                      color: FlutterFlowTheme.of(context).error,
                                                                      width: 2,
                                                                    ),
                                                                    borderRadius: BorderRadius.circular(8),
                                                                  ),
                                                                  focusedErrorBorder: OutlineInputBorder(
                                                                    borderSide: BorderSide(
                                                                      color: FlutterFlowTheme.of(context).error,
                                                                      width: 2,
                                                                    ),
                                                                    borderRadius: BorderRadius.circular(8),
                                                                  ),
                                                                ),
                                                                style: FlutterFlowTheme.of(context)
                                                                    .bodyMedium
                                                                    .override(
                                                                  fontFamily: 'Readex Pro',
                                                                  fontSize: 10,
                                                                ),
                                                                textAlign: TextAlign.end,
                                                                keyboardType: TextInputType.number,
                                                                cursorColor: const Color(0xFF333333),
                                                                //   validator: _model.textControllerValidator
                                                                //     .asValidator(context),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        Text(
                                                          ':الدفع الجزئي',
                                                          style:
                                                          FlutterFlowTheme.of(context).bodyMedium.override(
                                                            fontFamily: 'Readex Pro',
                                                            fontSize: 12,
                                                          ),
                                                        ),
                                                      ]
                                                          .divide(const SizedBox(width: 10))
                                                          .addToEnd(const SizedBox(width: 15)),
                                                    ),
                                                  ),
                                                  Row(
                                                    mainAxisSize: MainAxisSize.max,
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [

                                                      InkWell(
                                                        onTap: () async {
                                                          //     print(ManageUsersCubit.get(context).users[index].uId);
                                                          //  userSalary = ManageUsersCubit.get(context).users[index].totalSalary;
                                                          await ManageUsersCubit.get(context).payPartialSalary
                                                            (
                                                            userName: user.name??'',
                                                            currentTotalSalary: userSalary??0,
                                                            userId:
                                                            uid,salaryPaid: ManageUsersCubit.get(context).salaryController.text,
                                                          ).then((value) => Navigator.pop(context));
                                                        },
                                                        child:
                                                            BlocBuilder<ManageUsersCubit, ManageUsersState>(
  builder: (context, state) {
    return                                                             state is PaySalaryLoadingState? const CircularProgressIndicator():
    Container(
                                                          width: 130,
                                                          height: 40,
                                                          decoration: BoxDecoration(
                                                            color: const Color(0xFFB9B9B9),
                                                            borderRadius: BorderRadius.circular(8),
                                                          ),
                                                          child: Align(
                                                            alignment: const AlignmentDirectional(0, 0),
                                                            child: Text(
                                                              'دفع جزئي',
                                                              style: FlutterFlowTheme.of(context)
                                                                  .titleSmall
                                                                  .override(
                                                                fontFamily: 'Readex Pro',
                                                                color: Colors.white,
                                                                fontSize: 12,
                                                              ),
                                                            ),
                                                          ),
                                                        );
  },
),
                                                      ),

                                                      InkWell(
                                                        onTap: () async {
                                                          //     print(ManageUsersCubit.get(context).users[index].uId);
                                                          await ManageUsersCubit.get(context).paySalary(
                                                                                                                         userTotalSalary:user.totalSalary,
                                                            userName:
                                                          user.name,
                                                            userId:
                                                            uid,
                                                          ).then((value) => Navigator.pop(context));
                                                        },
                                                        child: BlocBuilder<ManageUsersCubit, ManageUsersState>(
  builder: (context, state) {
    return                                                             state is PayAllSalaryLoadingState? const CircularProgressIndicator():
    Container(
                                                          width: 130,
                                                          height: 40,
                                                          decoration: BoxDecoration(
                                                            color: Colors.blue,
                                                            borderRadius: BorderRadius.circular(8),
                                                          ),
                                                          child: Align(
                                                            alignment: const AlignmentDirectional(0, 0),
                                                            child: Text(
                                                              'دفع كل المرتب',
                                                              style: FlutterFlowTheme.of(context)
                                                                  .titleSmall
                                                                  .override(
                                                                fontFamily: 'Readex Pro',
                                                                color: Colors.white,
                                                                fontSize: 12,
                                                              ),
                                                            ),
                                                          ),
                                                        );
  },
),
                                                      )
                                                    ].divide(const SizedBox(width: 10)),
                                                  ),

                                                ].divide(const SizedBox(height: 35)).addToStart(const SizedBox(height: 50)),
                                              ),
                                              const SizedBox(
                                                height: 20,
                                              )
                                            ].divide(const SizedBox(height: 0)),
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                },
                                child: Align(
                                  alignment: const AlignmentDirectional(0, 0),
                                  child: Text(
                                    'دفع الراتب',
                                    textAlign: TextAlign.end,
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                      fontFamily: 'Readex Pro',
                                      color: Colors.blue,
                                      fontSize: 10,
                                      decoration:
                                      TextDecoration.underline,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                        BlocConsumer<ManageUsersCubit, ManageUsersState>(
                          listener: (context, state) {

                          },
                          builder: (context, state) {
                            return Container(
                              width: MediaQuery.sizeOf(context).width * 0.2,
                              height: 35,
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context)
                                    .secondaryBackground,
                                border: Border.all(
                                  color: const Color(0xFFB4B4B4),
                                  width: 1,
                                ),
                              ),
                              child: InkWell(
                                onTap: () async {
                                  //String? uid =ManageUsersCubit.get(context).coaches[index].uId;
                                  String? uid =user.uId;
                                  //show dialog
                                  await showDialog(
                                    useSafeArea: true,
                                    context: context,
                                    builder: (BuildContext context) {
                                      return Dialog(
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                        child: Container(
                                          //height: 500,
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Column(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  Row(
                                                    mainAxisSize: MainAxisSize.max,
                                                    mainAxisAlignment: MainAxisAlignment.end,
                                                    children: [
                                                      InkWell(
                                                        onTap: () {
                                                          Navigator.pop(context);
                                                        },
                                                        child: ClipRRect(
                                                          borderRadius: BorderRadius.circular(8),
                                                          child: SvgPicture.asset(
                                                            'assets/images/frame23420.svg',
                                                            width: 50,
                                                            height: 50,
                                                            fit: BoxFit.none,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Text(
                                                    //'bonus'
                                                    'المكافأة',
                                                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                      fontFamily: 'Readex Pro',
                                                      fontSize: 24,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Column(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  Align(
                                                    alignment: const AlignmentDirectional(0, 0),
                                                    child: Row(
                                                      mainAxisSize: MainAxisSize.max,
                                                      mainAxisAlignment: MainAxisAlignment.end,
                                                      children: [
                                                        Expanded(
                                                          child: Align(
                                                            alignment: const AlignmentDirectional(1, 0),
                                                            child: SizedBox(
                                                              width: 100,
                                                              child: TextFormField(
                                                                controller: ManageUsersCubit.get(context).salaryController,
                                                                autofocus: true,
                                                                obscureText: false,
                                                                decoration: InputDecoration(
                                                                  labelStyle: FlutterFlowTheme.of(context)
                                                                      .labelMedium
                                                                      .override(
                                                                    fontFamily: 'Readex Pro',
                                                                    fontSize: 10,
                                                                  ),
                                                                  hintText: 'اكتب رقم',
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
                                                                    borderRadius: BorderRadius.circular(8),
                                                                  ),
                                                                  focusedBorder: OutlineInputBorder(
                                                                    borderSide: const BorderSide(
                                                                      color: Colors.blue,
                                                                      width: 2,
                                                                    ),
                                                                    borderRadius: BorderRadius.circular(8),
                                                                  ),
                                                                  errorBorder: OutlineInputBorder(
                                                                    borderSide: BorderSide(
                                                                      color: FlutterFlowTheme.of(context).error,
                                                                      width: 2,
                                                                    ),
                                                                    borderRadius: BorderRadius.circular(8),
                                                                  ),
                                                                  focusedErrorBorder: OutlineInputBorder(
                                                                    borderSide: BorderSide(
                                                                      color: FlutterFlowTheme.of(context).error,
                                                                      width: 2,
                                                                    ),
                                                                    borderRadius: BorderRadius.circular(8),
                                                                  ),
                                                                ),
                                                                style: FlutterFlowTheme.of(context)
                                                                    .bodyMedium
                                                                    .override(
                                                                  fontFamily: 'Readex Pro',
                                                                  fontSize: 10,
                                                                ),
                                                                textAlign: TextAlign.end,
                                                                keyboardType: TextInputType.number,
                                                                cursorColor: const Color(0xFF333333),
                                                                //   validator: _model.textControllerValidator
                                                                //     .asValidator(context),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        Text(
                                                          'المكافأة',
                                                          style:
                                                          FlutterFlowTheme.of(context).bodyMedium.override(
                                                            fontFamily: 'Readex Pro',
                                                            fontSize: 12,
                                                          ),
                                                        ),
                                                      ]
                                                          .divide(const SizedBox(width: 10))
                                                          .addToEnd(const SizedBox(width: 15)),
                                                    ),
                                                  ),
                                                  Row(
                                                    mainAxisSize: MainAxisSize.max,
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [


                                                      InkWell(
                                                        onTap: () async {
                                                          //     print(ManageUsersCubit.get(context).users[index].uId);
                                                          await ManageUsersCubit.get(context).payBonus(
                                                            userId: uid,TotalSalary: user.totalSalary??0,
                                                            salaryPaid: ManageUsersCubit.get(context).salaryController.text,
                                                          ).then((value) => Navigator.pop(context));
                                                        },
                                                        child:
                                                        //PayBonusLoadingState
                                                        BlocBuilder<ManageUsersCubit, ManageUsersState>(
  builder: (context, state) {
    return state is PayBonusLoadingState? const CircularProgressIndicator():
                                                  Container(
                                                          width: 130,
                                                          height: 40,
                                                          decoration: BoxDecoration(
                                                            color: Colors.blue,
                                                            borderRadius: BorderRadius.circular(8),
                                                          ),
                                                          child: Align(
                                                            alignment: const AlignmentDirectional(0, 0),
                                                            child: Text(
                                                              //pay bonus
                                                              isCoachInfoList??false?
                                                              ' صرف مكافأة':
                                                              //add session
                                                              'اضافة ',
                                                              style: FlutterFlowTheme.of(context)
                                                                  .titleSmall
                                                                  .override(
                                                                fontFamily: 'Readex Pro',
                                                                color: Colors.white,
                                                                fontSize: 12,
                                                              ),
                                                            ),
                                                          ),
                                                        );
  },
),
                                                      )
                                                    ].divide(const SizedBox(width: 10)),
                                                  ),

                                                ].divide(const SizedBox(height: 35)).addToStart(const SizedBox(height: 50)),
                                              ),
                                              const SizedBox(
                                                height: 20,
                                              )
                                            ].divide(const SizedBox(height: 0)),
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                },
                                child: Align(
                                  alignment: const AlignmentDirectional(0, 0),
                                  child: Text(
                                    'مكافأة',
                                    textAlign: TextAlign.end,
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                      fontFamily: 'Readex Pro',
                                      color: Colors.blue,
                                      fontSize: 10,
                                      decoration:
                                      TextDecoration.underline,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),

                        Container(
                          width:
                          MediaQuery.sizeOf(context).width * 0.2,
                          height: 35,
                          decoration: BoxDecoration(
                            color: FlutterFlowTheme.of(context)
                                .secondaryBackground,
                            border: Border.all(
                              color: const Color(0xFFB4B4B4),
                              width: 1,
                            ),
                          ),
                          child: Align(
                            alignment: const AlignmentDirectional(0, 0),
                            child: Text(
                              //user.hourlyRate*user.totalHours??0,
                              //'${user.hourlyRate??0*user.totalHours!.toInt()??0}',
                              //multiply hourly rate by total hours
                              '${user.totalSalary??0}',
                              textAlign: TextAlign.end,
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                fontFamily: 'Readex Pro',
                                color: Colors.black,
                                fontSize: 10,
                              ),
                            ),
                          ),
                        ),
                        Align(
                          alignment: const AlignmentDirectional(1, 0),
                          child: Container(
                            width: MediaQuery.sizeOf(context).width *
                                0.2,
                            height: 35,
                            decoration: BoxDecoration(
                              color: FlutterFlowTheme.of(context)
                                  .secondaryBackground,
                              border: Border.all(
                                color: const Color(0xFFB4B4B4),
                                width: 1,
                              ),
                            ),
                            child: Align(
                              alignment: const AlignmentDirectional(0, 0),
                              child: Text(
                                ' ${
                                // ManageUsersCubit.get(context).coaches[index].fname??''} ${(ManageUsersCubit.get(context).coaches[index].lname??'')}',
                                    user.name??''} '
                                //    '${(user.lname??'')}'
                                ,
                                textAlign: TextAlign.end,
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                  fontFamily: 'Readex Pro',
                                  fontSize: 10,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ):
                    ListTile(
                      title: Text(user.name ?? ''),
                      subtitle: Text(user.phone ?? ''),



                      trailing: Checkbox(
                        value: isCoach
                            ? state.selectedCoaches.map((user) => user.uId).contains(user.uId)
                            : state.selectedUsers.map((user) => user.uId).contains(user.uId),
                        onChanged: (value) {
                          logger.d('value is $value');
                          if (value!) {
                            if (isCoach) {
                              addGroupCubit.selectCoach(user);
                            } else {
                              addGroupCubit.selectUser(user);
                            }
                          } else if (!value) {
                            if (isCoach) {
                              logger.d('user id is ${user.uId}');
                              context
                                  .read<AddGroupCubit>()
                                  .deselectCoach(user);
                            } else {
                              context
                                  .read<AddGroupCubit>()
                                  .deselectUser(user);
                            }
                          }
                        },
                      ),
                    );
                  },
                ),
              ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.end,
              //   children: [
              //     TextButton(
              //       onPressed: () => Navigator.of(context).pop(),
              //       child: Text('Cancel'),
              //     ),
              //     TextButton(
              //       onPressed: () {
              //         //    onSelectedUsersChanged(addGroupCubit.selectedUsers);
              //
              //         Navigator.of(context).pop();
              //       },
              //       child: Text('Save'),
              //     ),
              //   ],
              // ),
              isCoachInfoList ??false ?
              Container():
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text('Cancel'),
                  ),
                  TextButton(
                    onPressed: () {
                      //    onSelectedUsersChanged(addGroupCubit.selectedUsers);

                      Navigator.of(context).pop();
                    },
                    child: const Text('Save'),
                  ),
                ],
              ),
            ],
          )
              : isUserInfoList ?? false ?
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              //isCoachInfoList ?? false ?
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                      margin: EdgeInsets.only(right: 10.w
                          ,bottom: 15.h),
                      decoration: ShapeDecoration(
                        color: const Color(0xFFFAFAFA),
                        shape: RoundedRectangleBorder(
                          side: const BorderSide(width: 1, color: Color(0xFFB9B9B9)),
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                      height: 40.h,
                      width: 290.w,
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child:TextField(
                        onTap: //_showClearButton = false; /
                            () {
                          //  addGroupCubit.isSearch = true;
                          //make it using update funvtion
                          addGroupCubit.updateIsSearch(true);
                        },
                        //arabic
                        textAlign: TextAlign.right,
                        controller: addGroupCubit.searchController,
                        textInputAction: TextInputAction.search,
                        onSubmitted: (_) => addGroupCubit.onSearchSubmitted(addGroupCubit.searchController.text.trim(),isCoach),
                        decoration: InputDecoration(
                          border: InputBorder.none,

                          contentPadding: const EdgeInsets.only(right: 20),
                          //manage users
                          hintText: 'رقم الهاتف او الاسم ',
                          //trensform to arabic
                          suffixIcon: IconButton(
                            icon: const Icon(Icons.search),
                            onPressed: () => addGroupCubit.onSearchSubmitted(addGroupCubit.searchController.text.trim(),isCoach),
                          ),
                          prefixIcon:
                          isSearch? IconButton(
                              icon: const Icon(Icons.close),
                              onPressed: () {
                                addGroupCubit.searchController.clear();
                                //query ==null
                                //  addGroupCubit.usersQuery =null;
                                //make it using update funvtion
                                addGroupCubit.updateUsersQuery(
                                  //if is coach then show only coaches
                                  isCoach ? FirebaseFirestore.instance.collection('users').where(
                                      'role', isEqualTo: 'coach')
                                      .where('pid',isEqualTo: FirebaseAuth.instance.currentUser!.uid)
                                      :FirebaseFirestore.instance.collection('users').where(
                                      'role', isEqualTo: 'user')
                                      .where('pid',isEqualTo: FirebaseAuth.instance.currentUser!.uid),
                                );

                                //update isSearch
                                addGroupCubit.updateIsSearch(false);
                                FocusScope.of(context).unfocus();

                              }
                          ):null,
                        ),
                      )
                  ),
                ],
              ),
              //:
              // Padding(
              //   padding: const EdgeInsets.all(8.0),
              //   child:TextField(
              //     controller: addGroupCubit.searchController,
              //     textInputAction: TextInputAction.search,
              //     onSubmitted: (_) => addGroupCubit.onSearchSubmitted(addGroupCubit.searchController.text.trim(),isCoach),
              //     decoration: InputDecoration(
              //       hintText: 'Search by name or phone number',
              //       suffixIcon: IconButton(
              //         icon: Icon(Icons.search),
              //         onPressed: () => addGroupCubit.onSearchSubmitted(addGroupCubit.searchController.text.trim(),isCoach),
              //       ),
              //     ),
              //   ),
              // ),
              isUserInfoList ??false?
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    width:
                    MediaQuery.sizeOf(context).width * 0.2,
                    height: 35,
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context)
                          .secondaryBackground,
                      border: Border.all(
                        color: const Color(0xFFB4B4B4),
                        width: 1,
                      ),
                    ),
                    child: Align(
                      alignment: const AlignmentDirectional(0, 0),
                      child: Text(
                        //reduce sessions
                        'المزيد',
                        textAlign: TextAlign.end,
                        style: FlutterFlowTheme.of(context)
                            .bodyMedium
                            .override(
                          fontFamily: 'Readex Pro',
                          color: Colors.black,
                          fontSize: 10,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width:
                    MediaQuery.sizeOf(context).width * 0.2,
                    height: 35,
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context)
                          .secondaryBackground,
                      border: Border.all(
                        color: const Color(0xFFB4B4B4),
                        width: 1,
                      ),
                    ),
                    child: Align(
                      alignment: const AlignmentDirectional(0, 0),
                      child: Text(
                        //reduce sessions
                        'خصم حصص',
                        textAlign: TextAlign.end,
                        style: FlutterFlowTheme.of(context)
                            .bodyMedium
                            .override(
                          fontFamily: 'Readex Pro',
                          color: Colors.black,
                          fontSize: 10,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width:
                    MediaQuery.sizeOf(context).width * 0.2,
                    height: 35,
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context)
                          .secondaryBackground,
                      border: Border.all(
                        color: const Color(0xFFB4B4B4),
                        width: 1,
                      ),
                    ),
                    child: Align(
                      alignment: const AlignmentDirectional(0, 0),
                      child: Text(

                        //'add sessions',
                        'اضافة حصص',

                        textAlign: TextAlign.end,
                        style: FlutterFlowTheme.of(context)
                            .bodyMedium
                            .override(
                          fontFamily: 'Readex Pro',
                          color: Colors.black,
                          fontSize: 10,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width:
                    MediaQuery.sizeOf(context).width * 0.2,
                    height: 35,
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context)
                          .secondaryBackground,
                      border: Border.all(
                        color: const Color(0xFFB4B4B4),
                        width: 1,
                      ),
                    ),
                    child: Align(
                      alignment: const AlignmentDirectional(0, 0),
                      child: Text(
                        //number of sessions
                        'عدد الحصص',
                        textAlign: TextAlign.end,
                        style: FlutterFlowTheme.of(context)
                            .bodyMedium
                            .override(
                          fontFamily: 'Readex Pro',
                          color: Colors.black,
                          fontSize: 10,
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: const AlignmentDirectional(1, 0),
                    child: Container(
                      width: MediaQuery.sizeOf(context).width *
                          0.2,
                      height: 35,
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context)
                            .secondaryBackground,
                        border: Border.all(
                          color: const Color(0xFFB4B4B4),
                          width: 1,
                        ),
                      ),
                      child: Align(
                        alignment: const AlignmentDirectional(0, 0),
                        child: Text(
                          'الاسم',
                          textAlign: TextAlign.end,
                          style: FlutterFlowTheme.of(context)
                              .bodyMedium
                              .override(
                            fontFamily: 'Readex Pro',
                            fontSize: 10,
                          ),
                        ),
                      ),
                    ),
                  ),

                ],
              ) :Container(),
              Expanded(
                child: FirestoreListView(
                  shrinkWrap: true,
                  cacheExtent: 5000,
                  pageSize: 8,
                  query: query ??FirebaseFirestore.instance.collection('users').where(
                      'role', isEqualTo: isCoachInfoList??false ? 'coach' : 'user')
                      .where('pid',isEqualTo: FirebaseAuth.instance.currentUser!.uid),
                  itemBuilder: (context, document) {
                    final data = document.data() as Map<String, dynamic>;
                    final user = UserModel.fromJson(data);
                    return isCoachInfoList ??
                        false ?   Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          width: MediaQuery.sizeOf(context).width * 0.2,
                          height: 35,
                          decoration: BoxDecoration(
                            color: FlutterFlowTheme.of(context)
                                .secondaryBackground,
                            border: Border.all(
                              color: const Color(0xFFB4B4B4),
                              width: 1,
                            ),
                          ),
                          child: InkWell(
                            onTap: () async {
                              final manageSalaryCubit = ManageUsersCubit.get(context);
                              //manageSalaryCubit.initControllers(ManageUsersCubit.get(context).coaches[index]);
                              manageSalaryCubit.initControllers(user);
                              await Navigator.pushNamed(context,
                                  AppRoutes.editProfile,
                                  arguments: user
                                  as UserModel
                              ) ;


                            },
                            child: Align(
                              alignment: const AlignmentDirectional(0, 0),
                              child: InkWell(
                                child: Text(
                                  '...المزيد ',
                                  textAlign: TextAlign.end,
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                    fontFamily: 'Readex Pro',
                                    color: Colors.blue,
                                    fontSize: 10.sp,
                                    decoration:
                                    TextDecoration.underline,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        BlocBuilder<ManageUsersCubit, ManageUsersState>(
                          builder: (context, state) {
                            return Container(
                              width: MediaQuery.sizeOf(context).width * 0.2,
                              height: 35,
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context)
                                    .secondaryBackground,
                                border: Border.all(
                                  color: const Color(0xFFB4B4B4),
                                  width: 1,
                                ),
                              ),
                              child: InkWell(
                                onTap: () async {
                                  //      String? uid =ManageUsersCubit.get(context).coaches[index].uId;
                                  String? uid =user.uId;
                                  int? userSalary = user.totalSalary;
                                  //show dialog
                                  await showDialog(
                                    useSafeArea: true,
                                    context: context,
                                    builder: (BuildContext context) {
                                      return Dialog(
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                        child: Container(
                                          //height: 500,
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Column(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  Row(
                                                    mainAxisSize: MainAxisSize.max,
                                                    mainAxisAlignment: MainAxisAlignment.end,
                                                    children: [
                                                      InkWell(
                                                        onTap: () {
                                                          Navigator.pop(context);
                                                        },
                                                        child: ClipRRect(
                                                          borderRadius: BorderRadius.circular(8),
                                                          child: SvgPicture.asset(
                                                            'assets/images/frame23420.svg',
                                                            width: 50,
                                                            height: 50,
                                                            fit: BoxFit.none,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Text(
                                                    'دفع المرتب',
                                                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                      fontFamily: 'Readex Pro',
                                                      fontSize: 24,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Column(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  Align(
                                                    alignment: const AlignmentDirectional(0, 0),
                                                    child: Row(
                                                      mainAxisSize: MainAxisSize.max,
                                                      mainAxisAlignment: MainAxisAlignment.end,
                                                      children: [
                                                        Expanded(
                                                          child: Align(
                                                            alignment: const AlignmentDirectional(1, 0),
                                                            child: Container(
                                                              width: 100,
                                                              child: TextFormField(
                                                                controller: ManageUsersCubit.get(context).salaryController,
                                                                autofocus: true,
                                                                obscureText: false,
                                                                decoration: InputDecoration(
                                                                  labelStyle: FlutterFlowTheme.of(context)
                                                                      .labelMedium
                                                                      .override(
                                                                    fontFamily: 'Readex Pro',
                                                                    fontSize: 10,
                                                                  ),
                                                                  hintText: 'اكتب رقم',
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
                                                                    borderRadius: BorderRadius.circular(8),
                                                                  ),
                                                                  focusedBorder: OutlineInputBorder(
                                                                    borderSide: const BorderSide(
                                                                      color: Colors.blue,
                                                                      width: 2,
                                                                    ),
                                                                    borderRadius: BorderRadius.circular(8),
                                                                  ),
                                                                  errorBorder: OutlineInputBorder(
                                                                    borderSide: BorderSide(
                                                                      color: FlutterFlowTheme.of(context).error,
                                                                      width: 2,
                                                                    ),
                                                                    borderRadius: BorderRadius.circular(8),
                                                                  ),
                                                                  focusedErrorBorder: OutlineInputBorder(
                                                                    borderSide: BorderSide(
                                                                      color: FlutterFlowTheme.of(context).error,
                                                                      width: 2,
                                                                    ),
                                                                    borderRadius: BorderRadius.circular(8),
                                                                  ),
                                                                ),
                                                                style: FlutterFlowTheme.of(context)
                                                                    .bodyMedium
                                                                    .override(
                                                                  fontFamily: 'Readex Pro',
                                                                  fontSize: 10,
                                                                ),
                                                                textAlign: TextAlign.end,
                                                                keyboardType: TextInputType.number,
                                                                cursorColor: const Color(0xFF333333),
                                                                //   validator: _model.textControllerValidator
                                                                //     .asValidator(context),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        Text(
                                                          ':الدفع الجزئي',
                                                          style:
                                                          FlutterFlowTheme.of(context).bodyMedium.override(
                                                            fontFamily: 'Readex Pro',
                                                            fontSize: 12,
                                                          ),
                                                        ),
                                                      ]
                                                          .divide(const SizedBox(width: 10))
                                                          .addToEnd(const SizedBox(width: 15)),
                                                    ),
                                                  ),
                                                  Row(
                                                    mainAxisSize: MainAxisSize.max,
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [

                                                      InkWell(
                                                        onTap: () async {
                                                          //     print(ManageUsersCubit.get(context).users[index].uId);
                                                          await ManageUsersCubit.get(context).payPartialSalary(
                                                            userName: user.name??'',
                                                            currentTotalSalary: userSalary??0,
                                                            userId:
                                                            uid,salaryPaid: ManageUsersCubit.get(context).salaryController.text,
                                                          ).then((value) => Navigator.pop(context));
                                                        },
                                                        child: Container(
                                                          width: 130,
                                                          height: 40,
                                                          decoration: BoxDecoration(
                                                            color: const Color(0xFFB9B9B9),
                                                            borderRadius: BorderRadius.circular(8),
                                                          ),
                                                          child: Align(
                                                            alignment: const AlignmentDirectional(0, 0),
                                                            child: Text(
                                                              'دفع جزئي',
                                                              style: FlutterFlowTheme.of(context)
                                                                  .titleSmall
                                                                  .override(
                                                                fontFamily: 'Readex Pro',
                                                                color: Colors.white,
                                                                fontSize: 12,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),

                                                      InkWell(
                                                        onTap: () async {
                                                          //     print(ManageUsersCubit.get(context).users[index].uId);
                                                          await ManageUsersCubit.get(context).paySalary(
                                                             userTotalSalary:user.totalSalary,


                                                            userName:
                                                          user.name,
                                                            userId:
                                                            uid,
                                                          ).then((value) => Navigator.pop(context));
                                                        },
                                                        child: Container(
                                                          width: 130,
                                                          height: 40,
                                                          decoration: BoxDecoration(
                                                            color: Colors.blue,
                                                            borderRadius: BorderRadius.circular(8),
                                                          ),
                                                          child: Align(
                                                            alignment: const AlignmentDirectional(0, 0),
                                                            child: Text(
                                                              'دفع كل المرتب',
                                                              style: FlutterFlowTheme.of(context)
                                                                  .titleSmall
                                                                  .override(
                                                                fontFamily: 'Readex Pro',
                                                                color: Colors.white,
                                                                fontSize: 12,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      )
                                                    ].divide(const SizedBox(width: 10)),
                                                  ),

                                                ].divide(const SizedBox(height: 35)).addToStart(const SizedBox(height: 50)),
                                              ),
                                              const SizedBox(
                                                height: 20,
                                              )
                                            ].divide(const SizedBox(height: 0)),
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                },
                                child: Align(
                                  alignment: const AlignmentDirectional(0, 0),
                                  child: Text(
                                    'دفع الراتب',
                                    textAlign: TextAlign.end,
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                      fontFamily: 'Readex Pro',
                                      color: Colors.blue,
                                      fontSize: 10,
                                      decoration:
                                      TextDecoration.underline,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                        BlocConsumer<ManageUsersCubit, ManageUsersState>(
                          listener: (context, state) {

                          },
                          builder: (context, state) {
                            return Container(
                              width: MediaQuery.sizeOf(context).width * 0.2,
                              height: 35,
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context)
                                    .secondaryBackground,
                                border: Border.all(
                                  color: const Color(0xFFB4B4B4),
                                  width: 1,
                                ),
                              ),
                              child: InkWell(
                                onTap: () async {
                                  //String? uid =ManageUsersCubit.get(context).coaches[index].uId;
                                  String? uid =user.uId;
                                  //show dialog
                                  await showDialog(
                                    useSafeArea: true,
                                    context: context,
                                    builder: (BuildContext context) {
                                      return Dialog(
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Column(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Row(
                                                  mainAxisSize: MainAxisSize.max,
                                                  mainAxisAlignment: MainAxisAlignment.end,
                                                  children: [
                                                    ClipRRect(
                                                      borderRadius: BorderRadius.circular(8),
                                                      child: SvgPicture.asset(
                                                        'assets/images/frame23420.svg',
                                                        width: 50,
                                                        height: 50,
                                                        fit: BoxFit.none,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Text(
                                                  //'bonus'
                                                  'المكافأة',
                                                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                    fontFamily: 'Readex Pro',
                                                    fontSize: 24,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Column(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Align(
                                                  alignment: const AlignmentDirectional(0, 0),
                                                  child: Row(
                                                    mainAxisSize: MainAxisSize.max,
                                                    mainAxisAlignment: MainAxisAlignment.end,
                                                    children: [
                                                      Expanded(
                                                        child: Align(
                                                          alignment: const AlignmentDirectional(1, 0),
                                                          child: Container(
                                                            width: 100,
                                                            child: TextFormField(
                                                              controller: ManageUsersCubit.get(context).salaryController,
                                                              autofocus: true,
                                                              obscureText: false,
                                                              decoration: InputDecoration(
                                                                labelStyle: FlutterFlowTheme.of(context)
                                                                    .labelMedium
                                                                    .override(
                                                                  fontFamily: 'Readex Pro',
                                                                  fontSize: 10,
                                                                ),
                                                                hintText: 'اكتب رقم',
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
                                                                  borderRadius: BorderRadius.circular(8),
                                                                ),
                                                                focusedBorder: OutlineInputBorder(
                                                                  borderSide: const BorderSide(
                                                                    color: Colors.blue,
                                                                    width: 2,
                                                                  ),
                                                                  borderRadius: BorderRadius.circular(8),
                                                                ),
                                                                errorBorder: OutlineInputBorder(
                                                                  borderSide: BorderSide(
                                                                    color: FlutterFlowTheme.of(context).error,
                                                                    width: 2,
                                                                  ),
                                                                  borderRadius: BorderRadius.circular(8),
                                                                ),
                                                                focusedErrorBorder: OutlineInputBorder(
                                                                  borderSide: BorderSide(
                                                                    color: FlutterFlowTheme.of(context).error,
                                                                    width: 2,
                                                                  ),
                                                                  borderRadius: BorderRadius.circular(8),
                                                                ),
                                                              ),
                                                              style: FlutterFlowTheme.of(context)
                                                                  .bodyMedium
                                                                  .override(
                                                                fontFamily: 'Readex Pro',
                                                                fontSize: 10,
                                                              ),
                                                              textAlign: TextAlign.end,
                                                              keyboardType: TextInputType.number,
                                                              cursorColor: const Color(0xFF333333),
                                                              //   validator: _model.textControllerValidator
                                                              //     .asValidator(context),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      Text(
                                                        'المكافأة',
                                                        style:
                                                        FlutterFlowTheme.of(context).bodyMedium.override(
                                                          fontFamily: 'Readex Pro',
                                                          fontSize: 12,
                                                        ),
                                                      ),
                                                    ]
                                                        .divide(const SizedBox(width: 10))
                                                        .addToEnd(const SizedBox(width: 15)),
                                                  ),
                                                ),
                                                Row(
                                                  mainAxisSize: MainAxisSize.max,
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [


                                                    InkWell(
                                                      onTap: () async {
                                                        //     print(ManageUsersCubit.get(context).users[index].uId);
                                                        await ManageUsersCubit.get(context).payBonus(
                                                          userId: uid,TotalSalary: user.totalSalary??0,
                                                          salaryPaid: ManageUsersCubit.get(context).salaryController.text,
                                                        ).then((value) => Navigator.pop(context));
                                                      },
                                                      child: Container(
                                                        width: 130,
                                                        height: 40,
                                                        decoration: BoxDecoration(
                                                          color: Colors.blue,
                                                          borderRadius: BorderRadius.circular(8),
                                                        ),
                                                        child: Align(
                                                          alignment: const AlignmentDirectional(0, 0),
                                                          child: Text(
                                                            isCoachInfoList??false?
                                                            ' صرف مكافأة'
                                                                :'اضافة ',
                                                            style: FlutterFlowTheme.of(context)
                                                                .titleSmall
                                                                .override(
                                                              fontFamily: 'Readex Pro',
                                                              color: Colors.white,
                                                              fontSize: 12,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    )
                                                  ].divide(const SizedBox(width: 10)),
                                                ),

                                              ].divide(const SizedBox(height: 35)).addToStart(const SizedBox(height: 50)),
                                            ),
                                            const SizedBox(
                                              height: 20,
                                            )
                                          ].divide(const SizedBox(height: 0)),
                                        ),
                                      );
                                    },
                                  );
                                },
                                child: Align(
                                  alignment: const AlignmentDirectional(0, 0),
                                  child: Text(
                                    'مكافأة',
                                    textAlign: TextAlign.end,
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                      fontFamily: 'Readex Pro',
                                      color: Colors.blue,
                                      fontSize: 10,
                                      decoration:
                                      TextDecoration.underline,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),

                        Container(
                          width:
                          MediaQuery.sizeOf(context).width * 0.2,
                          height: 35,
                          decoration: BoxDecoration(
                            color: FlutterFlowTheme.of(context)
                                .secondaryBackground,
                            border: Border.all(
                              color: const Color(0xFFB4B4B4),
                              width: 1,
                            ),
                          ),
                          child: Align(
                            alignment: const AlignmentDirectional(0, 0),
                            child: Text(
                              //  ManageUsersCubit.get(context).coaches[index].totalSalary.toString(),
                              user.totalSalary.toString(),



                              textAlign: TextAlign.end,
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                fontFamily: 'Readex Pro',
                                color: Colors.black,
                                fontSize: 10,
                              ),
                            ),
                          ),
                        ),
                        Align(
                          alignment: const AlignmentDirectional(1, 0),
                          child: Container(
                            width: MediaQuery.sizeOf(context).width *
                                0.2,
                            height: 35,
                            decoration: BoxDecoration(
                              color: FlutterFlowTheme.of(context)
                                  .secondaryBackground,
                              border: Border.all(
                                color: const Color(0xFFB4B4B4),
                                width: 1,
                              ),
                            ),
                            child: Align(
                              alignment: const AlignmentDirectional(0, 0),
                              child: Text(
                                ' ${
                                // ManageUsersCubit.get(context).coaches[index].fname??''} ${(ManageUsersCubit.get(context).coaches[index].lname??'')}',
                                    user.name??''} '
                                //  '${(user.lname??'')}'
                                ,
                                textAlign: TextAlign.end,
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                  fontFamily: 'Readex Pro',
                                  fontSize: 10,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ): //dh
                    isUserInfoList ?? false ?
                    //error
                    //!Todo: error!
                    //7ot hena il row dh
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          width: MediaQuery.sizeOf(context).width * 0.2,
                          height: 35,
                          decoration: BoxDecoration(
                            color: FlutterFlowTheme.of(context)
                                .secondaryBackground,
                            border: Border.all(
                              color: const Color(0xFFB4B4B4),
                              width: 1,
                            ),
                          ),
                          child: InkWell(
                            onTap: () async {
                              final manageSalaryCubit = ManageUsersCubit.get(context);
                              //manageSalaryCubit.initControllers(ManageUsersCubit.get(context).coaches[index]);
                              manageSalaryCubit.initControllers(user);
                              await Navigator.pushNamed(context,
                                  AppRoutes.editProfile,
                                  arguments: user
                                  as UserModel
                              ) ;


                            },
                            child: Align(
                              alignment: const AlignmentDirectional(0, 0),
                              child: InkWell(
                                child: Text(
                                  '...المزيد ',
                                  textAlign: TextAlign.end,
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                    fontFamily: 'Readex Pro',
                                    color: Colors.blue,
                                    fontSize: 10.sp,
                                    decoration:
                                    TextDecoration.underline,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        BlocBuilder<ManageUsersCubit, ManageUsersState>(
                          builder: (context, state) {
                            return Container(
                              width: MediaQuery.sizeOf(context).width * 0.2,
                              height: 35,
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context)
                                    .secondaryBackground,
                                border: Border.all(
                                  color: const Color(0xFFB4B4B4),
                                  width: 1,
                                ),
                              ),
                              child: InkWell(
                                onTap: () async {
                                  //      String? uid =ManageUsersCubit.get(context).coaches[index].uId;
                                  String? uid =user.uId;
                                  int? userSessions = user.numberOfSessions;
                                  int? userSalary = user.totalSalary;
                                  //show dialog
                                  await showDialog(
                                    useSafeArea: true,
                                    context: context,
                                    builder: (BuildContext context) {
                                      return Dialog(
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                        child: Container(
                                          //height: 500,
                                          decoration: const BoxDecoration(
                                              color:Colors.white,
                                              borderRadius: BorderRadius.all(Radius.circular(8))
                                          ),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Column(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  Row(
                                                    mainAxisSize: MainAxisSize.max,
                                                    mainAxisAlignment: MainAxisAlignment.end,
                                                    children: [
                                                      InkWell
                                                        (
                                                        child: ClipRRect(
                                                          borderRadius: BorderRadius.circular(8),
                                                          child: SvgPicture.asset(
                                                            'assets/images/frame23420.svg',
                                                            width: 50,
                                                            height: 50,
                                                            fit: BoxFit.none,
                                                          ),
                                                        ),
                                                        onTap: () {
                                                          Navigator.pop(context);
                                                        },
                                                      ),
                                                    ],
                                                  ),
                                                  Text(
                                                    isCoachInfoList ??false ?
                                                    'دفع المرتب':
                                                    //  'reduce sessions',
                                                    'خصم حصص',


                                                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                      fontFamily: 'Readex Pro',
                                                      fontSize: 24,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Column(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  Align(
                                                    alignment: const AlignmentDirectional(0, 0),
                                                    child: Row(
                                                      mainAxisSize: MainAxisSize.max,
                                                      mainAxisAlignment: MainAxisAlignment.end,
                                                      children: [
                                                        Expanded(
                                                          child: Align(
                                                            alignment: const AlignmentDirectional(1, 0),
                                                            child: Container(
                                                              width: 100,
                                                              child: TextFormField(
                                                                controller: ManageUsersCubit.get(context).salaryController,
                                                                autofocus: true,
                                                                obscureText: false,
                                                                decoration: InputDecoration(
                                                                  labelStyle: FlutterFlowTheme.of(context)
                                                                      .labelMedium
                                                                      .override(
                                                                    fontFamily: 'Readex Pro',
                                                                    fontSize: 10,
                                                                  ),
                                                                  hintText: 'اكتب رقم',
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
                                                                    borderRadius: BorderRadius.circular(8),
                                                                  ),
                                                                  focusedBorder: OutlineInputBorder(
                                                                    borderSide: const BorderSide(
                                                                      color: Colors.blue,
                                                                      width: 2,
                                                                    ),
                                                                    borderRadius: BorderRadius.circular(8),
                                                                  ),
                                                                  errorBorder: OutlineInputBorder(
                                                                    borderSide: BorderSide(
                                                                      color: FlutterFlowTheme.of(context).error,
                                                                      width: 2,
                                                                    ),
                                                                    borderRadius: BorderRadius.circular(8),
                                                                  ),
                                                                  focusedErrorBorder: OutlineInputBorder(
                                                                    borderSide: BorderSide(
                                                                      color: FlutterFlowTheme.of(context).error,
                                                                      width: 2,
                                                                    ),
                                                                    borderRadius: BorderRadius.circular(8),
                                                                  ),
                                                                ),
                                                                style: FlutterFlowTheme.of(context)
                                                                    .bodyMedium
                                                                    .override(
                                                                  fontFamily: 'Readex Pro',
                                                                  fontSize: 10,
                                                                ),
                                                                textAlign: TextAlign.end,
                                                                keyboardType: TextInputType.number,
                                                                cursorColor: const Color(0xFF333333),
                                                                //   validator: _model.textControllerValidator
                                                                //     .asValidator(context),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        Text(
                                                          isCoachInfoList??false ?
                                                          ':الدفع الجزئي' :
                                                          ':عدد الحصص',
                                                          style:
                                                          FlutterFlowTheme.of(context).bodyMedium.override(
                                                            fontFamily: 'Readex Pro',
                                                            fontSize: 12,
                                                          ),
                                                        ),
                                                      ]
                                                          .divide(const SizedBox(width: 10))
                                                          .addToEnd(const SizedBox(width: 15)),
                                                    ),
                                                  ),
                                                  Row(
                                                    mainAxisSize: MainAxisSize.max,
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [

                                                      InkWell(
                                                        onTap: () async {
                                                          //     print(ManageUsersCubit.get(context).users[index].uId);
                                                          if(isCoachInfoList??false){
                                                            await ManageUsersCubit.get(context).payPartialSalary(
                                                              userName: user.name??'',
                                                              userId:
                                                              uid,salaryPaid: ManageUsersCubit.get(context).salaryController.text, currentTotalSalary: userSalary??0,                                                          ).then((value) => Navigator.pop(context));
                                                          }else{
                                                            await ManageUsersCubit.get(context).reduceSessions(
                                                              userName: user.name??'',
                                                              context,
                                                              userId:
                                                              uid,sessions: ManageUsersCubit.get(context).salaryController.text, NumberOfSessions: userSessions??0,
                                                            ).then((value) => Navigator.pop(context));
                                                          }

                                                        },
                                                        child: BlocBuilder<ManageUsersCubit, ManageUsersState>(
  builder: (context, state) {
    return
      state is ReduceSessionsLoadingState ? const CircularProgressIndicator() :
      Container(
                                                          width: 130,
                                                          height: 40,
                                                          decoration: BoxDecoration(
                                                            color: Colors.red,
                                                            borderRadius: BorderRadius.circular(8),
                                                          ),
                                                          child: Align(
                                                            alignment: const AlignmentDirectional(0, 0),
                                                            child: Text(
                                                              isCoachInfoList??false ?
                                                              'دفع جزئي'
                                                                  :
                                                              'خصم حصص',
                                                              style: FlutterFlowTheme.of(context)
                                                                  .titleSmall
                                                                  .override(
                                                                fontFamily: 'Readex Pro',
                                                                color: Colors.white,
                                                                fontSize: 12,
                                                              ),
                                                            ),
                                                          ),
                                                        );
  },
),
                                                      ),
                                                      isCoachInfoList??false ?
                                                      InkWell(
                                                        onTap: () async {
                                                          //     print(ManageUsersCubit.get(context).users[index].uId);
                                                          await ManageUsersCubit.get(context).paySalary(
                                                                                                                         userTotalSalary:user.totalSalary,
                                                            userName:
                                                          user.name,
                                                            userId:
                                                            uid,
                                                          ).then((value) => Navigator.pop(context));
                                                        },
                                                        child: Container(
                                                          width: 130,
                                                          height: 40,
                                                          decoration: BoxDecoration(
                                                            color: Colors.blue,
                                                            borderRadius: BorderRadius.circular(8),
                                                          ),
                                                          child: Align(
                                                            alignment: const AlignmentDirectional(0, 0),
                                                            child: Text(
                                                              'دفع كل المرتب',
                                                              style: FlutterFlowTheme.of(context)
                                                                  .titleSmall
                                                                  .override(
                                                                fontFamily: 'Readex Pro',
                                                                color: Colors.white,
                                                                fontSize: 12,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ):Container(),
                                                    ].divide(const SizedBox(width: 10)),
                                                  ),

                                                ].divide(const SizedBox(height: 35)).addToStart(const SizedBox(height: 50)),
                                              ),
                                              const SizedBox(
                                                height: 20,
                                              )
                                            ].divide(const SizedBox(height: 0)),
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                },
                                child: Align(
                                  alignment: const AlignmentDirectional(0, 0),
                                  child: Text(
                                    isCoachInfoList??false ?
                                    'دفع الراتب':
                                    //add sessions
                                    'خصم حصص',
                                    textAlign: TextAlign.end,
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                      fontFamily: 'Readex Pro',
                                      color: Colors.blue,
                                      fontSize: 10,
                                      decoration:
                                      TextDecoration.underline,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                        BlocConsumer<ManageUsersCubit, ManageUsersState>(
                          listener: (context, state) {

                          },
                          builder: (context, state) {
                            return Container(
                              width: MediaQuery.sizeOf(context).width * 0.2,
                              height: 35,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                  color: const Color(0xFFB4B4B4),
                                  width: 1,
                                ),
                              ),
                              child: InkWell(
                                onTap: () async {
                                  //String? uid =ManageUsersCubit.get(context).coaches[index].uId;
                                  String? uid =user.uId;
                                  String? userName = user.name;
                                  int? userSessions = user.numberOfSessions;
                                  int? userSalary = user.totalSalary;

                                  //show dialog
                                  await showDialog(
                                    useSafeArea: true,
                                    context: context,
                                    builder: (BuildContext context) {
                                      return Dialog(
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                        child: Container(
                                          decoration: const BoxDecoration(
                                              color:Colors.white,
                                              borderRadius: BorderRadius.all(Radius.circular(8))
                                          ),
                                          //height: 500,
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Column(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  Row(
                                                    mainAxisSize: MainAxisSize.max,
                                                    mainAxisAlignment: MainAxisAlignment.end,
                                                    children: [
                                                       InkWell(
                                                         onTap: () {
                                                           Navigator.pop(context);
                                                         },
                                                        child: ClipRRect(
                                                          borderRadius: BorderRadius.circular(8),
                                                          child: SvgPicture.asset(
                                                            'assets/images/frame23420.svg',
                                                            width: 50,
                                                            height: 50,
                                                            fit: BoxFit.none,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Text(
                                                    isCoachInfoList ??false ?
                                                    'المكافأة' :
                                                    //add sessions
                                                    'اضافة حصص',
                                                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                      fontFamily: 'Readex Pro',
                                                      fontSize: 24,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Column(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  Align(
                                                    alignment: const AlignmentDirectional(0, 0),
                                                    child: Row(
                                                      mainAxisSize: MainAxisSize.max,
                                                      mainAxisAlignment: MainAxisAlignment.end,
                                                      children: [
                                                        Expanded(
                                                          child: Align(
                                                            alignment: const AlignmentDirectional(1, 0),
                                                            child: Container(
                                                              width: 100,
                                                              child: TextFormField(
                                                                controller: ManageUsersCubit.get(context).salaryController,
                                                                autofocus: true,
                                                                obscureText: false,
                                                                decoration: InputDecoration(
                                                                  labelStyle: FlutterFlowTheme.of(context)
                                                                      .labelMedium
                                                                      .override(
                                                                    fontFamily: 'Readex Pro',
                                                                    fontSize: 10,
                                                                  ),
                                                                  hintText: 'اكتب رقم',
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
                                                                    borderRadius: BorderRadius.circular(8),
                                                                  ),
                                                                  focusedBorder: OutlineInputBorder(
                                                                    borderSide: const BorderSide(
                                                                      color: Colors.blue,
                                                                      width: 2,
                                                                    ),
                                                                    borderRadius: BorderRadius.circular(8),
                                                                  ),
                                                                  errorBorder: OutlineInputBorder(
                                                                    borderSide: BorderSide(
                                                                      color: FlutterFlowTheme.of(context).error,
                                                                      width: 2,
                                                                    ),
                                                                    borderRadius: BorderRadius.circular(8),
                                                                  ),
                                                                  focusedErrorBorder: OutlineInputBorder(
                                                                    borderSide: BorderSide(
                                                                      color: FlutterFlowTheme.of(context).error,
                                                                      width: 2,
                                                                    ),
                                                                    borderRadius: BorderRadius.circular(8),
                                                                  ),
                                                                ),
                                                                style: FlutterFlowTheme.of(context)
                                                                    .bodyMedium
                                                                    .override(
                                                                  fontFamily: 'Readex Pro',
                                                                  fontSize: 10,
                                                                ),
                                                                textAlign: TextAlign.end,
                                                                keyboardType: TextInputType.number,
                                                                cursorColor: const Color(0xFF333333),
                                                                //   validator: _model.textControllerValidator
                                                                //     .asValidator(context),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        Text(
                                                          isCoachInfoList??false ?
                                                          'المكافأة'
                                                              :'عدد الحصص',
                                                          style:
                                                          FlutterFlowTheme.of(context).bodyMedium.override(
                                                            fontFamily: 'Readex Pro',
                                                            fontSize: 12,
                                                          ),
                                                        ),
                                                      ]
                                                          .divide(const SizedBox(width: 10))
                                                          .addToEnd(const SizedBox(width: 15)),
                                                    ),
                                                  ),
                                                  Row(
                                                    mainAxisSize: MainAxisSize.max,
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [


                                                      InkWell(
                                                        onTap: () async {
                                                          //     print(ManageUsersCubit.get(context).users[index].uId);
                                                          if(isCoachInfoList??false){
                                                            await ManageUsersCubit.get(context).payPartialSalary
                                                              (
                                                              userName: userName??'',
                                                              userId:
                                                              uid,salaryPaid: ManageUsersCubit.get(context).salaryController.text, currentTotalSalary: userSalary ??0,
                                                            ).then((value) => Navigator.pop(context));
                                                          }else{
                                                            await ManageUsersCubit.get(context).addSessions(
                                                              context,

                                                              NumberOfSessions: userSessions??0,
                                                              userName: userName??'',
                                                              userId:
                                                              uid,sessions: ManageUsersCubit.get(context).salaryController.text,
                                                            ).then((value) => Navigator.pop(context));
                                                          }

                                                        },
                                                        child: BlocBuilder<ManageUsersCubit, ManageUsersState>(
  builder: (context, state) {
    return
  //    AddSessionsLoadingState
    state is AddSessionsLoadingState
        ? const CircularProgressIndicator()
        :
      Container(
                                                          width: 130,
                                                          height: 40,
                                                          decoration: BoxDecoration(
                                                            color: Colors.blue,
                                                            borderRadius: BorderRadius.circular(8),
                                                          ),
                                                          child: Align(
                                                            alignment: const AlignmentDirectional(0, 0),
                                                            child: Text(
                                                              //pay bonus
                                                              isCoachInfoList??false ?
                                                              ' صرف مكافأة'
                                                                  :'اضافة ',
                                                              style: FlutterFlowTheme.of(context)
                                                                  .titleSmall
                                                                  .override(
                                                                fontFamily: 'Readex Pro',
                                                                color: Colors.white,
                                                                fontSize: 12,
                                                              ),
                                                            ),
                                                          ),
                                                        );
  },
),
                                                      )
                                                    ].divide(const SizedBox(width: 10)),
                                                  ),

                                                ].divide(const SizedBox(height: 35)).addToStart(const SizedBox(height: 50)),
                                              ),
                                              const SizedBox(
                                                height: 20,
                                              )
                                            ].divide(const SizedBox(height: 0)),
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                },
                                child: Align(
                                  alignment: const AlignmentDirectional(0, 0),
                                  child: Text(
                                    isCoachInfoList??false ?
                                    'مكافأة':
                                    'اضافة حصص',
                                    textAlign: TextAlign.end,
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                      fontFamily: 'Readex Pro',
                                      color: Colors.blue,
                                      fontSize: 10,
                                      decoration:
                                      TextDecoration.underline,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),

                        Container(
                          width:
                          MediaQuery.sizeOf(context).width * 0.2,
                          height: 35,
                          decoration: BoxDecoration(
                            color: FlutterFlowTheme.of(context)
                                .secondaryBackground,
                            border: Border.all(
                              color: const Color(0xFFB4B4B4),
                              width: 1,
                            ),
                          ),
                          child: Align(
                            alignment: const AlignmentDirectional(0, 0),
                            child: Text(
                              //  ManageUsersCubit.get(context).coaches[index].totalSalary.toString(),
                              isCoachInfoList??false ?

                              user.totalSalary.toString()??'0':
                              user.numberOfSessions.toString()??'0',



                              textAlign: TextAlign.end,
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                fontFamily: 'Readex Pro',
                                color: Colors.black,
                                fontSize: 10,
                              ),
                            ),
                          ),
                        ),
                        Align(
                          alignment: const AlignmentDirectional(1, 0),
                          child: Container(
                            width: MediaQuery.sizeOf(context).width *
                                0.2,
                            height: 35,
                            decoration: BoxDecoration(
                              color: FlutterFlowTheme.of(context)
                                  .secondaryBackground,
                              border: Border.all(
                                color: const Color(0xFFB4B4B4),
                                width: 1,
                              ),
                            ),
                            child: Align(
                              alignment: const AlignmentDirectional(0, 0),
                              child: Text(
                                ' ${
                                // ManageUsersCubit.get(context).coaches[index].fname??''} ${(ManageUsersCubit.get(context).coaches[index].lname??'')}',
                                    user.name??''}'
                                //    ' ${(user.lname??'')}'
                                ,
                                textAlign: TextAlign.end,
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                  fontFamily: 'Readex Pro',
                                  fontSize: 10,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ):
                    ListTile(
                      title: Text(user.name ?? ''),
                      subtitle: Text(user.phone ?? ''),



                      trailing: Checkbox(
                        value: isCoach
                            ? state.selectedCoaches.map((user) => user.uId).contains(user.uId)
                            : state.selectedUsers.map((user) => user.uId).contains(user.uId),
                        onChanged: (value) {
                          logger.d('value is $value');
                          if (value!) {
                            if (isCoach) {
                              addGroupCubit.selectCoach(user);
                            } else {
                              addGroupCubit.selectUser(user);
                            }
                          } else if (!value) {
                            if (isCoach) {
                              logger.d('user id is ${user.uId}');
                              context
                                  .read<AddGroupCubit>()
                                  .deselectCoach(user);
                            } else {
                              context
                                  .read<AddGroupCubit>()
                                  .deselectUser(user);
                            }
                          }
                        },
                      ),
                    );
                  },
                ),
              ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.end,
              //   children: [
              //     TextButton(
              //       onPressed: () => Navigator.of(context).pop(),
              //       child: Text('Cancel'),
              //     ),
              //     TextButton(
              //       onPressed: () {
              //         //    onSelectedUsersChanged(addGroupCubit.selectedUsers);
              //
              //         Navigator.of(context).pop();
              //       },
              //       child: Text('Save'),
              //     ),
              //   ],
              // ),
              isCoachInfoList ??false ?
              Container():
              isUserInfoList ??false?
              Container():
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text('Cancel'),
                  ),
                  TextButton(
                    onPressed: () {
                      //    onSelectedUsersChanged(addGroupCubit.selectedUsers);

                      Navigator.of(context).pop();
                    },
                    child: const Text('Save'),
                  ),
                ],
              ),
            ],
          ):
          Dialog(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                isCoachInfoList ?? false ?
                Container(
                    decoration: ShapeDecoration(
                      color: const Color(0xFFFAFAFA),
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(width: 1, color: Color(0xFFB9B9B9)),
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                    height: 40.h,
                    width: 290.w,
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child:TextField(
                      //arasbic
                      textAlign: TextAlign.right,
                      onTap: //_showClearButton = false; /
                          () {
                        //  addGroupCubit.isSearch = true;
                        //make it using update funvtion
                        addGroupCubit.updateIsSearch(true);
                      },
                      controller: addGroupCubit.searchController,
                      textInputAction: TextInputAction.search,
                      onSubmitted: (_) => addGroupCubit.onSearchSubmitted(addGroupCubit.searchController.text.trim(),isCoach),
                      decoration: InputDecoration(
                        hintText: //'Search',
                        //translate this to arabic
                        'بحث',
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.search),
                          onPressed: () => addGroupCubit.onSearchSubmitted(addGroupCubit.searchController.text.trim(),isCoach),
                        ),
                        prefixIcon:
                        isSearch? IconButton(
                            icon: const Icon(Icons.close),
                            onPressed: () {
                              addGroupCubit.searchController.clear();
                              //query ==null
                              //  addGroupCubit.usersQuery =null;
                              //make it using update funvtion
                              addGroupCubit.updateUsersQuery(null);
                              //update isSearch
                              addGroupCubit.updateIsSearch(false);
                              FocusScope.of(context).unfocus();

                            }
                        ):null,
                      ),

                    )
                )
                    :
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child:TextFormField(
                    //searc fl add group cubit
                    textDirection: ui.TextDirection.ltr,
                    textAlign: TextAlign.right,

                    onTap: () {
                      addGroupCubit.updateIsSearch(true);
                    },
                    controller: addGroupCubit.searchController,
                    textInputAction: TextInputAction.search,
                    onFieldSubmitted: (_) => addGroupCubit.onSearchSubmitted(addGroupCubit.searchController.text.trim(),isCoach),
                    decoration: InputDecoration(

                      hintText:// 'Search ',
                      //translate this to arabic
                      //dh group search
                      'بحث',
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.search),
                        onPressed: () => addGroupCubit.onSearchSubmitted(addGroupCubit.searchController.text.trim(),isCoach),
                      ),
                      prefixIcon:
                      isSearch ? IconButton(
                          icon: const Icon(Icons.close),
                          onPressed: () {
                            addGroupCubit.searchController.clear();
                            //query ==null
                            //  addGroupCubit.usersQuery =null;
                            //make it using update funvtion

                            addGroupCubit.updateUsersQuery(
                              //if is coach then show only coaches
                              isCoach ? FirebaseFirestore.instance.collection('users').where(
                                  'role', isEqualTo: 'coach')
                                  .where('pid',isEqualTo: FirebaseAuth.instance.currentUser!.uid)
                                  :FirebaseFirestore.instance.collection('users').where(
                                  'role', isEqualTo: 'user')
                                  .where('pid',isEqualTo: FirebaseAuth.instance.currentUser!.uid),
                            );
                            //update isSearch
                            addGroupCubit.updateIsSearch(false);
                            FocusScope.of(context).unfocus();

                          }
                      ):null,

                    ),
                  ),
                ),
                isCoachInfoList??false?
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      width:
                      MediaQuery.sizeOf(context).width * 0.2,
                      height: 35,
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context)
                            .secondaryBackground,
                        border: Border.all(
                          color: const Color(0xFFB4B4B4),
                          width: 1,
                        ),
                      ),
                      child: Align(
                        alignment: const AlignmentDirectional(0, 0),
                        child: Text(
                          'دفع',
                          textAlign: TextAlign.end,
                          style: FlutterFlowTheme.of(context)
                              .bodyMedium
                              .override(
                            fontFamily: 'Readex Pro',
                            color: Colors.black,
                            fontSize: 10,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width:
                      MediaQuery.sizeOf(context).width * 0.2,
                      height: 35,
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context)
                            .secondaryBackground,
                        border: Border.all(
                          color: const Color(0xFFB4B4B4),
                          width: 1,
                        ),
                      ),
                      child: Align(
                        alignment: const AlignmentDirectional(0, 0),
                        child: Text(

                          'مكافأة',

                          textAlign: TextAlign.end,
                          style: FlutterFlowTheme.of(context)
                              .bodyMedium
                              .override(
                            fontFamily: 'Readex Pro',
                            color: Colors.black,
                            fontSize: 10,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width:
                      MediaQuery.sizeOf(context).width * 0.2,
                      height: 35,
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context)
                            .secondaryBackground,
                        border: Border.all(
                          color: const Color(0xFFB4B4B4),
                          width: 1,
                        ),
                      ),
                      child: Align(
                        alignment: const AlignmentDirectional(0, 0),
                        child: Text(
                          'مجموع المرتب',
                          textAlign: TextAlign.end,
                          style: FlutterFlowTheme.of(context)
                              .bodyMedium
                              .override(
                            fontFamily: 'Readex Pro',
                            color: Colors.black,
                            fontSize: 10,
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: const AlignmentDirectional(1, 0),
                      child: Container(
                        width: MediaQuery.sizeOf(context).width *
                            0.2,
                        height: 35,
                        decoration: BoxDecoration(
                          color: FlutterFlowTheme.of(context)
                              .secondaryBackground,
                          border: Border.all(
                            color: const Color(0xFFB4B4B4),
                            width: 1,
                          ),
                        ),
                        child: Align(
                          alignment: const AlignmentDirectional(0, 0),
                          child: Text(
                            'الاسم',
                            textAlign: TextAlign.end,
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                              fontFamily: 'Readex Pro',
                              fontSize: 10,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
                    :Container(),

                Expanded(
                  child: FirestoreListView(
                    shrinkWrap: true,
                    cacheExtent: 5000,
                    pageSize: 5,
                    query: query ??FirebaseFirestore.instance.collection('users').where(
                        'role', isEqualTo: isCoachInfoList??false ? 'coach' : 'user')
                        .where('pid',isEqualTo: FirebaseAuth.instance.currentUser!.uid),
                    itemBuilder: (context, document) {
                      final data = document.data() as Map<String, dynamic>;
                      final user = UserModel.fromJson(data);
                      return isCoachInfoList ??
                          false ?   Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            width: MediaQuery.sizeOf(context).width * 0.2,
                            height: 35,
                            decoration: BoxDecoration(
                              color: FlutterFlowTheme.of(context)
                                  .secondaryBackground,
                              border: Border.all(
                                color: const Color(0xFFB4B4B4),
                                width: 1,
                              ),
                            ),
                            child: InkWell(
                              onTap: () async {
                                final manageSalaryCubit = ManageUsersCubit.get(context);
                                //manageSalaryCubit.initControllers(ManageUsersCubit.get(context).coaches[index]);
                                manageSalaryCubit.initControllers(user);
                                await Navigator.pushNamed(context,
                                    AppRoutes.editProfile,
                                    arguments: user
                                    as UserModel
                                ) ;


                              },
                              child: Align(
                                alignment: const AlignmentDirectional(0, 0),
                                child: InkWell(
                                  child: Text(
                                    '...المزيد ',
                                    textAlign: TextAlign.end,
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                      fontFamily: 'Readex Pro',
                                      color: Colors.blue,
                                      fontSize: 10.sp,
                                      decoration:
                                      TextDecoration.underline,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          BlocBuilder<ManageUsersCubit, ManageUsersState>(
                            builder: (context, state) {
                              return Container(
                                width: MediaQuery.sizeOf(context).width * 0.2,
                                height: 35,
                                decoration: BoxDecoration(
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryBackground,
                                  border: Border.all(
                                    color: const Color(0xFFB4B4B4),
                                    width: 1,
                                  ),
                                ),
                                child: InkWell(
                                  onTap: () async {
                                    //      String? uid =ManageUsersCubit.get(context).coaches[index].uId;
                                    String? uid =user.uId;
                                    //show dialog
                                    await showDialog(
                                      useSafeArea: true,
                                      context: context,
                                      builder: (BuildContext context) {
                                        return Dialog(
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(8),
                                          ),
                                          child: Container(
                                            //height: 500,
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Column(
                                                  mainAxisSize: MainAxisSize.max,
                                                  children: [
                                                    Row(
                                                      mainAxisSize: MainAxisSize.max,
                                                      mainAxisAlignment: MainAxisAlignment.end,
                                                      children: [
                                                        ClipRRect(
                                                          borderRadius: BorderRadius.circular(8),
                                                          child: SvgPicture.asset(
                                                            'assets/images/frame23420.svg',
                                                            width: 50,
                                                            height: 50,
                                                            fit: BoxFit.none,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Text(
                                                      'دفع المرتب',
                                                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                        fontFamily: 'Readex Pro',
                                                        fontSize: 24,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Column(
                                                  mainAxisSize: MainAxisSize.max,
                                                  children: [
                                                    Align(
                                                      alignment: const AlignmentDirectional(0, 0),
                                                      child: Row(
                                                        mainAxisSize: MainAxisSize.max,
                                                        mainAxisAlignment: MainAxisAlignment.end,
                                                        children: [
                                                          Expanded(
                                                            child: Align(
                                                              alignment: const AlignmentDirectional(1, 0),
                                                              child: Container(
                                                                width: 100,
                                                                child: TextFormField(
                                                                  controller: ManageUsersCubit.get(context).salaryController,
                                                                  autofocus: true,
                                                                  obscureText: false,
                                                                  decoration: InputDecoration(
                                                                    labelStyle: FlutterFlowTheme.of(context)
                                                                        .labelMedium
                                                                        .override(
                                                                      fontFamily: 'Readex Pro',
                                                                      fontSize: 10,
                                                                    ),
                                                                    hintText: 'اكتب رقم',
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
                                                                      borderRadius: BorderRadius.circular(8),
                                                                    ),
                                                                    focusedBorder: OutlineInputBorder(
                                                                      borderSide: const BorderSide(
                                                                        color: Colors.blue,
                                                                        width: 2,
                                                                      ),
                                                                      borderRadius: BorderRadius.circular(8),
                                                                    ),
                                                                    errorBorder: OutlineInputBorder(
                                                                      borderSide: BorderSide(
                                                                        color: FlutterFlowTheme.of(context).error,
                                                                        width: 2,
                                                                      ),
                                                                      borderRadius: BorderRadius.circular(8),
                                                                    ),
                                                                    focusedErrorBorder: OutlineInputBorder(
                                                                      borderSide: BorderSide(
                                                                        color: FlutterFlowTheme.of(context).error,
                                                                        width: 2,
                                                                      ),
                                                                      borderRadius: BorderRadius.circular(8),
                                                                    ),
                                                                  ),
                                                                  style: FlutterFlowTheme.of(context)
                                                                      .bodyMedium
                                                                      .override(
                                                                    fontFamily: 'Readex Pro',
                                                                    fontSize: 10,
                                                                  ),
                                                                  textAlign: TextAlign.end,
                                                                  keyboardType: TextInputType.number,
                                                                  cursorColor: const Color(0xFF333333),
                                                                  //   validator: _model.textControllerValidator
                                                                  //     .asValidator(context),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          Text(
                                                            ':الدفع الجزئي',
                                                            style:
                                                            FlutterFlowTheme.of(context).bodyMedium.override(
                                                              fontFamily: 'Readex Pro',
                                                              fontSize: 12,
                                                            ),
                                                          ),
                                                        ]
                                                            .divide(const SizedBox(width: 10))
                                                            .addToEnd(const SizedBox(width: 15)),
                                                      ),
                                                    ),
                                                    Row(
                                                      mainAxisSize: MainAxisSize.max,
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      children: [

                                                        InkWell(
                                                          onTap: () async {
                                                            //     print(ManageUsersCubit.get(context).users[index].uId);
                                                            await ManageUsersCubit.get(context).payPartialSalary
                                                              (
                                                              userName: user.name??'',
                                                              userId:
                                                              uid,salaryPaid: ManageUsersCubit.get(context).salaryController.text, currentTotalSalary: user.totalSalary ??0,
                                                            ).then((value) => Navigator.pop(context));
                                                          },
                                                          child: Container(
                                                            width: 130,
                                                            height: 40,
                                                            decoration: BoxDecoration(
                                                              color: const Color(0xFFB9B9B9),
                                                              borderRadius: BorderRadius.circular(8),
                                                            ),
                                                            child: Align(
                                                              alignment: const AlignmentDirectional(0, 0),
                                                              child: Text(
                                                                'دفع جزئي',
                                                                style: FlutterFlowTheme.of(context)
                                                                    .titleSmall
                                                                    .override(
                                                                  fontFamily: 'Readex Pro',
                                                                  color: Colors.white,
                                                                  fontSize: 12,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),

                                                        InkWell(
                                                          onTap: () async {
                                                            //     print(ManageUsersCubit.get(context).users[index].uId);
                                                            await ManageUsersCubit.get(context).paySalary(
                                                             userTotalSalary:user.totalSalary,
                                                              userName:
                                                            user.name,
                                                              userId:
                                                              uid,
                                                            ).then((value) => Navigator.pop(context));
                                                          },
                                                          child: Container(
                                                            width: 130,
                                                            height: 40,
                                                            decoration: BoxDecoration(
                                                              color: Colors.blue,
                                                              borderRadius: BorderRadius.circular(8),
                                                            ),
                                                            child: Align(
                                                              alignment: const AlignmentDirectional(0, 0),
                                                              child: Text(
                                                                'دفع كل المرتب',
                                                                style: FlutterFlowTheme.of(context)
                                                                    .titleSmall
                                                                    .override(
                                                                  fontFamily: 'Readex Pro',
                                                                  color: Colors.white,
                                                                  fontSize: 12,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        )
                                                      ].divide(const SizedBox(width: 10)),
                                                    ),

                                                  ].divide(const SizedBox(height: 35)).addToStart(const SizedBox(height: 50)),
                                                ),
                                                const SizedBox(
                                                  height: 20,
                                                )
                                              ].divide(const SizedBox(height: 0)),
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  },
                                  child: Align(
                                    alignment: const AlignmentDirectional(0, 0),
                                    child: Text(
                                      'دفع الراتب',
                                      textAlign: TextAlign.end,
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                        fontFamily: 'Readex Pro',
                                        color: Colors.blue,
                                        fontSize: 10,
                                        decoration:
                                        TextDecoration.underline,
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                          BlocConsumer<ManageUsersCubit, ManageUsersState>(
                            listener: (context, state) {

                            },
                            builder: (context, state) {
                              return Container(
                                width: MediaQuery.sizeOf(context).width * 0.2,
                                height: 35,
                                decoration: BoxDecoration(
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryBackground,
                                  border: Border.all(
                                    color: const Color(0xFFB4B4B4),
                                    width: 1,
                                  ),
                                ),
                                child: InkWell(
                                  onTap: () async {
                                    //String? uid =ManageUsersCubit.get(context).coaches[index].uId;
                                    String? uid =user.uId;
                                    //show dialog
                                    await showDialog(
                                      useSafeArea: true,
                                      context: context,
                                      builder: (BuildContext context) {
                                        return Dialog(
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(8),
                                          ),
                                          child: Container(
                                            //height: 500,
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Column(
                                                  mainAxisSize: MainAxisSize.max,
                                                  children: [
                                                    Row(
                                                      mainAxisSize: MainAxisSize.max,
                                                      mainAxisAlignment: MainAxisAlignment.end,
                                                      children: [
                                                        ClipRRect(
                                                          borderRadius: BorderRadius.circular(8),
                                                          child: SvgPicture.asset(
                                                            'assets/images/frame23420.svg',
                                                            width: 50,
                                                            height: 50,
                                                            fit: BoxFit.none,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Text(
                                                      //'bonus'
                                                      'المكافأة',
                                                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                        fontFamily: 'Readex Pro',
                                                        fontSize: 24,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Column(
                                                  mainAxisSize: MainAxisSize.max,
                                                  children: [
                                                    Align(
                                                      alignment: const AlignmentDirectional(0, 0),
                                                      child: Row(
                                                        mainAxisSize: MainAxisSize.max,
                                                        mainAxisAlignment: MainAxisAlignment.end,
                                                        children: [
                                                          Expanded(
                                                            child: Align(
                                                              alignment: const AlignmentDirectional(1, 0),
                                                              child: Container(
                                                                width: 100,
                                                                child: TextFormField(
                                                                  controller: ManageUsersCubit.get(context).salaryController,
                                                                  autofocus: true,
                                                                  obscureText: false,
                                                                  decoration: InputDecoration(
                                                                    labelStyle: FlutterFlowTheme.of(context)
                                                                        .labelMedium
                                                                        .override(
                                                                      fontFamily: 'Readex Pro',
                                                                      fontSize: 10,
                                                                    ),
                                                                    hintText: 'اكتب رقم',
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
                                                                      borderRadius: BorderRadius.circular(8),
                                                                    ),
                                                                    focusedBorder: OutlineInputBorder(
                                                                      borderSide: const BorderSide(
                                                                        color: Colors.blue,
                                                                        width: 2,
                                                                      ),
                                                                      borderRadius: BorderRadius.circular(8),
                                                                    ),
                                                                    errorBorder: OutlineInputBorder(
                                                                      borderSide: BorderSide(
                                                                        color: FlutterFlowTheme.of(context).error,
                                                                        width: 2,
                                                                      ),
                                                                      borderRadius: BorderRadius.circular(8),
                                                                    ),
                                                                    focusedErrorBorder: OutlineInputBorder(
                                                                      borderSide: BorderSide(
                                                                        color: FlutterFlowTheme.of(context).error,
                                                                        width: 2,
                                                                      ),
                                                                      borderRadius: BorderRadius.circular(8),
                                                                    ),
                                                                  ),
                                                                  style: FlutterFlowTheme.of(context)
                                                                      .bodyMedium
                                                                      .override(
                                                                    fontFamily: 'Readex Pro',
                                                                    fontSize: 10,
                                                                  ),
                                                                  textAlign: TextAlign.end,
                                                                  keyboardType: TextInputType.number,
                                                                  cursorColor: const Color(0xFF333333),
                                                                  //   validator: _model.textControllerValidator
                                                                  //     .asValidator(context),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          Text(
                                                            'المكافأة',
                                                            style:
                                                            FlutterFlowTheme.of(context).bodyMedium.override(
                                                              fontFamily: 'Readex Pro',
                                                              fontSize: 12,
                                                            ),
                                                          ),
                                                        ]
                                                            .divide(const SizedBox(width: 10))
                                                            .addToEnd(const SizedBox(width: 15)),
                                                      ),
                                                    ),
                                                    Row(
                                                      mainAxisSize: MainAxisSize.max,
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      children: [


                                                        InkWell(
                                                          onTap: () async {
                                                            //     print(ManageUsersCubit.get(context).users[index].uId);
                                                            await ManageUsersCubit.get(context).payBonus(
                                                              userId:
                                                              uid,salaryPaid: ManageUsersCubit.get(context).salaryController.text, TotalSalary: user.totalSalary ??0,
                                                            ).then((value) => Navigator.pop(context));
                                                          },
                                                          child: Container(
                                                            width: 130,
                                                            height: 40,
                                                            decoration: BoxDecoration(
                                                              color: Colors.blue,
                                                              borderRadius: BorderRadius.circular(8),
                                                            ),
                                                            child: Align(
                                                              alignment: const AlignmentDirectional(0, 0),
                                                              child: Text(
                                                                //pay bonus
                                                                isCoachInfoList??false ?
                                                                ' صرف مكافأة':
                                                                'اضافة ',
                                                                style: FlutterFlowTheme.of(context)
                                                                    .titleSmall
                                                                    .override(
                                                                  fontFamily: 'Readex Pro',
                                                                  color: Colors.white,
                                                                  fontSize: 12,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        )
                                                      ].divide(const SizedBox(width: 10)),
                                                    ),

                                                  ].divide(const SizedBox(height: 35)).addToStart(const SizedBox(height: 50)),
                                                ),
                                                const SizedBox(
                                                  height: 20,
                                                )
                                              ].divide(const SizedBox(height: 0)),
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  },
                                  child: Align(
                                    alignment: const AlignmentDirectional(0, 0),
                                    child: Text(
                                      'مكافأة',
                                      textAlign: TextAlign.end,
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                        fontFamily: 'Readex Pro',
                                        color: Colors.blue,
                                        fontSize: 10,
                                        decoration:
                                        TextDecoration.underline,
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),

                          Container(
                            width:
                            MediaQuery.sizeOf(context).width * 0.2,
                            height: 35,
                            decoration: BoxDecoration(
                              color: FlutterFlowTheme.of(context)
                                  .secondaryBackground,
                              border: Border.all(
                                color: const Color(0xFFB4B4B4),
                                width: 1,
                              ),
                            ),
                            child: Align(
                              alignment: const AlignmentDirectional(0, 0),
                              child: Text(
                                //  ManageUsersCubit.get(context).coaches[index].totalSalary.toString(),
                                user.totalSalary.toString(),



                                textAlign: TextAlign.end,
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                  fontFamily: 'Readex Pro',
                                  color: Colors.black,
                                  fontSize: 10,
                                ),
                              ),
                            ),
                          ),
                          Align(
                            alignment: const AlignmentDirectional(1, 0),
                            child: Container(
                              width: MediaQuery.sizeOf(context).width *
                                  0.2,
                              height: 35,
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context)
                                    .secondaryBackground,
                                border: Border.all(
                                  color: const Color(0xFFB4B4B4),
                                  width: 1,
                                ),
                              ),
                              child: Align(
                                alignment: const AlignmentDirectional(0, 0),
                                child: Text(
                                  ' ${
                                  // ManageUsersCubit.get(context).coaches[index].fname??''} ${(ManageUsersCubit.get(context).coaches[index].lname??'')}',
                                      user.name??''} '
                                  //    '${(user.lname??'')}'
                                  ,
                                  textAlign: TextAlign.end,
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                    fontFamily: 'Readex Pro',
                                    fontSize: 10,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ):
                      ListTile(
                        title: Text(user.name ?? ''),
                        subtitle: Text(user.phone ?? ''),



                        trailing: Checkbox(
                          value: isCoach
                              ? state.selectedCoaches.map((user) => user.uId).contains(user.uId)
                              : state.selectedUsers.map((user) => user.uId).contains(user.uId),
                          onChanged: (value) {
                            logger.d('value is $value');
                            if (value!) {
                              if (isCoach) {
                                addGroupCubit.selectCoach(user);
                              } else {
                                addGroupCubit.selectUser(user);
                              }
                            } else if (!value) {
                              if (isCoach) {
                                logger.d('user id is ${user.uId}');
                                context
                                    .read<AddGroupCubit>()
                                    .deselectCoach(user);
                              } else {
                                context
                                    .read<AddGroupCubit>()
                                    .deselectUser(user);
                              }
                            }
                          },
                        ),
                      );
                    },
                  ),
                ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.end,
                //   children: [
                //     TextButton(
                //       onPressed: () => Navigator.of(context).pop(),
                //       child: Text('Cancel'),
                //     ),
                //     TextButton(
                //       onPressed: () {
                //     //    onSelectedUsersChanged(addGroupCubit.selectedUsers);
                //
                //         Navigator.of(context).pop();
                //       },
                //       child: Text('Save'),
                //     ),
                //   ],
                // ),
                isCoachInfoList ??false ?
                Container():
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () {
                        //    onSelectedUsersChanged(addGroupCubit.selectedUsers);

                        Navigator.of(context).pop();
                      },
                      child: const Text('Save'),
                    ),
                  ],
                ),
              ],
            ),
          );
      },
    );
  }
}
