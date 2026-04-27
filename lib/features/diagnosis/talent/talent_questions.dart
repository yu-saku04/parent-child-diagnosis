import '../../../models/question.dart';

class TalentQuestions {
  static const questions = [
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
      id: 't3',
      text: '親が説明しているとき、子どもはどんな様子ですか？',
      choices: [
        Choice(label: '理由や意味を知りたがる', score: 0, typeKey: 'logical'),
        Choice(label: '親の表情や声色に反応する', score: 0, typeKey: 'emotional'),
        Choice(label: '聞くより先に動き出す', score: 0, typeKey: 'active'),
        Choice(label: 'ゆっくり確認しながら聞く', score: 0, typeKey: 'stable'),
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
      id: 't8',
      text: '新しい場所に行ったとき、どんな反応をしやすいですか？',
      choices: [
        Choice(label: '周囲を観察して理解しようとする', score: 0, typeKey: 'logical'),
        Choice(label: '親や周囲の人の反応を気にする', score: 0, typeKey: 'emotional'),
        Choice(label: '興味のある場所へすぐ向かう', score: 0, typeKey: 'active'),
        Choice(label: '慣れるまで時間がかかる', score: 0, typeKey: 'stable'),
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
      id: 't10',
      text: '親に注意されたとき、どんな反応をしやすいですか？',
      choices: [
        Choice(label: '理由がわかると受け入れやすい', score: 0, typeKey: 'logical'),
        Choice(label: '傷ついた表情をしやすい', score: 0, typeKey: 'emotional'),
        Choice(label: 'すぐ別の行動に移る', score: 0, typeKey: 'active'),
        Choice(label: 'しばらく引きずることがある', score: 0, typeKey: 'stable'),
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
    Question(
      id: 't16',
      text: '親が急かしたとき、どうなりやすいですか？',
      choices: [
        Choice(label: '考えがまとまりにくくなる', score: 0, typeKey: 'logical'),
        Choice(label: '気持ちが乱れやすくなる', score: 0, typeKey: 'emotional'),
        Choice(label: '雑になりやすい', score: 0, typeKey: 'active'),
        Choice(label: '不安が強くなりやすい', score: 0, typeKey: 'stable'),
      ],
    ),
    Question(
      id: 't17',
      text: '初めての人と関わるときは？',
      choices: [
        Choice(label: '相手を観察する', score: 0, typeKey: 'logical'),
        Choice(label: '相手の雰囲気に影響される', score: 0, typeKey: 'emotional'),
        Choice(label: '自分から話しかける', score: 0, typeKey: 'active'),
        Choice(label: '慣れるまで距離を取る', score: 0, typeKey: 'stable'),
      ],
    ),
    Question(
      id: 't18',
      text: '好きなことに取り組むときの特徴は？',
      choices: [
        Choice(label: '細かいところまでこだわる', score: 0, typeKey: 'logical'),
        Choice(label: '感情豊かに表現する', score: 0, typeKey: 'emotional'),
        Choice(label: '夢中で動き続ける', score: 0, typeKey: 'active'),
        Choice(label: '同じことを安定して続ける', score: 0, typeKey: 'stable'),
      ],
    ),
    Question(
      id: 't19',
      text: '親が一番困りやすい場面は？',
      choices: [
        Choice(label: '理屈っぽく質問が多い', score: 0, typeKey: 'logical'),
        Choice(label: '気持ちの切り替えに時間がかかる', score: 0, typeKey: 'emotional'),
        Choice(label: '落ち着いて待つのが苦手', score: 0, typeKey: 'active'),
        Choice(label: '新しいことに慎重すぎる', score: 0, typeKey: 'stable'),
      ],
    ),
    Question(
      id: 't20',
      text: '伸ばしてあげたい力はどれに近いですか？',
      choices: [
        Choice(label: '考える力', score: 0, typeKey: 'logical'),
        Choice(label: '人の気持ちを理解する力', score: 0, typeKey: 'emotional'),
        Choice(label: '挑戦する力', score: 0, typeKey: 'active'),
        Choice(label: '継続する力', score: 0, typeKey: 'stable'),
      ],
    ),
  ];
}
