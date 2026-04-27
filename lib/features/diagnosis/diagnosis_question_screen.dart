import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../models/diagnosis_type.dart';
import '../../models/question.dart';
import '../../providers/auth_provider.dart';
import '../../providers/diagnosis_provider.dart';
import '../../providers/history_provider.dart';
import 'diagnosis_simple_result_screen.dart';

class DiagnosisQuestionScreen extends StatefulWidget {
  final DiagnosisType type;
  final String? ageGroup;

  const DiagnosisQuestionScreen({super.key, required this.type, this.ageGroup});

  @override
  State<DiagnosisQuestionScreen> createState() =>
      _DiagnosisQuestionScreenState();
}

class _DiagnosisQuestionScreenState extends State<DiagnosisQuestionScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<DiagnosisProvider>().startDiagnosis(widget.type, ageGroup: widget.ageGroup);
    });
  }

  void _onChoiceSelected(Choice choice) {
    context.read<DiagnosisProvider>().selectAnswer(choice);
  }

  void _onNext() {
    final provider = context.read<DiagnosisProvider>();
    if (provider.currentAnswer == null) return;

    if (provider.isLastQuestion) {
      _finish();
    } else {
      provider.goNext();
    }
  }

  void _onPrevious() {
    context.read<DiagnosisProvider>().goPrevious();
  }

  void _finish() {
    final diagProvider = context.read<DiagnosisProvider>();
    final authProvider = context.read<AuthProvider>();
    final historyProvider = context.read<HistoryProvider>();
    final isPremium = authProvider.isPremium;

    final result = diagProvider.calculateResult(authProvider.userId, isPremium);
    historyProvider.save(result);
    diagProvider.markSaved();

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => const DiagnosisSimpleResultScreen(),
      ),
    );
  }

  Color get _typeColor {
    switch (widget.type) {
      case DiagnosisType.stress:
        return AppColors.stressColor;
      case DiagnosisType.talent:
        return AppColors.talentColor;
      case DiagnosisType.ngBehavior:
        return AppColors.ngBehaviorColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<DiagnosisProvider>();
    final question = provider.currentQuestion;

    if (question == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(widget.type.shortLabel),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => _showExitDialog(),
        ),
      ),
      body: Column(
        children: [
          _buildProgressBar(provider),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildQuestionHeader(provider),
                  const SizedBox(height: 24),
                  _buildChoices(question, provider),
                ],
              ),
            ),
          ),
          _buildNavButtons(provider),
        ],
      ),
    );
  }

  Widget _buildProgressBar(DiagnosisProvider provider) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      color: Colors.white,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Q${provider.currentIndex + 1} / ${provider.totalQuestions}',
                style: AppTextStyles.bodySmall,
              ),
              Text(
                '${((provider.progress) * 100).toInt()}%',
                style: AppTextStyles.bodySmall,
              ),
            ],
          ),
          const SizedBox(height: 6),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: (provider.currentIndex + 1) / provider.totalQuestions,
              backgroundColor: AppColors.divider,
              valueColor: AlwaysStoppedAnimation<Color>(_typeColor),
              minHeight: 6,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuestionHeader(DiagnosisProvider provider) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          decoration: BoxDecoration(
            color: _typeColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            'Q${provider.currentIndex + 1}',
            style: TextStyle(
              color: _typeColor,
              fontWeight: FontWeight.bold,
              fontSize: 13,
            ),
          ),
        ),
        const SizedBox(height: 12),
        Text(
          provider.currentQuestion!.text,
          style: AppTextStyles.heading2,
        ),
      ],
    );
  }

  Widget _buildChoices(Question question, DiagnosisProvider provider) {
    return Column(
      children: question.choices.asMap().entries.map((entry) {
        final choice = entry.value;
        final isSelected = provider.currentAnswer?.label == choice.label;

        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: _ChoiceButton(
            choice: choice,
            isSelected: isSelected,
            color: _typeColor,
            onTap: () => _onChoiceSelected(choice),
            index: entry.key,
          ),
        );
      }).toList(),
    );
  }

  Widget _buildNavButtons(DiagnosisProvider provider) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 28),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: AppColors.divider)),
      ),
      child: Row(
        children: [
          if (provider.currentIndex > 0)
            Expanded(
              child: OutlinedButton(
                onPressed: _onPrevious,
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppColors.textSecondary,
                  side: const BorderSide(color: AppColors.divider),
                  minimumSize: const Size(0, 48),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: const Text('戻る'),
              ),
            ),
          if (provider.currentIndex > 0) const SizedBox(width: 12),
          Expanded(
            flex: 2,
            child: ElevatedButton(
              onPressed: provider.currentAnswer != null ? _onNext : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: _typeColor,
                foregroundColor: Colors.white,
                minimumSize: const Size(0, 48),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                disabledBackgroundColor: AppColors.divider,
              ),
              child: Text(
                provider.isLastQuestion ? '結果を見る' : '次へ',
                style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showExitDialog() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('診断を中断しますか？'),
        content: const Text('途中で終了すると、回答内容は保存されません。'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('続ける'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
              Navigator.pop(context);
            },
            child: const Text('中断する', style: TextStyle(color: AppColors.error)),
          ),
        ],
      ),
    );
  }
}

class _ChoiceButton extends StatelessWidget {
  final Choice choice;
  final bool isSelected;
  final Color color;
  final VoidCallback onTap;
  final int index;

  const _ChoiceButton({
    required this.choice,
    required this.isSelected,
    required this.color,
    required this.onTap,
    required this.index,
  });

  static const _labels = ['A', 'B', 'C', 'D'];

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected ? color.withOpacity(0.08) : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? color : AppColors.cardBorder,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: isSelected ? color : const Color(0xFFEEEFF3),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: Text(
                  index < _labels.length ? _labels[index] : '${index + 1}',
                  style: TextStyle(
                    color: isSelected ? Colors.white : AppColors.textSecondary,
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                choice.label,
                style: TextStyle(
                  fontSize: 15,
                  color: isSelected ? color : AppColors.textPrimary,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                ),
              ),
            ),
            if (isSelected)
              Icon(Icons.check_circle, color: color, size: 20),
          ],
        ),
      ),
    );
  }
}
