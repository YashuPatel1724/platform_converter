import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:platform_convertor/view/componets/add_user.dart';
import 'package:platform_convertor/view/componets/cuprtino_textField.dart';
import 'package:platform_convertor/view/componets/text_field.dart';

import '../../main.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    if(converter.isIos.value) {
      return Obx(() =>
          ListView(
            children: [
              // Profile Section
              Container(
                margin: const EdgeInsets.symmetric(vertical: 8),
                child: CupertinoListTile(
                  leading: const Icon(CupertinoIcons.person_add),
                  title: const Text('Profile'),
                  subtitle: const Text('Update Profile Data'),
                  trailing: CupertinoSwitch(
                    value: platform.profileUpdate.value,
                    onChanged: (value) {
                      platform.toggleProfileUpdate();
                    },
                  ),
                ),
              ),

              // Show profile update form only if profileUpdate is true
              platform.profileUpdate.value
                  ? Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CupertinoButton(
                          onPressed: () {
                            platform.addProfile();
                          },
                          child: CircleAvatar(
                            radius: 50,
                            backgroundImage: platform.profile.value.isNotEmpty
                                ? FileImage(File(platform.profile.value))
                                : const AssetImage(
                                'assets/images/profile-removebg-preview (1).png')
                            as ImageProvider,
                          ),
                        ),
                      ],
                    ),
                    MyCupertinoTextField(
                      placeholder: 'Name',
                      controller: platform.txtCurrentUserName,
                      icons: CupertinoIcons.person_add,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    MyCupertinoTextField(
                      placeholder: 'Chat Conversation',
                      controller: platform.txtCurrentUserChat,
                      icons: CupertinoIcons.chat_bubble_2,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        CupertinoButton(
                          onPressed: () {},
                          child: const Text('Save'),
                        ),
                      ],
                    ),
                  ],
                ),
              )
                  : Container(),

              // Theme Section
              CupertinoListTile(
                leading: const Icon(CupertinoIcons.moon),
                title: const Text('Theme'),
                subtitle: const Text('Change Theme'),
                trailing: CupertinoSwitch(
                  value: theme.isDark.value,
                  onChanged: (value) {
                    theme.darkMode();
                  },
                ),
              ),
            ],
          ));
    }
    else
      {
        return Obx(
          () =>  ListView(
            children: [
              ListTile(
                leading: const Icon(Icons.account_circle),
                title: const Text('Profile'),
                subtitle: const Text('Update Profile Data'),
                trailing: Switch(
                  value: platform.profileUpdate.value,
                  onChanged: (value) {
                    platform.toggleProfileUpdate();
                  },
                ),
              ),
              (platform.profileUpdate.value)
                  ? Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            platform.addProfile();
                          },
                          child: CircleAvatar(
                            radius: 50,
                            backgroundImage: platform.profile.value.isNotEmpty
                                ? FileImage(File(platform.profile.value))
                                : const AssetImage('assets/images/profile-removebg-preview (1).png'),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFields(
                      label: 'Name',
                      controller: platform.txtCurrentUserName,
                      prefixIcon: const Icon(Icons.person_add),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFields(
                      label: 'Chat Conversation',
                      controller: platform.txtCurrentUserChat,
                      prefixIcon: const Icon(Icons.chat_bubble),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        // TextButton(
                        //   onPressed: () {
                        //     platformProviderTrue.clearAllVar();
                        //   },
                        //   child: const Text('Clear'),
                        // ),
                        TextButton(
                          onPressed: () {},
                          child: const Text('Save'),
                        ),
                      ],
                    ),
                  ],
                ),
              )
                  : Container(),
              ListTile(
                leading: const Icon(Icons.dark_mode_outlined),
                title: const Text('Theme'),
                subtitle: const Text('Change Theme'),
                trailing: Switch(
                  value: theme.isDark.value,
                  onChanged: (value) {
                    theme.darkMode();
                  },
                ),
              ),
            ],
          ),
        );
      }
      }
  }
