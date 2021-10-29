import 'package:instagramclone/models/usermodel.dart';

class Chat {
  final UserModel sender;
  final isLiked;
  final unread;
  final text;
  final time;

  Chat({
    required this.sender,
    required this.isLiked,
    required this.unread,
    required this.text,
    required this.time,
  });
}

List<Chat> messages = [
  Chat(
    sender: usama,
    time: '5:30 PM',
    text: 'Hey, how\'s it going? What did you do today?',
    isLiked: true,
    unread: true,
  ),
  Chat(
    sender: currentuser,
    time: '4:30 PM',
    text: 'Just walked my doge. She was super duper cute. The best pupper!!',
    isLiked: false,
    unread: true,
  ),
  Chat(
    sender: usama,
    time: '3:45 PM',
    text: 'How\'s the doggo?',
    isLiked: false,
    unread: true,
  ),
  Chat(
    sender: usama,
    time: '3:15 PM',
    text: 'All the food',
    isLiked: true,
    unread: true,
  ),
  Chat(
    sender: currentuser,
    time: '2:30 PM',
    text: 'Nice! What kind of food did you eat?',
    isLiked: false,
    unread: true,
  ),
  Chat(
    sender: currentuser,
    time: '2:00 PM',
    text: 'I ate so much food today.',
    isLiked: false,
    unread: true,
  ),
];
