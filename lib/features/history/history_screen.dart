import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../core/utils/date_utils.dart';
import '../../core/constants/app_constants.dart';
import '../../models/diagnosis_result.dart';
import '../../models/diagnosis_type.dart';
import '../../providers/auth_provider.dart';
import '../../providers/history_provider.dart';
import '../../widgets/loading_view.dart';
import '../subscription/subscription_screen.dart';
import 'history_detail_screen.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final historyProvider = context.watch<HistoryProvider>();
    final isPremium = context.watch<AuthProvider>().isPremium;
    final results = historyProvider.visibleResults(isPremium);
    final allCount = historyProvider.allResults.length;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: const Text('診断履歴')),
      body: historyProvider.isLoading
          ? const LoadingView(message: '履歴を読み込み中...')
          : Column(
              children: [
                if (!isPremium && allCount > AppConstants.freeHistoryLimit)
                  _buildFreeNotice(context, allCount),
                Expanded(
                  child: results.isEmpty
                      ? _buildEmptyState()
                      : ListView.separated(
                          padding: const EdgeInsets.all(16),
                          itemCount: results.length,
                          separatorBuilder: (_, __) => const SizedBox(height: 10),
                          itemBuilder: (ctx, i) => _HistoryCard(
                            result: results[i],
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => HistoryDetailScreen(result: results[i]),
                              ),
                            ),
                          ),
                        ),
                ),
              ],
            ),
    );
  }

  Widget _buildFreeNotice(BuildContext context, int allCount) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.accent.withOpacity(0.08),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.accent.withOpacity(0.3)),
      ),
      child: Row(
        children: [
          const Icon(Icons.lock_outline, color: AppColors.accent, size: 18),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              '無料プランでは直近${AppConstants.freeHistoryLimit}件のみ表示されます（全$allCount件）',
              style: const TextStyle(fontSize: 13, color: AppColors.textSecondary),
            ),
          ),
          GestureDetector(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const SubscriptionScreen()),
            ),
            child: const Text(
              'プレミアムへ',
              style: TextStyle(fontSize: 12, color: AppColors.accent, fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.history, size: 64, color: AppColors.textHint),
          const SizedBox(height: 12),
          Text('まだ診断履歴がありません', style: AppTextStyles.body),
          const SizedBox(height: 4),
          Text('診断を完了すると履歴が保存されます', style: AppTextStyles.bodySmall),
        ],
      ),
    );
  }
}

class _HistoryCard extends StatelessWidget {
  final DiagnosisResult result;
  final VoidCallback onTap;

  const _HistoryCard({required this.result, required this.onTap});

  Color get _typeColor {
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

  String get _typeLabel {
    final type = DiagnosisType.values.firstWhere(
      (t) => t.storageKey == result.diagnosisType,
      orElse: () => DiagnosisType.stress,
    );
    return type.shortLabel;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: AppColors.cardBorder),
        ),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: _typeColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: Text(
                  DiagnosisType.values
                      .firstWhere(
                        (t) => t.storageKey == result.diagnosisType,
                        orElse: () => DiagnosisType.stress,
                      )
                      .iconEmoji,
                  style: const TextStyle(fontSize: 22),
                ),
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(_typeLabel, style: AppTextStyles.heading3),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                          color: _typeColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          result.typeLabel,
                          style: TextStyle(fontSize: 11, color: _typeColor, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    AppDateUtils.formatDate(result.createdAt),
                    style: AppTextStyles.bodySmall,
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '${result.score}/${result.maxScore}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: _typeColor,
                    fontSize: 16,
                  ),
                ),
                const Icon(Icons.chevron_right, color: AppColors.textHint, size: 18),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
