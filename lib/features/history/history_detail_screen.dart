import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../core/utils/date_utils.dart';
import '../../models/diagnosis_result.dart';
import '../../models/diagnosis_type.dart';

class HistoryDetailScreen extends StatelessWidget {
  final DiagnosisResult result;

  const HistoryDetailScreen({super.key, required this.result});

  Color get _color {
    switch (result.diagnosisType) {
      case 'stress':
        return AppColors.stressColor;
      case 'talent':
        return AppColors.talentColor;
      case 'ng_behavior':
        return AppColors.ngBehaviorColor;
      default:
        return AppColors.primary;
    }
  }

  DiagnosisType get _type => DiagnosisType.values.firstWhere(
        (t) => t.storageKey == result.diagnosisType,
        orElse: () => DiagnosisType.stress,
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: Text('${_type.shortLabel}の結果')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            const SizedBox(height: 20),
            _buildScoreCard(),
            const SizedBox(height: 16),
            _buildDetailCard(),
            const SizedBox(height: 16),
            _buildAiAdviceCard(),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: _color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(_type.iconEmoji, style: const TextStyle(fontSize: 28)),
        ),
        const SizedBox(width: 14),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(_type.label, style: AppTextStyles.heading3),
            Text(
              AppDateUtils.formatDateTime(result.createdAt),
              style: AppTextStyles.bodySmall,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildScoreCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: _color.withOpacity(0.07),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _color.withOpacity(0.2)),
      ),
      child: Column(
        children: [
          Text(
            '${result.score} / ${result.maxScore}点',
            style: TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.bold,
              color: _color,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
            decoration: BoxDecoration(
              color: _color,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              result.typeLabel,
              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 14),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: result.scorePercentage / 100,
              backgroundColor: AppColors.divider,
              valueColor: AlwaysStoppedAnimation<Color>(_color),
              minHeight: 8,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.cardBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('詳細コメント', style: AppTextStyles.heading3),
          const SizedBox(height: 12),
          Text(
            result.detailComment.isEmpty ? result.simpleComment : result.detailComment,
            style: AppTextStyles.body,
          ),
        ],
      ),
    );
  }

  Widget _buildAiAdviceCard() {
    if (result.aiAdvice.isEmpty) return const SizedBox.shrink();
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.cardBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.auto_awesome, size: 18, color: AppColors.primary),
              const SizedBox(width: 8),
              Text('アドバイス', style: AppTextStyles.heading3),
            ],
          ),
          const SizedBox(height: 12),
          Text(result.aiAdvice, style: AppTextStyles.body),
        ],
      ),
    );
  }
}
