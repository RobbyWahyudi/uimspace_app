import 'package:flutter/material.dart';
import 'package:uimspace_app/core/theme/space_theme.dart';
import 'package:uimspace_app/core/widgets/space_components.dart';
import 'widgets/home_widgets.dart';
import 'package:uimspace_app/features/notifications/presentation/notification_page.dart';
import 'package:uimspace_app/features/profile/presentation/profile_page.dart';
import 'package:uimspace_app/features/course/data/models/course_models.dart';
import 'package:uimspace_app/features/course/presentation/course_detail_page.dart';

/// Halaman Beranda (Home)
/// Menampilkan dashboard utama dengan:
/// - Header dengan avatar dan sapaan
/// - Search bar
/// - Tugas mendatang
/// - Pengumuman terbaru
/// - Ringkasan progres kelas
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Dummy data - nanti diganti dengan data dari API/state management
  final String _studentName = 'Robby Wahyudi';
  final String? _avatarUrl = null;

  // Search controller
  final TextEditingController _searchController = TextEditingController();

  // Dummy upcoming tasks
  final List<UpcomingTask> _upcomingTasks = [
    UpcomingTask(
      id: '1',
      title: 'Tugas Algoritma Pemrograman',
      courseName: 'Algoritma & Pemrograman',
      dueDate: DateTime.now().add(const Duration(hours: 5)),
      priority: TaskPriority.urgent,
      type: TaskType.assignment,
    ),
    UpcomingTask(
      id: '2',
      title: 'Kuis Basis Data',
      courseName: 'Basis Data',
      dueDate: DateTime.now().add(const Duration(days: 1, hours: 10)),
      priority: TaskPriority.high,
      type: TaskType.quiz,
    ),
    UpcomingTask(
      id: '3',
      title: 'Proyek Website E-Commerce',
      courseName: 'Pemrograman Web',
      dueDate: DateTime.now().add(const Duration(days: 3)),
      priority: TaskPriority.normal,
      type: TaskType.project,
    ),
    UpcomingTask(
      id: '4',
      title: 'UTS Matematika Diskrit',
      courseName: 'Matematika Diskrit',
      dueDate: DateTime.now().add(const Duration(days: 7)),
      priority: TaskPriority.high,
      type: TaskType.exam,
    ),
  ];

  // Dummy announcements
  final List<Announcement> _announcements = [
    Announcement(
      id: '1',
      title: 'Jadwal UAS Semester Ganjil 2024/2025',
      content:
          'Ujian Akhir Semester akan dilaksanakan pada tanggal 15-25 Januari 2025. Pastikan semua mahasiswa sudah menyelesaikan administrasi perkuliahan.',
      date: DateTime.now().subtract(const Duration(hours: 2)),
      type: AnnouncementType.important,
      isRead: false,
      author: 'Bagian Akademik',
    ),
    Announcement(
      id: '2',
      title: 'Seminar Nasional Teknologi Informasi',
      content:
          'Fakultas Teknik mengadakan Seminar Nasional dengan tema "Artificial Intelligence & Future of Education". Pendaftaran dibuka hingga 10 Januari 2025.',
      date: DateTime.now().subtract(const Duration(days: 1)),
      type: AnnouncementType.event,
      isRead: true,
      author: 'Fakultas Teknik',
    ),
    Announcement(
      id: '3',
      title: 'Pemeliharaan Server',
      content:
          'Akan dilakukan pemeliharaan server pada hari Sabtu, 28 Desember 2024 pukul 00:00-06:00 WIB. Layanan akademik tidak dapat diakses selama waktu tersebut.',
      date: DateTime.now().subtract(const Duration(days: 2)),
      type: AnnouncementType.info,
      isRead: true,
      author: 'IT Support',
    ),
  ];

  // Dummy course progress
  final List<CourseProgress> _courseProgress = [
    CourseProgress(
      id: '1',
      name: 'Algoritma & Pemrograman',
      code: 'IF2101',
      completedModules: 12,
      totalModules: 14,
      grade: 87.5,
      accentColor: SpaceColors.primary,
    ),
    CourseProgress(
      id: '2',
      name: 'Basis Data',
      code: 'IF2201',
      completedModules: 8,
      totalModules: 12,
      grade: 82.0,
      accentColor: SpaceColors.secondary,
    ),
    CourseProgress(
      id: '3',
      name: 'Pemrograman Web',
      code: 'IF2301',
      completedModules: 5,
      totalModules: 10,
      grade: 90.0,
      accentColor: const Color(0xFF8B5CF6), // Purple
    ),
    CourseProgress(
      id: '4',
      name: 'Matematika Diskrit',
      code: 'IF1101',
      completedModules: 3,
      totalModules: 14,
      grade: 78.5,
      accentColor: SpaceColors.warning,
    ),
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: SpaceColors.background,
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: _onRefresh,
          color: SpaceColors.primary,
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: SpaceDimensions.screenPadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 1. Header Section (Avatar, Greeting, Notification)
                _buildHeader(),

                const SizedBox(height: SpaceDimensions.spacing16),

                // 2. Search Bar
                _buildSearchBar(),

                const SizedBox(height: SpaceDimensions.spacing24),

                // 3. Quick Stats Row
                _buildQuickStats(),

                const SizedBox(height: SpaceDimensions.spacing24),

                // 4. Upcoming Tasks Section
                UpcomingTasksSection(
                  tasks: _upcomingTasks,
                  onViewAll: _onViewAllTasks,
                  onTaskTap: _onTaskTap,
                ),

                const SizedBox(height: SpaceDimensions.spacing24),

                // 5. Announcements Section
                AnnouncementsSection(
                  announcements: _announcements,
                  onViewAll: _onViewAllAnnouncements,
                  onAnnouncementTap: _onAnnouncementTap,
                ),

                const SizedBox(height: SpaceDimensions.spacing24),

                // 6. Class Progress Section
                ClassProgressSection(
                  courses: _courseProgress,
                  onViewAll: _onViewAllCourses,
                  onCourseTap: _onCourseTap,
                ),

                // Bottom padding for navigation bar
                const SizedBox(height: SpaceDimensions.spacing32),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Header dengan Avatar, Sapaan, dan Notification
  Widget _buildHeader() {
    return Row(
      children: [
        // Avatar
        GestureDetector(
          onTap: _onProfileTap,
          child: SpaceAvatar(
            imageUrl: _avatarUrl,
            name: _studentName,
            size: SpaceDimensions.avatarLg,
          ),
        ),

        const SizedBox(width: SpaceDimensions.spacing12),

        // Greeting and Name
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Halo,',
                style: SpaceTextStyles.bodyMedium.copyWith(
                  color: SpaceColors.textSecondary,
                ),
              ),
              Text(
                _studentName,
                style: SpaceTextStyles.titleLarge.copyWith(
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),

        // Notification Icon with Badge
        Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                // color: SpaceColors.surfaceVariant,
                shape: BoxShape.circle,
              ),
              child: IconButton(
                onPressed: _onNotificationTap,
                icon: const Icon(
                  Icons.notifications_outlined,
                  color: SpaceColors.textPrimary,
                ),
                tooltip: 'Notifikasi',
              ),
            ),
            // Notification badge
            Positioned(
              right: 4,
              top: 4,
              child: Container(
                width: 18,
                height: 18,
                decoration: BoxDecoration(
                  color: SpaceColors.error,
                  shape: BoxShape.circle,
                  border: Border.all(color: SpaceColors.background, width: 2),
                ),
                child: Center(
                  child: Text(
                    '3',
                    style: SpaceTextStyles.badge.copyWith(fontSize: 10),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  /// Search Bar dengan lebar penuh
  Widget _buildSearchBar() {
    return Container(
      decoration: BoxDecoration(
        color: SpaceColors.surfaceVariant,
        borderRadius: BorderRadius.circular(SpaceDimensions.radiusMd),
        border: Border.all(color: SpaceColors.border, width: 1),
      ),
      child: TextField(
        controller: _searchController,
        style: SpaceTextStyles.bodyMedium,
        decoration: InputDecoration(
          hintText: 'Cari mata kuliah, tugas, atau materi...',
          hintStyle: SpaceTextStyles.bodyMedium.copyWith(
            color: SpaceColors.textSecondary,
          ),
          prefixIcon: const Icon(
            Icons.search_rounded,
            color: SpaceColors.textSecondary,
          ),
          suffixIcon: _searchController.text.isNotEmpty
              ? IconButton(
                  onPressed: () {
                    _searchController.clear();
                    setState(() {});
                  },
                  icon: const Icon(
                    Icons.close_rounded,
                    color: SpaceColors.textSecondary,
                    size: SpaceDimensions.iconMd,
                  ),
                )
              : null,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: SpaceDimensions.spacing16,
            vertical: SpaceDimensions.spacing12,
          ),
        ),
        onChanged: (value) {
          setState(() {});
        },
        onSubmitted: _onSearch,
      ),
    );
  }

  /// Quick Stats Row
  Widget _buildQuickStats() {
    return Row(
      children: [
        Expanded(
          child: _QuickStatCard(
            icon: Icons.assignment_turned_in_rounded,
            label: 'Tugas Aktif',
            value: _upcomingTasks.length.toString(),
            color: SpaceColors.primary,
            onTap: _onViewAllTasks,
          ),
        ),
        const SizedBox(width: SpaceDimensions.spacing12),
        Expanded(
          child: _QuickStatCard(
            icon: Icons.calendar_today_rounded,
            label: 'Jadwal Hari Ini',
            value: '3',
            color: SpaceColors.primary,
            onTap: () {
              // Navigate to schedule
            },
          ),
        ),
        const SizedBox(width: SpaceDimensions.spacing12),
        Expanded(
          child: _QuickStatCard(
            icon: Icons.mail_outline_rounded,
            label: 'Pesan Baru',
            value: '5',
            color: SpaceColors.primary,
            onTap: () {
              // Navigate to messages
            },
          ),
        ),
      ],
    );
  }

  // ============================================
  // NAVIGATION METHODS
  // ============================================

  Future<void> _onRefresh() async {
    // Simulate refresh delay
    await Future.delayed(const Duration(seconds: 1));
    // TODO: Implement actual data refresh
  }

  void _onProfileTap() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ProfilePage()),
    );
  }

  void _onNotificationTap() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const NotificationsPage()),
    );
  }

  void _onSearch(String query) {
    // TODO: Implement search
    debugPrint('Search: $query');
  }

  void _onViewAllTasks() {
    // TODO: Navigate to all tasks page
    debugPrint('View All Tasks');
  }

  void _onTaskTap(UpcomingTask task) {
    // TODO: Navigate to task detail
    debugPrint('Open Task: ${task.title}');
  }

  void _onViewAllAnnouncements() {
    // TODO: Navigate to all announcements page
    debugPrint('View All Announcements');
  }

  void _onAnnouncementTap(Announcement announcement) {
    // TODO: Navigate to announcement detail
    debugPrint('Open Announcement: ${announcement.title}');
  }

  void _onViewAllCourses() {
    // TODO: Navigate to all courses page
    debugPrint('View All Courses');
  }

  void _onCourseTap(CourseProgress course) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CourseDetailPage(course: course)),
    );
  }
}

/// Quick Stat Card Widget
class _QuickStatCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color color;
  final VoidCallback? onTap;

  const _QuickStatCard({
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: SpaceDimensions.cardPaddingCompact,
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.1),
          borderRadius: SpaceDimensions.cardRadius,
          border: Border.all(color: color.withValues(alpha: 0.3), width: 1),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: color, size: SpaceDimensions.iconMd),
            const SizedBox(height: SpaceDimensions.spacing8),
            Text(
              value,
              style: SpaceTextStyles.headlineSmall.copyWith(color: color),
            ),
            const SizedBox(height: SpaceDimensions.spacing4),
            Text(
              label,
              style: SpaceTextStyles.labelSmall,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
