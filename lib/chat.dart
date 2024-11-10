import 'package:flutter/material.dart';
import 'package:food_waste/home_page.dart';

class Contact {
  final String name;
  final String lastMessage;
  final bool hasNewMessage;

  Contact({
    required this.name,
    required this.lastMessage,
    this.hasNewMessage = false,
  });
}

class ContactListPage extends StatelessWidget {
  const ContactListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Contact> contacts = [
      Contact(
          name: 'John', lastMessage: 'Hey, what\'s up?', hasNewMessage: true),
      Contact(
          name: 'Alice',
          lastMessage: 'See you tomorrow!',
          hasNewMessage: false),
      Contact(
          name: 'Bob', lastMessage: 'Can you call me?', hasNewMessage: true),
      Contact(
          name: 'Eve',
          lastMessage: 'Are you free later?',
          hasNewMessage: false),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Chats'),
      ),
      bottomNavigationBar: BottomAppBar(
        color: const Color.fromARGB(203, 100, 235, 33),
        height: 60,
        shape: const CircularNotchedRectangle(), // This adds notch for FAB
        child: SizedBox(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Spacer(),
              IconButton(
                icon: const Icon(Icons.message),
                onPressed: () {
                  // Home button action
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return ContactListPage();
                  }));
                },
              ),
              Spacer(
                flex: 8,
              ),
              IconButton(
                icon: const Icon(Icons.shopping_cart_rounded),
                onPressed: () {
                  // Search button action
                  print("Search button pressed");
                },
              ),
              Spacer(),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromARGB(203, 100, 235, 33),
        shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.circular(30), // Ensure the button remains round
        ),
        onPressed: () {
          Navigator.of(context)
              .pushReplacement(MaterialPageRoute(builder: (context) {
            return HomePage();
          }));
        },
        child: const Icon(
          Icons.home,
        ),
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.centerDocked, // Center the FAB
      body: ListView.builder(
        itemCount: contacts.length,
        itemBuilder: (context, index) {
          final contact = contacts[index];
          return ListTile(
            leading: Stack(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.grey[300],
                  child: Text(contact.name[0]),
                ),
                if (contact.hasNewMessage)
                  Positioned(
                    right: 0,
                    top: 0,
                    child: Container(
                      width: 10,
                      height: 10,
                      decoration: BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
              ],
            ),
            title: Text(contact.name),
            subtitle: Text(contact.lastMessage),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChatPage(contact: contact),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class ChatPage extends StatefulWidget {
  final Contact contact;

  const ChatPage({super.key, required this.contact});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _controller = TextEditingController();
  final List<Message> _messages = [];
  bool _isTyping = false;

  void _sendMessage() {
    if (_controller.text.isNotEmpty) {
      setState(() {
        _messages.add(Message(
          content: _controller.text,
          isUser: true,
          timestamp: DateTime.now(),
        ));
        _isTyping = false;
        _controller.clear();
      });
    }
  }

  void _simulateContactResponse() {
    Future.delayed(const Duration(seconds: 2), () {
      if (_messages.isNotEmpty && _messages.last.isUser) {
        setState(() {
          _messages.add(Message(
            content: "I'm here!",
            isUser: false,
            timestamp: DateTime.now(),
          ));
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.contact.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: _messages.length,
                itemBuilder: (context, index) {
                  final message = _messages[index];
                  final isUserMessage = message.isUser;

                  return Align(
                    alignment: isUserMessage
                        ? Alignment.centerRight
                        : Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8.0,
                          horizontal: 10.0), // Increased vertical padding
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 12,
                            horizontal:
                                18), // Increased padding inside the message bubble
                        decoration: BoxDecoration(
                          color: isUserMessage
                              ? Colors.green[100]
                              : Colors.blue[100],
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Column(
                          crossAxisAlignment: isUserMessage
                              ? CrossAxisAlignment.end
                              : CrossAxisAlignment.start,
                          children: [
                            Text(
                              message.content,
                              style: const TextStyle(color: Colors.black),
                            ),
                            const SizedBox(
                                height:
                                    6), // Increased space between message and timestamp
                            Text(
                              _formatTimestamp(message.timestamp),
                              style: TextStyle(
                                  color: Colors.grey[600], fontSize: 12),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            if (_isTyping)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Contact is typing..."),
                ),
              ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      onChanged: (text) {
                        setState(() {
                          _isTyping = text.isNotEmpty;
                        });
                      },
                      decoration: InputDecoration(
                        hintText: 'Type a message...',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.send),
                    onPressed: () {
                      _sendMessage();
                      _simulateContactResponse();
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatTimestamp(DateTime timestamp) {
    final hours = timestamp.hour;
    final minutes = timestamp.minute;
    final formattedTime =
        '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}';
    return formattedTime;
  }
}

class Message {
  final String content;
  final bool isUser;
  final DateTime timestamp;

  Message({
    required this.content,
    required this.isUser,
    required this.timestamp,
  });
}
