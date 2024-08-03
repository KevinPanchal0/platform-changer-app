import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:platform_changer_app/model/contact_model.dart';
import 'package:platform_changer_app/providers/contact_provider.dart';
import 'package:provider/provider.dart';

import '../providers/interface_change_provider.dart';
import '../providers/theme_toggle_provider.dart';

class AddContactPage extends StatefulWidget {
  const AddContactPage({super.key});

  @override
  State<AddContactPage> createState() => _AddContactPageState();
}

class _AddContactPageState extends State<AddContactPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  final ImagePicker _picker = ImagePicker();
  XFile? _image;

  @override
  Widget build(BuildContext context) {
    return (Provider.of<InterfaceChangeProvider>(context, listen: true)
            .interfaceChangeModel
            .isCupertino)
        ? CupertinoPageScaffold(
            navigationBar: const CupertinoNavigationBar(
              middle: Text('Add Contact'),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                    child: (_image != null)
                        ? GestureDetector(
                            onTap: () {
                              showCupertinoModalPopup(
                                  context: context,
                                  builder: (context) => Container(
                                        alignment: Alignment.topLeft,
                                        height: 300,
                                        color: (Provider.of<ThemeProvider>(
                                          context,
                                        ).themeModel.isDark)
                                            ? CupertinoColors.black
                                            : CupertinoColors.white,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            const SizedBox(
                                              height: 20,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                Text(
                                                  'Edit Profile Picture',
                                                  style: TextStyle(
                                                      fontSize: 25,
                                                      color: (Provider.of<
                                                              ThemeProvider>(
                                                        context,
                                                      ).themeModel.isDark)
                                                          ? CupertinoColors
                                                              .white
                                                          : CupertinoColors
                                                              .black,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                CupertinoButton(
                                                    child: const Icon(
                                                        CupertinoIcons.clear),
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                    })
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 36,
                                            ),
                                            CupertinoButton(
                                                onPressed: () {
                                                  getImageCupertino(
                                                      ImageSource.gallery);
                                                },
                                                child: const Text(
                                                  'Choose Photo',
                                                  style: TextStyle(
                                                    fontSize: 20,
                                                  ),
                                                )),
                                            const SizedBox(
                                              height: 40,
                                            ),
                                            CupertinoButton(
                                                onPressed: () {
                                                  getImageCupertino(
                                                      ImageSource.camera);
                                                },
                                                child: const Text(
                                                  'Take Photo',
                                                  style: TextStyle(
                                                    fontSize: 20,
                                                  ),
                                                )),
                                          ],
                                        ),
                                      ));
                            },
                            child: CircleAvatar(
                              backgroundImage: FileImage(File(_image!.path)),
                              maxRadius: 69,
                            ),
                          )
                        : GestureDetector(
                            onTap: () {
                              showCupertinoModalPopup(
                                  context: context,
                                  builder: (context) => CupertinoPopupSurface(
                                        child: Container(
                                          color: (Provider.of<ThemeProvider>(
                                            context,
                                          ).themeModel.isDark)
                                              ? CupertinoColors.black
                                              : CupertinoColors.white,
                                          height: 300,
                                          width:
                                              MediaQuery.of(context).size.width,
                                          child: Column(
                                            children: [
                                              const SizedBox(
                                                height: 20,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                children: [
                                                  Text(
                                                    'Edit Profile Picture',
                                                    style: TextStyle(
                                                      fontSize: 25,
                                                      color: (Provider.of<
                                                              ThemeProvider>(
                                                        context,
                                                      ).themeModel.isDark)
                                                          ? CupertinoColors
                                                              .white
                                                          : CupertinoColors
                                                              .black,
                                                    ),
                                                  ),
                                                  CupertinoButton(
                                                      child: const Icon(
                                                          CupertinoIcons.clear),
                                                      onPressed: () {
                                                        Navigator.of(context)
                                                            .pop();
                                                      })
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 36,
                                              ),
                                              CupertinoButton(
                                                  onPressed: () {
                                                    getImageCupertino(
                                                        ImageSource.gallery);
                                                  },
                                                  child: const Text(
                                                    'Choose Photo',
                                                    style: TextStyle(
                                                      fontSize: 20,
                                                    ),
                                                  )),
                                              const SizedBox(
                                                height: 40,
                                              ),
                                              CupertinoButton(
                                                  onPressed: () {
                                                    getImageCupertino(
                                                        ImageSource.camera);
                                                  },
                                                  child: const Text(
                                                    'Take Photo',
                                                    style: TextStyle(
                                                      fontSize: 20,
                                                    ),
                                                  )),
                                            ],
                                          ),
                                        ),
                                      ));
                            },
                            child: const CircleAvatar(
                              maxRadius: 69,
                              child: Icon(
                                Icons.add,
                                size: 69,
                              ),
                            ),
                          )),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: CupertinoTextField(
                        textInputAction: TextInputAction.next,
                        padding: const EdgeInsets.all(18),
                        placeholder: 'Name',
                        placeholderStyle: TextStyle(
                          color: (Provider.of<ThemeProvider>(
                            context,
                          ).themeModel.isDark)
                              ? CupertinoColors.inactiveGray
                              : CupertinoColors.black,
                        ),
                        controller: nameController,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: (Provider.of<ThemeProvider>(
                              context,
                            ).themeModel.isDark)
                                ? CupertinoColors.inactiveGray
                                : CupertinoColors.black,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: CupertinoTextField(
                        textInputAction: TextInputAction.done,
                        keyboardType: TextInputType.number,
                        padding: const EdgeInsets.all(18),
                        placeholder: 'Phone',
                        placeholderStyle: TextStyle(
                            color: (Provider.of<ThemeProvider>(
                          context,
                        ).themeModel.isDark)
                                ? CupertinoColors.inactiveGray
                                : CupertinoColors.black),
                        controller: phoneController,
                        maxLength: 10,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: (Provider.of<ThemeProvider>(
                              context,
                            ).themeModel.isDark)
                                ? CupertinoColors.inactiveGray
                                : CupertinoColors.black,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 36,
                ),
                CupertinoButton.filled(
                    onPressed: saveContactCupertino,
                    child: const Text(
                      'Save Contact',
                      style: TextStyle(fontSize: 20),
                    ))
              ],
            ),
          )
        : Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: const Text('Add Contact'),
            ),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                    child: (_image != null)
                        ? GestureDetector(
                            onTap: () {
                              showModalBottomSheet(
                                  context: context,
                                  builder: (context) => Container(
                                        alignment: Alignment.topLeft,
                                        height: 300,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            const SizedBox(
                                              height: 20,
                                            ),
                                            const Text(
                                              'Edit Profile Picture',
                                              style: TextStyle(
                                                  fontSize: 30,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            const SizedBox(
                                              height: 36,
                                            ),
                                            TextButton(
                                              onPressed: () {
                                                getImage(ImageSource.gallery);
                                              },
                                              child: const Text(
                                                'Choose Photo',
                                                style: TextStyle(
                                                  fontSize: 20,
                                                ),
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 40,
                                            ),
                                            TextButton(
                                                onPressed: () {
                                                  getImage(ImageSource.camera);
                                                },
                                                child: const Text(
                                                  'Take Photo',
                                                  style: TextStyle(
                                                    fontSize: 20,
                                                  ),
                                                )),
                                          ],
                                        ),
                                      ));
                            },
                            child: CircleAvatar(
                              backgroundImage: FileImage(File(_image!.path)),
                              maxRadius: 69,
                            ),
                          )
                        : GestureDetector(
                            onTap: () {
                              showModalBottomSheet(
                                  context: context,
                                  builder: (context) => SizedBox(
                                        height: 300,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        child: Column(
                                          children: [
                                            const SizedBox(
                                              height: 20,
                                            ),
                                            const Text(
                                              'Edit Profile Picture',
                                              style: TextStyle(
                                                  fontSize: 30,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            const SizedBox(
                                              height: 36,
                                            ),
                                            TextButton(
                                                onPressed: () {
                                                  getImage(ImageSource.gallery);
                                                  Navigator.of(context).pop();
                                                },
                                                child: const Text(
                                                  'Choose Photo',
                                                  style: TextStyle(
                                                    fontSize: 26,
                                                  ),
                                                )),
                                            const SizedBox(
                                              height: 40,
                                            ),
                                            TextButton(
                                                onPressed: () {
                                                  getImage(ImageSource.camera);
                                                  Navigator.of(context).pop();
                                                },
                                                child: const Text(
                                                  'Take Photo',
                                                  style: TextStyle(
                                                    fontSize: 26,
                                                  ),
                                                )),
                                          ],
                                        ),
                                      ));
                            },
                            child: const CircleAvatar(
                              maxRadius: 69,
                              child: Icon(
                                Icons.add,
                                size: 69,
                              ),
                            ),
                          )),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: TextField(
                        controller: nameController,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.name,
                        decoration: const InputDecoration(
                          label: Text(
                            'Name',
                            style: TextStyle(),
                          ),
                          prefixIcon: Icon(Icons.person_2_outlined),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: TextField(
                        textInputAction: TextInputAction.done,
                        keyboardType: TextInputType.number,
                        controller: phoneController,
                        maxLength: 10,
                        decoration: const InputDecoration(
                          label: Text(
                            'Phone',
                            style: TextStyle(),
                          ),
                          prefixIcon: Icon(Icons.phone_outlined),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 36,
                ),
                ElevatedButton(
                    onPressed: saveContactAndroid,
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'Save Contact',
                        style: TextStyle(fontSize: 16),
                      ),
                    ))
              ],
            ),
          );
  }

  Future getImage(source) async {
    final XFile? image = await _picker.pickImage(source: source);
    setState(() {
      _image = image;
    });
  }

  Future getImageCupertino(source) async {
    final XFile? image = await _picker.pickImage(source: source);
    setState(() {
      _image = image;
    });
  }

  void saveContactAndroid() {
    FocusScope.of(context).unfocus();

    if (nameController.text.isNotEmpty &&
        phoneController.text.isNotEmpty &&
        _image!.path.isNotEmpty) {
      Provider.of<ContactProvider>(context, listen: false)
          .addContact(ContactModel(
        name: nameController.text,
        phone: phoneController.text,
        image: _image!.path,
      ));
      Navigator.pop(context);
    } else {
      const snackBar = SnackBar(content: Text('All Fields are required!..'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  void saveContactCupertino() {
    FocusScope.of(context).unfocus();

    if (nameController.text.isNotEmpty &&
        phoneController.text.isNotEmpty &&
        _image!.path.isNotEmpty) {
      Provider.of<ContactProvider>(context, listen: false)
          .addContact(ContactModel(
        name: nameController.text,
        phone: phoneController.text,
        image: _image!.path,
      ));
      Navigator.pop(context);
    }
  }
}
