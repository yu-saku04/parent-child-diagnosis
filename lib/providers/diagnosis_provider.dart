import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';
import '../models/diagnosis_type.dart';
import '../models/question.dart';
import '../models/diagnosis_result.dart';
import '../models/result_detail.dart';
import '../features/diagnosis/stress/stress_questions.dart';
import '../features/diagnosis/stress/stress_result_logic.dart';
import '../features/diagnosis/talent/talent_questions.dart';
import '../features/diagnosis/talent/talent_result_logic.dart';
import '../features/diagnosis/ng_behavior/ng_behavior_questions.dart';
import '../features/diagnosis/ng_behavior/ng_behavior_result_logic.dart';
import '../services/ai_service.dart';

class DiagnosisProvider extends ChangeNotifier {
  static const _uuid = Uuid();
  final AiService _aiService = AiService();

  DiagnosisType? _currentType;
  List<Question> _questions = [];
  int _currentIndex = 0;
  final List<Choice?> _answers = [];
  DiagnosisResult? _lastResult;
  ResultDetail? _lastResultDetail;
  bool _isSaved = false;

  DiagnosisType? get currentType => _currentType;
  List<Question> get questions => _questions;
  int get currentIndex => _currentIndex;
  Question? get currentQuestion =>
      _currentIndex < _questions.length ? _questions[_currentIndex] : null;
  Choice? get currentAnswer =>
      _answers.isNotEmpty && _currentIndex < _answers.length
          ? _answers[_currentIndex]
          : null;
  int get totalQuestions => _questions.length;
  double get progress =>
      _questions.isEmpty ? 0 : _currentIndex / _questions.length;
  DiagnosisResult? get lastResult => _lastResult;
  ResultDetail? get lastResultDetail => _lastResultDetail;
  bool get isSaved => _isSaved;
  bool get isLastQuestion => _currentIndex == _questions.length - 1;

  void startDiagnosis(DiagnosisType type) {
    _currentType = type;
    _currentIndex = 0;
    _lastResult = null;
    _lastResultDetail = null;
    _isSaved = false;

    switch (type) {
      case DiagnosisType.stress:
        _questions = StressQuestions.questions;
        break;
      case DiagnosisType.talent:
        _questions = TalentQuestions.questions;
        break;
      case DiagnosisType.ngBehavior:
        _questions = NgBehaviorQuestions.questions;
        break;
    }

    _answers.clear();
    _answers.addAll(List.filled(_questions.length, null));
    notifyListeners();
  }

  void selectAnswer(Choice choice) {
    if (_currentIndex >= _answers.length) return;
    _answers[_currentIndex] = choice;
    notifyListeners();
  }

  bool goNext() {
    if (_answers[_currentIndex] == null) return false;
    if (_currentIndex < _questions.length - 1) {
      _currentIndex++;
      notifyListeners();
      return true;
    }
    return false;
  }

  bool goPrevious() {
    if (_currentIndex > 0) {
      _currentIndex--;
      notifyListeners();
      return true;
    }
    return false;
  }

  DiagnosisResult calculateResult(String userId, bool isPremium) {
    if (_currentType == null) throw StateError('No diagnosis started');

    final answers = _buildAnswerRecords();
    ResultDetail detail;

    switch (_currentType!) {
      case DiagnosisType.stress:
        detail = StressResultLogic.calculate(answers);
        break;
      case DiagnosisType.talent:
        detail = TalentResultLogic.calculate(answers);
        break;
      case DiagnosisType.ngBehavior:
        detail = NgBehaviorResultLogic.calculate(answers);
        break;
    }

    final aiAdvice = _aiService.generateAdvice(
      diagnosisType: _currentType!.storageKey,
      resultType: detail.resultType,
      isPremium: isPremium,
    );

    final totalScore = answers.fold<int>(0, (sum, a) => sum + a.score);
    final maxScore = _currentType == DiagnosisType.talent ? 20 : 45;

    final result = DiagnosisResult(
      id: _uuid.v4(),
      userId: userId,
      diagnosisType: _currentType!.storageKey,
      score: totalScore,
      maxScore: maxScore,
      resultType: detail.resultType,
      typeLabel: detail.typeLabel,
      answers: answers,
      simpleComment: detail.simpleComment,
      detailComment: detail.detailComment,
      aiAdvice: aiAdvice,
      createdAt: DateTime.now(),
    );

    _lastResult = result;
    _lastResultDetail = ResultDetail(
      resultType: detail.resultType,
      typeLabel: detail.typeLabel,
      simpleComment: detail.simpleComment,
      detailComment: detail.detailComment,
      categoryScores: detail.categoryScores,
      improvements: detail.improvements,
      aiAdvice: aiAdvice,
    );
    notifyListeners();
    return result;
  }

  List<AnswerRecord> _buildAnswerRecords() {
    final records = <AnswerRecord>[];
    for (int i = 0; i < _questions.length; i++) {
      final q = _questions[i];
      final choice = _answers[i];
      if (choice == null) continue;
      records.add(AnswerRecord(
        questionId: q.id,
        selectedLabel: choice.label,
        score: choice.score,
        typeKey: choice.typeKey,
        category: q.category,
      ));
    }
    return records;
  }

  void markSaved() {
    _isSaved = true;
    notifyListeners();
  }

  void reset() {
    _currentType = null;
    _questions = [];
    _currentIndex = 0;
    _answers.clear();
    _lastResult = null;
    _lastResultDetail = null;
    _isSaved = false;
    notifyListeners();
  }
}
