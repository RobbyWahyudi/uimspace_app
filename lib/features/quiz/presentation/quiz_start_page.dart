import 'package:flutter/material.dart';
import 'package:uimspace_app/core/theme/space_theme.dart';
import 'package:uimspace_app/core/widgets/space_card.dart';
import 'package:uimspace_app/features/quiz/models/quiz_model.dart';
import 'quiz_question_page.dart';

class QuizStartPage extends StatelessWidget {
  final QuizModel quiz;

  const QuizStartPage({super.key, required this.quiz});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: SpaceColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: SpaceColors.textPrimary,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Persiapan Kuis',
          style: SpaceTextStyles.titleMedium.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Image/Icon
              Center(
                child: Container(
                  padding: const EdgeInsets.all(32),
                  decoration: BoxDecoration(
                    color: SpaceColors.primary.withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.quiz_rounded,
                    size: 64,
                    color: SpaceColors.primary,
                  ),
                ),
              ),
              const SizedBox(height: 32),

              // Quiz Title
              Center(
                child: Text(
                  quiz.title,
                  textAlign: TextAlign.center,
                  style: SpaceTextStyles.headlineSmall.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Description
              Text(
                quiz.description,
                textAlign: TextAlign.center,
                style: SpaceTextStyles.bodyMedium.copyWith(
                  color: SpaceColors.textSecondary,
                ),
              ),

              const SizedBox(height: 40),

              // Rules/Stats Card
              Text(
                'Detail Kuis',
                style: SpaceTextStyles.titleSmall.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: _buildInfoCard(
                      Icons.timer_outlined,
                      'Waktu',
                      '${quiz.durationMinutes} Menit',
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildInfoCard(
                      Icons.help_outline_rounded,
                      'Soal',
                      '${quiz.totalQuestions} Pertanyaan',
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              _buildInfoCard(
                Icons.stars_rounded,
                'Kriteria Lulus',
                'Minimal 70% Jawaban Benar',
              ),

              const SizedBox(height: 32),

              // Instruction list
              Text(
                'Instruksi',
                style: SpaceTextStyles.titleSmall.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              _buildInstructionItem(
                'Selesaikan kuis dalam batas waktu yang ditentukan.',
              ),
              _buildInstructionItem(
                'Jawaban akan tersimpan otomatis setiap soal.',
              ),
              _buildInstructionItem('Pastikan koneksi internet stabil.'),
              _buildInstructionItem(
                'Hasil akan langsung ditampilkan setelah submit.',
              ),

              const SizedBox(height: 32),

              // Start Button (Moved here)
              ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => QuizQuestionPage(quiz: quiz),
                    ),
                  );
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
                  elevation: 0,
                ),
                child: Text(
                  'Mulai Kuis Sekarang',
                  style: SpaceTextStyles.titleSmall.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoCard(IconData icon, String label, String value) {
    return SpaceCard(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Icon(icon, color: SpaceColors.primary, size: 24),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: SpaceTextStyles.labelSmall.copyWith(
                  color: SpaceColors.textSecondary,
                ),
              ),
              Text(
                value,
                style: SpaceTextStyles.bodyMedium.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInstructionItem(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(
            Icons.check_circle_outline_rounded,
            color: SpaceColors.success,
            size: 18,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: SpaceTextStyles.bodySmall.copyWith(
                color: SpaceColors.textSecondary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
