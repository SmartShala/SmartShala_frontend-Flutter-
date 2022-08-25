class ResultModel {
  final int id;
  final String status;
  final int score;

  const ResultModel({
    required this.id,
    required this.status,
    required this.score,
  });

  factory ResultModel.fromJson(Map<String, dynamic> json) {
    return ResultModel(
      id: json['id'] as int,
      status: json['status'] as String,
      score: json['score'] as int,
    );
  }
}
