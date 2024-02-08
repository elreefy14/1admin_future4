import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';
import 'package:flutter/material.dart';

import '../../../../manage_users_coaches/business_logic/manage_users_cubit.dart';

class CoachList extends StatelessWidget {
  final String uid;
  final String dayName;
  final String scheduleId;
  final String role;

  const CoachList({
    Key? key,
    required this.uid,
    required this.dayName,
    required this.scheduleId, required this.role,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: ManageUsersCubit.get(context).schedules?.length ?? 0,
      itemBuilder: (context, index) {
        return FirestoreListView<Map<String, dynamic>>(
          pageSize: 5,
          shrinkWrap: true,
          loadingBuilder: (context) => Center(child: CircularProgressIndicator()),
          cacheExtent: 100,
          query: FirebaseFirestore.instance
              .collection('admins')
              .doc(FirebaseAuth.instance.currentUser?.uid)
              .collection('schedules')
              .doc(ManageUsersCubit.get(context).days?[
          ManageUsersCubit.get(context).selectedDayIndex
          ].name ?? '')
              .collection('schedules')
              .doc('${ManageUsersCubit.get(context).schedules?[index].scheduleId}')
              .collection('users'),
              //.where('role', isEqualTo: role),
          itemBuilder: (context, snapshot) {
            Map<String, dynamic> user = snapshot.data();
            int startTime = ManageUsersCubit.get(context).schedules?[index].startTime?.toDate().hour ?? 0;
            int endTime = ManageUsersCubit.get(context).schedules?[index].endTime?.toDate().hour ?? 0;
            int totalHours = endTime - startTime;
            totalHours += Duration(minutes: 2).inHours;
            return Column(
              children: [
                CheckboxListTile(
                  title: Text(user['name']),
                  value: user['finished'],
                  onChanged: (value) async {
                    FirebaseFirestore firestore = FirebaseFirestore.instance;
                    if (value == true) {
                      firestore
                          .collection('admins')
                          .doc(FirebaseAuth.instance.currentUser?.uid)
                          .collection('schedules')
                          .doc(ManageUsersCubit.get(context).days?[
                      ManageUsersCubit.get(context).selectedDayIndex
                      ].name ?? '')
                          .collection('schedules')
                          .doc('${ManageUsersCubit.get(context).schedules?[index].scheduleId}')
                          .collection('users')
                          .doc(user['uid'])
                          .update({'finished': value,});
                      firestore.collection('users').doc(user['uid']).update({'totalHours': FieldValue.increment(totalHours)});
                      firestore.collection('users').doc(user['uid']).collection('notifications').add({
                        'message': 'تم اضافة ${totalHours} ساعات لحسابك',
                        'timestamp': Timestamp.now(),
                      });
                    } else {
                      firestore
                          .collection('admins')
                          .doc(FirebaseAuth.instance.currentUser?.uid)
                          .collection('schedules')
                          .doc(ManageUsersCubit.get(context).days?[
                      ManageUsersCubit.get(context).selectedDayIndex
                      ].name ?? '')
                          .collection('schedules')
                          .doc('${ManageUsersCubit.get(context).schedules?[index].scheduleId}')
                          .collection('users')
                          .doc(user['uid'])
                          .update({'finished': value,});
                      firestore.collection('users').doc(user['uid']).update({'totalHours': FieldValue.increment(-totalHours)});
                      firestore.collection('users').doc(user['uid']).collection('notifications').add({
                        'message': 'تم خصم ${totalHours} ساعات من حسابك',
                        'timestamp': Timestamp.now(),
                      });
                    }
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }
}