import 'package:flutter/material.dart';
import 'package:uimspace_app/core/theme/space_theme.dart';
import 'package:uimspace_app/features/quiz/models/quiz_model.dart';

class QuizResultPage extends StatelessWidget {
  final QuizModel quiz;
  final double score;
  final int correctCount;

  const QuizResultPage({
    super.key,
    required this.quiz,
    required this.score,
    required this.correctCount,
  });

  @override
  Widget build(BuildContext context) {
    final isPassed = score >= 70;

    return Scaffold(
      backgroundColor: SpaceColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),

              // Animated Result Icon
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  color: (isPassed ? SpaceColors.success : SpaceColors.error)
                      .withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Icon(
                    isPassed
                        ? Icons.emoji_events_rounded
                        : Icons.sentiment_very_dissatisfied_rounded,
                    size: 64,
                    color: isPassed ? SpaceColors.success : SpaceColors.error,
                  ),
                ),
              ),
              const SizedBox(height: 32),

              // Title
              Text(
                isPassed ? 'Luar Biasa!' : 'Tetap Semangat!',
                style: SpaceTextStyles.headlineSmall.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                isPassed
                    ? 'Anda berhasil menyelesaikan kuis ini dengan sangat baik.'
                    : 'Jangan menyerah, Anda bisa mencoba lagi untuk memperbaiki nilai.',
                textAlign: TextAlign.center,
                style: SpaceTextStyles.bodyMedium.copyWith(
                  color: SpaceColors.textSecondary,
                ),
              ),

              const SizedBox(height: 48),

              // Score Card
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 40,
                  vertical: 24,
                ),
                decoration: BoxDecoration(
                  color: SpaceColors.surfaceVariant.withValues(alpha: 0.3),
                  borderRadius: BorderRadius.circular(SpaceDimensions.radiusLg),
                  border: Border.all(color: SpaceColors.border),
                ),
                child: Column(
                  children: [
                    Text(
                      'Skor Akhir',
                      style: SpaceTextStyles.labelMedium.copyWith(
                        color: SpaceColors.textSecondary,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      score.toInt().toString(),
                      style: SpaceTextStyles.displayLarge.copyWith(
                        color: isPassed
                            ? SpaceColors.success
                            : SpaceColors.error,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 32),

              // Summary Details
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildSummaryItem(
                    Icons.check_circle_rounded,
                    SpaceColors.success,
                    '$correctCount Benar',
                  ),
                  const SizedBox(width: 24),
                  _buildSummaryItem(
                    Icons.cancel_rounded,
                    SpaceColors.error,
                    '${quiz.totalQuestions - correctCount} Salah',
                  ),
                ],
              ),

              const Spacer(),

              // Action Buttons
              ElevatedButton(
                onPressed: () {
                  // Navigate back to class detail or home
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: SpaceColors.primary,
                  foregroundColor: Colors.white,
                  minimumSize: const Size(double.infinity, 56),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      SpaceDimensions.radiusMd,
                    ),
                  ),
                ),
                child: Text(
                  'Kembali ke Kelas',
                  style: SpaceTextStyles.titleSmall.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              if (!isPassed) ...[
                const SizedBox(height: 16),
                TextButton(
                  onPressed: () {
                    // Navigate back to Start page for retry
                    Navigator.pop(context);
                  },
                  child: const Text('Coba Lagi'),
                ),
              ],

              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSummaryItem(IconData icon, Color color, String label) {
    return Row(
      children: [
        Icon(icon, color: color, size: 20),
        const SizedBox(width: 8),
        Text(
          label,
          style: SpaceTextStyles.bodyMedium.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
