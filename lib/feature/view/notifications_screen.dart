import 'package:flutter/material.dart';
import 'package:emr_application/config/app_colors.dart';
import 'package:emr_application/core/custom_widgets/custom_text.dart';
import 'package:emr_application/core/extensions/app_extensions.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final List<Map<String, dynamic>> _allNotifications = [
    {
      'id': '1',
      'type': 'chat',
      'title': 'New Message',
      'body': 'Dr. Sarah has sent you a message regarding your report.',
      'time': '2 mins ago',
      'isRead': false,
    },
    {
      'id': '2',
      'type': 'call_missed',
      'title': 'Missed Video Call',
      'body': 'You missed a scheduled video call from Dr. Michael Chen.',
      'time': '45 mins ago',
      'isRead': false,
    },
    {
      'id': '3',
      'type': 'reminder',
      'title': 'Upcoming Consultation',
      'body': 'Your consultation with Dr. Linda starts in 10 minutes.',
      'time': '10 mins ago',
      'isRead': true,
    },
    {
      'id': '4',
      'type': 'other',
      'title': 'Prescription Ready',
      'body':
          'Your latest prescription has been uploaded and is ready for download.',
      'time': '2 hours ago',
      'isRead': true,
    },
    {
      'id': '5',
      'type': 'chat',
      'title': 'New Message',
      'body': 'The lab has uploaded your blood test results.',
      'time': '5 hours ago',
      'isRead': true,
    },
    {
      'id': '6',
      'type': 'call_missed',
      'title': 'Missed Audio Call',
      'body': 'You missed an audio check-up call from the nursing station.',
      'time': 'Yesterday',
      'isRead': true,
    },
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _clearAllNotifications() {
    setState(() {
      final currentTabIndex = _tabController.index;
      if (currentTabIndex == 0) {
        _allNotifications.clear();
      } else {
        String type = "";
        if (currentTabIndex == 1) type = "chat";
        if (currentTabIndex == 2) type = "call_missed";
        if (currentTabIndex == 3) type = "reminder";
        _allNotifications.removeWhere((n) => n['type'] == type);
      }
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
          content: CustomText(
              text: "Notifications cleared",
              color: Colors.white,
              fontSize: 14)),
    );
  }

  void _handleNotificationClick(Map<String, dynamic> notification) {
    setState(() {
      notification['isRead'] = true;
    });

    if (notification['type'] == 'chat') {
      Navigator.pushNamed(context, '/open_chat');
    } else if (notification['type'] == 'call_missed' ||
        notification['type'] == 'reminder') {
      Navigator.pushNamed(context, '/upcoming-consultation');
    } else if (notification['title'] == 'Prescription Ready') {
      Navigator.pushNamed(context, '/report');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: CustomText(
                text: "Opening: ${notification['title']}",
                color: Colors.white,
                fontSize: 14)),
      );
    }
  }

  List<Map<String, dynamic>> _getFilteredNotifications(int tabIndex) {
    if (tabIndex == 0) {
      return _allNotifications;
    }
    if (tabIndex == 1) {
      return _allNotifications.where((n) => n['type'] == 'chat').toList();
    }
    if (tabIndex == 2) {
      return _allNotifications
          .where((n) => n['type'] == 'call_missed')
          .toList();
    }
    if (tabIndex == 3) {
      return _allNotifications.where((n) => n['type'] == 'reminder').toList();
    }
    return _allNotifications;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded,
              color: AppColors.black, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: const CustomText(
          text: "Notifications",
          fontWeight: FontWeight.w600,
          fontSize: 18,
          color: AppColors.black,
        ),
        actions: [
          if (_allNotifications.isNotEmpty)
            TextButton(
              onPressed: _clearAllNotifications,
              child: const CustomText(
                text: "Clear All",
                color: AppColors.red,
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),
          8.width,
        ],
        bottom: TabBar(
          controller: _tabController,
          labelColor: AppColors.primaryLight,
          unselectedLabelColor: AppColors.greyDark,
          indicatorColor: AppColors.primaryLight,
          indicatorWeight: 3,
          labelStyle:
              const TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
          tabs: const [
            Tab(text: "All"),
            Tab(text: "Chats"),
            Tab(text: "Calls"),
            Tab(text: "Reminders"),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildNotificationList(0),
          _buildNotificationList(1),
          _buildNotificationList(2),
          _buildNotificationList(3),
        ],
      ),
    );
  }

  Widget _buildNotificationList(int tabIndex) {
    final notifications = _getFilteredNotifications(tabIndex);

    if (notifications.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.notifications_off_outlined,
                size: 64, color: AppColors.greyMedium.withValues(alpha: 0.5)),
            16.height,
            const CustomText(
              text: "No notifications yet",
              color: AppColors.greyDark,
              fontSize: 16,
            ),
          ],
        ),
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: notifications.length,
      separatorBuilder: (context, index) => 12.height,
      itemBuilder: (context, index) {
        final notification = notifications[index];
        return _buildNotificationCard(notification);
      },
    );
  }

  Widget _buildNotificationCard(Map<String, dynamic> notification) {
    IconData icon;
    Color iconColor;
    Color bgColor;

    switch (notification['type']) {
      case 'chat':
        icon = Icons.chat_bubble_outline_rounded;
        iconColor = Colors.blue;
        bgColor = Colors.blue.shade50;
        break;
      case 'call_missed':
        icon = Icons.phone_missed_rounded;
        iconColor = Colors.red;
        bgColor = Colors.red.shade50;
        break;
      case 'reminder':
        icon = Icons.alarm_rounded;
        iconColor = Colors.orange;
        bgColor = Colors.orange.shade50;
        break;
      default:
        icon = Icons.notifications_none_rounded;
        iconColor = Colors.green;
        bgColor = Colors.green.shade50;
    }

    return Card(
      elevation: 2,
      child: Card(
        elevation: 2,
        child: Dismissible(
          key: ValueKey(notification['id']),
          direction: DismissDirection.endToStart,
          onDismissed: (direction) {
            setState(() {
              _allNotifications.removeWhere((n) => n['id'] == notification['id']);
            });
        
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                  content: CustomText(
                      text: "Notification deleted",
                      color: Colors.white,
                      fontSize: 14)),
            );
          },
          
          child: GestureDetector(
            onTap: () => _handleNotificationClick(notification),
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.03),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
                border: notification['isRead']
                    ? null
                    : Border.all(
                        color: AppColors.primaryLight.withValues(alpha: 0.3),
                        width: 1),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: bgColor,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(icon, color: iconColor, size: 20),
                  ),
                  12.width,
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomText(
                              text: notification['title'],
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                            ),
                            CustomText(
                              text: notification['time'],
                              fontSize: 11,
                              color: AppColors.greyDark,
                            ),
                          ],
                        ),
                        4.height,
                        CustomText(
                          text: notification['body'],
                          fontSize: 13,
                          color: AppColors.verydarkgrayishblue,
                          maxLines: 2,
                        ),
                      ],
                    ),
                  ),
                  if (!notification['isRead'])
                    Container(
                      margin: const EdgeInsets.only(left: 8, top: 4),
                      width: 8,
                      height: 8,
                      decoration: const BoxDecoration(
                        color: AppColors.primaryLight,
                        shape: BoxShape.circle,
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
