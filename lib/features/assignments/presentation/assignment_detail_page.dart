import 'package:flutter/material.dart';
import 'package:uimspace_app/core/theme/space_theme.dart';
import 'package:uimspace_app/core/widgets/space_card.dart';
import 'package:uimspace_app/core/widgets/space_components.dart';
import 'package:uimspace_app/features/assignments/models/assignment_model.dart';
import 'package:intl/intl.dart';

class AssignmentDetailPage extends StatefulWidget {
  final AssignmentModel assignment;

  const AssignmentDetailPage({super.key, required this.assignment});

  @override
  State<AssignmentDetailPage> createState() => _AssignmentDetailPageState();
}

class _AssignmentDetailPageState extends State<AssignmentDetailPage> {
  late bool _isSubmitted;
  String? _uploadedFileName;
  DateTime? _submissionDate;

  @override
  void initState() {
    super.initState();
    _isSubmitted = widget.assignment.isSubmitted;
    _uploadedFileName = widget.assignment.fileName;
    _submissionDate = widget.assignment.submissionDate;
  }

  void _handleFileUpload() {
    setState(() {
      _uploadedFileName = 'Tugas_Pekan_1_Robby.pdf';
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('File berhasil dipilih'),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _handleSubmit() {
    if (_uploadedFileName == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Silakan upload file terlebih dahulu'),
          behavior: SnackBarBehavior.floating,
          backgroundColor: SpaceColors.error,
        ),
      );
      return;
    }

    setState(() {
      _isSubmitted = true;
      _submissionDate = DateTime.now();
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Tugas berhasil dikumpulkan'),
        behavior: SnackBarBehavior.floating,
        backgroundColor: SpaceColors.success,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isQuiz = widget.assignment.type == AssignmentType.quiz;
    final isGraded = widget.assignment.grade != null;
    final isOverdue =
        widget.assignment.deadline.isBefore(DateTime.now()) && !_isSubmitted;
    final deadlineStr = DateFormat(
      'dd MMM yyyy, HH:mm',
    ).format(widget.assignment.deadline);

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
          isQuiz ? 'Detail Kuis' : 'Detail Tugas',
          style: SpaceTextStyles.titleMedium.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildStatusBadge(isGraded, isOverdue),
            const SizedBox(height: 16),
            Text(
              widget.assignment.title,
              style: SpaceTextStyles.headlineSmall.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: _buildInfoItem(
                    Icons.calendar_month_rounded,
                    'Deadline',
                    deadlineStr,
                    isOverdue ? SpaceColors.error : SpaceColors.textSecondary,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildInfoItem(
                    Icons.assignment_ind_rounded,
                    'Tipe',
                    isQuiz ? 'Kuis Online' : 'Upload File',
                    SpaceColors.primary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),
            Text(
              'Deskripsi',
              style: SpaceTextStyles.titleSmall.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              widget.assignment.description ??
                  'Tidak ada deskripsi untuk tugas ini.',
              style: SpaceTextStyles.bodyMedium.copyWith(
                color: SpaceColors.textSecondary,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 32),
            if (!isQuiz) ...[
              Text(
                'Pengumpulan',
                style: SpaceTextStyles.titleSmall.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              if (_isSubmitted)
                _buildSubmittedView(isGraded)
              else
                _buildUploadForm(),
            ],
            const SizedBox(height: 40),
          ],
        ),
      ),
      bottomNavigationBar: !_isSubmitted && !isQuiz
          ? _buildBottomAction()
          : null,
    );
  }

  Widget _buildStatusBadge(bool isGraded, bool isOverdue) {
    String text;
    Color color;

    if (isGraded) {
      text = 'Sudah Dinilai';
      color = SpaceColors.success;
    } else if (_isSubmitted) {
      text = 'Terkirim';
      color = SpaceColors.info;
    } else if (isOverdue) {
      text = 'Terlambat';
      color = SpaceColors.error;
    } else {
      text = 'Belum Dikumpulkan';
      color = SpaceColors.warning;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(SpaceDimensions.radiusXs),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Text(
        text,
        style: SpaceTextStyles.labelSmall.copyWith(
          color: color,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildInfoItem(
    IconData icon,
    String label,
    String value,
    Color valueColor,
  ) {
    return SpaceCard(
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 20, color: SpaceColors.textSecondary),
          const SizedBox(height: 8),
          Text(
            label,
            style: SpaceTextStyles.labelSmall.copyWith(
              color: SpaceColors.textSecondary,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: SpaceTextStyles.bodySmall.copyWith(
              color: valueColor,
              fontWeight: FontWeight.bold,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Widget _buildUploadForm() {
    return InkWell(
      onTap: _handleFileUpload,
      borderRadius: BorderRadius.circular(SpaceDimensions.radiusMd),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 32),
        decoration: BoxDecoration(
          color: SpaceColors.surfaceVariant.withValues(alpha: 0.5),
          borderRadius: BorderRadius.circular(SpaceDimensions.radiusMd),
          border: Border.all(
            color: SpaceColors.border,
            style: BorderStyle.solid,
          ),
        ),
        child: Column(
          children: [
            if (_uploadedFileName == null) ...[
              const Icon(
                Icons.cloud_upload_outlined,
                size: 48,
                color: SpaceColors.primary,
              ),
              const SizedBox(height: 12),
              Text('Klik untuk upload file', style: SpaceTextStyles.bodyMedium),
              const SizedBox(height: 4),
              Text(
                'Format: PDF, ZIP (Max 10MB)',
                style: SpaceTextStyles.bodySmall.copyWith(
                  color: SpaceColors.textSecondary,
                ),
              ),
            ] else ...[
              const Icon(
                Icons.insert_drive_file_rounded,
                size: 48,
                color: SpaceColors.success,
              ),
              const SizedBox(height: 12),
              Text(
                _uploadedFileName!,
                style: SpaceTextStyles.bodyMedium.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              TextButton(
                onPressed: _handleFileUpload,
                child: const Text('Ganti File'),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildSubmittedView(bool isGraded) {
    return SpaceCard(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                Icons.check_circle_rounded,
                color: SpaceColors.success,
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                'Tugas telah dikumpulkan',
                style: SpaceTextStyles.bodyMedium.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildDetailRow(
            'Waktu Pengiriman',
            DateFormat('dd MMM yyyy, HH:mm').format(_submissionDate!),
          ),
          _buildDetailRow('Nama File', _uploadedFileName ?? '-'),
          if (isGraded) ...[
            const SpaceDivider(height: 1),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Nilai',
                  style: SpaceTextStyles.bodyMedium.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  widget.assignment.grade?.toString() ?? '-',
                  style: SpaceTextStyles.headlineSmall.copyWith(
                    color: SpaceColors.success,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            if (widget.assignment.feedback != null) ...[
              const SizedBox(height: 12),
              Text('Feedback:', style: SpaceTextStyles.labelSmall),
              const SizedBox(height: 4),
              Text(
                widget.assignment.feedback!,
                style: SpaceTextStyles.bodySmall.copyWith(
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ] else ...[
            const SizedBox(height: 12),
            Text(
              'Belum dinilai oleh dosen',
              style: SpaceTextStyles.bodySmall.copyWith(
                color: SpaceColors.textSecondary,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: SpaceTextStyles.bodySmall.copyWith(
              color: SpaceColors.textSecondary,
            ),
          ),
          Text(
            value,
            style: SpaceTextStyles.bodySmall.copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomAction() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: SpaceColors.surface,
        border: const Border(top: BorderSide(color: SpaceColors.border)),
      ),
      child: ElevatedButton(
        onPressed: _handleSubmit,
        style: ElevatedButton.styleFrom(
          backgroundColor: SpaceColors.primary,
          foregroundColor: Colors.white,
          minimumSize: const Size(double.infinity, 54),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(SpaceDimensions.radiusMd),
          ),
          elevation: 0,
        ),
        child: Text(
          'Kumpulkan Tugas',
          style: SpaceTextStyles.titleSmall.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
