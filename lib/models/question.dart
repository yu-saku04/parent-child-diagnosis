class Choice {
  final String label;
  final int score;
  final String? typeKey;

  const Choice({required this.label, required this.score, this.typeKey});
}

class Question {
  final String id;
  final String text;
  final List<Choice> choices;
  final String? category;

  const Question({
    required this.id,
    required this.text,
    required this.choices,
    this.category,
  });
}
