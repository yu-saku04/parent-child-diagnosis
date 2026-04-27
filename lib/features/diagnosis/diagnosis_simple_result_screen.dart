import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../models/diagnosis_type.dart';
import '../../providers/auth_provider.dart';
import '../../providers/diagnosis_provider.dart';
import '../../providers/ad_provider.dart';
import '../../widgets/primary_button.dart';
import '../../widgets/secondary_button.dart';
import '../../widgets/result_score_card.dart';
import '../subscription/subscription_screen.dart';
import 'diagnosis_detail_result_screen.dart';

class DiagnosisSimpleResultScreen extends StatelessWidget {
  const DiagnosisSimpleResultScreen({super.key});

  Color _typeColor(String? typeKey) {
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
    final result = diagProvider.lastResult;
    final isPremium = context.watch<AuthProvider>().isPremium;

    if (result == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    final type = DiagnosisType.values.firstWhere(
      (t) => t.storageKey == result.diagnosisType,
      orElse: () => DiagnosisType.stress,
    );
    final color = _typeColor(result.diagnosisType);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: Text('${type.shortLabel}の結果')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            ResultScoreCard(
              score: result.score,
              maxScore: result.maxScore,
              typeLabel: result.typeLabel,
              diagnosisLabel: type.label,
              color: color,
            ),
            const SizedBox(height: 20),
            _buildCommentCard(result.simpleComment),
            const SizedBox(height: 24),
            if (!isPremium)
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Text(
                  '詳細結果を見るには短い広告を視聴してください。\n広告なしで使う場合はプレミアムプランをご利用ください。',
                  textAlign: TextAlign.center,
                  style: AppTextStyles.bodySmall,
                ),
              ),
            PrimaryButton(
              label: '詳細結果を見る',
              onPressed: () => _onDetailTap(context, isPremium),
            ),
            const SizedBox(height: 12),
            SecondaryButton(
              label: 'ホームに戻る',
              onPressed: () => Navigator.popUntil(context, (route) => route.isFirst),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCommentCard(String comment) {
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
          Text('傾向コメント', style: AppTextStyles.heading3),
          const SizedBox(height: 10),
          Text(comment, style: AppTextStyles.body),
        ],
      ),
    );
  }

  void _onDetailTap(BuildContext context, bool isPremium) {
    if (isPremium) {
      _goToDetail(context);
    } else {
      _showAdDialog(context);
    }
  }

  void _showAdDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => _AdSelectionSheet(onWatchAd: () async {
        Navigator.pop(ctx);
        final adProvider = context.read<AdProvider>();
        final rewarded = await adProvider.watchAd(context);
        if (rewarded && context.mounted) {
          _goToDetail(context);
        } else if (!rewarded && context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(adProvider.errorMessage ?? '広告の読み込みに失敗しました。'),
            ),
          );
        }
      }, onUpgrade: () {
        Navigator.pop(ctx);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const SubscriptionScreen()),
        );
      }),
    );
  }

  void _goToDetail(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const DiagnosisDetailResultScreen()),
    );
  }
}

class _AdSelectionSheet extends StatelessWidget {
  final VoidCallback onWatchAd;
  final VoidCallback onUpgrade;

  const _AdSelectionSheet({required this.onWatchAd, required this.onUpgrade});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      padding: const EdgeInsets.fromLTRB(24, 16, 24, 40),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: AppColors.divider,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 20),
          Text('詳細結果を見る方法', style: AppTextStyles.heading2),
          const SizedBox(height: 8),
          Text(
            '以下のいずれかの方法で詳細結果をご覧いただけます',
            style: AppTextStyles.bodySmall,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          _OptionCard(
            icon: Icons.play_circle_outline,
            title: '広告を見て無料で表示',
            subtitle: '短い広告を見ると詳細結果が表示されます',
            color: AppColors.primary,
            onTap: onWatchAd,
          ),
          const SizedBox(height: 12),
          _OptionCard(
            icon: Icons.star,
            title: 'プレミアムで広告なしで表示',
            subtitle: '詳細結果・履歴・AIアドバイスが使い放題',
            color: AppColors.accent,
            onTap: onUpgrade,
          ),
          const SizedBox(height: 16),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('戻る', style: TextStyle(color: AppColors.textSecondary)),
          ),
        ],
      ),
    );
  }
}

class _OptionCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color color;
  final VoidCallback onTap;

  const _OptionCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: color.withOpacity(0.05),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: color.withOpacity(0.3)),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: color, size: 26),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15)),
                  const SizedBox(height: 2),
                  Text(subtitle, style: const TextStyle(fontSize: 12, color: AppColors.textSecondary)),
                ],
              ),
            ),
            Icon(Icons.chevron_right, color: color),
          ],
        ),
      ),
    );
  }
}
