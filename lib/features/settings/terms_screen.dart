import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';

class TermsScreen extends StatelessWidget {
  const TermsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: const Text('利用規約')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('利用規約', style: AppTextStyles.heading1),
            SizedBox(height: 8),
            Text('最終更新日：2024年1月1日', style: AppTextStyles.bodySmall),
            SizedBox(height: 20),
            _Section(
              title: '第1条（目的）',
              content: '本規約は、親子コンディション診断アプリ（以下「本アプリ」）の利用条件を定めるものです。ユーザーは本規約に同意した上で本アプリをご利用ください。',
            ),
            _Section(
              title: '第2条（サービス内容）',
              content: '本アプリは、親のストレス傾向・子どもの才能タイプ・親のNG行動傾向を可視化するための診断ツールを提供します。本アプリは参考情報の提供を目的とするものであり、医療的な診断や治療の代替となるものではありません。',
            ),
            _Section(
              title: '第3条（免責事項）',
              content: '本アプリの診断結果は、あくまでも参考情報です。「可能性があります」「傾向があります」という表現を使用しており、個々の状況を断定するものではありません。診断結果に基づく判断や行動については、ユーザー自身の責任において行ってください。不安な点がある場合は、専門機関にご相談ください。',
            ),
            _Section(
              title: '第4条（禁止事項）',
              content: 'ユーザーは以下の行為を行ってはなりません。\n・本アプリを商業目的で無断使用すること\n・本アプリのリバースエンジニアリング\n・他のユーザーへの迷惑行為\n・法令に違反する行為',
            ),
            _Section(
              title: '第5条（課金）',
              content: 'プレミアムプランは月額制サブスクリプションです。解約しない限り自動更新されます。解約はGoogle Playの設定から行えます。一度購入した料金の返金は、各ストアの規定に従います。',
            ),
            _Section(
              title: '第6条（規約の変更）',
              content: '本規約は、必要に応じて変更することがあります。変更後は、アプリ内に掲載した時点で効力を生じます。',
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
