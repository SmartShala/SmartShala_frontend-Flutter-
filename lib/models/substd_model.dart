import 'dart:convert';

SubAndStdModel subAndStdModelFromJson(String str) =>
    SubAndStdModel.fromJson(json.decode(str));

String subAndStdModelToJson(SubAndStdModel data) => json.encode(data.toJson());

class SubAndStdModel {
  SubAndStdModel({
    required this.standards,
    required this.subjects,
  });

  List<List<int>> standards;
  List<List<dynamic>> subjects;

  factory SubAndStdModel.fromJson(Map<String, dynamic> json) => SubAndStdModel(
        standards: List<List<int>>.from(
            json["standards"].map((x) => List<int>.from(x.map((x) => x)))),
        subjects: List<List<dynamic>>.from(
            json["subjects"].map((x) => List<dynamic>.from(x.map((x) => x)))),
      );

  Map<String, dynamic> toJson() => {
        "standards": List<dynamic>.from(
            standards.map((x) => List<dynamic>.from(x.map((x) => x)))),
        "subjects": List<dynamic>.from(
            subjects.map((x) => List<dynamic>.from(x.map((x) => x)))),
      };
}
