  import 'dart:io';

  import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
  import 'package:get/get.dart';
import 'package:platform_convertor/main.dart';
  import 'package:platform_convertor/view/componets/text_field.dart';

  import '../../controller/paltform_controller.dart';
import 'cuprtino_textField.dart';

  var platform = Get.put(PlatFormController());

  class AddUser extends StatelessWidget {
    const AddUser({super.key});

    @override
    Widget build(BuildContext context) {
      if(converter.isIos.value)
        {
          return Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    platform.addProfile();
                  },
                  child: Obx(
                        () => CircleAvatar(
                      maxRadius: 50,
                      backgroundImage: platform.profile.value.isNotEmpty
                          ? FileImage(File(platform.profile.value))
                          : const AssetImage('assets/images/profile-removebg-preview (1).png'),
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // Name Text Field (Cupertino Style)
                MyCupertinoTextField(
                  controller: platform.txtName,
                  placeholder: 'Name',
                  icons: CupertinoIcons.profile_circled,
                ),
                const SizedBox(height: 20),

                // Phone Text Field (Cupertino Style)
                MyCupertinoTextField(
                  controller: platform.txtName,
                  placeholder: 'Phone',
                  icons: CupertinoIcons.profile_circled,
                ),
                const SizedBox(height: 20),
                //
                MyCupertinoTextField(
                  controller: platform.txtName,
                  placeholder: 'Chat Conversation',
                  icons: CupertinoIcons.profile_circled,
                ),
                const SizedBox(height: 20),

                Obx(
                      () => Row(
                    children: [
                      CupertinoButton(
                        onPressed: () {
                          showCupertinoModalPopup(
                            context: context,
                            builder: (context) => Container(
                              height: 200,
                              color: theme.isDark.value
                                  ? CupertinoColors.black
                                  : CupertinoColors.white,
                              child: CupertinoDatePicker(
                                mode: CupertinoDatePickerMode.date,
                                onDateTimeChanged: (value) {
                                  platform.addDateForCupertino(value);
                                },
                              ),
                            ),
                          );
                        },
                        child: const Icon(CupertinoIcons.calendar),
                      ),
                      Text(
                        platform.date.value.isEmpty ? 'Pick Date' : platform.date.value,
                        style: const TextStyle(fontSize: 17),
                      ),
                    ],
                  ),
                ),
                Obx(
                      () => Row(
                    children: [
                      CupertinoButton(
                        onPressed: () {
                          showCupertinoModalPopup(
                            context: context,
                            builder: (context) => Container(
                              height: 200,
                              color: theme.isDark.value
                                  ? CupertinoColors.black
                                  : CupertinoColors.white,
                              child: CupertinoDatePicker(
                                mode: CupertinoDatePickerMode.time,
                                onDateTimeChanged: (value) {
                                  platform.addTimeForCupertino(value);
                                },
                              ),
                            ),
                          );
                        },
                        child: const Icon(CupertinoIcons.time),
                      ),
                      Text(
                        platform.time.value.isEmpty ? 'Pick Time' : platform.time.value,
                        style: const TextStyle(fontSize: 17),
                      ),
                    ],
                  ),
                ),
                Spacer(),
                CupertinoButton(
                  onPressed: () {
                    platform.userData;
                  },
                  child: Container(
                    alignment: Alignment.center,
                    height:50,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40),
                      color: (theme.isDark.value)
                          ? CupertinoColors.black
                          : CupertinoColors.systemGrey,
                    ),
                    child: const Text(
                      'Save',
                      style: TextStyle(
                        color: CupertinoColors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ); // ios
        }
      else
        {
          return
          Padding(
            padding: EdgeInsets.all(15.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      platform.addProfile();
                    },
                    child: Obx(
                          () =>  CircleAvatar(
                        maxRadius: 50,
                        backgroundImage: (platform.profile.value.isNotEmpty)
                            ? FileImage(
                          File(platform.profile.value),
                        )
                            : const AssetImage(
                            'assets/images/profile-removebg-preview (1).png'),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFields(
                    controller: platform.txtName,
                    label: 'Name',
                    prefixIcon: Icon(Icons.person),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFields(
                    controller: platform.txtPhone,
                    label: 'Phone',
                    prefixIcon: Icon(Icons.person),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFields(
                    controller: platform.txtChat,
                    label: 'Chat Conversation',
                    prefixIcon: Icon(Icons.person),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Obx(
                        () => Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            platform.addDate(context);
                          },
                          icon: const Icon(Icons.calendar_month),
                        ),
                        Text(
                          (platform.date.value == '')
                              ? 'Pick Date'
                              : platform.date.value,
                          style: const TextStyle(
                            fontSize: 17,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Obx(
                        () => Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            platform.addTime(context);
                          },
                          icon: const Icon(Icons.alarm),
                        ),
                        Text(
                          (platform.time.value == '')
                              ? 'Pick Time'
                              : platform.time.value,
                          style: const TextStyle(
                            fontSize: 17,
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 30,),
                  GestureDetector(
                    onTap: () {
                      platform.addUserData();
                      platform.clearAllVar();
                    },
                    child: Container(
                      alignment: Alignment.center,
                      height: 50,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40),
                        color: (theme.isDark.value)
                            ? Colors.black
                            : Colors.grey,
                      ),
                      child: const Text(
                        'Save',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ); // android
        }

    }
  }
