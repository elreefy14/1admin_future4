import 'package:cloud_firestore/cloud_firestore.dart';
//    UserModel model = UserModel(
//         name: 'Write your name...',
//         level: 3,
//         hourlyRate: 0,
//         totalHours: 0,
//         totalSalary: 0,
//         currentMonthHours: 0,
//         currentMonthSalary: 0,
//     );
class UserModel
{
//    UserModel model = UserModel(
//         name: 'Write your name...',
//         level: 3,
//         hourlyRate: 0,
//         totalHours: 0,
//         totalSalary: 0,
//         currentMonthHours: 0,
//         currentMonthSalary: 0,
//     );
  String? name;
  String? email;
  int? level;
  int? hourlyRate;
  int? totalHours;
  int? totalSalary;
  int? currentMonthHours;
  int? currentMonthSalary;
  String? uId;
  String? phone;
  String? fname;
  String? lname;
  String? image;
  String? token;
  List<String>? branches;
  String? role;
  Timestamp? date;
  //pid
  String? pid;
  //numberOfSessions
  int? numberOfSessions;
  String? password;
//  String? name;
//   String? email;
//   int? level;
//   int? hourlyRate;
//   int? totalHours;
//   int? totalSalary;
//   int? currentMonthHours;
//   int? currentMonthSalary;
//   String? uId;
//   String? phone;
//   String? role;
//   //image
//   String? image;
//   //fname
//   String? fname;
//   //lname
//   String? lname;


  UserModel({
    this.role,
    this.name,
    this.email,
    this.level,
    this.hourlyRate,
    this.totalHours,
    this.totalSalary,
    this.currentMonthHours,
    this.currentMonthSalary,
    this.uId,
    this.phone,
    this.fname,
    this.lname,
    this.image,
    this.token,
    this.branches,
    this.pid, this.numberOfSessions,
    this.date, this.password,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    role = json['role'];
    name = json['name'];
    email = json['email'];
    level = json['level'];
    hourlyRate = json['hourlyRate'];
    totalHours = json['totalHours'];
    totalSalary = json['totalSalary'];
    currentMonthHours = json['currentMonthHours'];
    currentMonthSalary = json['currentMonthSalary'];
    uId = json['uId'];
    phone = json['phone'];
    fname = json['fname'];
    lname = json['lname'];
    image = json['image'];
    token = json['token'];
    pid = json['pid'];
    branches = json['branches'] != null ? List<String>.from(json['branches']) : null;
    numberOfSessions = json['numberOfSessions'];
    date = json['date'];
    password = json['password'];

  }

  Map<String, dynamic> toJson() {

    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['role'] = this.role;
    data['name'] = this.name;
    data['email'] = this.email;
    data['level'] = this.level;
    data['hourlyRate'] = this.hourlyRate;
    data['totalHours'] = this.totalHours;
    data['totalSalary'] = this.totalSalary;
    data['currentMonthHours'] = this.currentMonthHours;
    data['currentMonthSalary'] = this.currentMonthSalary;
    data['uId'] = this.uId;
    data['phone'] = this.phone;
    data['fname'] = this.fname;
    data['lname'] = this.lname;
    data['image'] = this.image;
    data['token'] = this.token;
    data['branches'] = this.branches;
    data['pid'] = this.pid;
    data['numberOfSessions'] = this.numberOfSessions;
    data['date'] = this.date;
    data['password'] = this.password;

    return data;

  }

  Map<String, dynamic> toMap() {
    return {
      'role': role,
      'name': name,
      'email': email,
      'level': level,
      'hourlyRate': hourlyRate,
      'totalHours': totalHours,
      'totalSalary': totalSalary,
      'currentMonthHours': currentMonthHours,
      'currentMonthSalary': currentMonthSalary,
      'uId': uId,
      'phone': phone,
      'fname': fname,
      'lname': lname,
      'image': image,
      'token': token,
      'branches': branches,
      'pid': pid,
      'numberOfSessions': numberOfSessions,
      'date': date,
      'password': password,
    };

  }
}



