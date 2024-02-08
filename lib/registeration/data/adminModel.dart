import 'package:cloud_firestore/cloud_firestore.dart';
//    AdminModel model = AdminModel(
//         name: 'Write your name...',
//         level: 3,
//         hourlyRate: 0,
//         totalHours: 0,
//         totalSalary: 0,
//         currentMonthHours: 0,
//         currentMonthSalary: 0,
//     );
class AdminModel
{
//password
  
   String? password;
  Timestamp? date;
  String? pId;
  String? phone;
  String? fname;
  String? lname;
  String? token;
  int? Salary;
  List<String>? branches;
  int? totalMoneySpentOnCoaches;
  int? totalMoneyearned;





  AdminModel({
    //password
    this.password,
    this.date,
    this.pId,
    this.phone,
    this.fname,
    this.lname,
    this.token,
    this.Salary,
    this.branches,
    this.totalMoneySpentOnCoaches,
    this.totalMoneyearned,


  });

  AdminModel.fromJson(Map<String, dynamic> json) {
    //password
    password = json['password'];

    date = json['date'];
    pId = json['pId'];
    phone = json['phone'];
    fname = json['fname'];
    lname = json['lname'];
    token = json['token'];
    Salary = json['totalSalary'];
    branches = json['branches'].cast<String>();
    totalMoneySpentOnCoaches = json['totalMoneySpentOnCoaches'];
    totalMoneyearned = json['totalMoneyearned'];


  }

  Map<String, dynamic> toMap() {
    return {
      //password
      'password': password,
       'date': date,
      'pId': pId,
      'phone': phone,
      'fname': fname,
      'lname': lname,
      'token': token,
      'totalSalary': Salary,
      'branches': branches,
      'totalMoneySpentOnCoaches': totalMoneySpentOnCoaches,
      'totalMoneyearned': totalMoneyearned,
    };
  }
}