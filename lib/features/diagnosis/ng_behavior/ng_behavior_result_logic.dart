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
      ..sort((a, b) => b.percentage.compareTo(a.percentage));

    final improvements = _getImprovements(catScores);

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

  static String _getSimpleComment(String resultType) {
    switch (resultType) {
      case 'stable':
        return '関わりは安定しています。このまま継続していきましょう。';
      case 'mild':
        return '一部に改善の余地があります。余裕がない時の対応を少し見直しましょう。';
      case 'review':
        return '関わりに偏りがあります。まずは話をじっくり聞く時間を意識してみましょう。';
      case 'urgent':
        return '余裕のなさが影響している可能性があります。焦らず、小さな改善から始めましょう。';
      default:
        return '';
    }
  }

  static String _getDetailComment(String resultType) {
    switch (resultType) {
      case 'stable':
        return '日々の関わりは安定している傾向があります。子どもとの関係を大切にしながら、このペースを続けていきましょう。定期的に振り返ることで、さらに良い関わりにつなげられます。';
      case 'mild':
        return '一部の場面で改善の余地がある傾向があります。特に余裕のない時に出やすいパターンを意識するだけで、関係が変わってくることがあります。少しずつ取り組んでいきましょう。';
      case 'review':
        return '関わりに偏りがある傾向があります。特定の場面で同じパターンが出やすいことがあります。まずは「最後まで聞く」ことを意識するだけでも、子どもとの関係に変化が生まれやすくなります。';
      case 'urgent':
        return '余裕のなさが関わり方に影響している可能性があります。まず親自身が少し楽になることが大切です。完璧な親でなくて大丈夫です。叱ってしまっても「さっきはごめんね」と修復できれば、関係は回復していきます。必要に応じて専門機関への相談も選択肢の一つです。';
      default:
        return '';
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
}

class _CategoryInfo {
  final String label;
  final int maxScore;
  final String advice;

  const _CategoryInfo({required this.label, required this.maxScore, required this.advice});
}
