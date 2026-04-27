import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../models/diagnosis_type.dart';
import '../../models/result_detail.dart';
import '../../providers/auth_provider.dart';
import '../../providers/diagnosis_provider.dart';
import '../../widgets/primary_button.dart';

class DiagnosisDetailResultScreen extends StatelessWidget {
  const DiagnosisDetailResultScreen({super.key});

  Color _typeColor(String typeKey) {
    switch (typeKey) {
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

  @override
  Widget build(BuildContext context) {
    final diagProvider = context.watch<DiagnosisProvider>();
    final isPremium = context.watch<AuthProvider>().isPremium;
    final result = diagProvider.lastResult;
    final detail = diagProvider.lastResultDetail;

    if (result == null || detail == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    final type = DiagnosisType.values.firstWhere(
      (t) => t.storageKey == result.diagnosisType,
      orElse: () => DiagnosisType.stress,
    );
    final color = _typeColor(result.diagnosisType);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: Text('${type.shortLabel}の詳細結果')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTypeBadge(detail, color),
            const SizedBox(height: 20),
            _buildDetailCommentCard(detail.detailComment),
            const SizedBox(height: 16),
            _buildCategorySection(detail.categoryScores, color),
            const SizedBox(height: 16),
            _buildImprovementsSection(detail.improvements),
            const SizedBox(height: 16),
            _buildAiAdviceSection(result.aiAdvice, isPremium),
            if (diagProvider.isSaved) ...[
              const SizedBox(height: 16),
              _buildSavedNotice(),
            ],
            const SizedBox(height: 24),
            PrimaryButton(
              label: 'ホームに戻る',
              onPressed: () => Navigator.popUntil(context, (route) => route.isFirst),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildTypeBadge(ResultDetail detail, Color color) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: color.withOpacity(0.07),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withOpacity(0.2)),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              detail.typeLabel,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            detail.simpleComment,
            textAlign: TextAlign.center,
            style: AppTextStyles.body,
          ),
        ],
      ),
    );
  }

  Widget _buildDetailCommentCard(String comment) {
    return _SectionCard(
      title: '詳しい解説',
      icon: Icons.info_outline,
      child: Text(comment, style: AppTextStyles.body),
    );
  }

  Widget _buildCategorySection(List<CategoryScore> scores, Color color) {
    return _SectionCard(
      title: '傾向の内訳',
      icon: Icons.bar_chart,
      child: Column(
        children: scores.map((cat) => _CategoryBar(cat: cat, color: color)).toList(),
      ),
    );
  }

  Widget _buildImprovementsSection(List<String> improvements) {
    return _SectionCard(
      title: '改善アクション',
      icon: Icons.tips_and_updates_outlined,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: improvements.map((item) => _ImprovementItem(text: item)).toList(),
      ),
    );
  }

  Widget _buildAiAdviceSection(String advice, bool isPremium) {
    return _SectionCard(
      title: isPremium ? 'AIアドバイス（詳細）' : 'AIアドバイス',
      icon: Icons.auto_awesome,
      badge: isPremium ? null : '無料版',
      child: Text(
        advice.isEmpty ? 'アドバイスの生成に失敗しました。基本アドバイスを表示します。' : advice,
        style: AppTextStyles.body,
      ),
    );
  }

  Widget _buildSavedNotice() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.secondary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: const Row(
        children: [
          Icon(Icons.check_circle, color: AppColors.secondary, size: 18),
          SizedBox(width: 8),
          Text(
            '診断結果を履歴に保存しました',
            style: TextStyle(color: AppColors.secondary, fontSize: 13),
          ),
        ],
      ),
    );
  }
}

class _SectionCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final Widget child;
  final String? badge;

  const _SectionCard({
    required this.title,
    required this.icon,
    required this.child,
    this.badge,
  });

  @override
  Widget build(BuildContext context) {
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
              Icon(icon, size: 18, color: AppColors.primary),
              const SizedBox(width: 8),
              Text(title, style: AppTextStyles.heading3),
              if (badge != null) ...[
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: AppColors.textHint.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    badge!,
                    style: const TextStyle(fontSize: 11, color: AppColors.textHint),
                  ),
                ),
              ],
            ],
          ),
          const SizedBox(height: 14),
          child,
        ],
      ),
    );
  }
}

class _CategoryBar extends StatelessWidget {
  final CategoryScore cat;
  final Color color;

  const _CategoryBar({required this.cat, required this.color});

  Color get _barColor {
    final pct = cat.percentage;
    if (pct >= 70) return AppColors.scoreHigh;
    if (pct >= 40) return AppColors.scoreMid;
    return AppColors.scoreLow;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(cat.label, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500)),
              Text(
                '${cat.score} / ${cat.maxScore}',
                style: AppTextStyles.caption,
              ),
            ],
          ),
          const SizedBox(height: 6),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: cat.percentage / 100,
              backgroundColor: AppColors.divider,
              valueColor: AlwaysStoppedAnimation<Color>(_barColor),
              minHeight: 8,
            ),
          ),
          const SizedBox(height: 4),
          Text(cat.advice, style: AppTextStyles.caption),
        ],
      ),
    );
  }
}

class _ImprovementItem extends StatelessWidget {
  final String text;

  const _ImprovementItem({required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 4),
            child: Icon(Icons.fiber_manual_record, size: 8, color: AppColors.primary),
          ),
          const SizedBox(width: 10),
          Expanded(child: Text(text, style: AppTextStyles.body)),
        ],
      ),
    );
  }
}
