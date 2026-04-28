import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/utils/helpers.dart';
import '../../bloc/consultation/consultation_bloc.dart';
import 'prescription_screen.dart';

class ActiveConsultationScreen extends StatefulWidget {
  final String consultationId;
  const ActiveConsultationScreen({super.key, required this.consultationId});

  @override
  State<ActiveConsultationScreen> createState() => _ActiveConsultationScreenState();
}

class _ActiveConsultationScreenState extends State<ActiveConsultationScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  late ConsultationBloc _consultationBloc;
  List<Map<String, dynamic>> _messages = [];

  @override
  void initState() {
    super.initState();
    _consultationBloc = GetIt.instance<ConsultationBloc>();
    _consultationBloc.add(LoadConsultationEvent(widget.consultationId));
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _sendMessage() {
    if (_messageController.text.trim().isEmpty) return;
    _consultationBloc.add(
      SendMessageEvent(
        consultationId: widget.consultationId,
        content: _messageController.text,
      ),
    );
    _messageController.clear();
    _scrollToBottom();
  }

  void _scrollToBottom() {
    Future.delayed(const Duration(milliseconds: 100), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('الاستشارة الطبية'),
        actions: [
          IconButton(
            icon: const Icon(Icons.call),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.videocam),
            onPressed: () {},
          ),
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'prescription') {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const PrescriptionScreen(),
                  ),
                );
              } else if (value == 'end') {
                _endConsultation();
              }
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'prescription',
                child: Row(
                  children: [
                    Icon(Icons.medical_information),
                    SizedBox(width: 8),
                    Text('الوصفة الطبية'),
                  ],
                ),
              ),
              const PopupMenuItem(
                value: 'end',
                child: Row(
                  children: [
                    Icon(Icons.call_end, color: Colors.red),
                    SizedBox(width: 8),
                    Text('إنهاء الاستشارة'),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          // Doctor Info
          Container(
            padding: const EdgeInsets.all(16),
            color: Colors.teal.shade50,
            child: Row(
              children: [
                const CircleAvatar(
                  radius: 25,
                  backgroundColor: Colors.teal,
                  child: Icon(Icons.person, color: Colors.white),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'د. أحمد محمد',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'باطنية',
                        style: TextStyle(color: Colors.grey.shade600),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text(
                    'متصل',
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ),
              ],
            ),
          ),
          // Messages
          Expanded(
            child: BlocBuilder<ConsultationBloc, ConsultationState>(
              bloc: _consultationBloc,
              builder: (context, state) {
                if (state is ConsultationLoaded) {
                  _messages = state.messages;
                  _scrollToBottom();
                }
                return ListView.builder(
                  controller: _scrollController,
                  reverse: false,
                  padding: const EdgeInsets.all(16),
                  itemCount: _messages.length,
                  itemBuilder: (context, index) {
                    final message = _messages[index];
                    final isUser = message['isUser'] == true;
                    return _buildMessageBubble(
                      message['text'],
                      message['time'],
                      isUser,
                    );
                  },
                );
              },
            ),
          ),
          // Input
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade300,
                  blurRadius: 4,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.attach_file),
                  onPressed: () {},
                ),
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      hintText: 'اكتب رسالتك...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Colors.grey.shade100,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                    ),
                    onSubmitted: (_) => _sendMessage(),
                  ),
                ),
                const SizedBox(width: 8),
                CircleAvatar(
                  backgroundColor: AppColors.primary,
                  child: IconButton(
                    icon: const Icon(Icons.send, color: Colors.white),
                    onPressed: _sendMessage,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMessageBubble(String text, String time, bool isUser) {
    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isUser ? AppColors.primary : Colors.grey.shade200,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(16),
            topRight: const Radius.circular(16),
            bottomLeft: isUser ? const Radius.circular(16) : Radius.zero,
            bottomRight: isUser ? Radius.zero : const Radius.circular(16),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              text,
              style: TextStyle(
                color: isUser ? Colors.white : Colors.black,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              time,
              style: TextStyle(
                fontSize: 10,
                color: isUser ? Colors.white70 : Colors.grey.shade600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _endConsultation() async {
    final confirm = await Helpers.showConfirmDialog(
      context,
      title: 'إنهاء الاستشارة',
      message: 'هل أنت متأكد من إنهاء هذه الاستشارة؟',
    );
    if (confirm) {
      _consultationBloc.add(EndConsultationEvent(widget.consultationId));
      Navigator.pop(context);
      Helpers.showSnackBar(context, 'تم إنهاء الاستشارة بنجاح');
    }
  }
}
