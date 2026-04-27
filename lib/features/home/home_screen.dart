import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/constants/app_constants.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../models/diagnosis_type.dart';
import '../../providers/auth_provider.dart';
import '../../providers/history_provider.dart';
import '../../widgets/diagnosis_card.dart';
import '../../widgets/premium_badge.dart';
import '../diagnosis/diagnosis_question_screen.dart';
import '../history/history_screen.dart';
import '../subscription/subscription_screen.dart';
import '../settings/settings_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<HistoryProvider>().load();
    });
  }

  void _startDiagnosis(DiagnosisType type) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => DiagnosisQuestionScreen(type: type),
      ),
    );
  }

  void _openHistory() {
    Navigator.push(context, MaterialPageRoute(builder: (_) => const HistoryScreen()));
  }

  void _openSubscription() {
    Navigator.push(context, MaterialPageRoute(builder: (_) => const SubscriptionScreen()));
  }

  void _openSettings() {
    Navigator.push(context, MaterialPageRoute(builder: (_) => const SettingsScreen()));
  }

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthProvider>();
    final isPremium = auth.isPremium;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text(AppConstants.appName),
        actions: [
          if (isPremium) const Padding(
            padding: EdgeInsets.only(right: 8),
            child: Center(child: PremiumBadge()),
          ),
          IconButton(
            icon: const Icon(Icons.settings_outlined),
            onPressed: _openSettings,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildWelcomeCard(isPremium),
            const SizedBox(height: 24),
            Text('今日の状態チェック', style: AppTextStyles.heading2),
            const SizedBox(height: 4),
            Text(
              '気になる診断を選んで始めましょう',
              style: AppTextStyles.bodySmall,
            ),
            const SizedBox(height: 16),
            DiagnosisCard(type: DiagnosisType.stress, onTap: () => _startDiagnosis(DiagnosisType.stress)),
            const SizedBox(height: 12),
            DiagnosisCard(type: DiagnosisType.talent, onTap: () => _startDiagnosis(DiagnosisType.talent)),
            const SizedBox(height: 12),
            DiagnosisCard(type: DiagnosisType.ngBehavior, onTap: () => _startDiagnosis(DiagnosisType.ngBehavior)),
            const SizedBox(height: 24),
            _buildHistoryButton(),
            if (!isPremium) ...[
              const SizedBox(height: 16),
              _buildPremiumBanner(),
            ],
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildWelcomeCard(bool isPremium) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppColors.primaryLight, AppColors.primary],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '今日も一緒にいることが\n一番大切なことです',
            style: TextStyle(
              color: Colors.white,
              fontSize: 17,
              fontWeight: FontWeight.w600,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            isPremium ? 'プレミアムプランご利用中' : '診断を始めて、今の状態を確認しましょう',
            style: TextStyle(
              color: Colors.white.withOpacity(0.85),
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHistoryButton() {
    return InkWell(
      onTap: _openHistory,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.cardBorder),
        ),
        child: Row(
          children: [
            const Icon(Icons.history, color: AppColors.primary),
            const SizedBox(width: 12),
            Text('診断履歴を見る', style: AppTextStyles.heading3),
            const Spacer(),
            const Icon(Icons.chevron_right, color: AppColors.textHint),
          ],
        ),
      ),
    );
  }

  Widget _buildPremiumBanner() {
    return GestureDetector(
      onTap: _openSubscription,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFFFFF8EE),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.accent.withOpacity(0.3)),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColors.accent.withOpacity(0.15),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(Icons.star, color: AppColors.accent, size: 22),
            ),
            const SizedBox(width: 12),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'プレミアムプランで詳細機能を解放',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  SizedBox(height: 2),
                  Text(
                    '広告なし・履歴無制限・AIアドバイス',
                    style: TextStyle(fontSize: 12, color: AppColors.textSecondary),
                  ),
                ],
              ),
            ),
            const Icon(Icons.chevron_right, color: AppColors.accent),
          ],
        ),
      ),
    );
  }
}
