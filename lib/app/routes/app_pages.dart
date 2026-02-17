import 'package:get/get.dart';

import '../modules/chat/bindings/chat_binding.dart';
import '../modules/chat/views/chat_view.dart';

class AppPages {
  static const initial = Routes.chat;

  static final routes = [GetPage(name: Routes.chat, page: () => const ChatView(), binding: ChatBinding())];
}

abstract class Routes {
  static const chat = '/chat';
}
