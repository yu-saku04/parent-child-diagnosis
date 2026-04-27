import '../../../models/diagnosis_result.dart';
import '../../../models/result_detail.dart';

class NgBehaviorResultLogic {
  static const _categories = {
    'anticipation': _CategoryInfo(
      label: '先回り・過干渉',
      maxScore: 12,
      advice: '「どうしたい？」と一声かけてみましょう。子どもの意思を先に聞くだけで、関係が変わっていきます。',
    ),
    'interrupting': _CategoryInfo(
      label: '話を遮る',
      maxScore: 9,
      advice: '最後まで聞くだけで、子どもの安心感が変わります。解決策より共感を先にしてみましょう。',
    ),
    'scolding': _CategoryInfo(
      label: '否定・叱責',
      maxScore: 9,
      advice: '行動だけを指摘し、人格は否定しないよう意識しましょう。「〇〇はやめて」より「〇〇してみよう」という言い換えが効果的です。',
    ),
    'results': _CategoryInfo(
      label: '結果・比較',
      maxScore: 9,
      advice: '結果より過程を見て、「頑張ったね」を大切に。他の子との比較は自己肯定感に影響することがあります。',
    ),
    'emotion': _CategoryInfo(
      label: '感情反応',
      maxScore: 6,
      advice: '感情的になることは誰にでもあります。後から「さっきはごめんね」と修復できれば十分です。',
    ),
  };

  static const _simpleCommentPatterns = {
    'stable': [
      '子どもとの関わりが安定しています。このままのペースを大切にしていきましょう。',
      '日々の関わりにバランスが取れています。これからも今の接し方を続けてください。',
      '関わり方に余裕が感じられます。小さな工夫が積み重なっているのかもしれません。',
    ],
    'mild': [
      '一部に改善の余地があります。余裕がないときの対応を少し意識してみましょう。',
      'ほとんどの関わりは適切です。いくつかの場面で少し工夫できるかもしれません。',
      '大枠は安定していますが、疲れているときに出やすいパターンが見られます。',
    ],
    'review': [
      '関わりに偏りがある傾向があります。スコアの高いカテゴリから一つだけ見直してみましょう。',
      '特定の場面でパターンが出やすいかもしれません。まずは一つだけ変えてみましょう。',
      '気になるポイントがあります。完璧を目指さず、一歩ずつ取り組んでいきましょう。',
    ],
    'urgent': [
      '余裕のなさが関わり方に影響している可能性があります。焦らず、小さな改善から始めましょう。',
      '親自身が疲れているサインかもしれません。まずは自分を休めることを最優先にしてください。',
      '今は難しい時期かもしれません。一人で抱え込まず、周囲のサポートを求めてみましょう。',
    ],
  };

  static const _detailCommentPatterns = {
    'stable': [
      '日々の関わりは安定している傾向があります。子どもとの関係を大切にしながら、このペースを続けていきましょう。定期的に振り返ることで、さらに良い関わりにつなげられます。',
      '全体的にバランスの取れた関わりができています。ストレスが高い日でも崩れにくいペースが身についているのかもしれません。引き続き、子どもの気持ちに寄り添い続けてください。',
    ],
    'mild': [
      '一部の場面で改善の余地がある傾向があります。特に余裕のない時に出やすいパターンを意識するだけで、関係が変わってくることがあります。少しずつ取り組んでいきましょう。',
      '概ね安定した関わりができていますが、疲れているときや忙しいときに出やすいパターンがあるようです。「今日は余裕がない」と気づいたときだけ、一つだけ意識してみてください。',
    ],
    'review': [
      '関わりに偏りがある傾向があります。特定の場面で同じパターンが出やすいことがあります。まずは「最後まで聞く」ことを意識するだけでも、子どもとの関係に変化が生まれやすくなります。',
      '気になるカテゴリがいくつかあります。一度に全部を変えようとするより、「今週はこれだけ」と一つに絞って取り組む方が続きやすいです。',
    ],
    'urgent': [
      '余裕のなさが関わり方に影響している可能性があります。まず親自身が少し楽になることが大切です。完璧な親でなくて大丈夫です。叱ってしまっても「さっきはごめんね」と修復できれば、関係は回復していきます。',
      '今、親自身がとても大変な状況にあるのかもしれません。子どもへの関わりを変えようとする前に、まず自分を休ませてください。必要に応じて専門機関への相談も大切な選択肢です。',
    ],
  };

  static ResultDetail calculate(List<AnswerRecord> answers) {
    final catScores = <String, int>{
      'anticipation': 0,
      'interrupting': 0,
      'scolding': 0,
      'results': 0,
      'emotion': 0,
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
      ..sort((a, b) => b.percentage.compareTo(a.percentage));

    final improvements = _getImprovements(catScores);
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
    if (total <= 34) return 'review';
    return 'urgent';
  }

  static String _getTypeLabel(String resultType) {
    switch (resultType) {
      case 'stable': return '安定した関わり';
      case 'mild': return '見直しポイントあり';
      case 'review': return '偏りあり';
      case 'urgent': return '要見直し';
      default: return '－';
    }
  }

  static List<String> _getImprovements(Map<String, int> catScores) {
    final improvements = <String>[];
    final sorted = catScores.entries.toList()
      ..sort((a, b) {
        final infoA = _categories[a.key]!;
        final infoB = _categories[b.key]!;
        final pctA = infoA.maxScore > 0 ? a.value / infoA.maxScore : 0;
        final pctB = infoB.maxScore > 0 ? b.value / infoB.maxScore : 0;
        return pctB.compareTo(pctA);
      });

    for (final entry in sorted.take(3)) {
      if (entry.value > 0 && _categories.containsKey(entry.key)) {
        improvements.add('【${_categories[entry.key]!.label}】${_categories[entry.key]!.advice}');
      }
    }

    if (improvements.isEmpty) {
      improvements.add('今の関わりをそのまま続けていきましょう。定期的なチェックで良い状態を維持できます。');
    }

    return improvements;
  }

  static List<String> _getGoodPoints(Map<String, int> catScores) {
    final goodPoints = <String>[];

    if ((catScores['anticipation'] ?? 0) <= 3) {
      goodPoints.add('先回りせず、子どもの意思を尊重できています');
    }
    if ((catScores['interrupting'] ?? 0) <= 2) {
      goodPoints.add('子どもの話をしっかり聞けています');
    }
    if ((catScores['scolding'] ?? 0) <= 2) {
      goodPoints.add('否定的な言葉を控えられています');
    }
    if ((catScores['results'] ?? 0) <= 2) {
      goodPoints.add('プロセスを大切にした関わりができています');
    }
    if ((catScores['emotion'] ?? 0) <= 1) {
      goodPoints.add('感情的になることが少なく、安定した対応ができています');
    }

    return goodPoints.isEmpty
        ? ['この診断に向き合っていること自体、素晴らしい一歩です']
        : goodPoints;
  }
}

class _CategoryInfo {
  final String label;
  final int maxScore;
  final String advice;

  const _CategoryInfo({required this.label, required this.maxScore, required this.advice});
}
