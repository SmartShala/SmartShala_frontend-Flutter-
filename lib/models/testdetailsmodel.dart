// Serializable model to hold the test details

// ---------------  TEST REQUEST MODEL  ---------------- //
import 'dart:convert';

TestDetailsRequestModel testDetailsModelFromJson(String str) =>
    TestDetailsRequestModel.fromJson(json.decode(str));

String testDetailsModelToJson(TestDetailsRequestModel data) =>
    json.encode(data.toJson());

class TestDetailsRequestModel {
  TestDetailsRequestModel({
    required this.name,
    required this.description,
    required this.topic,
    required this.standard,
    required this.subject,
  });

  String name;
  String description;
  String topic;
  int standard;
  int subject;

  factory TestDetailsRequestModel.fromJson(Map<String, dynamic> json) =>
      TestDetailsRequestModel(
        name: json["name"],
        description: json["description"],
        topic: json["topic"],
        standard: json["standard"],
        subject: json["subject"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "description": description,
        "topic": topic,
        "standard": standard,
        "subject": subject,
      };
}

// ---------------  TEST RESPONSE MODEL  ---------------- //

TestDetailsResponseModel testDetailsResponseModelFromJson(String str) =>
    TestDetailsResponseModel.fromJson(json.decode(str));

String testDetailsResponseModelToJson(TestDetailsResponseModel data) =>
    json.encode(data.toJson());

class TestDetailsResponseModel {
  TestDetailsResponseModel({
    this.testId,
    this.name,
    this.description,
    this.updatedAt,
  });

  int? testId;
  String? name;
  String? description;
  DateTime? updatedAt;

  factory TestDetailsResponseModel.fromJson(Map<String, dynamic> json) =>
      TestDetailsResponseModel(
        testId: json["id"] as int,
        name: json["name"] as String,
        description: json["description"] as String,
        updatedAt: json["updated_at"] != null
            ? DateTime.parse(json["updated_at"])
            : null,
      );

  Map<String, dynamic> toJson() => {
        "id": testId,
        "name": name,
        "description": description,
        "updated_at": updatedAt?.toIso8601String() ?? "",
      };
}
