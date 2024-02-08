import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../registeration/data/userModel.dart';
import '../../../../manage_users_coaches/business_logic/manage_users_cubit.dart';

class CustomSearchBar extends StatelessWidget {
  final TextEditingController _model = TextEditingController();
  final bool isCoach;

  CustomSearchBar({this.isCoach = true});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            decoration: ShapeDecoration(
              color: Color(0xFFFAFAFA),
              shape: RoundedRectangleBorder(
                side: BorderSide(width: 1, color: Color(0xFFB9B9B9)),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            height: 40.h,
            width: 290.w,
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: TextField(
              controller: _model,
              decoration: InputDecoration(
                hintText: 'name or phone number',
                suffixIcon: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    String query = _model.text;
                    //delete spaces in the beginning and end of the query
                    query = query.trim();
                    Query collectionQuery = FirebaseFirestore.instance.collection('users');
                    if (isCoach) {
                      collectionQuery = collectionQuery.where('role', isEqualTo: 'coach');
                    } else {
                      collectionQuery = collectionQuery.where('role', isEqualTo: 'user');
                    }
                    collectionQuery.where('name', isGreaterThanOrEqualTo: query)
                        .where('name', isLessThan: query + 'z')
                        .get()
                        .then((snapshot) {
                      if (snapshot.docs.isNotEmpty) {
                        List users = snapshot.docs
                            .map((e) => UserModel.fromJson(e.data() as Map<String, dynamic>))
                            .toList();
                             if (isCoach) {
                     //  ManageSalaryCubit.get(context).updateListOfCoaches(users);
                    } else {
                    //   ManageSalaryCubit.get(context).updateListOfUsers(users);
                    }
                      
                      } else {
                        // If no results found for name search, search by phone number
                        collectionQuery.where('phone', isGreaterThanOrEqualTo: query)
                            .where('phone', isLessThan: query + 'z')
                            .get()
                            .then((snapshot) {
                          List users = snapshot.docs
                              .map((e) => UserModel.fromJson(e.data() as Map<String, dynamic>))
                              .toList();
                                   if (isCoach) {
                    //   ManageSalaryCubit.get(context).updateListOfCoaches(users);
                    } else {
                    //   ManageSalaryCubit.get(context).updateListOfUsers(users);
                    }
                        });
                      }
                    });
                  },
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}