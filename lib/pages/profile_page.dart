import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/interface_change_provider.dart';
import '../providers/profile_provider.dart';
import '../providers/theme_toggle_provider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  TextEditingController genderController = TextEditingController();

  DateTime? pickedTimeCupertino;
  String dateString = "";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final profileProvider = Provider.of<ProfileProvider>(context, listen: true);
    final profile = profileProvider.profileModel;

    nameController.text = profile.name;
    phoneController.text = profile.phone;
    emailController.text = profile.email;
    genderController.text = profile.gender;
    return (Provider.of<InterfaceChangeProvider>(context)
            .interfaceChangeModel
            .isAndroid)
        ? CupertinoPageScaffold(
            navigationBar: CupertinoNavigationBar(),
            child: SafeArea(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CupertinoTextField(
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.name,
                      padding: EdgeInsets.all(18),
                      placeholder: 'Name',
                      decoration: BoxDecoration(
                          border: Border.all(
                        color: (Provider.of<ThemeProvider>(
                          context,
                        ).themeModel.isDark)
                            ? CupertinoColors.inactiveGray
                            : CupertinoColors.black,
                      )),
                      controller: nameController,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CupertinoTextField(
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.number,
                      padding: EdgeInsets.all(18),
                      placeholder: 'Phone',
                      decoration: BoxDecoration(
                          border: Border.all(
                        color: (Provider.of<ThemeProvider>(
                          context,
                        ).themeModel.isDark)
                            ? CupertinoColors.inactiveGray
                            : CupertinoColors.black,
                      )),
                      controller: phoneController,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CupertinoTextField(
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.emailAddress,
                      padding: EdgeInsets.all(18),
                      placeholder: 'Email',
                      decoration: BoxDecoration(
                          border: Border.all(
                        color: (Provider.of<ThemeProvider>(
                          context,
                        ).themeModel.isDark)
                            ? CupertinoColors.inactiveGray
                            : CupertinoColors.black,
                      )),
                      controller: emailController,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      (pickedTimeCupertino == null)
                          ? Text('Pick Date')
                          : Text(
                              profile.dob,
                              style: TextStyle(fontSize: 25),
                            ),
                      SizedBox(
                        width: 150,
                      ),
                      CupertinoButton(
                          child: Icon(
                            CupertinoIcons.calendar,
                            size: 36,
                          ),
                          onPressed: () {
                            showCupertinoModalPopup(
                                context: context,
                                builder: (context) {
                                  return Container(
                                    color: (Provider.of<ThemeProvider>(
                                      context,
                                    ).themeModel.isDark)
                                        ? CupertinoColors.inactiveGray
                                        : CupertinoColors.white,
                                    height: 300,
                                    width: MediaQuery.of(context).size.width,
                                    child: CupertinoDatePicker(
                                        initialDateTime: DateTime.now(),
                                        mode: CupertinoDatePickerMode.date,
                                        onDateTimeChanged: (DateTime val) {
                                          pickedTimeCupertino = val;
                                          dateString =
                                              "${pickedTimeCupertino!.day}/${pickedTimeCupertino!.month}/${pickedTimeCupertino!.year}";
                                          profileProvider
                                              .updateDate(dateString);
                                        }),
                                  );
                                });
                          })
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CupertinoTextField(
                      textInputAction: TextInputAction.done,
                      keyboardType: TextInputType.name,
                      padding: EdgeInsets.all(18),
                      placeholder: 'Gender',
                      decoration: BoxDecoration(
                          border: Border.all(
                        color: (Provider.of<ThemeProvider>(
                          context,
                        ).themeModel.isDark)
                            ? CupertinoColors.inactiveGray
                            : CupertinoColors.black,
                      )),
                      controller: genderController,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CupertinoButton(
                        child: Text('Update Contact'),
                        onPressed: () {
                          profileProvider.updateProfile(
                              nameController.text,
                              emailController.text,
                              phoneController.text,
                              dateString,
                              genderController.text);
                          Navigator.pop(context);
                        }),
                  )
                ],
              ),
            ),
          )
        : Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              centerTitle: true,
              title: const Text('Edit Profile'),
            ),
            body: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: TextField(
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(), hintText: 'Name'),
                    controller: nameController,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: TextField(
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(), hintText: 'Phone'),
                    controller: phoneController,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: TextField(
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(), hintText: 'Email'),
                    controller: emailController,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: TextField(
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.datetime,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(), hintText: 'dob'),
                    controller: dobController,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: TextField(
                    textInputAction: TextInputAction.done,
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(), hintText: 'Gender'),
                    controller: genderController,
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    profileProvider.updateProfile(
                        nameController.text,
                        phoneController.text,
                        emailController.text,
                        dobController.text,
                        genderController.text);
                    Navigator.pop(context);
                  },
                  child: Text('Update Contact'),
                ),
              ],
            ),
          );
  }
}
