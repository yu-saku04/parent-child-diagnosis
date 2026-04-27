class AnswerRecord {
  final String questionId;
  final String selectedLabel;
  final int score;
  final String? typeKey;
  final String? category;

  const AnswerRecord({
    required this.questionId,
    required this.selectedLabel,
    required this.score,
    this.typeKey,
    this.category,
  });

  Map<String, dynamic> toJson() => {
        'questionId': questionId,
        'selectedLabel': selectedLabel,
        'score': score,
        'typeKey': typeKey,
        'category': category,
      };

  factory AnswerRecord.fromJson(Map<String, dynamic> json) => AnswerRecord(
        questionId: json['questionId'] as String,
        selectedLabel: json['selectedLabel'] as String,
        score: json['score'] as int,
        typeKey: json['typeKey'] as String?,
        category: json['category'] as String?,
      );
}

class DiagnosisResult {
  final String id;
  final String userId;
  final String diagnosisType;
  final int score;
  final int maxScore;
  final String resultType;
  final String typeLabel;
  final List<AnswerRecord> answers;
  final String simpleComment;
  final String detailComment;
  final String aiAdvice;
  final DateTime createdAt;

  DiagnosisResult({
    required this.id,
    required this.userId,
    required this.diagnosisType,
    required this.score,
    required this.maxScore,
    required this.resultType,
    required this.typeLabel,
    required this.answers,
    required this.simpleComment,
    required this.detailComment,
    required this.aiAdvice,
    required this.createdAt,
  });

  int get scorePercentage =>
      maxScore > 0 ? ((score / maxScore) * 100).round().clamp(0, 100) : 0;

  Map<String, dynamic> toJson() => {
        'id': id,
        'userId': userId,
        'diagnosisType': diagnosisType,
        'score': score,
        'maxScore': maxScore,
        'resultType': resultType,
        'typeLabel': typeLabel,
        'answers': answers.map((a) => a.toJson()).toList(),
        'simpleComment': simpleComment,
        'detailComment': detailComment,
        'aiAdvice': aiAdvice,
        'createdAt': createdAt.toIso8601String(),
      };

  factory DiagnosisResult.fromJson(Map<String, dynamic> json) =>
      DiagnosisResult(
        id: json['id'] as String,
        userId: json['userId'] as String,
        diagnosisType: json['diagnosisType'] as String,
        score: json['score'] as int,
        maxScore: json['maxScore'] as int? ?? 45,
        resultType: json['resultType'] as String,
        typeLabel: json['typeLabel'] as String? ?? '',
        answers: (json['answers'] as List)
            .map((a) => AnswerRecord.fromJson(a as Map<String, dynamic>))
            .toList(),
        simpleComment: json['simpleComment'] as String,
        detailComment: json['detailComment'] as String,
        aiAdvice: json['aiAdvice'] as String,
        createdAt: DateTime.parse(json['createdAt'] as String),
      );
}
