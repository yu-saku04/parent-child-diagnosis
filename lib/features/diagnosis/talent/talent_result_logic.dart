import '../../../models/diagnosis_result.dart';
import '../../../models/result_detail.dart';

class TalentResultLogic {
  static const _typeData = {
    'logical': _TypeData(
      typeName: 'じっくり考える探究タイプ',
      label: '論理型',
      description: '物事の仕組みや理由に関心を持ちやすいタイプです。納得できると集中力を発揮し、深く考える力が伸びやすい傾向があります。',
      strengths: ['観察力がある', '理由を考える力がある', '集中して取り組みやすい'],
      ngBehaviors: ['「いいから早くして」と急かす', '理由を説明せずに指示する', '質問を面倒がる'],
      goodPhrases: ['どうしてそう思ったの？', 'どこが面白かった？', '一緒に理由を考えてみよう'],
      dailyAdvice: '結果だけでなく、考えた過程をほめましょう。質問が多いときは、すぐ答えを出さず一緒に考える時間をつくることが大切です。',
    ),
    'emotional': _TypeData(
      typeName: '気持ちを感じ取る共感タイプ',
      label: '感情型',
      description: '人の表情や雰囲気、気持ちに反応しやすいタイプです。安心できる関係の中で、表現力や共感力が伸びやすい傾向があります。',
      strengths: ['共感力がある', '表現が豊か', '人との関係を大切にしやすい'],
      ngBehaviors: ['泣くことを否定する', '感情を軽く扱う', '結果だけで評価する'],
      goodPhrases: ['悲しかったんだね', 'そう感じたんだね', '気持ちを教えてくれてありがとう'],
      dailyAdvice: 'まず気持ちを受け止めてから、次の行動を一緒に考えましょう。感情を否定せず、言葉にする練習を支えることが大切です。',
    ),
    'active': _TypeData(
      typeName: 'まずやってみる挑戦タイプ',
      label: '行動型',
      description: '考える前に動きながら学ぶことが得意なタイプです。体験を通じて理解し、挑戦する中で力を伸ばしやすい傾向があります。',
      strengths: ['行動力がある', '挑戦を楽しめる', '体験から学びやすい'],
      ngBehaviors: ['長く説明しすぎる', '動きたい気持ちを押さえつける', '失敗を強く叱る'],
      goodPhrases: ['まず一回やってみよう', 'やってみて何がわかった？', '次はどうしたらうまくいきそう？'],
      dailyAdvice: '説明を短くし、体験の中で学ばせましょう。失敗した後に責めるのではなく、次の工夫につなげることが大切です。',
    ),
    'stable': _TypeData(
      typeName: '安心して伸びる継続タイプ',
      label: '安定型',
      description: '安心できる環境や見通しがあると力を発揮しやすいタイプです。同じことを繰り返す中で、着実に成長しやすい傾向があります。',
      strengths: ['継続力がある', '丁寧に取り組める', '安心できる環境で力を発揮しやすい'],
      ngBehaviors: ['いきなり新しいことをさせる', '慎重さを責める', '他の子と比べる'],
      goodPhrases: ['ゆっくりで大丈夫', 'いつもの流れでやってみよう', '少しずつ慣れていこう'],
      dailyAdvice: '事前に予定や流れを伝えるようにしましょう。小さな成功体験を積み重ねて、自信につなげることが大切です。',
    ),
    'balance': _TypeData(
      typeName: '場面に合わせて力を出すバランスタイプ',
      label: 'バランス型',
      description: '一つの傾向に偏りすぎず、場面によってさまざまな強みが出やすいタイプです。環境や関わる人によって多様な力を発揮しやすい傾向があります。',
      strengths: ['柔軟性がある', '複数の力を持っている', '環境に合わせて変化しやすい'],
      ngBehaviors: ['一つのタイプに決めつける', 'その日の様子だけで判断する', '比較して評価する'],
      goodPhrases: ['今日はどんな感じだった？', 'どれが一番やりやすかった？', 'いろいろ試してみよう'],
      dailyAdvice: '複数の経験をさせながら、子どもが自然に力を発揮する場面を観察しましょう。親が決めつけすぎず、得意が出る環境を探していきましょう。',
    ),
  };

  static const _typeLabels = {
    'logical': '論理型',
    'emotional': '感情型',
    'active': '行動型',
    'stable': '安定型',
    'balance': 'バランス型',
  };

  static ResultDetail calculate(List<AnswerRecord> answers) {
    final typeCount = <String, int>{
      'logical': 0,
      'emotional': 0,
      'active': 0,
      'stable': 0,
    };

    for (final a in answers) {
      if (a.typeKey != null && typeCount.containsKey(a.typeKey)) {
        typeCount[a.typeKey!] = typeCount[a.typeKey!]! + 1;
      }
    }

    final dominantType = _getDominantType(typeCount, answers);
    final data = _typeData[dominantType]!;

    final categoryScores = typeCount.entries.map((e) {
      return CategoryScore(
        key: e.key,
        label: _typeLabels[e.key] ?? e.key,
        score: e.value,
        maxScore: answers.length,
        advice: _typeData[e.key]?.dailyAdvice ?? '',
      );
    }).toList()
      ..sort((a, b) => b.score.compareTo(a.score));

    final simpleComment = '${data.typeName}の傾向があります。${data.description}';
    final detailComment = _buildDetailComment(data, typeCount, answers.length);
    final improvements = [
      ...data.ngBehaviors.map((n) => '避けたい関わり方：$n'),
      '今日からできること：${data.dailyAdvice}',
    ];

    final goodPoints = _getGoodPoints(data);

    return ResultDetail(
      resultType: dominantType,
      typeLabel: data.label,
      simpleComment: simpleComment,
      detailComment: detailComment,
      categoryScores: categoryScores,
      improvements: improvements,
      goodPoints: goodPoints,
      aiAdvice: '',
    );
  }

  static List<String> _getGoodPoints(_TypeData data) {
    return [
      '${data.strengths[0]}という強みがあります',
      if (data.strengths.length > 1) '${data.strengths[1]}という特徴が見られます',
    ];
  }

  static String _getDominantType(Map<String, int> counts, List<AnswerRecord> answers) {
    final maxCount = counts.values.reduce((a, b) => a > b ? a : b);
    final topTypes = counts.entries
        .where((e) => e.value == maxCount)
        .map((e) => e.key)
        .toList();

    if (topTypes.length == 1) return topTypes.first;

    // 最後の質問の回答を参考に決定
    if (answers.isNotEmpty) {
      final lastAnswer = answers.last;
      if (lastAnswer.typeKey != null && topTypes.contains(lastAnswer.typeKey)) {
        return lastAnswer.typeKey!;
      }
    }

    return 'balance';
  }

  static String _buildDetailComment(_TypeData data, Map<String, int> counts, int total) {
    final buf = StringBuffer();
    buf.writeln('【${data.typeName}】');
    buf.writeln(data.description);
    buf.writeln();
    buf.writeln('▼ 強み');
    for (final s in data.strengths) {
      buf.writeln('・$s');
    }
    buf.writeln();
    buf.writeln('▼ おすすめの声かけ');
    for (final p in data.goodPhrases) {
      buf.writeln('「$p」');
    }
    buf.writeln();
    buf.writeln('▼ 今日からできる関わり方');
    buf.writeln(data.dailyAdvice);
    return buf.toString().trim();
  }
}

class _TypeData {
  final String typeName;
  final String label;
  final String description;
  final List<String> strengths;
  final List<String> ngBehaviors;
  final List<String> goodPhrases;
  final String dailyAdvice;

  const _TypeData({
    required this.typeName,
    required this.label,
    required this.description,
    required this.strengths,
    required this.ngBehaviors,
    required this.goodPhrases,
    required this.dailyAdvice,
  });
}
