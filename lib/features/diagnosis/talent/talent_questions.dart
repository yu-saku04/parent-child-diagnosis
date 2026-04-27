import '../../../models/question.dart';

class TalentQuestions {
  static List<Question> getQuestionsForAge(String ageGroup) {
    switch (ageGroup) {
      case '0-2':
        return _age0to2Questions;
      case '3-4':
        return _age3to4Questions;
      case '5-7':
      default:
        return _age5to7Questions;
    }
  }

  // 0〜2歳：観察できる行動ベースの質問
  static const _age0to2Questions = [
    Question(
      id: 'a0_1',
      text: '新しいおもちゃを初めて見たとき、最初の反応は？',
      choices: [
        Choice(label: 'じっと観察してから触ろうとする', score: 0, typeKey: 'logical'),
        Choice(label: '声を出したり笑顔で反応する', score: 0, typeKey: 'emotional'),
        Choice(label: 'すぐ手を伸ばして触ろうとする', score: 0, typeKey: 'active'),
        Choice(label: '慎重に様子を見てから少しずつ近づく', score: 0, typeKey: 'stable'),
      ],
    ),
    Question(
      id: 'a0_2',
      text: '親が笑いかけたとき、どんな反応をしますか？',
      choices: [
        Choice(label: 'まじめに見つめ返すことが多い', score: 0, typeKey: 'logical'),
        Choice(label: 'すぐに笑い返す', score: 0, typeKey: 'emotional'),
        Choice(label: '声を出したり体を動かす', score: 0, typeKey: 'active'),
        Choice(label: '知っている人のときだけ笑う', score: 0, typeKey: 'stable'),
      ],
    ),
    Question(
      id: 'a0_3',
      text: '音楽が流れたとき、どんな反応をしやすいですか？',
      choices: [
        Choice(label: '音の方向をじっと見つめる', score: 0, typeKey: 'logical'),
        Choice(label: '体を揺らしたり声を出す', score: 0, typeKey: 'emotional'),
        Choice(label: '手足を大きく動かす', score: 0, typeKey: 'active'),
        Choice(label: '静かに聞いている', score: 0, typeKey: 'stable'),
      ],
    ),
    Question(
      id: 'a0_4',
      text: 'お気に入りのおもちゃで遊ぶとき、どんな様子ですか？',
      choices: [
        Choice(label: '同じ部分を繰り返し確認するように触る', score: 0, typeKey: 'logical'),
        Choice(label: '声を出したり親に見せようとする', score: 0, typeKey: 'emotional'),
        Choice(label: 'ダイナミックに動かして遊ぶ', score: 0, typeKey: 'active'),
        Choice(label: '静かに繰り返して遊ぶ', score: 0, typeKey: 'stable'),
      ],
    ),
    Question(
      id: 'a0_5',
      text: '知らない人が近づいてきたとき、どんな様子ですか？',
      choices: [
        Choice(label: 'じっと相手の顔を観察する', score: 0, typeKey: 'logical'),
        Choice(label: '泣いたり不安そうな表情になる', score: 0, typeKey: 'emotional'),
        Choice(label: '興味を持って近づこうとする', score: 0, typeKey: 'active'),
        Choice(label: '親の顔を確認してから判断する', score: 0, typeKey: 'stable'),
      ],
    ),
    Question(
      id: 'a0_6',
      text: '機嫌が悪いとき、落ち着きやすいのはどんなとき？',
      choices: [
        Choice(label: 'あやし方に一定のパターンがあると落ち着く', score: 0, typeKey: 'logical'),
        Choice(label: '声かけや抱っこで落ち着く', score: 0, typeKey: 'emotional'),
        Choice(label: '体を動かすと落ち着く', score: 0, typeKey: 'active'),
        Choice(label: 'いつものルーティン（授乳・お気に入り）で落ち着く', score: 0, typeKey: 'stable'),
      ],
    ),
    Question(
      id: 'a0_7',
      text: '食事のとき、どんな様子ですか？',
      choices: [
        Choice(label: '食べ物をじっと見てから食べる', score: 0, typeKey: 'logical'),
        Choice(label: '食べながら声を出したり表情豊か', score: 0, typeKey: 'emotional'),
        Choice(label: '次々と食べようとする', score: 0, typeKey: 'active'),
        Choice(label: 'いつもと同じリズムで落ち着いて食べる', score: 0, typeKey: 'stable'),
      ],
    ),
    Question(
      id: 'a0_8',
      text: '眠る前の様子はどんな感じですか？',
      choices: [
        Choice(label: '眠くなるサインがわかりやすい（目をこする等）', score: 0, typeKey: 'logical'),
        Choice(label: '添い寝や声かけがあると安心して眠れる', score: 0, typeKey: 'emotional'),
        Choice(label: 'なかなか眠れずそわそわしがち', score: 0, typeKey: 'active'),
        Choice(label: '決まったルーティンで落ち着いて眠れる', score: 0, typeKey: 'stable'),
      ],
    ),
    Question(
      id: 'a0_9',
      text: '外出先でどんな様子を見せますか？',
      choices: [
        Choice(label: '周囲の景色や物をじっと観察する', score: 0, typeKey: 'logical'),
        Choice(label: '感情豊かに反応する', score: 0, typeKey: 'emotional'),
        Choice(label: '活発に動こうとする', score: 0, typeKey: 'active'),
        Choice(label: '最初は様子を見てから行動する', score: 0, typeKey: 'stable'),
      ],
    ),
    Question(
      id: 'a0_10',
      text: '親と一緒に遊ぶとき、どんな様子ですか？',
      choices: [
        Choice(label: '親の動きをじっと見てから真似する', score: 0, typeKey: 'logical'),
        Choice(label: '楽しそうな声を出したり表情豊か', score: 0, typeKey: 'emotional'),
        Choice(label: '積極的に親に働きかけてくる', score: 0, typeKey: 'active'),
        Choice(label: '安心して落ち着いて遊べる', score: 0, typeKey: 'stable'),
      ],
    ),
    Question(
      id: 'a0_11',
      text: '親がいなくなったとき（視界から消えたとき）の反応は？',
      choices: [
        Choice(label: 'きょろきょろして探す', score: 0, typeKey: 'logical'),
        Choice(label: 'すぐ泣いたり声を出して呼ぶ', score: 0, typeKey: 'emotional'),
        Choice(label: '別のことに移って遊び続ける', score: 0, typeKey: 'active'),
        Choice(label: '少し待ってから反応する', score: 0, typeKey: 'stable'),
      ],
    ),
    Question(
      id: 'a0_12',
      text: 'この子の特徴として一番当てはまるのは？',
      choices: [
        Choice(label: '細かいものをよく観察する・じっくり確認する', score: 0, typeKey: 'logical'),
        Choice(label: '感情表現が豊か・人が好き', score: 0, typeKey: 'emotional'),
        Choice(label: '体を動かすことが大好き・探索好き', score: 0, typeKey: 'active'),
        Choice(label: '変化に敏感・いつものものが好き', score: 0, typeKey: 'stable'),
      ],
    ),
  ];

  // 3〜4歳：幼児期の行動・反応ベースの質問
  static const _age3to4Questions = [
    Question(
      id: 'a3_1',
      text: '遊んでいるとき、どんな遊びに集中しやすいですか？',
      choices: [
        Choice(label: '積み木や形合わせなど仕組みを考える遊び', score: 0, typeKey: 'logical'),
        Choice(label: 'ごっこ遊びや人形・ぬいぐるみ遊び', score: 0, typeKey: 'emotional'),
        Choice(label: '走り回ったり体を動かす遊び', score: 0, typeKey: 'active'),
        Choice(label: '同じ遊びを繰り返し楽しむ', score: 0, typeKey: 'stable'),
      ],
    ),
    Question(
      id: 'a3_2',
      text: 'うまくできなかったとき、どんな反応をしますか？',
      choices: [
        Choice(label: '「なんで？」と理由を聞こうとする', score: 0, typeKey: 'logical'),
        Choice(label: '泣いたり感情が大きく揺れる', score: 0, typeKey: 'emotional'),
        Choice(label: 'すぐもう一度やり直そうとする', score: 0, typeKey: 'active'),
        Choice(label: 'しばらくやめてしまう', score: 0, typeKey: 'stable'),
      ],
    ),
    Question(
      id: 'a3_3',
      text: '新しい場所（公園・お店）に行ったとき、どんな様子ですか？',
      choices: [
        Choice(label: '周囲をじっくり観察してから動き出す', score: 0, typeKey: 'logical'),
        Choice(label: '親の反応や表情を確認する', score: 0, typeKey: 'emotional'),
        Choice(label: '興味のある場所へすぐ向かう', score: 0, typeKey: 'active'),
        Choice(label: '慣れるまで親のそばから離れない', score: 0, typeKey: 'stable'),
      ],
    ),
    Question(
      id: 'a3_4',
      text: 'お友達と遊ぶとき、どんな様子ですか？',
      choices: [
        Choice(label: 'ルールや順番を気にする', score: 0, typeKey: 'logical'),
        Choice(label: '相手の様子をよく観察している', score: 0, typeKey: 'emotional'),
        Choice(label: '遊びを引っ張っていこうとする', score: 0, typeKey: 'active'),
        Choice(label: 'いつものお友達と安心して遊びたがる', score: 0, typeKey: 'stable'),
      ],
    ),
    Question(
      id: 'a3_5',
      text: '絵本を読んでいるとき、どんな様子ですか？',
      choices: [
        Choice(label: '細かい絵を指摘したり質問する', score: 0, typeKey: 'logical'),
        Choice(label: '物語の登場人物の気持ちに反応する', score: 0, typeKey: 'emotional'),
        Choice(label: '体を動かしたり一緒に声を出す', score: 0, typeKey: 'active'),
        Choice(label: '同じ絵本を何度も読みたがる', score: 0, typeKey: 'stable'),
      ],
    ),
    Question(
      id: 'a3_6',
      text: '親に注意されたとき、どんな反応をしますか？',
      choices: [
        Choice(label: '「なんで？」と理由を聞く', score: 0, typeKey: 'logical'),
        Choice(label: '傷ついた表情や涙が出やすい', score: 0, typeKey: 'emotional'),
        Choice(label: 'すぐ別の行動に移る', score: 0, typeKey: 'active'),
        Choice(label: 'しばらく引きずることがある', score: 0, typeKey: 'stable'),
      ],
    ),
    Question(
      id: 'a3_7',
      text: '自分でやりたがるとき、どんな様子ですか？',
      choices: [
        Choice(label: 'できる方法を確認してから始める', score: 0, typeKey: 'logical'),
        Choice(label: '「見てて」と親の注目を求める', score: 0, typeKey: 'emotional'),
        Choice(label: '見切り発車でやり始める', score: 0, typeKey: 'active'),
        Choice(label: '親が隣にいると安心してやれる', score: 0, typeKey: 'stable'),
      ],
    ),
    Question(
      id: 'a3_8',
      text: '褒められたとき、どんな反応をしますか？',
      choices: [
        Choice(label: '何が良かったのか確認する', score: 0, typeKey: 'logical'),
        Choice(label: 'とても嬉しそうにして表情が輝く', score: 0, typeKey: 'emotional'),
        Choice(label: 'もっとやろうとする', score: 0, typeKey: 'active'),
        Choice(label: '照れながらも満足そうにする', score: 0, typeKey: 'stable'),
      ],
    ),
    Question(
      id: 'a3_9',
      text: '予定が急に変わったとき（予告なしに）、どんな様子ですか？',
      choices: [
        Choice(label: '「なんで？」と理由を聞く', score: 0, typeKey: 'logical'),
        Choice(label: '気持ちが大きく揺れやすい', score: 0, typeKey: 'emotional'),
        Choice(label: '気持ちを切り替えて別のことをしようとする', score: 0, typeKey: 'active'),
        Choice(label: '不安になったり泣き出す', score: 0, typeKey: 'stable'),
      ],
    ),
    Question(
      id: 'a3_10',
      text: '子どもが安心しやすいのはどんなときですか？',
      choices: [
        Choice(label: '見通しや理由がわかるとき', score: 0, typeKey: 'logical'),
        Choice(label: '気持ちを受け止めてもらえたとき', score: 0, typeKey: 'emotional'),
        Choice(label: '自由に動けるとき', score: 0, typeKey: 'active'),
        Choice(label: 'いつもの流れが守られているとき', score: 0, typeKey: 'stable'),
      ],
    ),
    Question(
      id: 'a3_11',
      text: '苦手なことに取り組むとき、どんなサポートが合いやすいですか？',
      choices: [
        Choice(label: '手順を説明してあげる', score: 0, typeKey: 'logical'),
        Choice(label: '気持ちに寄り添ってから一緒に取り組む', score: 0, typeKey: 'emotional'),
        Choice(label: 'まず一緒に体験してみる', score: 0, typeKey: 'active'),
        Choice(label: '安心できる環境でゆっくり練習する', score: 0, typeKey: 'stable'),
      ],
    ),
    Question(
      id: 'a3_12',
      text: '親が一番困りやすい場面は？',
      choices: [
        Choice(label: '「なんで？」「どうして？」の質問が多い', score: 0, typeKey: 'logical'),
        Choice(label: '気持ちの切り替えに時間がかかる', score: 0, typeKey: 'emotional'),
        Choice(label: '落ち着いて待つのが苦手', score: 0, typeKey: 'active'),
        Choice(label: '新しいことへの挑戦を嫌がる', score: 0, typeKey: 'stable'),
      ],
    ),
  ];

  // 5〜7歳：思考・社会性ベースの質問（12問）
  static const _age5to7Questions = [
    Question(
      id: 't1',
      text: '新しいおもちゃや遊びを見たとき、子どもはどんな反応をしやすいですか？',
      choices: [
        Choice(label: 'まず仕組みやルールを知りたがる', score: 0, typeKey: 'logical'),
        Choice(label: '誰かと一緒に楽しみたがる', score: 0, typeKey: 'emotional'),
        Choice(label: 'すぐに触って試そうとする', score: 0, typeKey: 'active'),
        Choice(label: '少し様子を見てから始める', score: 0, typeKey: 'stable'),
      ],
    ),
    Question(
      id: 't2',
      text: 'うまくできないことがあったとき、どんな反応をしやすいですか？',
      choices: [
        Choice(label: 'なぜできなかったのか考える', score: 0, typeKey: 'logical'),
        Choice(label: '悔しさや悲しさを強く表す', score: 0, typeKey: 'emotional'),
        Choice(label: 'もう一度すぐ挑戦する', score: 0, typeKey: 'active'),
        Choice(label: 'いったんやめて落ち着こうとする', score: 0, typeKey: 'stable'),
      ],
    ),
    Question(
      id: 't4',
      text: '友だちと遊ぶとき、どんな傾向がありますか？',
      choices: [
        Choice(label: 'ルールや順番を気にする', score: 0, typeKey: 'logical'),
        Choice(label: '相手の気持ちをよく見ている', score: 0, typeKey: 'emotional'),
        Choice(label: '遊びをリードしたがる', score: 0, typeKey: 'active'),
        Choice(label: '慣れた相手と安心して遊びたい', score: 0, typeKey: 'stable'),
      ],
    ),
    Question(
      id: 't5',
      text: '褒められたとき、どんな反応をしやすいですか？',
      choices: [
        Choice(label: '何が良かったのか知りたがる', score: 0, typeKey: 'logical'),
        Choice(label: 'とても嬉しそうにする', score: 0, typeKey: 'emotional'),
        Choice(label: 'もっとやろうとする', score: 0, typeKey: 'active'),
        Choice(label: '照れながらも安心する', score: 0, typeKey: 'stable'),
      ],
    ),
    Question(
      id: 't6',
      text: '予定が急に変わったとき、どんな反応をしやすいですか？',
      choices: [
        Choice(label: '理由を説明されると納得しやすい', score: 0, typeKey: 'logical'),
        Choice(label: '気持ちが揺れやすい', score: 0, typeKey: 'emotional'),
        Choice(label: 'すぐ次の行動に移れる', score: 0, typeKey: 'active'),
        Choice(label: '不安になりやすい', score: 0, typeKey: 'stable'),
      ],
    ),
    Question(
      id: 't7',
      text: '集中しているときの様子は？',
      choices: [
        Choice(label: '一つのことを深く考える', score: 0, typeKey: 'logical'),
        Choice(label: '物語や人との関わりに入り込む', score: 0, typeKey: 'emotional'),
        Choice(label: '体を動かしながら集中する', score: 0, typeKey: 'active'),
        Choice(label: '静かな環境で集中しやすい', score: 0, typeKey: 'stable'),
      ],
    ),
    Question(
      id: 't9',
      text: '何かを選ぶとき、どんな傾向がありますか？',
      choices: [
        Choice(label: '比べて考えて選ぶ', score: 0, typeKey: 'logical'),
        Choice(label: '好き嫌いや気持ちで選ぶ', score: 0, typeKey: 'emotional'),
        Choice(label: '直感ですぐ選ぶ', score: 0, typeKey: 'active'),
        Choice(label: 'いつものものを選びやすい', score: 0, typeKey: 'stable'),
      ],
    ),
    Question(
      id: 't11',
      text: '遊び方の特徴は？',
      choices: [
        Choice(label: 'パズルや組み立てが好き', score: 0, typeKey: 'logical'),
        Choice(label: 'ごっこ遊びや物語が好き', score: 0, typeKey: 'emotional'),
        Choice(label: '外遊びや体を動かす遊びが好き', score: 0, typeKey: 'active'),
        Choice(label: '慣れた遊びを繰り返すのが好き', score: 0, typeKey: 'stable'),
      ],
    ),
    Question(
      id: 't12',
      text: '子どもが安心しやすいのはどんなときですか？',
      choices: [
        Choice(label: '見通しや理由がわかるとき', score: 0, typeKey: 'logical'),
        Choice(label: '気持ちを受け止めてもらえたとき', score: 0, typeKey: 'emotional'),
        Choice(label: '自由に動けるとき', score: 0, typeKey: 'active'),
        Choice(label: 'いつもの流れが守られているとき', score: 0, typeKey: 'stable'),
      ],
    ),
    Question(
      id: 't13',
      text: '何かに興味を持ったとき、どうなりやすいですか？',
      choices: [
        Choice(label: '詳しく知りたがる', score: 0, typeKey: 'logical'),
        Choice(label: '誰かに話したがる', score: 0, typeKey: 'emotional'),
        Choice(label: 'すぐやってみたがる', score: 0, typeKey: 'active'),
        Choice(label: '少しずつ慣れていく', score: 0, typeKey: 'stable'),
      ],
    ),
    Question(
      id: 't14',
      text: '苦手なことに向き合うとき、どんな支援が合いやすいですか？',
      choices: [
        Choice(label: '手順を説明される', score: 0, typeKey: 'logical'),
        Choice(label: '気持ちに寄り添ってもらう', score: 0, typeKey: 'emotional'),
        Choice(label: 'まず一緒にやってみる', score: 0, typeKey: 'active'),
        Choice(label: '安心できる環境で練習する', score: 0, typeKey: 'stable'),
      ],
    ),
    Question(
      id: 't15',
      text: '子どもが力を発揮しやすい場面は？',
      choices: [
        Choice(label: '考える時間がある場面', score: 0, typeKey: 'logical'),
        Choice(label: '人との関わりがある場面', score: 0, typeKey: 'emotional'),
        Choice(label: '体験しながら学ぶ場面', score: 0, typeKey: 'active'),
        Choice(label: '落ち着いた環境の場面', score: 0, typeKey: 'stable'),
      ],
    ),
  ];
}
