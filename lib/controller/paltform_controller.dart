import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:platform_convertor/Db%20helper/db_helper.dart';

class PlatFormController {
  var txtName = TextEditingController();
  var txtPhone = TextEditingController();
  var txtChat = TextEditingController();
  var txtCurrentUserChat = TextEditingController();
  var txtCurrentUserName = TextEditingController();
  RxString profile = ''.obs, date = ''.obs, time = ''.obs;
  RxBool profileUpdate = false.obs;
  RxList userData = [].obs;

  // RxInt id= 0.obs;

  Future<void> initDatbase() async {
    await DbHelper.dbHelper.database;
  }

  Future<void> addUserData() async {
    await DbHelper.dbHelper.addUserToDatabase(
        name: txtName.text,
        phone: txtPhone.text,
        chatConversation: txtChat.text,
        profile: (profile.isNotEmpty && profile.value != "")
            ? profile.value
            : 'assets/images/profile-removebg-preview (1).png',
        date: date.value,
        time: time.value);
    // PlatformModal(
    //   name: txtName.text,
    //   phone: txtPhone.text,
    //   chatConversation: txtChat.text,
    //   profile: profile.value,
    //   date: date.value,
    //   time: time.value,
    // );
    readDataFromDatabase();
  }

  Future<List<Map<String, Object?>>> readDataFromDatabase() async {
    return userData.value = await DbHelper.dbHelper.readDataFromDatabase();
  }

  Future<void> deleteData(int id) async {
    await DbHelper.dbHelper.deleteDataFromDatabase(id);
    readDataFromDatabase();
  }

  void addDateForCupertino(DateTime value) {
    date.value = '${value.day}/${value.month}/${value.year}';
  }

  void addTimeForCupertino(DateTime value) {
    time.value = '${value.hour % 12}:${value.minute} PM';

  }

  void toggleProfileUpdate() {
    profileUpdate.value = !profileUpdate.value;
  }

  Future<void> updateData(String name, String phone, String chatConversation,
      String profile, int id) async {
    await DbHelper.dbHelper
        .updateDataFromDatabase(name, phone, chatConversation, profile, id);
    clearAllVar();
  }

  Future<void> addDate(BuildContext context) async {
    DateTime? dateTime = await showDatePicker(
      context: context,
      firstDate: DateTime(1937),
      lastDate: DateTime.now(),
    );
    date.value = '${dateTime!.day}/${dateTime.month}/${dateTime.year}';
  }

  Future<void> addTime(BuildContext context) async {
    TimeOfDay? timeOfDay = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    time.value =
        '${timeOfDay!.hour % 12}:${timeOfDay.minute} ${timeOfDay.period.name.toUpperCase()}';
  }

  Future<void> addProfile() async {
    XFile? xFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    FileImage fileImage = FileImage(File(xFile!.path));
    profile.value = fileImage.file.path;
  }

  void clearAllVar() {
    txtName.clear();
    txtPhone.clear();
    txtChat.clear();
    time.value = '';
    date.value = '';
    profile.value = '';
    txtCurrentUserChat.clear();
    txtCurrentUserName.clear();
  }

  PlatFormController() {
    initDatbase();
  }
}
