//RegisterModel class which parse this json using json_serializable
// {"status":"success","id":"2"}
import 'package:json_annotation/json_annotation.dart';
part 'register_model.g.dart';

@JsonSerializable()
class RegisterModel {
  // {
  // "status": true,
  // "message": "تم تسجيل الدخول بنجاح",
  // "data": {
  // "id": 22255,
  // "name": "ahmed hossam",
  // "email": "ahemd@gmail.com",
  // "phone": "178878778",
  // "image": "https://student.valuxapps.com/storage/uploads/users/lWZwvcyMmi_1667469843.jpeg",
  // "points": 0,
  // "credit": 0,
  // "token": "LC5BeJJE7ePZ4D27p1Af8CvyiN1NmpwLWUKa8F7HIElrBpIsur6TybGWUXHBHz8VEKoWzs"
  // }
  // }
  //parse json to RegisterModel class using json_serializable
  bool? status;
  String? message;
  Data data;
  RegisterModel({
    required this.status,
    required this.message,
    required this.data,
  });
  factory RegisterModel.fromJson(Map<String, dynamic> json) =>
      _$RegisterModelFromJson(json);
  Map<String, dynamic> toJson() => _$RegisterModelToJson(this);
}
@JsonSerializable()
class Data {
  int? id;
  String? name;
  String? email;
  String? phone;
  String? image;
  int? points;
  int? credit;
  String? token;
  Data({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.image,
    required this.points,
    required this.credit,
    required this.token,
  });
  factory Data.fromJson(Map<String, dynamic> json) =>
      _$DataFromJson(json);
  Map<String, dynamic> toJson() => _$DataToJson(this);


}


