
import 'package:platform_convertor/view/componets/callList_page.dart';
import 'package:platform_convertor/view/componets/chat_page.dart';
import 'package:platform_convertor/view/componets/settings_page.dart';

import '../componets/add_user.dart';

List tabViewList = [
  const AddUser(),
  const ChatPage(),
  const CalllistPage(),
  const SettingsPage()
];
