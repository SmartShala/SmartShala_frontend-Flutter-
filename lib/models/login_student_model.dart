import 'dart:convert';

// ---------------  LOGIN RESPONSE MODEL  ---------------- //

LoginstudentResponseModel loginResponseModelFromJson(String str) =>
    LoginstudentResponseModel.fromJson(json.decode(str));

String loginstudentResponseModelToJson(LoginstudentResponseModel data) =>
    json.encode(data.toJson());

class LoginstudentResponseModel {
  LoginstudentResponseModel({
    required this.refresh,
    required this.access,
  });

  String refresh;
  String access;

  factory LoginstudentResponseModel.fromJson(Map<String, dynamic> json) =>
      LoginstudentResponseModel(
        refresh: json["refresh"],
        access: json["access"],
      );

  Map<String, dynamic> toJson() => {
        "refresh": refresh,
        "access": access,
      };
}

// ---------------  LOGIN REQUEST MODEL  ---------------- //

LoginstudentRequestModel loginRequestModelFromJson(String str) =>
    LoginstudentRequestModel.fromJson(json.decode(str));

String loginRequestModelToJson(LoginstudentRequestModel data) =>
    json.encode(data.toJson());

class LoginstudentRequestModel {
  LoginstudentRequestModel({
    required this.id,
  });

  int id;

  factory LoginstudentRequestModel.fromJson(Map<String, dynamic> json) =>
      LoginstudentRequestModel(
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
      };
}
