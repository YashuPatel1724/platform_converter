import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:platform_convertor/controller/paltform_controller.dart';
import 'package:platform_convertor/controller/theme_controller.dart';
import 'package:platform_convertor/view/Ios/ios_ui.dart';
import 'package:platform_convertor/view/android_ui.dart';
import 'package:platform_convertor/view/componets/add_user.dart';
import 'package:platform_convertor/view/theme/global_theme.dart';

import 'controller/paltform_converter.dart';
 // Fixed import

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() => converter.isIos.value
        ? CupertinoApp(
            debugShowCheckedModeBanner: false,
            theme: theme.isDark.value
                ? GlobalTheme.cupertinoThemeDark
                : GlobalTheme.cupertinoThemeLight,
      home: IosUi(),
          )
        : GetMaterialApp(
            theme: GlobalTheme.themeLight,
            darkTheme: GlobalTheme.themeDark,
            themeMode: theme.isDark.value ? ThemeMode.dark : ThemeMode.light,
            debugShowCheckedModeBanner: false,
            home: const AndroidUi(),
          ));
  }
}

var theme = Get.put(ThemeController());
var converter = Get.put(PaltformConverter()); // Fixed typo
