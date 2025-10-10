import 'package:get/get.dart';

class ChatSession {
  final String id;
  final String title;
  final DateTime lastUpdated;
  ChatSession({required this.id, required this.title, required this.lastUpdated});
}

class ChatHistoryController extends GetxController {
  final RxList<ChatSession> sessions = <ChatSession>[
    ChatSession(id: '1', title: 'Welcome conversation', lastUpdated: DateTime.now()),
    ChatSession(id: '2', title: 'Project ideas', lastUpdated: DateTime.now().subtract(const Duration(hours: 2))),
  ].obs;
}


