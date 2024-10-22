import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:platform_convertor/main.dart';
import 'package:platform_convertor/modal/platform_modal.dart';
import 'package:platform_convertor/view/componets/add_user.dart';
import 'package:platform_convertor/view/componets/text_field.dart';

import 'cuprtino_textField.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    if (converter.isIos.value) {
      return FutureBuilder(
        future: platform.readDataFromDatabase(),
        builder: (context, snapshot) {
          List<PlatformModal> userData = platform.userData
              .map(
                (element) => PlatformModal.fromMap(element),
          )
              .toList();
          return ListView.builder(
            itemCount: userData.length,
            itemBuilder: (context, index) {
              String profilePath = userData[index].profile;

              ImageProvider profileImage;

              // Check if profilePath is a URL (network image)
              if (profilePath.startsWith('http')) {
                profileImage = NetworkImage(profilePath);
              }
              // Check if profilePath is a valid local file
              else if (File(profilePath).existsSync()) {
                profileImage = FileImage(File(profilePath));
              }
              // Default to asset image
              else {
                profileImage = const AssetImage('assets/images/profile-removebg-preview (1).png');
              }
              return Container(
                margin: const EdgeInsets.symmetric(vertical: 8),
                child: CupertinoListTile(
                  onTap: () {
                    showCupertinoModalPopup(
                      context: context,
                      builder: (context) =>
                          Container(
                            width: double.infinity,
                            color: theme.isDark.value
                                ? CupertinoColors.black
                                : CupertinoColors.white,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  CircleAvatar(
                                    backgroundImage: profileImage,

                                    radius: 50,
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    userData[index].name,
                                    style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                   userData[index].chatConversation,
                                    style: const TextStyle(
                                      fontSize: 18,
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      IconButton(
                                        onPressed: () {
                                          platform.txtChat.text =
                                              userData[index].chatConversation;
                                          platform.txtName.text =
                                              userData[index].name;
                                          platform.txtPhone.text =
                                              userData[index].phone;
                                          platform.profile.value = userData[index].profile;
                                          Navigator.pop(context);
                                          showCupertinoDialog(
                                            barrierDismissible: false,
                                            context: context,
                                            builder: (context) =>
                                                CupertinoAlertDialog(
                                                  title: const Text('Update User'),
                                                  actions: [
                                                    Column(
                                                      children: [
                                                        GestureDetector(
                                                          onTap: () {
                                                            platform
                                                                .addProfile();
                                                          },
                                                          child:
                                                                CircleAvatar(
                                                                  radius: 50,
                                                                  backgroundImage: profileImage
                                                                ),

                                                        ),
                                                        SizedBox(
                                                          height:10,
                                                        ),
                                                        MyCupertinoTextField(
                                                          controller:
                                                          platform
                                                              .txtName,
                                                          placeholder: 'Name',
                                                          icons: CupertinoIcons
                                                              .person_add,
                                                        ),
                                                        SizedBox(
                                                          height:10,
                                                        ),
                                                        MyCupertinoTextField(
                                                          textInputType:
                                                          TextInputType.phone,
                                                          controller:
                                                          platform
                                                              .txtPhone,
                                                          placeholder: 'Phone',
                                                          icons: CupertinoIcons.phone,
                                                        ),
                                                        SizedBox(
                                                          height:10,
                                                        ),
                                                        MyCupertinoTextField(
                                                          controller:
                                                          platform
                                                              .txtChat,
                                                          placeholder:
                                                          'Chat Conversation',
                                                          icons: CupertinoIcons
                                                              .chat_bubble_2,
                                                        ),
                                                        SizedBox(
                                                          height: 10,
                                                        ),
                                                        Row(
                                                          mainAxisAlignment:
                                                          MainAxisAlignment.end,
                                                          children: [
                                                            TextButton(
                                                              onPressed: () {
                                                                platform.clearAllVar();
                                                                Navigator.pop(
                                                                    context);
                                                              },
                                                              child: const Text(
                                                                  'Cancel'),
                                                            ),
                                                            TextButton(
                                                              onPressed: () {
                                                                platform.updateData(
                                                                  platform.txtName.text,
                                                                  platform.txtPhone.text,
                                                                  platform
                                                                      .txtChat
                                                                      .text,
                                                                  platform.profile.value,
                                                                  userData[index].id!,
                                                                );
                                                                Navigator.pop(
                                                                    context);
                                                              },
                                                              child: const Text('OK'),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                          ); // //
                                        },
                                        icon: const Icon(Icons.edit),
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          platform.deleteData(userData[index].id!.toInt());
                                          Navigator.pop(context);
                                        },
                                        icon: const Icon(
                                          Icons.delete,
                                          color: Colors.red,
                                        ),
                                      ),
                                    ],
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text('Cancel'),
                                  ),
                                ],
                              ),
                            ),
                          ),
                    );
                  },
                  leading: CircleAvatar(
                    backgroundImage: profileImage,
                    maxRadius: 25,
                  ),
                  title: Text(userData[index].name),
                  subtitle: Text(userData[index].chatConversation),
                  trailing: Text(
                      '${userData[index].date}, ${userData[index].time}'),
                  // trailing: Text(
                  //     '${value.userData[index]['date']}, ${value.userData[index]['time']}'),
                ),
              );
            },
          );
        },
      );
    } else {
      return FutureBuilder(
        future: platform.readDataFromDatabase(),
        builder: (context, snapshot) {
          List<PlatformModal> userData = platform.userData.map((element) =>
              PlatformModal.fromMap(element),).toList();
          return ListView.builder(
            itemCount: userData.length,
            itemBuilder: (context, index) {
              String profilePath = userData[index].profile;

              ImageProvider profileImage;

              if (profilePath.startsWith('http')) {
                profileImage = NetworkImage(profilePath);
              } else if (File(profilePath).existsSync()) {
                profileImage = FileImage(File(profilePath));
              } else {
                profileImage = const AssetImage('assets/images/profile-removebg-preview (1).png');
              }

              return ListTile(
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (context) => SizedBox(
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            CircleAvatar(
                              backgroundImage: profileImage,
                              radius: 50,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              userData[index].name,
                              style: const TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              userData[index].chatConversation,
                              style: const TextStyle(
                                fontSize: 16,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                IconButton(
                                  onPressed: () {
                                    platform.txtChat.text = userData[index].chatConversation;
                                    platform.txtName.text = userData[index].name;
                                    platform.txtPhone.text = userData[index].phone;
                                    platform.profile.value = userData[index].profile;
                                    Navigator.pop(context);
                                    showDialog(
                                      barrierDismissible: false,
                                      context: context,
                                      builder: (context) => SingleChildScrollView(
                                        child: Obx(
                                          () =>  AlertDialog(
                                            title: const Text('Update User'),
                                            actions: [
                                              Column(
                                                children: [
                                                  GestureDetector(
                                                    onTap: () {
                                                      platform.addProfile();
                                                    },
                                                    child:  CircleAvatar(
                                                        radius: 50,
                                                        backgroundImage: profileImage
                                                      ),

                                                  ),
                                                  const SizedBox(height: 10),
                                                  TextFields(
                                                    controller: platform.txtName,
                                                    label: 'Name',
                                                    prefixIcon: const Icon(Icons.person_add),
                                                  ),
                                                  const SizedBox(height: 10),
                                                  TextFields(
                                                    textInputType: TextInputType.phone,
                                                    controller: platform.txtPhone,
                                                    label: 'Phone',
                                                    prefixIcon: const Icon(Icons.call),
                                                  ),
                                                  const SizedBox(height: 10),
                                                  TextFields(
                                                    controller: platform.txtChat,
                                                    label: 'Chat Conversation',
                                                    prefixIcon: const Icon(Icons.chat_bubble),
                                                  ),
                                                  const SizedBox(height: 10),
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.end,
                                                    children: [
                                                      TextButton(
                                                        onPressed: () {
                                                          platform.clearAllVar();
                                                          Navigator.pop(context);
                                                        },
                                                        child: const Text('Cancel'),
                                                      ),
                                                      TextButton(
                                                        onPressed: () {
                                                          platform.updateData(
                                                            platform.txtName.text,
                                                            platform.txtPhone.text,
                                                            platform.txtChat.text,
                                                            platform.profile.value,
                                                            userData[index].id!,
                                                          );
                                                          Navigator.pop(context);
                                                        },
                                                        child: const Text('OK'),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                  icon: const Icon(Icons.edit),
                                ),
                                IconButton(
                                  onPressed: () {
                                    platform.deleteData(userData[index].id!.toInt());
                                    Navigator.pop(context);
                                  },
                                  icon: const Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                  ),
                                ),
                              ],
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text('Cancel'),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
                leading: CircleAvatar(
                  maxRadius: 25,
                  backgroundImage: profileImage,
                ),
                title: Text(userData[index].name),
                subtitle: Text(userData[index].chatConversation),
                trailing: Text('${userData[index].date}, ${userData[index].time}'),
              );
            },
          );
        },
      );

    }
  }
}
