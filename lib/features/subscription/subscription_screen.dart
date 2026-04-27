import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../providers/auth_provider.dart';
import '../../providers/subscription_provider.dart';
import '../../widgets/primary_button.dart';
import '../../widgets/secondary_button.dart';
import '../../widgets/loading_view.dart';

class SubscriptionScreen extends StatefulWidget {
  const SubscriptionScreen({super.key});

  @override
  State<SubscriptionScreen> createState() => _SubscriptionScreenState();
}

class _SubscriptionScreenState extends State<SubscriptionScreen> {
  @override
  void initState() {
    super.initState();
    context.read<SubscriptionProvider>().loadPrice();
  }

  @override
  Widget build(BuildContext context) {
    final subProvider = context.watch<SubscriptionProvider>();
    final isPremium = context.watch<AuthProvider>().isPremium;

    if (subProvider.isLoading) {
      return const Scaffold(body: LoadingView(message: '処理中...'));
    }

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: const Text('プレミアムプラン')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            _buildHeroCard(isPremium),
            const SizedBox(height: 24),
            _buildFeatureList(),
            const SizedBox(height: 24),
            _buildComparisonTable(),
            if (subProvider.errorMessage != null) ...[
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.error.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  subProvider.errorMessage!,
                  style: const TextStyle(color: AppColors.error, fontSize: 13),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
            const SizedBox(height: 24),
            if (!isPremium) ...[
              PrimaryButton(
                label: '${subProvider.price ?? '¥480/月'} で始める',
                onPressed: () => _purchase(context),
                icon: const Icon(Icons.star, color: Colors.white, size: 18),
              ),
              const SizedBox(height: 12),
              SecondaryButton(
                label: '購入を復元する',
                onPressed: () => _restore(context),
              ),
            ] else
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.secondary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.check_circle, color: AppColors.secondary),
                    SizedBox(width: 8),
                    Text(
                      'プレミアムプランをご利用中です',
                      style: TextStyle(
                        color: AppColors.secondary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            const SizedBox(height: 20),
            Text(
              '※ サブスクリプションはいつでもキャンセル可能です。\n購入後は自動更新となります。',
              style: AppTextStyles.caption,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildHeroCard(bool isPremium) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFFF8C42), Color(0xFFFFAD69)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        children: [
          const Icon(Icons.star, color: Colors.white, size: 48),
          const SizedBox(height: 12),
          const Text(
            'プレミアムプラン',
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            isPremium ? 'ご利用中' : '広告なし・詳細機能解放',
            style: TextStyle(
              color: Colors.white.withOpacity(0.9),
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureList() {
    const features = [
      ('広告なし', '診断中・結果閲覧時に広告が表示されません', Icons.block),
      ('詳細結果見放題', '広告なしで何度でも詳細結果を確認できます', Icons.description_outlined),
      ('履歴無制限', '過去の診断結果をすべて保存・閲覧できます', Icons.history),
      ('グラフ表示', 'ストレス推移や診断傾向をグラフで確認できます', Icons.bar_chart),
      ('AIアドバイス強化', '詳細なアドバイスと具体的な改善提案が届きます', Icons.auto_awesome),
    ];

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.cardBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('プレミアム機能', style: AppTextStyles.heading3),
          const SizedBox(height: 16),
          ...features.map((f) => _FeatureRow(label: f.$1, desc: f.$2, icon: f.$3)),
        ],
      ),
    );
  }

  Widget _buildComparisonTable() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.cardBorder),
      ),
      child: Column(
        children: [
          _TableHeader(),
          _TableRow(label: '診断利用', free: '○', premium: '○'),
          _TableRow(label: '簡易結果', free: '○', premium: '○'),
          _TableRow(label: '詳細結果', free: '広告視聴後', premium: '無制限'),
          _TableRow(label: '履歴保存', free: '直近3件', premium: '無制限'),
          _TableRow(label: 'グラフ', free: '×', premium: '○'),
          _TableRow(label: 'AIアドバイス', free: '簡易版', premium: '詳細版'),
          _TableRow(label: '広告', free: 'あり', premium: 'なし'),
        ],
      ),
    );
  }

  Future<void> _purchase(BuildContext context) async {
    final subProvider = context.read<SubscriptionProvider>();
    final authProvider = context.read<AuthProvider>();
    final success = await subProvider.purchase();
    if (!context.mounted) return;
    if (success) {
      await authProvider.setPremium(true);
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('プレミアムプランへのアップグレードが完了しました！')),
      );
    }
  }

  Future<void> _restore(BuildContext context) async {
    final subProvider = context.read<SubscriptionProvider>();
    final authProvider = context.read<AuthProvider>();
    final success = await subProvider.restore();
    if (!context.mounted) return;
    if (success) {
      await authProvider.setPremium(true);
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('購入の復元が完了しました！')),
      );
    }
  }
}

class _FeatureRow extends StatelessWidget {
  final String label;
  final String desc;
  final IconData icon;

  const _FeatureRow({required this.label, required this.desc, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: AppColors.accent.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: AppColors.accent, size: 18),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
                Text(desc, style: AppTextStyles.caption),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _TableHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: const BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      child: const Row(
        children: [
          Expanded(flex: 2, child: Text('機能', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13))),
          Expanded(child: Center(child: Text('無料', style: TextStyle(fontSize: 12, color: AppColors.textSecondary)))),
          Expanded(
            child: Center(
              child: Text('プレミアム', style: TextStyle(fontSize: 12, color: AppColors.accent, fontWeight: FontWeight.bold)),
            ),
          ),
        ],
      ),
    );
  }
}

class _TableRow extends StatelessWidget {
  final String label;
  final String free;
  final String premium;

  const _TableRow({required this.label, required this.free, required this.premium});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: const BoxDecoration(
        border: Border(top: BorderSide(color: AppColors.divider)),
      ),
      child: Row(
        children: [
          Expanded(flex: 2, child: Text(label, style: const TextStyle(fontSize: 13))),
          Expanded(child: Center(child: Text(free, style: const TextStyle(fontSize: 12, color: AppColors.textSecondary)))),
          Expanded(
            child: Center(
              child: Text(
                premium,
                style: const TextStyle(fontSize: 12, color: AppColors.accent, fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
