import 'package:flutter/material.dart';
import '../models/diagnosis_type.dart';
import '../core/theme/app_colors.dart';
import '../core/theme/app_text_styles.dart';

class DiagnosisCard extends StatelessWidget {
  final DiagnosisType type;
  final VoidCallback onTap;

  const DiagnosisCard({super.key, required this.type, required this.onTap});

  Color get _color {
    switch (type) {
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
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.cardBorder),
          boxShadow: [
            BoxShadow(
              color: _color.withOpacity(0.06),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 52,
              height: 52,
              decoration: BoxDecoration(
                color: _color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: Text(
                  type.iconEmoji,
                  style: const TextStyle(fontSize: 26),
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(type.label, style: AppTextStyles.heading3),
                  const SizedBox(height: 4),
                  Text(
                    type.description,
                    style: AppTextStyles.bodySmall,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            Icon(Icons.chevron_right, color: _color),
          ],
        ),
      ),
    );
  }
}
