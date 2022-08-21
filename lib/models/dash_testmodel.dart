
class DashTestModel {
  final int testid;
  final String subject;
  final int forClass;
  final String topic;

  const DashTestModel({
    required this.testid,
    required this.subject,
    required this.forClass,
    required this.topic,
  });

  factory DashTestModel.fromJson(Map<String, dynamic> json) {
    return DashTestModel(
      testid: json['id'] as int,
      subject: json['name'] as String,
      forClass: json['standard'] as int,
      topic: json['description'] as String,
    );
  }
}
