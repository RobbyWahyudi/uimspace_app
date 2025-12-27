import 'package:flutter/material.dart';
import 'package:uimspace_app/core/theme/space_theme.dart';
import 'package:uimspace_app/core/widgets/space_card.dart';
import 'package:uimspace_app/features/home/presentation/widgets/upcoming_tasks_section.dart';
import 'package:intl/intl.dart';

class AssignmentListPage extends StatefulWidget {
  const AssignmentListPage({super.key});

  @override
  State<AssignmentListPage> createState() => _AssignmentListPageState();
}

class _AssignmentListPageState extends State<AssignmentListPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  // Dummy data
  final List<UpcomingTask> _allTasks = [
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
      priority: TaskPriority.normal,
      type: TaskType.quiz,
    ),
    UpcomingTask(
      id: '3',
      title: 'UTS Pemrograman Web',
      courseName: 'Pemrograman Web',
      dueDate: DateTime.now().add(const Duration(days: 7)),
      priority: TaskPriority.high,
      type: TaskType.exam,
    ),
    UpcomingTask(
      id: '4',
      title: 'Tugas Kalkulus II',
      courseName: 'Kalkulus II',
      dueDate: DateTime.now().subtract(const Duration(days: 1)),
      priority: TaskPriority.low,
      type: TaskType.assignment,
    ),
    UpcomingTask(
      id: '5',
      title: 'Kuis Etika Profesi',
      courseName: 'Etika Profesi',
      dueDate: DateTime.now().add(const Duration(days: 3)),
      priority: TaskPriority.normal,
      type: TaskType.quiz,
    ),
    UpcomingTask(
      id: '6',
      title: 'Project Akhir Mobile',
      courseName: 'Pemrograman Mobile',
      dueDate: DateTime.now().add(const Duration(days: 14)),
      priority: TaskPriority.high,
      type: TaskType.project,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  List<UpcomingTask> get _filteredTasks {
    List<UpcomingTask> tasks = _allTasks;

    // Filter by Tab
    if (_tabController.index == 1) {
      tasks = tasks
          .where(
            (t) => t.type == TaskType.assignment || t.type == TaskType.project,
          )
          .toList();
    } else if (_tabController.index == 2) {
      tasks = tasks
          .where((t) => t.type == TaskType.quiz || t.type == TaskType.exam)
          .toList();
    }

    // Sort by Due Date (Closest first)
    tasks.sort((a, b) => a.dueDate.compareTo(b.dueDate));

    return tasks;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: SpaceColors.background,
      appBar: AppBar(
        title: Text(
          'Tugas & Kuis',
          style: SpaceTextStyles.titleMedium.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: SpaceColors.background,
        foregroundColor: SpaceColors.textPrimary,
        surfaceTintColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              color: SpaceColors.background,
              child: TabBar(
                controller: _tabController,
                labelColor: SpaceColors.primary,
                unselectedLabelColor: SpaceColors.textSecondary,
                indicatorColor: SpaceColors.primary,
                indicatorWeight: 3,
                indicatorSize: TabBarIndicatorSize.tab,
                labelStyle: SpaceTextStyles.titleSmall.copyWith(
                  fontWeight: FontWeight.bold,
                ),
                onTap: (index) => setState(() {}),
                tabs: const [
                  Tab(text: 'Semua'),
                  Tab(text: 'Tugas'),
                  Tab(text: 'Kuis'),
                ],
              ),
            ),
            Expanded(
              child: _filteredTasks.isEmpty
                  ? _buildEmptyState()
                  : ListView.builder(
                      padding: const EdgeInsets.all(16),
                      itemCount: _filteredTasks.length,
                      itemBuilder: (context, index) {
                        return _AssignmentCard(task: _filteredTasks[index]);
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
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
            'Tidak ada tugas ditemukan',
            style: SpaceTextStyles.titleMedium.copyWith(
              color: SpaceColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}

class _AssignmentCard extends StatelessWidget {
  final UpcomingTask task;

  const _AssignmentCard({required this.task});

  String get _typeLabel {
    return switch (task.type) {
      TaskType.assignment => 'Tugas',
      TaskType.quiz => 'Kuis',
      TaskType.project => 'Proyek',
      TaskType.exam => 'Ujian',
    };
  }

  @override
  Widget build(BuildContext context) {
    final isOverdue = task.dueDate.isBefore(DateTime.now());

    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: SpaceCard(
        onTap: () {
          // Navigate to detail
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    _typeLabel.toUpperCase(),
                    style: SpaceTextStyles.labelSmall.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 10,
                    ),
                  ),
                ),
                Text(
                  _getRemainingTime(task.dueDate),
                  style: SpaceTextStyles.labelSmall.copyWith(
                    color: isOverdue
                        ? SpaceColors.error
                        : SpaceColors.textSecondary,
                    fontWeight: isOverdue ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              task.title,
              style: SpaceTextStyles.titleMedium.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              task.courseName,
              style: SpaceTextStyles.bodySmall.copyWith(
                color: SpaceColors.textSecondary,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Icon(
                  Icons.access_time,
                  size: 14,
                  color: SpaceColors.textSecondary,
                ),
                const SizedBox(width: 4),
                Text(
                  'Deadline: ${DateFormat('dd MMM yyyy, HH:mm').format(task.dueDate)}',
                  style: SpaceTextStyles.labelSmall.copyWith(
                    color: SpaceColors.textSecondary,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _getRemainingTime(DateTime date) {
    final now = DateTime.now();
    final difference = date.difference(now);

    if (difference.isNegative) {
      return 'Terlambat';
    } else if (difference.inDays > 0) {
      return '${difference.inDays} hari lagi';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} jam lagi';
    } else {
      return '${difference.inMinutes} menit lagi';
    }
  }
}
