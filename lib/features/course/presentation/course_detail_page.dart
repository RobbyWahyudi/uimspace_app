import 'package:flutter/material.dart';
import 'package:uimspace_app/core/theme/space_theme.dart';
import 'package:uimspace_app/core/widgets/space_card.dart';
import 'package:uimspace_app/features/course/data/models/course_models.dart';
import 'package:uimspace_app/core/widgets/space_components.dart';
import 'package:intl/intl.dart';

class CourseDetailPage extends StatefulWidget {
  final CourseProgress course;

  const CourseDetailPage({super.key, required this.course});

  @override
  State<CourseDetailPage> createState() => _CourseDetailPageState();
}

class _CourseDetailPageState extends State<CourseDetailPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  // Dummy data for materials
  final List<CourseMeeting> _meetings = [
    CourseMeeting(
      id: '1',
      title: 'Pertemuan 1: Pengenalan Mata Kuliah',
      description:
          'Pada pertemuan ini kita akan membahas tentang silabus, kontrak perkuliahan, dan pengenalan dasar mata kuliah.',
      materials: [
        const CourseMaterial(
          id: 'm1',
          title: 'Silabus Perkuliahan',
          type: CourseMaterialType.pdf,
          isOpened: true,
        ),
        const CourseMaterial(
          id: 'm2',
          title: 'Video Pengenalan',
          type: CourseMaterialType.video,
          isOpened: true,
        ),
      ],
    ),
    CourseMeeting(
      id: '2',
      title: 'Pertemuan 2: Dasar-dasar & Teori',
      description:
          'Membahas konsep dasar dan teori pendukung yang akan digunakan selama satu semester ke depan.',
      materials: [
        const CourseMaterial(
          id: 'm3',
          title: 'Modul Teori Dasar',
          type: CourseMaterialType.pdf,
          isOpened: false,
        ),
        const CourseMaterial(
          id: 'm4',
          title: 'Link Referensi Luar',
          type: CourseMaterialType.url,
          isOpened: false,
        ),
        const CourseMaterial(
          id: 'm5',
          title: 'Sesi Tanya Jawab (Recorded Zoom)',
          type: CourseMaterialType.zoom,
          isOpened: false,
        ),
      ],
    ),
    CourseMeeting(
      id: '3',
      title: 'Pertemuan 3: Implementasi Praktis',
      description:
          'Penerapan langsung dari teori yang telah dipelajari pada pertemuan sebelumnya.',
      materials: [
        const CourseMaterial(
          id: 'm6',
          title: 'Panduan Praktikum 1',
          type: CourseMaterialType.pdf,
          isOpened: false,
        ),
      ],
    ),
  ];

  // Dummy data for assessments
  final List<CourseAssessment> _assessments = [
    CourseAssessment(
      id: 't1',
      title: 'Tugas 1: Analisis Konsep',
      type: AssessmentType.assignment,
      deadline: DateTime.now().add(const Duration(days: 2)),
      description:
          'Menganalisis konsep yang telah dipelajari pada pertemuan 1 dan 2.',
    ),
    CourseAssessment(
      id: 'q1',
      title: 'Kuis 1: Dasar Teori',
      type: AssessmentType.quiz,
      deadline: DateTime.now().add(const Duration(days: 4)),
      description: 'Kuis pilihan ganda mengenai materi pertemuan 1-3.',
    ),
    CourseAssessment(
      id: 't2',
      title: 'Tugas 2: Implementasi Mini Project',
      type: AssessmentType.assignment,
      deadline: DateTime.now().add(const Duration(days: 10)),
      description: 'Membuat proyek kecil berdasarkan panduan praktikum.',
      isSubmitted: false,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeColor = widget.course.accentColor ?? SpaceColors.primary;

    return Scaffold(
      backgroundColor: SpaceColors.background,
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverAppBar(
              expandedHeight: 220.0,
              floating: false,
              pinned: true,
              backgroundColor: themeColor,
              leading: Container(
                margin: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.2),
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  icon: const Icon(
                    Icons.arrow_back_ios_new_rounded,
                    color: Colors.white,
                    size: 18,
                  ),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
              flexibleSpace: FlexibleSpaceBar(
                titlePadding: const EdgeInsets.only(
                  left: 16,
                  right: 16,
                  bottom: 16,
                ),
                title: innerBoxIsScrolled
                    ? Text(
                        widget.course.name,
                        style: SpaceTextStyles.titleMedium.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    : null,
                background: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        themeColor,
                        themeColor.withValues(alpha: 0.6),
                        themeColor.withValues(alpha: 0.4),
                      ],
                    ),
                  ),
                  child: Stack(
                    children: [
                      Positioned(
                        right: -30,
                        top: -20,
                        child: Icon(
                          Icons.rocket_launch_rounded,
                          size: 200,
                          color: Colors.white.withValues(alpha: 0.1),
                        ),
                      ),
                      SafeArea(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(24, 64, 24, 24),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.white.withValues(alpha: 0.2),
                                  borderRadius: BorderRadius.circular(
                                    SpaceDimensions.radiusXs,
                                  ),
                                ),
                                child: Text(
                                  widget.course.code,
                                  style: SpaceTextStyles.labelSmall.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                widget.course.name,
                                style: SpaceTextStyles.headlineSmall.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const Spacer(),
                              SpaceProgressBar(
                                value: widget.course.progressPercentage,
                                color: Colors.white,
                                backgroundColor: Colors.white.withValues(
                                  alpha: 0.2,
                                ),
                                height: 6,
                                label: 'Progres Belajar',
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SliverPersistentHeader(
              pinned: true,
              delegate: _SliverAppBarDelegate(
                TabBar(
                  controller: _tabController,
                  labelColor: SpaceColors.primary,
                  unselectedLabelColor: SpaceColors.textSecondary,
                  indicatorColor: SpaceColors.primary,
                  indicatorWeight: 3,
                  indicatorSize: TabBarIndicatorSize.tab,
                  labelStyle: SpaceTextStyles.titleSmall.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                  tabs: const [
                    Tab(text: 'Materi'),
                    Tab(text: 'Tugas & Kuis'),
                  ],
                ),
              ),
            ),
          ];
        },
        body: TabBarView(
          controller: _tabController,
          children: [_buildMateriTab(), _buildTugasTab()],
        ),
      ),
    );
  }

  Widget _buildMateriTab() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _meetings.length,
      itemBuilder: (context, index) {
        final meeting = _meetings[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: SpaceColors.primary.withValues(alpha: 0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        '${index + 1}',
                        style: SpaceTextStyles.labelMedium.copyWith(
                          color: SpaceColors.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      meeting.title,
                      style: SpaceTextStyles.titleMedium.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Container(
                margin: const EdgeInsets.only(left: 16),
                padding: const EdgeInsets.only(left: 24, bottom: 8),
                decoration: const BoxDecoration(
                  border: Border(
                    left: BorderSide(color: SpaceColors.divider, width: 2),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      meeting.description,
                      style: SpaceTextStyles.bodyMedium.copyWith(
                        color: SpaceColors.textSecondary,
                      ),
                    ),
                    const SizedBox(height: 16),
                    ...meeting.materials.map(
                      (materi) => _buildMaterialItem(materi),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildMaterialItem(CourseMaterial materi) {
    IconData iconData;
    Color iconColor;

    switch (materi.type) {
      case CourseMaterialType.pdf:
        iconData = Icons.picture_as_pdf_rounded;
        iconColor = Colors.red.shade400;
        break;
      case CourseMaterialType.video:
        iconData = Icons.play_circle_fill_rounded;
        iconColor = Colors.blue.shade400;
        break;
      case CourseMaterialType.url:
        iconData = Icons.link_rounded;
        iconColor = Colors.green.shade400;
        break;
      case CourseMaterialType.zoom:
        iconData = Icons.videocam_rounded;
        iconColor = Colors.indigo.shade400;
        break;
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: SpaceCard(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        onTap: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Membuka ${materi.title}'),
              behavior: SnackBarBehavior.floating,
              backgroundColor: SpaceColors.primary,
            ),
          );
        },
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: iconColor.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(iconData, color: iconColor, size: 20),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                materi.title,
                style: SpaceTextStyles.bodyMedium.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            if (materi.isOpened)
              const Icon(
                Icons.check_circle_rounded,
                color: SpaceColors.success,
                size: 20,
              )
            else
              const Icon(
                Icons.radio_button_unchecked_rounded,
                color: SpaceColors.textSecondary,
                size: 20,
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildTugasTab() {
    if (_assessments.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.assignment_turned_in_outlined,
              size: 64,
              color: SpaceColors.textSecondary.withValues(alpha: 0.5),
            ),
            const SizedBox(height: 16),
            Text(
              'Tidak ada tugas atau kuis saat ini',
              style: SpaceTextStyles.bodyLarge.copyWith(
                color: SpaceColors.textSecondary,
              ),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _assessments.length,
      itemBuilder: (context, index) {
        final assessment = _assessments[index];
        final isQuiz = assessment.type == AssessmentType.quiz;
        final isOverdue = assessment.deadline.isBefore(DateTime.now());
        final deadlineStr = DateFormat(
          'dd MMM yyyy, HH:mm',
        ).format(assessment.deadline);

        return Padding(
          padding: const EdgeInsets.only(bottom: 12.0),
          child: SpaceCard(
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Membuka detail ${isQuiz ? 'Kuis' : 'Tugas'}'),
                  behavior: SnackBarBehavior.floating,
                ),
              );
            },
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color:
                        (isQuiz ? SpaceColors.secondary : SpaceColors.primary)
                            .withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    isQuiz ? Icons.quiz_rounded : Icons.assignment_rounded,
                    color: isQuiz ? SpaceColors.secondary : SpaceColors.primary,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        assessment.title,
                        style: SpaceTextStyles.titleSmall.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Icon(
                            Icons.timer_outlined,
                            size: 14,
                            color: isOverdue
                                ? SpaceColors.error
                                : SpaceColors.textSecondary,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            deadlineStr,
                            style: SpaceTextStyles.bodySmall.copyWith(
                              color: isOverdue
                                  ? SpaceColors.error
                                  : SpaceColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 14,
                  color: SpaceColors.textSecondary.withValues(alpha: 0.5),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate(this._tabBar);

  final TabBar _tabBar;

  @override
  double get minExtent => _tabBar.preferredSize.height;
  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Container(color: SpaceColors.background, child: _tabBar);
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}
