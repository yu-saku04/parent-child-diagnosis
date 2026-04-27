import '../../../models/question.dart';

class StressQuestions {
  static const _options = [
    Choice(label: 'ほとんどない', score: 0),
    Choice(label: 'たまにある', score: 1),
    Choice(label: 'よくある', score: 2),
    Choice(label: 'かなりある', score: 3),
  ];

  static const questions = [
    Question(id: 's1', text: '十分な睡眠がとれていないと感じる', choices: _options, category: 'physical'),
    Question(id: 's2', text: '慢性的な疲れがなかなか抜けない', choices: _options, category: 'physical'),
    Question(id: 's3', text: '頭痛・肩こり・胃の不調など体の不調が続いている', choices: _options, category: 'physical'),
    Question(id: 's4', text: '些細なことでイライラしてしまう', choices: _options, category: 'emotional'),
    Question(id: 's5', text: '気分が落ち込むことが多い', choices: _options, category: 'emotional'),
    Question(id: 's6', text: '将来への不安を感じることが多い', choices: _options, category: 'emotional'),
    Question(id: 's7', text: '悩みを相談できる人がいないと感じる', choices: _options, category: 'isolation'),
    Question(id: 's8', text: '子育てを一人で抱えていると感じる', choices: _options, category: 'isolation'),
    Question(id: 's9', text: '周囲に助けを求めにくい', choices: _options, category: 'isolation'),
    Question(id: 's10', text: '子どもへの対応に自信が持てない', choices: _options, category: 'pressure'),
    Question(id: 's11', text: '「良い親でなければ」という焦りを感じる', choices: _options, category: 'pressure'),
    Question(id: 's12', text: '子どもに強く当たってしまい後悔することがある', choices: _options, category: 'pressure'),
    Question(id: 's13', text: '趣味や好きなことをする時間がない', choices: _options, category: 'selfcare'),
    Question(id: 's14', text: '自分のことは常に後回しになっている', choices: _options, category: 'selfcare'),
    Question(id: 's15', text: 'リフレッシュできる時間がとれていない', choices: _options, category: 'selfcare'),
  ];
}
