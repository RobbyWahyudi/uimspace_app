import 'package:flutter/material.dart';
import 'package:uimspace_app/core/theme/space_theme.dart';
import 'package:uimspace_app/core/widgets/space_card.dart';
import '../models/course_model.dart';

/// Halaman Kelas Saya (My Courses)
/// Menampilkan seluruh mata kuliah yang diambil dengan:
/// - Nama mata kuliah
/// - Kode kelas
/// - Progress bar (% selesai)
class MyCoursesPage extends StatefulWidget {
  const MyCoursesPage({super.key});

  @override
  State<MyCoursesPage> createState() => _MyCoursesPageState();
}

class _MyCoursesPageState extends State<MyCoursesPage> {
  // Filter state
  CourseFilter _selectedFilter = CourseFilter.all;

  // Search controller
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  // Dummy data untuk mata kuliah
  final List<Course> _courses = [
    Course(
      id: '1',
      name: 'Algoritma & Pemrograman',
      code: 'IF2101',
      description:
          'Dasar-dasar algoritma dan pemrograman menggunakan bahasa C/C++',
      instructor: 'Dr. Ahmad Fauzi, M.Kom',
      completedModules: 12,
      totalModules: 14,
      grade: 87.5,
      accentColor: SpaceColors.primary,
      credits: 4,
      semester: 'Ganjil 2024/2025',
      lastAccessed: DateTime.now().subtract(const Duration(hours: 2)),
    ),
    Course(
      id: '2',
      name: 'Basis Data',
      code: 'IF2201',
      description: 'Konsep dan implementasi sistem basis data relasional',
      instructor: 'Prof. Budi Santoso, Ph.D',
      completedModules: 8,
      totalModules: 12,
      grade: 82.0,
      accentColor: SpaceColors.secondary,
      credits: 3,
      semester: 'Ganjil 2024/2025',
      lastAccessed: DateTime.now().subtract(const Duration(days: 1)),
    ),
    Course(
      id: '3',
      name: 'Pemrograman Web',
      code: 'IF2301',
      description:
          'Pengembangan aplikasi web menggunakan HTML, CSS, JavaScript',
      instructor: 'Dewi Kartika, S.Kom, M.T',
      completedModules: 5,
      totalModules: 10,
      grade: 90.0,
      accentColor: const Color(0xFF8B5CF6),
      credits: 3,
      semester: 'Ganjil 2024/2025',
      lastAccessed: DateTime.now().subtract(const Duration(hours: 5)),
    ),
    Course(
      id: '4',
      name: 'Matematika Diskrit',
      code: 'IF1101',
      description: 'Logika matematika, teori himpunan, relasi, dan fungsi',
      instructor: 'Dr. Eko Prasetyo, M.Si',
      completedModules: 3,
      totalModules: 14,
      grade: 78.5,
      accentColor: SpaceColors.warning,
      credits: 3,
      semester: 'Ganjil 2024/2025',
      lastAccessed: DateTime.now().subtract(const Duration(days: 3)),
    ),
    Course(
      id: '5',
      name: 'Jaringan Komputer',
      code: 'IF3101',
      description: 'Konsep dasar jaringan komputer dan protokol komunikasi',
      instructor: 'Dr. Fajar Rahman, M.T',
      completedModules: 10,
      totalModules: 10,
      grade: 85.0,
      accentColor: SpaceColors.success,
      credits: 3,
      semester: 'Ganjil 2024/2025',
      lastAccessed: DateTime.now().subtract(const Duration(days: 7)),
    ),
    Course(
      id: '6',
      name: 'Kecerdasan Buatan',
      code: 'IF4201',
      description:
          'Pengenalan konsep AI, machine learning, dan neural networks',
      instructor: 'Dr. Galih Hermawan, M.Kom',
      completedModules: 2,
      totalModules: 12,
      grade: 0,
      accentColor: SpaceColors.info,
      credits: 3,
      semester: 'Ganjil 2024/2025',
      lastAccessed: DateTime.now().subtract(const Duration(hours: 8)),
    ),
  ];

  List<Course> get _filteredCourses {
    List<Course> filtered = _courses;

    // Apply filter
    switch (_selectedFilter) {
      case CourseFilter.all:
        break;
      case CourseFilter.inProgress:
        filtered = filtered.where((c) => !c.isCompleted).toList();
        break;
      case CourseFilter.completed:
        filtered = filtered.where((c) => c.isCompleted).toList();
        break;
    }

    // Apply search
    if (_searchQuery.isNotEmpty) {
      filtered = filtered.where((c) {
        final query = _searchQuery.toLowerCase();
        return c.name.toLowerCase().contains(query) ||
            c.code.toLowerCase().contains(query) ||
            (c.instructor?.toLowerCase().contains(query) ?? false);
      }).toList();
    }

    return filtered;
  }

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
          child: CustomScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            slivers: [
              // Header
              SliverToBoxAdapter(
                child: Padding(
                  padding: SpaceDimensions.screenPadding,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Title
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Kelas Saya',
                            style: SpaceTextStyles.headlineLarge,
                          ),
                          IconButton(
                            onPressed: _showSortOptions,
                            icon: const Icon(
                              Icons.sort_rounded,
                              color: SpaceColors.textPrimary,
                            ),
                            tooltip: 'Urutkan',
                          ),
                        ],
                      ),
                      const SizedBox(height: SpaceDimensions.spacing4),
                      Text(
                        '${_courses.length} mata kuliah aktif semester ini',
                        style: SpaceTextStyles.bodyMedium.copyWith(
                          color: SpaceColors.textSecondary,
                        ),
                      ),
                      const SizedBox(height: SpaceDimensions.spacing16),

                      // Search Bar
                      _buildSearchBar(),
                      const SizedBox(height: SpaceDimensions.spacing16),

                      // Summary Stats
                      _buildSummaryStats(),
                      const SizedBox(height: SpaceDimensions.spacing16),

                      // Filter Chips
                      _buildFilterChips(),
                      const SizedBox(height: SpaceDimensions.spacing8),
                    ],
                  ),
                ),
              ),

              // Course List
              _filteredCourses.isEmpty
                  ? SliverFillRemaining(child: _buildEmptyState())
                  : SliverPadding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: SpaceDimensions.spacing16,
                      ),
                      sliver: SliverList(
                        delegate: SliverChildBuilderDelegate((context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(
                              bottom: SpaceDimensions.spacing12,
                            ),
                            child: _CourseCard(
                              course: _filteredCourses[index],
                              onTap: () =>
                                  _onCourseTap(_filteredCourses[index]),
                            ),
                          );
                        }, childCount: _filteredCourses.length),
                      ),
                    ),

              // Bottom padding
              const SliverToBoxAdapter(
                child: SizedBox(height: SpaceDimensions.spacing32),
              ),
            ],
          ),
        ),
      ),
    );
  }

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
          hintText: 'Cari mata kuliah atau dosen...',
          hintStyle: SpaceTextStyles.bodyMedium.copyWith(
            color: SpaceColors.textSecondary,
          ),
          prefixIcon: const Icon(
            Icons.search_rounded,
            color: SpaceColors.textSecondary,
          ),
          suffixIcon: _searchQuery.isNotEmpty
              ? IconButton(
                  onPressed: () {
                    _searchController.clear();
                    setState(() => _searchQuery = '');
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
        onChanged: (value) => setState(() => _searchQuery = value),
      ),
    );
  }

  Widget _buildSummaryStats() {
    final totalModules = _courses.fold(0, (sum, c) => sum + c.totalModules);
    final completedModules = _courses.fold(
      0,
      (sum, c) => sum + c.completedModules,
    );
    final totalCredits = _courses.fold(0, (sum, c) => sum + c.credits);
    final completedCourses = _courses.where((c) => c.isCompleted).length;

    return Row(
      children: [
        Expanded(
          child: _StatCard(
            icon: Icons.school_rounded,
            label: 'Total Kelas',
            value: '${_courses.length}',
            color: SpaceColors.primary,
          ),
        ),
        const SizedBox(width: SpaceDimensions.spacing12),
        Expanded(
          child: _StatCard(
            icon: Icons.check_circle_rounded,
            label: 'Selesai',
            value: '$completedCourses',
            color: SpaceColors.success,
          ),
        ),
        const SizedBox(width: SpaceDimensions.spacing12),
        Expanded(
          child: _StatCard(
            icon: Icons.library_books_rounded,
            label: 'Modul',
            value: '$completedModules/$totalModules',
            color: SpaceColors.secondary,
          ),
        ),
        const SizedBox(width: SpaceDimensions.spacing12),
        Expanded(
          child: _StatCard(
            icon: Icons.credit_score_rounded,
            label: 'SKS',
            value: '$totalCredits',
            color: SpaceColors.warning,
          ),
        ),
      ],
    );
  }

  Widget _buildFilterChips() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: CourseFilter.values.map((filter) {
          final isSelected = _selectedFilter == filter;
          final count = switch (filter) {
            CourseFilter.all => _courses.length,
            CourseFilter.inProgress =>
              _courses.where((c) => !c.isCompleted).length,
            CourseFilter.completed =>
              _courses.where((c) => c.isCompleted).length,
          };

          return Padding(
            padding: const EdgeInsets.only(right: SpaceDimensions.spacing8),
            child: FilterChip(
              label: Text('${filter.label} ($count)'),
              selected: isSelected,
              onSelected: (selected) {
                setState(() => _selectedFilter = filter);
              },
              backgroundColor: SpaceColors.surfaceVariant,
              selectedColor: SpaceColors.primary.withValues(alpha: 0.2),
              checkmarkColor: SpaceColors.primary,
              labelStyle: SpaceTextStyles.labelMedium.copyWith(
                color: isSelected
                    ? SpaceColors.primary
                    : SpaceColors.textSecondary,
              ),
              side: BorderSide(
                color: isSelected ? SpaceColors.primary : SpaceColors.border,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: SpaceDimensions.chipRadius,
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: SpaceDimensions.screenPadding,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(SpaceDimensions.spacing24),
              decoration: BoxDecoration(
                color: SpaceColors.primary.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                _searchQuery.isNotEmpty
                    ? Icons.search_off_rounded
                    : Icons.school_outlined,
                size: SpaceDimensions.icon3xl,
                color: SpaceColors.primary,
              ),
            ),
            const SizedBox(height: SpaceDimensions.spacing24),
            Text(
              _searchQuery.isNotEmpty ? 'Tidak ada hasil' : 'Tidak ada kelas',
              style: SpaceTextStyles.titleLarge,
            ),
            const SizedBox(height: SpaceDimensions.spacing8),
            Text(
              _searchQuery.isNotEmpty
                  ? 'Coba ubah kata kunci pencarian'
                  : 'Belum ada mata kuliah yang diambil',
              style: SpaceTextStyles.bodyMedium.copyWith(
                color: SpaceColors.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _onRefresh() async {
    await Future.delayed(const Duration(seconds: 1));
    // TODO: Implement actual data refresh
  }

  void _onCourseTap(Course course) {
    // TODO: Navigate to course detail
    debugPrint('Open Course: ${course.name}');
  }

  void _showSortOptions() {
    showModalBottomSheet(
      context: context,
      backgroundColor: SpaceColors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: SpaceDimensions.bottomSheetRadius,
      ),
      builder: (context) => Padding(
        padding: SpaceDimensions.screenPadding,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: SpaceColors.textSecondary,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: SpaceDimensions.spacing16),
            Text('Urutkan Berdasarkan', style: SpaceTextStyles.titleMedium),
            const SizedBox(height: SpaceDimensions.spacing16),
            _SortOption(
              icon: Icons.sort_by_alpha_rounded,
              label: 'Nama (A-Z)',
              onTap: () => Navigator.pop(context),
            ),
            _SortOption(
              icon: Icons.trending_up_rounded,
              label: 'Progress Tertinggi',
              onTap: () => Navigator.pop(context),
            ),
            _SortOption(
              icon: Icons.trending_down_rounded,
              label: 'Progress Terendah',
              onTap: () => Navigator.pop(context),
            ),
            _SortOption(
              icon: Icons.access_time_rounded,
              label: 'Terakhir Diakses',
              onTap: () => Navigator.pop(context),
            ),
            const SizedBox(height: SpaceDimensions.spacing16),
          ],
        ),
      ),
    );
  }
}

// ============================================
// PRIVATE WIDGETS
// ============================================

class _StatCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color color;

  const _StatCard({
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: SpaceDimensions.spacing12,
        horizontal: SpaceDimensions.spacing8,
      ),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: SpaceDimensions.cardRadius,
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: SpaceDimensions.iconMd),
          const SizedBox(height: SpaceDimensions.spacing4),
          Text(
            value,
            style: SpaceTextStyles.titleMedium.copyWith(
              color: color,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            label,
            style: SpaceTextStyles.labelSmall,
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}

class _CourseCard extends StatelessWidget {
  final Course course;
  final VoidCallback? onTap;

  const _CourseCard({required this.course, this.onTap});

  Color get _progressColor {
    if (course.isCompleted) return SpaceColors.success;
    if (course.progressPercentage >= 0.75) return SpaceColors.success;
    if (course.progressPercentage >= 0.5) return SpaceColors.secondary;
    if (course.progressPercentage >= 0.25) return SpaceColors.warning;
    return SpaceColors.primary;
  }

  @override
  Widget build(BuildContext context) {
    final color = course.accentColor ?? _progressColor;

    return SpaceCard(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Course Icon
              Container(
                width: SpaceDimensions.icon3xl,
                height: SpaceDimensions.icon3xl,
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(SpaceDimensions.radiusSm),
                ),
                child: Icon(
                  Icons.class_rounded,
                  color: color,
                  size: SpaceDimensions.iconLg,
                ),
              ),
              const SizedBox(width: SpaceDimensions.spacing12),

              // Course Info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Code Badge
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: SpaceDimensions.spacing8,
                        vertical: SpaceDimensions.spacing2,
                      ),
                      decoration: BoxDecoration(
                        color: color.withValues(alpha: 0.15),
                        borderRadius: SpaceDimensions.chipRadius,
                      ),
                      child: Text(
                        course.code,
                        style: SpaceTextStyles.labelSmall.copyWith(
                          color: color,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const SizedBox(height: SpaceDimensions.spacing6),

                    // Course Name
                    Text(
                      course.name,
                      style: SpaceTextStyles.titleMedium.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),

                    // Instructor
                    if (course.instructor != null) ...[
                      const SizedBox(height: SpaceDimensions.spacing4),
                      Row(
                        children: [
                          Icon(
                            Icons.person_outline_rounded,
                            size: SpaceDimensions.iconSm,
                            color: SpaceColors.textSecondary,
                          ),
                          const SizedBox(width: SpaceDimensions.spacing4),
                          Expanded(
                            child: Text(
                              course.instructor!,
                              style: SpaceTextStyles.bodySmall,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
              ),

              // Grade Badge
              if (course.grade != null && course.grade! > 0)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: SpaceDimensions.spacing12,
                    vertical: SpaceDimensions.spacing8,
                  ),
                  decoration: BoxDecoration(
                    color: SpaceColors.success.withValues(alpha: 0.15),
                    borderRadius: SpaceDimensions.chipRadius,
                  ),
                  child: Column(
                    children: [
                      Text(
                        course.grade!.toStringAsFixed(1),
                        style: SpaceTextStyles.titleMedium.copyWith(
                          color: SpaceColors.success,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Nilai',
                        style: SpaceTextStyles.labelSmall.copyWith(
                          color: SpaceColors.success,
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),

          const SizedBox(height: SpaceDimensions.spacing16),

          // Progress Bar
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${course.completedModules} dari ${course.totalModules} modul selesai',
                    style: SpaceTextStyles.labelSmall,
                  ),
                  Text(
                    '${course.progressPercent}%',
                    style: SpaceTextStyles.labelMedium.copyWith(
                      color: color,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: SpaceDimensions.spacing8),
              ClipRRect(
                borderRadius: BorderRadius.circular(SpaceDimensions.radiusXs),
                child: LinearProgressIndicator(
                  value: course.progressPercentage,
                  backgroundColor: SpaceColors.surfaceVariant,
                  valueColor: AlwaysStoppedAnimation<Color>(color),
                  minHeight: 8,
                ),
              ),
            ],
          ),

          // Status and Credits
          const SizedBox(height: SpaceDimensions.spacing12),
          Row(
            children: [
              // Status Badge
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: SpaceDimensions.spacing8,
                  vertical: SpaceDimensions.spacing4,
                ),
                decoration: BoxDecoration(
                  color: _progressColor.withValues(alpha: 0.15),
                  borderRadius: SpaceDimensions.chipRadius,
                ),
                child: Text(
                  course.statusText,
                  style: SpaceTextStyles.labelSmall.copyWith(
                    color: _progressColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const Spacer(),
              // Credits
              Row(
                children: [
                  Icon(
                    Icons.credit_card_rounded,
                    size: SpaceDimensions.iconSm,
                    color: SpaceColors.textSecondary,
                  ),
                  const SizedBox(width: SpaceDimensions.spacing4),
                  Text(
                    '${course.credits} SKS',
                    style: SpaceTextStyles.labelSmall,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _SortOption extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _SortOption({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: SpaceColors.primary),
      title: Text(label, style: SpaceTextStyles.bodyMedium),
      onTap: onTap,
      contentPadding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: SpaceDimensions.cardRadius),
    );
  }
}
