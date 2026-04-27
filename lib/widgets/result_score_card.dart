import 'package:flutter/material.dart';
import '../core/theme/app_colors.dart';
import '../core/theme/app_text_styles.dart';

class ResultScoreCard extends StatelessWidget {
  final int score;
  final int maxScore;
  final String typeLabel;
  final String diagnosisLabel;
  final Color color;

  const ResultScoreCard({
    super.key,
    required this.score,
    required this.maxScore,
    required this.typeLabel,
    required this.diagnosisLabel,
    required this.color,
  });

  int get _percentage => maxScore > 0
      ? ((score / maxScore) * 100).round().clamp(0, 100)
      : 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [color.withOpacity(0.08), color.withOpacity(0.02)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withOpacity(0.2)),
      ),
      child: Column(
        children: [
          Text(diagnosisLabel, style: AppTextStyles.bodySmall),
          const SizedBox(height: 12),
          Text(
            '$score',
            style: AppTextStyles.scoreNumber.copyWith(color: color),
          ),
          Text(
            '/ $maxScore点',
            style: AppTextStyles.bodySmall,
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              typeLabel,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 15,
              ),
            ),
          ),
          const SizedBox(height: 16),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: _percentage / 100,
              backgroundColor: AppColors.divider,
              valueColor: AlwaysStoppedAnimation<Color>(color),
              minHeight: 8,
            ),
          ),
        ],
      ),
    );
  }
}
