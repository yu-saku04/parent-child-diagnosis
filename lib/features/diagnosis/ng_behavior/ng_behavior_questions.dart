import '../../../models/question.dart';

class NgBehaviorQuestions {
  static const _options = [
    Choice(label: 'ほとんどない', score: 0),
    Choice(label: 'たまにある', score: 1),
    Choice(label: 'よくある', score: 2),
    Choice(label: 'かなりある', score: 3),
  ];

  static const questions = [
    Question(id: 'n1', text: '子どもが考える前に指示してしまう', choices: _options, category: 'anticipation'),
    Question(id: 'n2', text: '話を最後まで聞かない', choices: _options, category: 'interrupting'),
    Question(id: 'n3', text: '「早くしなさい」と言う', choices: _options, category: 'scolding'),
    Question(id: 'n4', text: '理由を聞く前に叱る', choices: _options, category: 'scolding'),
    Question(id: 'n5', text: '結果だけで評価する', choices: _options, category: 'results'),
    Question(id: 'n6', text: '他の子と比べる', choices: _options, category: 'results'),
    Question(id: 'n7', text: '子どもの感情を面倒に感じる', choices: _options, category: 'emotion'),
    Question(id: 'n8', text: 'やりたいことを止める', choices: _options, category: 'anticipation'),
    Question(id: 'n9', text: '先回りして手伝う', choices: _options, category: 'anticipation'),
    Question(id: 'n10', text: '機嫌によって対応が変わる', choices: _options, category: 'emotion'),
    Question(id: 'n11', text: 'すぐに解決策を言う', choices: _options, category: 'interrupting'),
    Question(id: 'n12', text: '子どもの感情を軽く扱う', choices: _options, category: 'scolding'),
    Question(id: 'n13', text: 'スマホを見ながら話を聞く', choices: _options, category: 'interrupting'),
    Question(id: 'n14', text: 'できていない所ばかり見る', choices: _options, category: 'results'),
    Question(id: 'n15', text: '子どもをコントロールしようとする', choices: _options, category: 'anticipation'),
  ];
}
