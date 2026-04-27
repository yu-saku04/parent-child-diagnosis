import '../../../models/diagnosis_result.dart';
import '../../../models/result_detail.dart';

class StressResultLogic {
  static const _categories = {
    'physical': _CategoryInfo(
      label: '身体的疲労',
      maxScore: 9,
      advice: '睡眠と休息を最優先にしましょう。家事のハードルを下げ、子どもの昼寝中に一緒に横になるなど、5〜10分の小さな休息を積み重ねることが効果的です。',
    ),
    'emotional': _CategoryInfo(
      label: '感情・気分の不安定さ',
      maxScore: 9,
      advice: '感情を紙に書き出したり、信頼できる人に話すだけで気持ちが軽くなることがあります。「完璧にやらない日」を週に一日つくるのもおすすめです。',
    ),
    'isolation': _CategoryInfo(
      label: '孤立感・サポート不足',
      maxScore: 9,
      advice: '地域の子育て支援センターや同じ境遇の親のコミュニティを活用しましょう。パートナーや家族に「具体的に何が大変か」を一つだけ伝えてみることも大切です。',
    ),
    'pressure': _CategoryInfo(
      label: '子育てプレッシャー',
      maxScore: 9,
      advice: '「良い親でなければ」という気持ちは自然なことです。叱ってしまった後に「さっきはごめんね」と伝えるだけで、関係は修復できます。今日一緒にいた、それだけで十分です。',
    ),
    'selfcare': _CategoryInfo(
      label: '自己ケア不足',
      maxScore: 9,
      advice: '1日5分でも「自分のための時間」をつくりましょう。好きな飲み物を飲む、音楽を聴くなど小さなことで構いません。親が整うと、子どもへの関わりも自然と変わります。',
    ),
  };

  static const _simpleCommentPatterns = {
    'stable': [
      'ストレスは比較的低い状態です。今のペースを大切にしながら、自分を労わることも忘れずに。',
      '心身のバランスが保てている状態です。小さな積み重ねが効いているのかもしれません。',
      '良い状態を維持できています。今後も自分のコンディションに目を向けていきましょう。',
    ],
    'mild': [
      'ストレスが少しずつ溜まってきているようです。小さな休息をこまめに取り入れることで、だいぶ楽になるかもしれません。',
      '疲れが積み重なりつつある段階です。意識的に休む時間をつくってみましょう。',
      '少し無理をしているかもしれません。「頑張りすぎない」ことを意識してみてください。',
    ],
    'high': [
      'ストレスがかなり高まっています。一人で抱え込まず、誰かに頼ることを意識してみてください。',
      '心身への負担が大きい状態かもしれません。まず一つだけでも「手を抜いていいこと」を見つけましょう。',
      '限界に近いサインが出ているかもしれません。少し休む許可を自分に与えてください。',
    ],
    'critical': [
      '心身ともに限界に近い可能性があります。完璧を目指さなくて大丈夫です。まず休むことを最優先にしましょう。',
      '今がとても大変な時期かもしれません。助けを求めることも立派な選択です。一人で頑張ろうとしなくて大丈夫です。',
      '体と心が限界を訴えているかもしれません。専門機関への相談も含め、サポートを求める選択肢を考えてみましょう。',
    ],
  };

  static const _detailCommentPatterns = {
    'stable': [
      '現在のストレス傾向は比較的低い状態です。日々の小さな工夫が実を結んでいるかもしれません。このペースを大切にしながら、定期的に自分の状態を振り返ることをおすすめします。',
      '心身ともに安定した状態が続いています。これは決して当たり前のことではありません。自分を労う時間も意識的につくりながら、良いコンディションを保っていきましょう。',
    ],
    'mild': [
      'ストレスが蓄積しつつある傾向があります。今は大丈夫でも、気づかないうちに疲れが積み重なることがあります。小さな休息を意識的にとり、一人で抱え込まないことが大切です。',
      '少しずつ疲れが溜まってきているようです。「これくらい大丈夫」と思いがちな時期ですが、早めに手を打つことが大切です。今日から一つだけ、休める時間を意識してつくってみましょう。',
    ],
    'high': [
      'ストレスがかなり高まっている傾向があります。心身のバランスが崩れやすい状態かもしれません。完璧な親である必要はありません。できることから少しずつ、負担を減らしていきましょう。',
      'かなり無理をしている状態かもしれません。「やらないこと」を決めることも大切なスキルです。周囲に一つだけお願いすることから始めてみましょう。',
    ],
    'critical': [
      '心身ともに限界に近い可能性があります。この状態が続くと、体や心に影響が出てくることがあります。一人で解決しようとせず、周囲の人や専門機関に相談することも大切な選択肢です。',
      '今、本当につらい状態にあるかもしれません。それでも毎日子どもに向き合っているあなたは十分に頑張っています。今すぐ全部を解決しなくて大丈夫です。まず誰かに気持ちを話すことから始めましょう。',
    ],
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
    final simpleComment = _pickPattern(_simpleCommentPatterns[resultType], total);
    final detailComment = _pickPattern(_detailCommentPatterns[resultType], total);

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
    final goodPoints = _getGoodPoints(catScores);

    return ResultDetail(
      resultType: resultType,
      typeLabel: typeLabel,
      simpleComment: simpleComment,
      detailComment: detailComment,
      categoryScores: categoryScores,
      improvements: improvements,
      goodPoints: goodPoints,
      aiAdvice: '',
    );
  }

  static String _pickPattern(List<String>? patterns, int seed) {
    if (patterns == null || patterns.isEmpty) return '';
    return patterns[seed % patterns.length];
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

  static List<String> _getGoodPoints(Map<String, int> catScores) {
    final goodPoints = <String>[];

    if ((catScores['physical'] ?? 0) <= 2) {
      goodPoints.add('身体の疲労が比較的少ない状態です');
    }
    if ((catScores['emotional'] ?? 0) <= 2) {
      goodPoints.add('感情が安定している状態です');
    }
    if ((catScores['isolation'] ?? 0) <= 2) {
      goodPoints.add('サポートを受けられている環境にいます');
    }
    if ((catScores['pressure'] ?? 0) <= 2) {
      goodPoints.add('子育てのプレッシャーを適切に扱えています');
    }
    if ((catScores['selfcare'] ?? 0) <= 2) {
      goodPoints.add('自分のことも大切にできています');
    }

    return goodPoints.isEmpty
        ? ['この診断を受けること自体が自分を大切にする行動です']
        : goodPoints;
  }
}

class _CategoryInfo {
  final String label;
  final int maxScore;
  final String advice;

  const _CategoryInfo({required this.label, required this.maxScore, required this.advice});
}
