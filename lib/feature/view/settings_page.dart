import 'package:flutter/material.dart';
import 'package:emr_application/config/app_colors.dart';
import 'package:emr_application/config/app_assets.dart';
import 'package:emr_application/core/custom_widgets/custom_text.dart';
import 'package:emr_application/core/custom_widgets/shared_preference.dart';
import 'package:emr_application/core/extensions/app_extensions.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool notificationsEnabled = true;

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final notifications =
        await SharedPreferencesHelper.areNotificationsEnabled();
    setState(() {
      notificationsEnabled = notifications;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: const CustomText(
          text: 'Settings',
          size: 18,
          weight: FontWeight.w600,
        ),
        centerTitle: true,
        backgroundColor: theme.appBarTheme.backgroundColor,
        elevation: 0.5,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 20),
        children: [
          _sectionTitle('General'),
          _settingsTile(
            icon: Icons.notifications_active_outlined,
            title: 'Notifications',
            subtitle: 'Manage app notifications',
            trailing: Switch(
              value: notificationsEnabled,
              activeThumbColor: AppColors.primary,
              onChanged: (value) async {
                await SharedPreferencesHelper.setNotificationsEnabled(value);
                setState(() {
                  notificationsEnabled = value;
                });
              },
            ),
          ),
          _settingsTile(
            icon: Icons.language_outlined,
            title: 'Language',
            subtitle: 'English (US)',
            onTap: () {
              _showLanguageDialog();
            },
          ),
          20.height,
          _sectionTitle('Account & Security'),
          _settingsTile(
            icon: Icons.privacy_tip_outlined,
            title: 'Privacy Settings',
            subtitle: 'Manage your data privacy',
            onTap: () {
              _showPrivacyPolicyDialog();
            },
          ),
          20.height,
          _sectionTitle('Support'),
          _settingsTile(
            icon: Icons.help_outline_rounded,
            title: 'Help & Support',
            subtitle: 'Get assistance and FAQs',
            onTap: () {
              _showHelpSupportDialog();
            },
          ),
          _settingsTile(
            icon: Icons.info_outline_rounded,
            title: 'About App',
            subtitle: 'Version 1.0.0 (Latest)',
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Row(
                    children: [
                      Image.asset(AppAssets.applogo, width: 40, height: 40),
                      12.width,
                      const CustomText(
                        text: 'About EMR App',
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ],
                  ),
                  content: const Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        text: 'Version 1.0.0',
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                      SizedBox(height: 8),
                      CustomText(
                        text: 'Your secure health records companion.',
                        fontSize: 13,
                      ),
                    ],
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const CustomText(
                        text: 'Close',
                        color: AppColors.primary,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: CustomText(
        text: title,
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: AppColors.primary,
      ),
    );
  }

  Widget _settingsTile({
    required IconData icon,
    required String title,
    required String subtitle,
    Widget? trailing,
    VoidCallback? onTap,
  }) {
    return ListTile(
      onTap: onTap,
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: AppColors.primary.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(icon, color: AppColors.primary, size: 22),
      ),
      title: CustomText(
        text: title,
        fontSize: 16,
        fontWeight: FontWeight.w500,
      ),
      subtitle: CustomText(
        text: subtitle,
        fontSize: 12,
        color: AppColors.greyDark,
      ),
      trailing: trailing ??
          const Icon(Icons.arrow_forward_ios_rounded,
              size: 16, color: AppColors.greyMedium),
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
    );
  }

  void _showHelpSupportDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const CustomText(
            text: 'Help & Support', fontSize: 18, fontWeight: FontWeight.w600),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CustomText(text: 'Contact us for any issues:', fontSize: 14),
            15.height,
            _supportItem(Icons.email_outlined, 'support@emrapp.com'),
            10.height,
            _supportItem(Icons.phone_outlined, '+1 (800) EMR-HELP'),
            10.height,
            _supportItem(
                Icons.chat_bubble_outline, 'Live Chat (Available 24/7)'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const CustomText(text: 'Close', color: AppColors.primary),
          ),
        ],
      ),
    );
  }

  Widget _supportItem(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 18, color: AppColors.primary),
        10.width,
        CustomText(text: text, fontSize: 14),
      ],
    );
  }

  void _showPrivacyPolicyDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const CustomText(
            text: 'Privacy Policy', fontSize: 18, fontWeight: FontWeight.w600),
        content: const SizedBox(
          height: 300,
          child: SingleChildScrollView(
            child: CustomText(
              text:
                  'This Privacy Policy describes how your personal information is collected, used, and shared when you use the EMR Application.\n\n'
                  '1. DATA COLLECTION\n'
                  'We collect health data, personal identifiers, and medical history to provide better healthcare services.\n\n'
                  '2. DATA SHARING\n'
                  'Your data is only shared with authorized medical professionals involved in your care.\n\n'
                  '3. SECURITY\n'
                  'We use industry-standard encryption to protect your sensitive health information.\n\n'
                  '4. YOUR RIGHTS\n'
                  'You have the right to access, correct, or delete your data at any time.',
              fontSize: 13,
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const CustomText(
                text: 'I Understand', color: AppColors.primary),
          ),
        ],
      ),
    );
  }

  void _showLanguageDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const CustomText(
            text: 'Select Language', fontSize: 18, fontWeight: FontWeight.w600),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _languageItem('English (US)', true),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const CustomText(text: 'Cancel', color: AppColors.greyDark),
          ),
        ],
      ),
    );
  }

  Widget _languageItem(String language, bool isSelected) {
    return ListTile(
      title: CustomText(text: language, fontSize: 15),
      trailing: isSelected
          ? const Icon(Icons.check_circle, color: AppColors.primary)
          : null,
      onTap: () {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Language changed to $language')),
        );
      },
    );
  }
}
