import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:emr_application/config/app_colors.dart';
import 'package:emr_application/config/app_assets.dart';
import 'package:emr_application/core/custom_widgets/custom_text.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final List<Map<String, dynamic>> _chats = [
    {
      'name': 'Dr. Michael Chen',
      'message': 'Do you have any recent test reports?',
      'time': '1:23 PM',
      'hasUnread': true,
      'image': AppAssets.iconsarah,
    },
    {
      'name': 'Dr. Antony Nicholas',
      'message': 'Hello Doctor, I have a headache since last...',
      'time': '2:14 PM',
      'hasUnread': false,
      'image': AppAssets.iconmichealchen,
    },
    {
      'name': 'Dr. Emily Rodriguez',
      'message': 'typing...',
      'time': '1:23 PM',
      'hasUnread': false,
      'image': AppAssets.iconsarah,
    },
    {
      'name': 'Dr. Patrick Johnson',
      'message': 'Please check your blood test reports once...',
      'time': '12/09/25',
      'hasUnread': false,
      'image': AppAssets.icondoctor,
    },
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const CustomText(
          text: 'Chat',
          size: 18,
          weight: FontWeight.w500,
          color: AppColors.black,
        ),
        centerTitle: true,
        backgroundColor: AppColors.white,
        elevation: 0.5,

        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: GestureDetector(
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                      content: Text('Filter options coming soon...')),
                );
              },
              child: AppAssets.iconfilter.endsWith('.svg')
                  ? SvgPicture.asset(
                      AppAssets.iconfilter,
                      width: 16,
                      height: 16,
                      colorFilter: const ColorFilter.mode(
                          AppColors.verydarkgrayishblue, BlendMode.srcIn),
                    )
                  : Image.asset(
                      AppAssets.iconfilter,
                      width: 22,
                      height: 22,
                      color: AppColors.verydarkgrayishblue,
                    ),
            ),
          ),
        ],
      ),

      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: AppColors.background,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search',
                border: InputBorder.none,
                suffixIcon: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Image.asset(
                    AppAssets.iconsearch,
                    width: 20,
                    height: 20,
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
          ),

          Expanded(
            child: ListView.separated(
              itemCount: _chats.length,
              separatorBuilder: (context, index) => Divider(
                color: Colors.grey.shade300,
                indent: 80,
                height: 1,
              ),
              itemBuilder: (context, index) {
                final chat = _chats[index];
                return Card(
                  elevation: 2,
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 24,
                      backgroundColor: Colors.transparent,
                      backgroundImage: AssetImage(chat['image']),
                    ),
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: CustomText(
                            text: chat['name'],
                            size: 15,
                            weight: FontWeight.w500,
                            color: AppColors.black,
                          ),
                        ),
                        CustomText(
                          text: chat['time'],
                          size: 12,
                          color: Colors.grey.shade600,
                        ),
                      ],
                    ),
                    subtitle: Row(
                      children: [
                        Expanded(
                          child: CustomText(
                            text: chat['message'],
                            size: 13,
                            color: chat['message'] == 'typing...'
                                ? AppColors.primary
                                : Colors.grey.shade600,
                          ),
                        ),
                        if (chat['hasUnread'])
                          Container(
                            width: 10,
                            height: 10,
                            decoration: const BoxDecoration(
                              color: AppColors.primary,
                              shape: BoxShape.circle,
                            ),
                          ),
                      ],
                    ),
                    onTap: () {
                      Navigator.pushNamed(context, '/open_chat');
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),


    );
  }
}
