import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:platform_convertor/main.dart';
import 'package:platform_convertor/view/componets/add_user.dart';
import 'package:platform_convertor/view/componets/callList_page.dart';
import 'package:platform_convertor/view/componets/chat_page.dart';
import 'package:platform_convertor/view/componets/settings_page.dart';

class AndroidUi extends StatelessWidget {
  const AndroidUi({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: Text('PlatForm Converter'),
          actions: [
            Switch(
              value: converter.isIos.value,
              onChanged: (value) {
                converter.changePlatform();
              },
            ),
            Obx(
              () => Switch(
                value: theme.isDark.value,
                onChanged: (value) {
                  theme.darkMode();
                },
              ),
            ),
          ],
          bottom: TabBar(
            tabAlignment: TabAlignment.fill,
            indicatorPadding: EdgeInsets.zero,
            tabs: [
              Tab(
                child: Icon(Icons.account_circle),
              ),
              Tab(
                text: 'CHATS',
              ),
              Tab(
                text: 'CALLS',
              ),
              Tab(
                text: 'SETTINGS',
              ),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            AddUser(),
            ChatPage(),
            CalllistPage(),
           SettingsPage()
          ],
        ),
      ),
    );
  }
}
