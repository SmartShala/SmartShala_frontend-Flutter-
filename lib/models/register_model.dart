import 'dart:convert';

// ---------------  REGISTER REQUEST MODEL  ---------------- //

RegisterRequestModel registerRequestModelFromJson(String str) =>
    RegisterRequestModel.fromJson(json.decode(str));

String registerRequestModelToJson(RegisterRequestModel data) =>
    json.encode(data.toJson());

class RegisterRequestModel {
  RegisterRequestModel({
    required this.name,
    required this.email,
    this.contact,
    this.teacherId,
    required this.password,
  });

  String name;
  String email;
  int? contact;
  String? teacherId;
  String password;

  factory RegisterRequestModel.fromJson(Map<String, dynamic> json) =>
      RegisterRequestModel(
        name: json["name"],
        email: json["email"],
    contact: json["contact"],
        teacherId: json["teacher_id"],
          password: json["password"],
      );

    Map<String, dynamic> toJson() => {
        "name": name,
      "email": email,
        "contact": contact,
        "teacher_id": teacherId,
        "password": password,
    };
}
    
// ---------------  REGISTER RESPONSE MODEL  ---------------- //

RegisterResponseModel registerResponseModelFromJson(String str) =>
    RegisterResponseModel.fromJson(json.decode(str));

String registerResponseModelToJson(RegisterResponseModel data) =>
    json.encode(data.toJson());

class RegisterResponseModel {
  RegisterResponseModel({
    this.id,
    this.name,
    this.email,
    this.contact,
    this.teacherId,
    this.password,
  });

  String? id;
  String? name;
  String? email;
  int? contact;
  String? teacherId;
  String? password;

  factory RegisterResponseModel.fromJson(Map<String, dynamic> json) =>
      RegisterResponseModel(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        contact: json["contact"],
        teacherId: json["teacher_id"],
        password: json["password"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "contact": contact,
        "teacher_id": teacherId,
        "password": password,
      };
}
