// Phase 1: テンプレートベースのアドバイス（AI API連携はPhase 4以降）
class AiService {
  String generateAdvice({
    required String diagnosisType,
    required String resultType,
    required bool isPremium,
  }) {
    final advice = _getAdvice(diagnosisType, resultType);
    if (isPremium) {
      return advice.full;
    }
    return advice.brief;
  }

  _AdviceText _getAdvice(String diagnosisType, String resultType) {
    switch (diagnosisType) {
      case 'stress':
        return _stressAdvice(resultType);
      case 'talent':
        return _talentAdvice(resultType);
      case 'ng_behavior':
        return _ngBehaviorAdvice(resultType);
      default:
        return _AdviceText(
          brief: '今日も子育てお疲れさまです。一歩一歩、できることから取り組んでいきましょう。',
          full: '今日も子育てお疲れさまです。一歩一歩、できることから取り組んでいきましょう。',
        );
    }
  }

  _AdviceText _stressAdvice(String resultType) {
    switch (resultType) {
      case 'stable':
        return _AdviceText(
          brief: '比較的安定した状態を保てています。このペースを大切に続けましょう。',
          full: '比較的安定した状態を保てています。今のペースをぜひ大切にしてください。\n\n今日できる3つのこと：\n1. 自分をほめる時間を1分だけとる\n2. 好きな飲み物でほっと一息つく\n3. 「今日これができた」を一つ思い出す',
        );
      case 'mild':
        return _AdviceText(
          brief: 'ストレスが少しずつ溜まってきているようです。こまめな小休憩を意識しましょう。',
          full: 'ストレスが少しずつ溜まってきているようです。完璧を目指さなくても大丈夫です。\n\n今日できる3つのこと：\n1. 10分だけ横になる時間をつくる\n2. 今日一番大変だったことを書き出す\n3. 明日の目標をひとつだけ決める',
        );
      case 'high':
        return _AdviceText(
          brief: 'ストレスがかなり高まっています。一人で抱え込まず、誰かに頼ることを意識してみてください。',
          full: 'ストレスがかなり高まっています。一人で抱え込まず、誰かに頼ることを意識してみてください。\n\n今日できる3つのこと：\n1. 信頼できる人に「少し話を聞いて」と連絡する\n2. 今日の家事を一つ省略する\n3. 5分間だけ深呼吸と瞑想をする',
        );
      case 'critical':
        return _AdviceText(
          brief: '心身ともに限界に近い可能性があります。まず休むことを最優先にしましょう。',
          full: '心身ともに限界に近い可能性があります。完璧を目指さなくて大丈夫です。まず休むことを最優先にしましょう。\n\n今日できる3つのこと：\n1. 今日の予定を一つキャンセルしていい\n2. 地域の子育て支援センターや相談窓口に連絡してみる\n3. 「助けを求めることは強さ」と自分に言い聞かせる\n\n必要に応じて、専門機関への相談も選択肢の一つです。',
        );
      default:
        return _AdviceText(
          brief: '今日も子育てお疲れさまです。',
          full: '今日も子育てお疲れさまです。',
        );
    }
  }

  _AdviceText _talentAdvice(String resultType) {
    switch (resultType) {
      case 'logical':
        return _AdviceText(
          brief: '考える力を大切に育てましょう。質問を面倒がらず、一緒に考える時間を持つことが伸ばすカギです。',
          full: '「なぜ？」「どうして？」をよく聞くお子さんは、深く考える力が育っています。\n\n今日できる3つのこと：\n1. 質問されたらすぐ答えず「どう思う?」と返してみる\n2. 一緒にパズルや組み立て遊びをする時間をつくる\n3. 「考えたプロセス」をほめる',
        );
      case 'emotional':
        return _AdviceText(
          brief: '感受性豊かなお子さんです。気持ちをまず受け止めることが、最大の力を引き出します。',
          full: '感情豊かで共感力の高いお子さんです。人の気持ちに敏感なことは大きな強みです。\n\n今日できる3つのこと：\n1. 「そう感じたんだね」と気持ちをまず受け止める\n2. 否定する前に共感する言葉を一つ加える\n3. 感情を言語化する練習を一緒にする',
        );
      case 'active':
        return _AdviceText(
          brief: '体を動かしながら学ぶ力があります。失敗しても責めず、次の挑戦につなげましょう。',
          full: '行動力と挑戦する力がお子さんの強みです。体験を通じてどんどん成長していきます。\n\n今日できる3つのこと：\n1. 説明は短く、まずやらせてみる\n2. 失敗したとき「次はどうする?」を一緒に考える\n3. 外で体を動かす機会を一つ作る',
        );
      case 'stable':
        return _AdviceText(
          brief: '安心できる環境の中で着実に伸びるタイプです。見通しを伝えることで力を発揮します。',
          full: '継続力と丁寧さがお子さんの強みです。安心できる環境で着実に成長していきます。\n\n今日できる3つのこと：\n1. 明日の予定を今日のうちに教えておく\n2. いつものルーティンを大切に守る\n3. 「ゆっくりで大丈夫」という言葉をかける',
        );
      case 'balance':
        return _AdviceText(
          brief: '場面に応じてさまざまな力を発揮できるバランスタイプです。多様な体験を大切にしましょう。',
          full: 'さまざまな力をバランスよく持つお子さんです。環境に合わせて力を発揮できる柔軟性があります。\n\n今日できる3つのこと：\n1. 一つのことに決めつけず、いろいろな体験をさせる\n2. その日の様子をよく観察する\n3. 「どれが一番楽しかった?」と聞いてみる',
        );
      default:
        return _AdviceText(
          brief: '今日も子育てお疲れさまです。',
          full: '今日も子育てお疲れさまです。',
        );
    }
  }

  _AdviceText _ngBehaviorAdvice(String resultType) {
    switch (resultType) {
      case 'stable':
        return _AdviceText(
          brief: '関わりは安定しています。このまま継続していきましょう。',
          full: '関わりは安定しています。ぜひこのまま続けていきましょう。\n\n今日できる3つのこと：\n1. 今の関わりで良いことを一つ書き出す\n2. 子どもと5分だけ一対一の時間をつくる\n3. 「今日もありがとう」と子どもに伝える',
        );
      case 'mild':
        return _AdviceText(
          brief: '一部に改善の余地があります。余裕がない時の対応を少し見直しましょう。',
          full: '一部に改善の余地があります。余裕がない時の対応を少し意識するだけで、関係が変わってきます。\n\n今日できる3つのこと：\n1. 「早くして」の代わりに「あと何分で終わる?」と聞いてみる\n2. 子どもの話を最後まで聞く練習をする\n3. 今日一番うまくいった関わりを思い出す',
        );
      case 'review':
        return _AdviceText(
          brief: '関わりに偏りがあります。まずは話をじっくり聞く時間を意識しましょう。',
          full: '関わりに偏りがあります。まずは「聞く」ことを意識するだけで大きな変化が生まれます。\n\n今日できる3つのこと：\n1. 最後まで聞いてから話す練習を一回やってみる\n2. 子どもが何かを言ったとき「そうなんだ」と返す\n3. 叱ってしまったら「さっきはごめんね」と修復する',
        );
      case 'urgent':
        return _AdviceText(
          brief: '余裕のなさが影響している可能性があります。焦らず、小さな改善から始めましょう。',
          full: '余裕のなさが行動に影響している可能性があります。まず自分自身を整えることが大切です。\n\n今日できる3つのこと：\n1. 今日一つだけ、子どもを急かすのをやめてみる\n2. 叱った後「ごめんね」を一言加える練習をする\n3. 地域の子育て相談窓口に話を聞いてもらう\n\n必要に応じて、専門機関に相談することも選択肢の一つです。',
        );
      default:
        return _AdviceText(
          brief: '今日も子育てお疲れさまです。',
          full: '今日も子育てお疲れさまです。',
        );
    }
  }
}

class _AdviceText {
  final String brief;
  final String full;

  const _AdviceText({required this.brief, required this.full});
}
