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
  DateTime? pickedTimeAndroid;
  String dateString = "";

  @override
  Widget build(BuildContext context) {
    final profileProvider = Provider.of<ProfileProvider>(context, listen: true);
    final profile = profileProvider.profileModel;

    nameController.text = profile.name;
    phoneController.text = profile.phone;
    emailController.text = profile.email;
    genderController.text = profile.gender;
    return (Provider.of<InterfaceChangeProvider>(context, listen: true)
            .interfaceChangeModel
            .isCupertino)
        ? CupertinoPageScaffold(
            navigationBar: const CupertinoNavigationBar(),
            child: SafeArea(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CupertinoTextField(
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.name,
                      padding: const EdgeInsets.all(18),
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
                      padding: const EdgeInsets.all(18),
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
                      padding: const EdgeInsets.all(18),
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
                          ? const Text('Pick Date')
                          : Text(
                              profile.dob,
                              style: const TextStyle(fontSize: 25),
                            ),
                      const SizedBox(
                        width: 150,
                      ),
                      CupertinoButton(
                          child: const Icon(
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        'Gender: ${profile.gender}',
                        style: const TextStyle(fontSize: 18),
                      ),
                      const SizedBox(
                        width: 140,
                      ),
                      IconButton(
                          onPressed: () {
                            showCupertinoModalPopup(
                                context: context,
                                builder: (context) {
                                  return CupertinoAlertDialog(
                                    title: const Text('Pick Gender'),
                                    actions: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            CupertinoRadio(

                                              value: 'Male',
                                              groupValue: profile.gender,
                                              onChanged: (value) {
                                                profileProvider
                                                    .handleGenderChange(value);
                                                Navigator.of(context).pop();
                                              },
                                            ),
                                            const Text('Male'),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            CupertinoRadio(
                                              value: 'Female',
                                              groupValue: profile.gender,
                                              onChanged: (value) {
                                                profileProvider
                                                    .handleGenderChange(value);
                                                Navigator.of(context).pop();
                                              },
                                            ),

                                            const Text('Female'),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            CupertinoRadio(
                                              value: 'Other',
                                              groupValue: profile.gender,
                                              onChanged: (value) {
                                                profileProvider
                                                    .handleGenderChange(value);
                                                Navigator.of(context).pop();
                                              },
                                            ),

                                            const Text('Other'),
                                          ],
                                        ),
                                      ),
                                    ],
                                  );
                                });
                          },
                          icon: const Icon(CupertinoIcons.person, size: 36,)),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CupertinoButton(
                        child: const Text('Update Profile'),
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
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(), hintText: 'Name'),
                    controller: nameController,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: TextField(
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(), hintText: 'Phone'),
                    controller: phoneController,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: TextField(
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(), hintText: 'Email'),
                    controller: emailController,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    (pickedTimeAndroid == null)
                        ? const Text(
                            'Pick Date',
                            style: TextStyle(fontSize: 18),
                          )
                        : Text(
                            profile.dob,
                            style: const TextStyle(fontSize: 18),
                          ),
                    const SizedBox(
                      width: 150,
                    ),
                    IconButton(
                      onPressed: () async {
                        pickedTimeAndroid = await showDatePicker(
                            context: context,
                            firstDate: DateTime(1900),
                            lastDate: DateTime.now());

                        if (pickedTimeAndroid != null) {
                          dateString =
                              '${pickedTimeAndroid!.day}/${pickedTimeAndroid!.month}/${pickedTimeAndroid!.year}';
                          profileProvider.updateDate(dateString);
                        }
                      },
                      icon: const Icon(Icons.calendar_month_outlined),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Gender: ${profile.gender}',
                      style: const TextStyle(fontSize: 18),
                    ),
                    IconButton(
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: const Text('Pick Gender'),
                                  actions: [
                                    RadioListTile(
                                      title: const Text('Male'),
                                      value: 'Male',
                                      groupValue: profile.gender,
                                      onChanged: (value) {
                                        profileProvider
                                            .handleGenderChange(value);
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                    RadioListTile(
                                      title: const Text('Female'),
                                      value: 'Female',
                                      groupValue: profile.gender,
                                      onChanged: (value) {
                                        profileProvider
                                            .handleGenderChange(value);
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                    RadioListTile(
                                      title: const Text('Other'),
                                      value: 'Other',
                                      groupValue: profile.gender,
                                      onChanged: (value) {
                                        profileProvider
                                            .handleGenderChange(value);
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ],
                                );
                              });
                        },
                        icon: const Icon(Icons.person)),
                  ],
                ),
                ElevatedButton(
                  onPressed: () {
                    profileProvider.updateProfile(
                        nameController.text,
                        phoneController.text,
                        emailController.text,
                        dateString,
                        genderController.text);
                    Navigator.pop(context);
                  },
                  child: const Text('Update Contact'),
                ),
              ],
            ),
          );
  }
}
