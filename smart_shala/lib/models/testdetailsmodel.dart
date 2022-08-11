// Serializable model to hold the test details

class TestDetailsModel {
  final String name;
  final String desc;
  final int year;
  final String sec;
  final String topic;

  const TestDetailsModel({
    required this.name,
    required this.desc,
    required this.year,
    required this.sec,
    required this.topic,
  });

  factory TestDetailsModel.fromJson(Map<String, dynamic> json) {
    return TestDetailsModel(
        name: json['name'] as String,
        desc: json['desc'] as String,
        year: json['year'] as int,
        sec: json['sec'] as String,
        topic: json['topic'] as String);
  }
  
  Map<String, dynamic> toJson() => {
    'name': name,
    'desc': desc,
    'year': year,
    'sec': sec,
    'topic': topic,
  };
}
