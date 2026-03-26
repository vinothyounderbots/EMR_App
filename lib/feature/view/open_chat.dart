import 'package:flutter/material.dart';
import 'package:emr_application/config/app_colors.dart';
import 'package:emr_application/config/app_assets.dart';
import 'package:emr_application/core/custom_widgets/custom_text.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';
import 'package:intl/intl.dart';
import 'package:record/record.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'dart:async';
import 'package:audioplayers/audioplayers.dart';
import 'package:open_filex/open_filex.dart';

class OpenChatPage extends StatefulWidget {
  const OpenChatPage({super.key});

  @override
  State<OpenChatPage> createState() => _OpenChatPageState();
}

class _OpenChatPageState extends State<OpenChatPage> {
  final ImagePicker _picker = ImagePicker();
  final TextEditingController _messageController = TextEditingController();
  late final AudioRecorder _audioRecorder;
  late final AudioPlayer _audioPlayer;
  bool _isRecording = false;
  String? _previewPath;
  bool _isPlayingPreview = false;
  String? _currentlyPlayingPath;
  Duration _audioPosition = Duration.zero;
  Duration _audioDuration = Duration.zero;
  Timer? _timer;
  int _recordDuration = 0;

  @override
  void initState() {
    super.initState();
    _audioRecorder = AudioRecorder();
    _audioPlayer = AudioPlayer();

    _audioPlayer.onPositionChanged.listen((pos) {
      if (mounted) {
        setState(() => _audioPosition = pos);
      }
    });

    _audioPlayer.onDurationChanged.listen((dur) {
      if (mounted) {
        setState(() => _audioDuration = dur);
      }
    });

    _audioPlayer.onPlayerComplete.listen((_) {
      if (mounted) {
        setState(() {
          _isPlayingPreview = false;
          _currentlyPlayingPath = null;
          _audioPosition = Duration.zero;
        });
      }
    });

    _audioPlayer.onPlayerStateChanged.listen((state) {
      if (state == PlayerState.stopped || state == PlayerState.completed) {
        if (mounted) {
          setState(() {
            _isPlayingPreview = false;
            _currentlyPlayingPath = null;
            _audioPosition = Duration.zero;
          });
        }
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _audioRecorder.dispose();
    _audioPlayer.dispose();
    _messageController.dispose();
    super.dispose();
  }

  final List<Map<String, dynamic>> _messages = [
    {
      'type': 'text',
      'text':
          "Good morning doctor, I've been having pressure when I walk fast. I also feel breathless.",
      'time': "12:40 PM",
      'isMe': true,
    },
    {
      'type': 'image',
      'text': "Here my X-rays",
      'time': "12:43 PM",
      'images': [AppAssets.iconxay, AppAssets.iconxay, AppAssets.iconxay],
      'isMe': true,
      'isAsset': true,
    },
    {
      'type': 'text',
      'text': "Do you have any recent test reports?",
      'time': "12:50 PM",
      'isMe': false,
      'quoteTitle': "You",
      'quoteText': "5 Images",
    },
    {
      'type': 'file',
      'fileName': "Test_Report.pdf",
      'fileInfo': "4 pages . PDF . 2MB",
      'time': "01:00 PM",
      'isMe': true,
    },
  ];

  void _sendMessage() {
    if (_messageController.text.trim().isEmpty) return;
    setState(() {
      _messages.add({
        'type': 'text',
        'text': _messageController.text.trim(),
        'time': DateFormat('hh:mm a').format(DateTime.now()),
        'isMe': true,
      });
      _messageController.clear();
    });
  }

  Future<void> _pickImage(ImageSource source) async {
    try {
      final XFile? image = await _picker.pickImage(source: source);
      if (image != null) {
        setState(() {
          _messages.add({
            'type': 'image',
            'text': "Sent an image",
            'time': DateFormat('hh:mm a').format(DateTime.now()),
            'images': [image.path],
            'isMe': true,
            'isAsset': false,
          });
        });
      }
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error picking image: $e')),
      );
    }
  }

  Future<void> _pickDocument() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf', 'doc', 'docx', 'txt'],
      );

      if (result != null) {
        PlatformFile file = result.files.single;
        setState(() {
          _messages.add({
            'type': 'file',
            'fileName': file.name,
            'fileInfo': "${(file.size / 1024).toStringAsFixed(1)} KB",
            'time': DateFormat('hh:mm a').format(DateTime.now()),
            'isMe': true,
            'filePath': file.path,
          });
        });
      }
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error picking document: $e')),
      );
    }
  }

  Future<void> _pickAudio() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['mp3'],
      );

      if (result != null) {
        PlatformFile file = result.files.single;
        setState(() {
          _messages.add({
            'type': 'voice',
            'duration': file.name.length > 10
                ? '${file.name.substring(0, 7)}...'
                : file.name,
            'time': DateFormat('hh:mm a').format(DateTime.now()),
            'isMe': true,
            'filePath': file.path,
          });
        });
      }
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error selecting audio: $e')),
      );
    }
  }

  Future<void> _startRecording() async {
    try {
      if (await _audioRecorder.hasPermission()) {
        final directory = await getApplicationDocumentsDirectory();
        final String filePath = p.join(directory.path,
            'recording_${DateTime.now().millisecondsSinceEpoch}.m4a');

        const config = RecordConfig();

        await _audioRecorder.start(config, path: filePath);

        setState(() {
          _isRecording = true;
          _recordDuration = 0;
        });

        _startTimer();
      } else {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Microphone permission denied')),
        );
      }
    } catch (e) {
      debugPrint('Error starting recording: $e');
    }
  }

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (Timer t) {
      setState(() {
        _recordDuration++;
      });
    });
  }

  Future<void> _stopRecording() async {
    try {
      _timer?.cancel();
      final path = await _audioRecorder.stop();

      if (path != null) {
        setState(() {
          _isRecording = false;
          _previewPath = path;
        });
      }
    } catch (e) {
      debugPrint('Error stopping recording: $e');
    }
  }

  void _sendPreview() {
    if (_previewPath != null) {
      setState(() {
        _messages.add({
          'type': 'voice',
          'duration': _formatDuration(_recordDuration),
          'time': DateFormat('hh:mm a').format(DateTime.now()),
          'isMe': true,
          'filePath': _previewPath,
        });
        _previewPath = null;
        _isPlayingPreview = false;
        _audioPlayer.stop();
      });
    }
  }

  void _deletePreview() {
    setState(() {
      _previewPath = null;
      _isPlayingPreview = false;
      _audioPlayer.stop();
    });
  }

  Future<void> _togglePreviewPlayback() async {
    if (_previewPath == null) return;

    if (_isPlayingPreview) {
      await _audioPlayer.pause();
    } else {
      await _audioPlayer.play(DeviceFileSource(_previewPath!));
    }

    setState(() {
      _isPlayingPreview = !_isPlayingPreview;
      _currentlyPlayingPath = null;
    });
  }

  Future<void> _toggleMessagePlayback(String filePath) async {
    if (_currentlyPlayingPath == filePath) {
      await _audioPlayer.pause();
      setState(() {
        _currentlyPlayingPath = null;
      });
    } else {
      await _audioPlayer.stop();
      setState(() {
        _audioPosition = Duration.zero;
      });
      await _audioPlayer.play(DeviceFileSource(filePath));
      setState(() {
        _currentlyPlayingPath = filePath;
        _isPlayingPreview = false;
      });
    }
  }

  void _showFullScreenImage(String imagePath, bool isAsset) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
            backgroundColor: Colors.black,
            iconTheme: const IconThemeData(color: Colors.white),
            elevation: 0,
          ),
          body: Center(
            child: InteractiveViewer(
              child: isAsset
                  ? Image.asset(imagePath, fit: BoxFit.contain)
                  : Image.file(File(imagePath), fit: BoxFit.contain),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _openFile(String? filePath) async {
    if (filePath == null) return;
    try {
      final result = await OpenFilex.open(filePath);
      if (result.type != ResultType.done) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Could not open file: ${result.message}')),
        );
      }
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error opening file: $e')),
      );
    }
  }

  void _cancelRecording() async {
    try {
      _timer?.cancel();
      await _audioRecorder.stop();
      setState(() {
        _isRecording = false;
        _recordDuration = 0;
      });
    } catch (e) {
      debugPrint('Error cancelling recording: $e');
    }
  }

  String _formatDuration(int seconds) {
    final int minutes = seconds ~/ 60;
    final int remainingSeconds = seconds % 60;
    return '$minutes:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  void _showAttachmentOptions() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              margin: const EdgeInsets.only(bottom: 24),
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildOptionItem(
                  icon: Icons.image,
                  label: "Image",
                  color: Colors.purple,
                  onTap: () {
                    Navigator.pop(context);
                    _showImageSourceOptions();
                  },
                ),
                _buildOptionItem(
                  icon: Icons.insert_drive_file,
                  label: "Document",
                  color: Colors.orange,
                  onTap: () {
                    Navigator.pop(context);
                    _pickDocument();
                  },
                ),
                _buildOptionItem(
                  icon: Icons.audio_file,
                  label: "Audio",
                  color: Colors.blue,
                  onTap: () {
                    Navigator.pop(context);
                    _pickAudio();
                  },
                ),
              ],
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  void _showImageSourceOptions() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              margin: const EdgeInsets.only(bottom: 24),
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildOptionItem(
                  icon: Icons.photo_library,
                  label: "Gallery",
                  color: Colors.blue,
                  onTap: () {
                    Navigator.pop(context);
                    _pickImage(ImageSource.gallery);
                  },
                ),
                _buildOptionItem(
                  icon: Icons.camera_alt,
                  label: "Camera",
                  color: Colors.green,
                  onTap: () {
                    Navigator.pop(context);
                    _pickImage(ImageSource.camera);
                  },
                ),
              ],
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildOptionItem({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: 30),
          ),
          const SizedBox(height: 8),
          CustomText(text: label, fontSize: 14, color: AppColors.black),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0.5,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const CustomText(
          text: 'Dr. Michael Chen',
          size: 18,
          weight: FontWeight.w500,
          color: AppColors.black,
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16.0),
            child: CircleAvatar(
              radius: 20,
              backgroundImage: AssetImage(AppAssets.iconsarah),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final msg = _messages[index];
                if (index == 0) {
                  return Column(
                    children: [
                      const Center(
                        child: CustomText(
                          text: 'Today',
                          size: 12,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 16),
                      _buildDynamicMessage(msg),
                    ],
                  );
                }
                return _buildDynamicMessage(msg);
              },
            ),
          ),
          _buildMessageInput(context),
        ],
      ),
    );
  }

  Widget _buildDynamicMessage(Map<String, dynamic> msg) {
    switch (msg['type']) {
      case 'text':
        return _buildMessageBubble(
          context,
          text: msg['text'],
          time: msg['time'],
          isMe: msg['isMe'],
          quoteTitle: msg['quoteTitle'],
          quoteText: msg['quoteText'],
        );

      case 'image':
        return _buildImageMessageBubble(
          context,
          text: msg['text'],
          time: msg['time'],
          images: List<String>.from(msg['images']),
          isMe: msg['isMe'],
          isAsset: msg['isAsset'] ?? false,
        );
      case 'file':
        return _buildFileMessageBubble(
          context,
          fileName: msg['fileName'],
          fileInfo: msg['fileInfo'],
          time: msg['time'],
          isMe: msg['isMe'],
          filePath: msg['filePath'],
        );
      case 'voice':
        return _buildVoiceMessageBubble(
          context,
          duration: msg['duration'],
          time: msg['time'],
          isMe: msg['isMe'],
          filePath: msg['filePath'],
        );
      default:
        return const SizedBox.shrink();
    }
  }

  Widget _buildMessageBubble(BuildContext context,
      {required String text,
      required String time,
      required bool isMe,
      String? quoteTitle,
      String? quoteText}) {
    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Column(
        crossAxisAlignment:
            isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.75),
            decoration: BoxDecoration(
              color: isMe ? const Color(0xFFD4E9F7) : AppColors.white,
              borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(16),
                topRight: const Radius.circular(16),
                bottomLeft: isMe ? const Radius.circular(16) : Radius.zero,
                bottomRight: isMe ? Radius.zero : const Radius.circular(16),
              ),
              boxShadow: isMe
                  ? null
                  : [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.05),
                        blurRadius: 5,
                        offset: const Offset(0, 2),
                      ),
                    ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (quoteTitle != null && quoteText != null)
                  Container(
                    width: double.infinity,
                    margin: const EdgeInsets.only(bottom: 8),
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(8),
                      border: const Border(
                        left:
                            BorderSide(color: AppColors.primaryLight, width: 3),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          text: quoteTitle,
                          size: 11,
                          color: AppColors.primaryLight,
                          weight: FontWeight.bold,
                        ),
                        CustomText(
                          text: quoteText,
                          size: 13,
                          color: Colors.grey.shade700,
                        ),
                      ],
                    ),
                  ),
                CustomText(
                  text: text,
                  size: 14,
                  color: AppColors.black,
                ),
                const SizedBox(height: 5),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CustomText(
                      text: time,
                      size: 10,
                      color: Colors.grey,
                    ),
                    if (isMe) ...[
                      const SizedBox(width: 4),
                      const Icon(Icons.done_all,
                          size: 12, color: AppColors.primaryLight),
                    ],
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
        ],
      ),
    );
  }

  Widget _buildImageMessageBubble(BuildContext context,
      {required String text,
      required String time,
      required List<String> images,
      required bool isMe,
      bool isAsset = true}) {
    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Column(
        crossAxisAlignment:
            isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.75),
            decoration: BoxDecoration(
              color: isMe ? const Color(0xFFD4E9F7) : AppColors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (images.length == 1)
                  GestureDetector(
                    onTap: () => _showFullScreenImage(images[0], isAsset),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: isAsset
                          ? Image.asset(images[0],
                              height: 200, fit: BoxFit.cover)
                          : Image.file(File(images[0]),
                              height: 200, fit: BoxFit.cover),
                    ),
                  )
                else
                  Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: GestureDetector(
                          onTap: () => _showFullScreenImage(images[0], isAsset),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: isAsset
                                ? Image.asset(images[0],
                                    height: 180, fit: BoxFit.cover)
                                : Image.file(File(images[0]),
                                    height: 180, fit: BoxFit.cover),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        flex: 1,
                        child: Column(
                          children: [
                            GestureDetector(
                              onTap: () =>
                                  _showFullScreenImage(images[1], isAsset),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: isAsset
                                    ? Image.asset(images[1],
                                        height: 86, fit: BoxFit.cover)
                                    : Image.file(File(images[1]),
                                        height: 86, fit: BoxFit.cover),
                              ),
                            ),
                            const SizedBox(height: 8),
                            GestureDetector(
                              onTap: () =>
                                  _showFullScreenImage(images[2], isAsset),
                              child: Stack(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: isAsset
                                        ? Image.asset(images[2],
                                            height: 86, fit: BoxFit.cover)
                                        : Image.file(File(images[2]),
                                            height: 86, fit: BoxFit.cover),
                                  ),
                                  Container(
                                    height: 86,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      color:
                                          Colors.black.withValues(alpha: 0.6),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: const CustomText(
                                      text: '+2\nimages',
                                      size: 14,
                                      color: Colors.white,
                                      weight: FontWeight.bold,
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                const SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: CustomText(
                    text: text,
                    size: 14,
                    color: AppColors.black,
                  ),
                ),
                const SizedBox(height: 5),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CustomText(
                        text: time,
                        size: 10,
                        color: Colors.grey,
                      ),
                      if (isMe) ...[
                        const SizedBox(width: 4),
                        const Icon(Icons.done_all,
                            size: 12, color: AppColors.primaryLight),
                      ],
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
        ],
      ),
    );
  }

  Widget _buildFileMessageBubble(BuildContext context,
      {required String fileName,
      required String fileInfo,
      required String time,
      required bool isMe,
      String? filePath}) {
    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Column(
        crossAxisAlignment:
            isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.75),
            decoration: BoxDecoration(
              color: isMe ? const Color(0xFFD4E9F7) : AppColors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () => _openFile(filePath),
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.blue.withValues(alpha: 0.08),
                      borderRadius: BorderRadius.circular(12),
                      border:
                          Border.all(color: Colors.blue.withValues(alpha: 0.1)),
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: const Color(0xFF3498DB),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Icon(Icons.insert_drive_file,
                              color: Colors.white, size: 24),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText(
                                text: fileName,
                                size: 14,
                                weight: FontWeight.w600,
                                color: AppColors.black,
                              ),
                              CustomText(
                                text: fileInfo,
                                size: 12,
                                color: Colors.grey.shade600,
                              ),
                            ],
                          ),
                        ),
                        const Icon(Icons.arrow_circle_down_outlined,
                            color: Colors.grey, size: 28),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CustomText(
                      text: time,
                      size: 10,
                      color: Colors.grey,
                    ),
                    if (isMe) ...[
                      const SizedBox(width: 4),
                      const Icon(Icons.done_all,
                          size: 12, color: AppColors.primaryLight),
                    ],
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
        ],
      ),
    );
  }

  Widget _buildVoiceMessageBubble(BuildContext context,
      {required String duration,
      required String time,
      required bool isMe,
      String? filePath}) {
    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Column(
        crossAxisAlignment:
            isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.7),
            decoration: BoxDecoration(
              color: isMe ? const Color(0xFFD4E9F7) : AppColors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    GestureDetector(
                      onTap: () {
                        if (filePath != null) {
                          _toggleMessagePlayback(filePath);
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: const BoxDecoration(
                          color: Color(0xFF3498DB),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                            _currentlyPlayingPath == filePath
                                ? Icons.pause
                                : Icons.play_arrow,
                            color: Colors.white,
                            size: 20),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            height: 2,
                            color: Colors.grey.shade300,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: List.generate(30, (index) {
                              double progress =
                                  (_currentlyPlayingPath == filePath &&
                                          _audioDuration.inMilliseconds > 0)
                                      ? _audioPosition.inMilliseconds /
                                          _audioDuration.inMilliseconds
                                      : 0.0;
                              bool isActive = index < (progress * 30).round();

                              return AnimatedContainer(
                                duration: const Duration(milliseconds: 100),
                                width: 2,
                                height: 8 + (index % 5 * 2.5).toDouble(),
                                decoration: BoxDecoration(
                                  color: isActive
                                      ? const Color(0xFF3498DB)
                                      : (_currentlyPlayingPath == filePath
                                          ? Colors.grey.shade300
                                          : Colors.grey.shade400),
                                  borderRadius: BorderRadius.circular(1),
                                ),
                              );
                            }),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 12),
                    CustomText(
                      text: duration,
                      size: 12,
                      color: AppColors.black,
                      weight: FontWeight.w600,
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CustomText(
                      text: time,
                      size: 10,
                      color: Colors.grey,
                    ),
                    if (isMe) ...[
                      const SizedBox(width: 4),
                      const Icon(Icons.done_all,
                          size: 12, color: AppColors.primaryLight),
                    ],
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
        ],
      ),
    );
  }

  Widget _buildMessageInput(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(12, 8, 12, 24),
      decoration: BoxDecoration(
        color: AppColors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          if (!_isRecording) ...[
            IconButton(
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
              onPressed: _showAttachmentOptions,
              icon: const Icon(Icons.attach_file, color: Colors.grey),
            ),
            const SizedBox(width: 2),
            IconButton(
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
              onPressed: () => _pickImage(ImageSource.camera),
              icon: const Icon(Icons.camera_alt_outlined, color: Colors.grey),
            ),
          ],
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
              decoration: BoxDecoration(
                color: AppColors.background,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: _isRecording
                  ? Row(
                      children: [
                        const Icon(Icons.mic, color: Colors.red, size: 20),
                        const SizedBox(width: 8),
                        Expanded(
                          child: CustomText(
                            text:
                                "Recording... ${_formatDuration(_recordDuration)}",
                            size: 14,
                            color: Colors.red,
                            maxLines: 1,
                          ),
                        ),
                        TextButton(
                          onPressed: _cancelRecording,
                          child: const CustomText(
                            text: "Cancel",
                            size: 14,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    )
                  : _previewPath != null
                      ? Row(
                          children: [
                            IconButton(
                              icon: Icon(
                                  _isPlayingPreview
                                      ? Icons.pause
                                      : Icons.play_arrow,
                                  color: const Color(0xFF3498DB)),
                              onPressed: _togglePreviewPlayback,
                              padding: EdgeInsets.zero,
                              constraints: const BoxConstraints(),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  Container(
                                    height: 2,
                                    color: Colors.grey.shade200,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: List.generate(30, (index) {
                                      double progress = (_isPlayingPreview &&
                                              _audioDuration.inMilliseconds > 0)
                                          ? _audioPosition.inMilliseconds /
                                              _audioDuration.inMilliseconds
                                          : 0.0;
                                      bool isActive =
                                          index < (progress * 30).round();

                                      return AnimatedContainer(
                                        duration:
                                            const Duration(milliseconds: 100),
                                        width: 2,
                                        height:
                                            8 + (index % 5 * 2.5).toDouble(),
                                        decoration: BoxDecoration(
                                          color: isActive
                                              ? const Color(0xFF3498DB)
                                              : Colors.grey.shade300,
                                          borderRadius:
                                              BorderRadius.circular(1),
                                        ),
                                      );
                                    }),
                                  ),
                                ],
                              ),
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: _deletePreview,
                              padding: EdgeInsets.zero,
                              constraints: const BoxConstraints(),
                            ),
                          ],
                        )
                      : TextField(
                          controller: _messageController,
                          decoration: const InputDecoration(
                            hintText: 'Send a message',
                            border: InputBorder.none,
                            hintStyle:
                                TextStyle(color: Colors.grey, fontSize: 14),
                            contentPadding: EdgeInsets.symmetric(vertical: 12),
                          ),
                          onSubmitted: (_) => _sendMessage(),
                          onChanged: (text) {
                            setState(() {});
                          },
                        ),
            ),
          ),
          const SizedBox(width: 4),
          GestureDetector(
            onTap: () {
              if (_isRecording) {
                _stopRecording();
              } else if (_previewPath != null) {
                _sendPreview();
              } else if (_messageController.text.trim().isNotEmpty) {
                _sendMessage();
              } else {
                _startRecording();
              }
            },
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: const BoxDecoration(
                color: Color(0xFF3498DB),
                shape: BoxShape.circle,
              ),
              child: Icon(
                _isRecording
                    ? Icons.stop
                    : (_messageController.text.trim().isEmpty &&
                            _previewPath == null
                        ? Icons.mic
                        : Icons.send),
                color: Colors.white,
                size: 18,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
