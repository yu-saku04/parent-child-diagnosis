import '../../../models/diagnosis_result.dart';
import '../../../models/result_detail.dart';

class StressResultLogic {
  static const _categories = {
    'physical': _CategoryInfo(label: '身体的疲労', maxScore: 9, advice: '睡眠と休息を最優先にしましょう。「少し横になる」だけでも体は回復します。家事や育児のハードルを下げることも大切です。'),
    'emotional': _CategoryInfo(label: '感情・気分の不安定さ', maxScore: 9, advice: '感情を抱え込まず、書き出したり声に出して話す機会をつくりましょう。感情が揺れることは自然なことです。'),
    'isolation': _CategoryInfo(label: '孤立感・サポート不足', maxScore: 9, advice: '一人で抱え込まずに相談しましょう。地域の子育て支援センターやオンラインの親コミュニティも活用できます。'),
    'pressure': _CategoryInfo(label: '子育てプレッシャー', maxScore: 9, advice: '「完璧な親」は存在しません。失敗しても後から修復できます。「今日も一緒にいた」それだけで十分です。'),
    'selfcare': _CategoryInfo(label: '自己ケア不足', maxScore: 9, advice: '1日5分でも自分のための時間をつくりましょう。親が整うことで、子どもへの関わりも自然と変わってきます。'),
  };

  static ResultDetail calculate(List<AnswerRecord> answers) {
    final catScores = <String, int>{
      'physical': 0,
      'emotional': 0,
      'isolation': 0,
      'pressure': 0,
      'selfcare': 0,
    };

    int total = 0;
    for (final a in answers) {
      total += a.score;
      if (a.category != null && catScores.containsKey(a.category)) {
        catScores[a.category!] = catScores[a.category!]! + a.score;
      }
    }

    final resultType = _getResultType(total);
    final typeLabel = _getTypeLabel(resultType);
    final simpleComment = _getSimpleComment(resultType);
    final detailComment = _getDetailComment(resultType);

    final categoryScores = catScores.entries.map((e) {
      final info = _categories[e.key]!;
      return CategoryScore(
        key: e.key,
        label: info.label,
        score: e.value,
        maxScore: info.maxScore,
        advice: info.advice,
      );
    }).toList()
      ..sort((a, b) => b.score.compareTo(a.score));

    final improvements = _getImprovements(resultType, catScores);

    return ResultDetail(
      resultType: resultType,
      typeLabel: typeLabel,
      simpleComment: simpleComment,
      detailComment: detailComment,
      categoryScores: categoryScores,
      improvements: improvements,
      aiAdvice: '',
    );
  }

  static String _getResultType(int total) {
    if (total <= 10) return 'stable';
    if (total <= 22) return 'mild';
    if (total <= 34) return 'high';
    return 'critical';
  }

  static String _getTypeLabel(String resultType) {
    switch (resultType) {
      case 'stable': return '安定状態';
      case 'mild': return 'やや蓄積中';
      case 'high': return 'ストレス高め';
      case 'critical': return '要注意';
      default: return '－';
    }
  }

  static String _getSimpleComment(String resultType) {
    switch (resultType) {
      case 'stable':
        return 'ストレスは比較的低い状態です。今のペースを大切にしながら、自分を労わることも忘れずに。';
      case 'mild':
        return 'ストレスが少しずつ溜まってきているようです。小さな休息をこまめに取り入れることで、だいぶ楽になるかもしれません。';
      case 'high':
        return 'ストレスがかなり高まっています。一人で抱え込まず、誰かに頼ることを意識してみてください。';
      case 'critical':
        return '心身ともに限界に近い可能性があります。完璧を目指さなくて大丈夫です。まず休むことを最優先にしましょう。';
      default:
        return '';
    }
  }

  static String _getDetailComment(String resultType) {
    switch (resultType) {
      case 'stable':
        return '現在のストレス傾向は比較的低い状態です。日々の小さな工夫が実を結んでいるかもしれません。このペースを大切にしながら、定期的に自分の状態を振り返ることをおすすめします。';
      case 'mild':
        return 'ストレスが蓄積しつつある傾向があります。今は大丈夫でも、気づかないうちに疲れが積み重なることがあります。小さな休息を意識的にとり、一人で抱え込まないことが大切です。';
      case 'high':
        return 'ストレスがかなり高まっている傾向があります。心身のバランスが崩れやすい状態かもしれません。完璧な親である必要はありません。できることから少しずつ、負担を減らしていきましょう。';
      case 'critical':
        return '心身ともに限界に近い可能性があります。この状態が続くと、体や心に影響が出てくることがあります。一人で解決しようとせず、周囲の人や専門機関に相談することも大切な選択肢です。必要に応じて専門機関への相談をご検討ください。';
      default:
        return '';
    }
  }

  static List<String> _getImprovements(String resultType, Map<String, int> catScores) {
    final improvements = <String>[];
    final sorted = catScores.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));

    for (final entry in sorted.take(3)) {
      if (entry.value > 0 && _categories.containsKey(entry.key)) {
        improvements.add('【${_categories[entry.key]!.label}】${_categories[entry.key]!.advice}');
      }
    }

    if (improvements.isEmpty) {
      improvements.add('今の状態を続けていきましょう。定期的なチェックで心の健康を維持できます。');
    }

    return improvements;
  }
}

class _CategoryInfo {
  final String label;
  final int maxScore;
  final String advice;

  const _CategoryInfo({required this.label, required this.maxScore, required this.advice});
}
