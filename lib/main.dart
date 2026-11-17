import 'package:flutter/material.dart';

void main() {
  runApp(const TawasolApp());
}

class TawasolApp extends StatelessWidget {
  const TawasolApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'تواصل',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        // توحيد لون الخلفية العامة ليناسب تدرجات الأيقونة (أزرق داكن وعميق)
        scaffoldBackgroundColor: const Color(0xFF0A192F),
        primaryColor: const Color(0xFF0077B6),
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFF00B4D8), // لون التركواز المتدرج من الأيقونة
          surface: Color(0xFF102A43),  // خلفية البطاقات والعناصر
          onSurface: Colors.white,
        ),
      ),
      home: const PersonalChatScreen(),
    );
  }
}

// نموذج الرسالة الفردية
class Message {
  final String text;
  final bool isMe;

  Message({required this.text, required this.isMe});
}

// شاشة المحادثة الشخصية المباشرة
class PersonalChatScreen extends StatefulWidget {
  const PersonalChatScreen({super.key});

  @override
  State<PersonalChatScreen> createState() => _PersonalChatScreenState();
}

class _PersonalChatScreenState extends State<PersonalChatScreen> {
  // رسائل تجريبية أولية
  final List<Message> _messages = [
    Message(text: 'أهلاً بك، تم دمج ألوان الأيقونة (الأزرق والتركواز) في خلفيات التطبيق.', isMe: false),
  ];
  
  final TextEditingController _controller = TextEditingController();

  void _sendMessage() {
    if (_controller.text.trim().isEmpty) return;
    setState(() {
      _messages.add(Message(text: _controller.text.trim(), isMe: true));
    });
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'تواصل - محادثة شخصية',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        // لون شريط العناوين مستوحى من الأزرق الملكي للأيقونة
        backgroundColor: const Color(0xFF102A43),
        elevation: 0,
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final msg = _messages[index];
                return Align(
                  alignment: msg.isMe ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 6),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width * 0.75,
                    ),
                    decoration: BoxDecoration(
                      // رسائلك تظهر بلون تركواز متدرج يطابق الأيقونة، ورسائل الطرف الآخر بلون هادئ متناسق
                      color: msg.isMe ? const Color(0xFF0077B6) : const Color(0xFF1B3B5F),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Text(
                      msg.text,
                      style: const TextStyle(color: Colors.white, fontSize: 15),
                    ),
                  ),
                );
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            // شريط الإدخال السفلي بنفس لون السطح المتناسق
            color: const Color(0xFF102A43),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: 'اكتب رسالتك هنا...',
                      hintStyle: const TextStyle(color: Colors.white54),
                      filled: true,
                      fillColor: const Color(0xFF0A192F),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    ),
                    onSubmitted: (_) => _sendMessage(),
                  ),
                ),
                const SizedBox(width: 8),
                CircleAvatar(
                  backgroundColor: const Color(0xFF00B4D8),
                  child: IconButton(
                    icon: const Icon(Icons.send_rounded, color: Colors.white, size: 20),
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
}
