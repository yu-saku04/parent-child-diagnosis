import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: const Text('プライバシーポリシー')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('プライバシーポリシー', style: AppTextStyles.heading1),
            SizedBox(height: 8),
            Text('最終更新日：2024年1月1日', style: AppTextStyles.bodySmall),
            SizedBox(height: 20),
            _Section(
              title: '1. 収集する情報',
              content:
                  '本アプリは、診断の回答データをお客様のデバイス上にローカル保存します。氏名、メールアドレス等の個人情報は収集しません。子どもの名前の入力は任意であり、入力しなくてもすべての機能をご利用いただけます。',
            ),
            _Section(
              title: '2. 情報の利用目的',
              content: '収集した情報は、アプリ内での診断結果の表示・履歴管理のみに使用します。第三者への提供は行いません。',
            ),
            _Section(
              title: '3. 広告について',
              content: '無料プランでは、Google AdMob（Google LLC）が提供する広告が表示される場合があります。広告配信のために、Google社が情報を収集することがあります。詳細はGoogle社のプライバシーポリシーをご参照ください。',
            ),
            _Section(
              title: '4. 課金について',
              content: 'プレミアムプランの決済はGoogle Play Billing（Google LLC）を通じて行われます。決済情報はGoogle社が管理します。本アプリは決済情報を収集・保存しません。',
            ),
            _Section(
              title: '5. データの削除',
              content: '設定画面の「診断データを削除」から、ローカルに保存されたすべての診断データを削除できます。',
            ),
            _Section(
              title: '6. 免責事項',
              content: '本アプリは参考情報の提供を目的としています。医療的な診断や治療の代替となるものではありません。診断結果に不安を感じる場合は、専門機関へのご相談をおすすめします。',
            ),
            _Section(
              title: '7. お問い合わせ',
              content: 'ご不明な点や削除依頼については、アプリ内のお問い合わせ機能よりご連絡ください。',
            ),
          ],
        ),
      ),
    );
  }
}

class _Section extends StatelessWidget {
  final String title;
  final String content;

  const _Section({required this.title, required this.content});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: AppTextStyles.heading3),
          const SizedBox(height: 8),
          Text(content, style: AppTextStyles.body),
        ],
      ),
    );
  }
}
