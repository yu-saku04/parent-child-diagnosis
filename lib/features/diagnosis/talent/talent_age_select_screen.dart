import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../models/diagnosis_type.dart';
import '../diagnosis_question_screen.dart';

class TalentAgeSelectScreen extends StatelessWidget {
  const TalentAgeSelectScreen({super.key});

  static const _ageGroups = [
    _AgeGroupData(
      key: '0-2',
      label: '0〜2歳',
      description: '赤ちゃん〜よちよち歩きの時期\n観察できる行動から傾向を確認します',
      emoji: '🍼',
    ),
    _AgeGroupData(
      key: '3-4',
      label: '3〜4歳',
      description: '言葉が増えてくる幼児期\n遊び方や感情の反応から傾向を確認します',
      emoji: '🧩',
    ),
    _AgeGroupData(
      key: '5-7',
      label: '5〜7歳',
      description: '就学前〜小学校低学年\n思考・社会性の傾向から才能タイプを確認します',
      emoji: '📚',
    ),
  ];

  void _start(BuildContext context, String ageGroup) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => DiagnosisQuestionScreen(
          type: DiagnosisType.talent,
          ageGroup: ageGroup,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: const Text('子どもの才能診断')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF8B5CF6), Color(0xFFA78BFA)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  const Text('✨', style: TextStyle(fontSize: 40)),
                  const SizedBox(height: 8),
                  const Text(
                    'お子さんの年齢を選んでください',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    '年齢に合わせた12問でお子さんの才能タイプを診断します',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.9),
                      fontSize: 13,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Text('年齢グループを選択', style: AppTextStyles.heading3),
            const SizedBox(height: 12),
            ..._ageGroups.map((ag) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: _AgeGroupCard(
                data: ag,
                onTap: () => _start(context, ag.key),
              ),
            )),
            const SizedBox(height: 8),
            Text(
              '※ 診断結果はあくまでも傾向の目安です。\n子どもの個性はひとつの型に収まるものではありません。',
              style: AppTextStyles.caption,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}

class _AgeGroupData {
  final String key;
  final String label;
  final String description;
  final String emoji;

  const _AgeGroupData({
    required this.key,
    required this.label,
    required this.description,
    required this.emoji,
  });
}

class _AgeGroupCard extends StatelessWidget {
  final _AgeGroupData data;
  final VoidCallback onTap;

  const _AgeGroupCard({required this.data, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.cardBorder),
          boxShadow: [
            BoxShadow(
              color: AppColors.talentColor.withOpacity(0.06),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: AppColors.talentColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Center(
                child: Text(data.emoji, style: const TextStyle(fontSize: 28)),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    data.label,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(data.description, style: AppTextStyles.bodySmall),
                ],
              ),
            ),
            const Icon(Icons.chevron_right, color: AppColors.talentColor),
          ],
        ),
      ),
    );
  }
}
