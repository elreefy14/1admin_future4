import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';
import 'package:flutter/material.dart';

import '../../registeration/data/userModel.dart';

class SearchUsersWidget extends StatefulWidget {
  const SearchUsersWidget({Key? key, required TextEditingController searchController,required this.isCoach}) : super(key: key);
final isCoach ;
  @override
  _SearchUsersWidgetState createState() => _SearchUsersWidgetState();
}

class _SearchUsersWidgetState extends State<SearchUsersWidget> {
  final TextEditingController _searchController = TextEditingController();
  Query? _query;
  int? numberOfQuery;
  List<String> _selectedUsersUids = [];

  @override
  void initState() {
    super.initState();
    _query = FirebaseFirestore.instance.collection('users');
  }

  Future<void> _onSearchSubmitted(String value) async {
    Query newQuery = FirebaseFirestore.instance
        .collection('users')
        .where('name', isGreaterThanOrEqualTo: value)
        .where('name', isLessThan: value + 'z')
        //order by name
        .orderBy('name', descending: false)
        .limit(100);

    QuerySnapshot querySnapshot =
        await newQuery.get(GetOptions(source: Source.serverAndCache));
    numberOfQuery = querySnapshot.docs.length;
    print('number of query is $numberOfQuery');
    print(numberOfQuery);

    if (numberOfQuery == 0) {
      newQuery = FirebaseFirestore.instance
          .collection('users')
          .where('phone', isGreaterThanOrEqualTo: value)
          .where('phone', isLessThan: value + 'z')
          //order by name
          .orderBy('phone', descending: false)
          .limit(100);
    }

    setState(() {
      _query = newQuery;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            //i want when i click on search icon the keyboard will be closed
            textInputAction: TextInputAction.search,
            onSubmitted: (value) => _onSearchSubmitted(value.trim()),
            controller: _searchController,
            decoration: InputDecoration(
              hintText: 'Search by name or phone number',
              suffixIcon: IconButton(
                icon: Icon(Icons.search),
                onPressed: () =>
                    _onSearchSubmitted(_searchController.text.trim()),
              ),
            ),
          ),
        ),
        //
        Expanded(
          child: FirestoreListView(
            shrinkWrap: true,
            cacheExtent: 300,
            pageSize: 5,
            query: _query!,
            itemBuilder: (context, document) {
              final data = document.data() as Map<String, dynamic>;
              final user = UserModel.fromJson(data);
              return ListTile(
                title: Text(user.name ?? ''),
                subtitle: Text(user.phone ?? ''),
                trailing: Checkbox(
                  value: _selectedUsersUids.contains(user.uId),
                  onChanged: (value) {
                    setState(() {
                      if (value!) {
                          _selectedUsersUids.add(user.uId!);
                        //print user all info 
                        print('user all info are ${user.toJson()}');
                        print('selected users is ${
                            _selectedUsersUids[0]
                        }');
                      
                        print('value is $value');
                        print('user info is ${user.name}');
                        print('user info is ${user.phone}');
                      
                        print('selected users is $_selectedUsersUids.length');
                      } else {
                        print('value is $value');
                        print('user info is ${user.name}');
                        _selectedUsersUids.remove(user.uId!);

                      }
                    });
                  },
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}