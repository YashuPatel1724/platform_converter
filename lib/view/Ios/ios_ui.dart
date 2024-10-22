
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:platform_convertor/main.dart';
import 'package:platform_convertor/view/Ios/tabViewList.dart';
class IosUi extends StatelessWidget {
  const IosUi({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: const Text('Platform Converter'),
        trailing:
        Obx(
          () =>  CupertinoSwitch(
            value: converter.isIos.value,
            onChanged: (value) {
              converter.changePlatform();
            },
          ),
        ),
      ),
      child: CupertinoTabScaffold(
        tabBar: CupertinoTabBar(
          items: const [
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.person_add),
            ),
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.chat_bubble_2),
              label: 'Chat',
            ),
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.phone),
              label: 'Calls',
            ),
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.settings),
              label: 'Settings',
            ),
          ],
        ),
        tabBuilder: (context, index) => SafeArea(
          child: CupertinoPageScaffold(
            child: tabViewList[index],
          ),
        ),
      ),
    );
  }
}
