import 'dart:async';
import 'package:flutter/material.dart';
import 'package:uimspace_app/core/theme/space_theme.dart';
import 'package:uimspace_app/core/widgets/space_components.dart';
import 'package:uimspace_app/features/quiz/models/quiz_model.dart';
import 'quiz_result_page.dart';

class QuizQuestionPage extends StatefulWidget {
  final QuizModel quiz;

  const QuizQuestionPage({super.key, required this.quiz});

  @override
  State<QuizQuestionPage> createState() => _QuizQuestionPageState();
}

class _QuizQuestionPageState extends State<QuizQuestionPage> {
  int _currentIndex = 0;
  late List<int?> _answers;
  late Timer _timer;
  int _secondsRemaining = 0;

  @override
  void initState() {
    super.initState();
    _answers = List.generate(widget.quiz.totalQuestions, (_) => null);
    _secondsRemaining = widget.quiz.durationMinutes * 60;
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_secondsRemaining > 0) {
          _secondsRemaining--;
        } else {
          _timer.cancel();
          _submitQuiz();
        }
      });
    });
  }

  String _formatTime(int totalSeconds) {
    final minutes = totalSeconds ~/ 60;
    final seconds = totalSeconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  void _submitQuiz() {
    _timer.cancel();

    // Calculate score (mock logic)
    int correctCount = 0;
    if (widget.quiz.questions != null) {
      for (int i = 0; i < widget.quiz.questions!.length; i++) {
        if (_answers[i] == widget.quiz.questions![i].correctOptionIndex) {
          correctCount++;
        }
      }
    } else {
      // Mock random correct answers for dummy mode
      correctCount = _answers.where((a) => a != null).length;
    }

    final double score = (correctCount / widget.quiz.totalQuestions) * 100;

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => QuizResultPage(
          quiz: widget.quiz,
          score: score,
          correctCount: correctCount,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final question = widget.quiz.questions?[_currentIndex];
    final progress = (_currentIndex + 1) / widget.quiz.totalQuestions;

    return Scaffold(
      backgroundColor: SpaceColors.background,
      appBar: AppBar(
        backgroundColor: SpaceColors.background,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Soal ${_currentIndex + 1}/${widget.quiz.totalQuestions}',
              style: SpaceTextStyles.titleSmall.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: _secondsRemaining < 60
                    ? SpaceColors.error.withValues(alpha: 0.1)
                    : SpaceColors.primary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.timer_outlined,
                    size: 16,
                    color: _secondsRemaining < 60
                        ? SpaceColors.error
                        : SpaceColors.primary,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    _formatTime(_secondsRemaining),
                    style: SpaceTextStyles.labelMedium.copyWith(
                      color: _secondsRemaining < 60
                          ? SpaceColors.error
                          : SpaceColors.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            SpaceProgressBar(
              value: progress,
              height: 4,
              backgroundColor: SpaceColors.border,
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      question?.text ?? 'Apa kepanjangan dari UIM?',
                      style: SpaceTextStyles.titleLarge.copyWith(height: 1.4),
                    ),
                    const SizedBox(height: 32),
                    ...List.generate(
                      question?.options.length ?? 4,
                      (index) => _buildOption(
                        index,
                        question?.options[index] ?? 'Opsi ${index + 1}',
                      ),
                    ),
                  ],
                ),
              ),
            ),
            _buildNavigation(),
          ],
        ),
      ),
    );
  }

  Widget _buildOption(int index, String text) {
    final isSelected = _answers[_currentIndex] == index;

    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: InkWell(
        onTap: () {
          setState(() {
            _answers[_currentIndex] = index;
          });
        },
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: isSelected
                ? SpaceColors.primary.withValues(alpha: 0.05)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: isSelected ? SpaceColors.primary : SpaceColors.border,
              width: isSelected ? 2 : 1,
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: isSelected ? SpaceColors.primary : Colors.transparent,
                  border: Border.all(
                    color: isSelected
                        ? SpaceColors.primary
                        : SpaceColors.textSecondary,
                  ),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    String.fromCharCode(65 + index),
                    style: SpaceTextStyles.labelMedium.copyWith(
                      color: isSelected
                          ? Colors.white
                          : SpaceColors.textSecondary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  text,
                  style: SpaceTextStyles.bodyMedium.copyWith(
                    fontWeight: isSelected
                        ? FontWeight.bold
                        : FontWeight.normal,
                    color: isSelected
                        ? SpaceColors.primary
                        : SpaceColors.textPrimary,
                  ),
                ),
              ),
              if (isSelected)
                const Icon(
                  Icons.check_circle_rounded,
                  color: SpaceColors.primary,
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavigation() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: SpaceColors.surface,
        border: const Border(top: BorderSide(color: SpaceColors.border)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (_currentIndex > 0)
            TextButton.icon(
              onPressed: () {
                setState(() => _currentIndex--);
              },
              icon: const Icon(Icons.arrow_back),
              label: const Text('Kembali'),
            )
          else
            const SizedBox.shrink(),

          ElevatedButton(
            onPressed: () {
              if (_currentIndex < widget.quiz.totalQuestions - 1) {
                setState(() => _currentIndex++);
              } else {
                _showConfirmSubmit();
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: SpaceColors.primary,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(SpaceDimensions.radiusMd),
              ),
            ),
            child: Text(
              _currentIndex < widget.quiz.totalQuestions - 1
                  ? 'Lanjut'
                  : 'Selesai',
              style: SpaceTextStyles.labelMedium.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showConfirmSubmit() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Selesaikan Kuis?'),
        content: const Text(
          'Pastikan semua jawaban sudah terisi dengan benar.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Batal'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              _submitQuiz();
            },
            child: const Text('Ya, Selesai'),
          ),
        ],
      ),
    );
  }
}
