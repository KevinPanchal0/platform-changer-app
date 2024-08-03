import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../model/contact_model.dart';
import '../providers/contact_provider.dart';
import '../providers/interface_change_provider.dart';

class DetailPage extends StatelessWidget {
  final ContactModel? contact;
  const DetailPage({super.key, this.contact});

  @override
  Widget build(BuildContext context) {
    final TextEditingController nameController = TextEditingController();
    final TextEditingController phoneController = TextEditingController();
    final contacts = Provider.of<ContactProvider>(context, listen: true);

    if (contact != null) {
      // Check if contact is not null
      nameController.text = contact!.name;
      phoneController.text = contact!.phone;
    }

    return (Provider.of<InterfaceChangeProvider>(context, listen: true)
            .interfaceChangeModel
            .isCupertino)
        ? CupertinoPageScaffold(
            navigationBar: const CupertinoNavigationBar(
              middle: Text('Contacts'),
            ),
            resizeToAvoidBottomInset: true,
            child: (contact != null)
                ? SingleChildScrollView(
                    child: SafeArea(
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 150,
                          ),
                          CircleAvatar(
                            maxRadius: 69,
                            backgroundImage: FileImage(File(contact!.image)),
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          Text(
                            contact!.name,
                            style: const TextStyle(
                              fontSize: 26,
                            ),
                          ),
                          Text(
                            contact!.phone,
                            style: const TextStyle(
                              fontSize: 26,
                            ),
                          ),
                          const SizedBox(
                            height: 36,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Column(
                                children: [
                                  CupertinoButton(
                                    onPressed: () async {
                                      await launchUrl(Uri.parse(
                                          'tel:' '+91${contact!.phone}'));
                                    },
                                    child: const Icon(
                                      CupertinoIcons.phone,
                                      color: CupertinoColors.activeOrange,
                                    ),
                                  ),
                                  const Text(
                                    'Call',
                                    style: TextStyle(fontSize: 20),
                                  )
                                ],
                              ),
                              Column(
                                children: [
                                  CupertinoButton(
                                    onPressed: () async {
                                      await launchUrl(Uri.parse(
                                          'sms:' '+91 ${contact!.phone}'));
                                    },
                                    child: const Icon(
                                      CupertinoIcons.bubble_left,
                                      color: CupertinoColors.activeOrange,
                                    ),
                                  ),
                                  const Text(
                                    'Massage',
                                    style: TextStyle(fontSize: 20),
                                  )
                                ],
                              ),
                              Column(
                                children: [
                                  CupertinoButton(
                                      onPressed: () {
                                        showCupertinoModalPopup(
                                            context: context,
                                            builder: (context) {
                                              return CupertinoActionSheet(
                                                title: const Text('Are you sure?'),
                                                actions: [
                                                  CupertinoButton(
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                      // contacts.removeContact(data: contact);
                                                    },
                                                    child: const Text('Cancle'),
                                                  ),
                                                  CupertinoButton(
                                                    onPressed: () {
                                                      contacts.removeContact(
                                                          data: contact!);
                                                      Navigator
                                                          .pushNamedAndRemoveUntil(
                                                        context,
                                                        '/',
                                                        (Route<dynamic>
                                                                route) =>
                                                            false, // Remove all routes until the root route
                                                      );
                                                    },
                                                    child: const Text('Delete'),
                                                  ),
                                                ],
                                              );
                                            });
                                      },
                                      child: const Icon(
                                        CupertinoIcons.delete,
                                        color: CupertinoColors.activeOrange,
                                        size: 30,
                                      )),
                                  const Text(
                                    'Delete',
                                    style: TextStyle(fontSize: 20),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          Column(
                            children: [
                              CupertinoButton(
                                onPressed: () {
                                  showCupertinoModalPopup(
                                      context: context,
                                      builder: (context) {
                                        return CupertinoAlertDialog(
                                          title: const Text('Edit Contact'),
                                          actions: [
                                            Center(
                                              child: CircleAvatar(
                                                radius: 36,
                                                backgroundImage: FileImage(
                                                    File(contact!.image)),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: CupertinoTextField(
                                                textInputAction:
                                                    TextInputAction.next,
                                                keyboardType:
                                                    TextInputType.name,
                                                controller: nameController,
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: CupertinoTextField(
                                                textInputAction:
                                                    TextInputAction.done,
                                                keyboardType:
                                                    TextInputType.number,
                                                controller: phoneController,
                                                maxLength: 10,
                                              ),
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                TextButton(
                                                    onPressed: () {
                                                      contact!.name =
                                                          nameController.text;
                                                      contact!.phone =
                                                          phoneController.text;
                                                      ContactModel
                                                          updatedContact =
                                                          ContactModel(
                                                        name:
                                                            nameController.text,
                                                        phone: phoneController
                                                            .text,
                                                        image: contact!.image,
                                                      );
                                                      contacts.updateContact(
                                                          updatedContact); // Update using the provider
                                                      Navigator.pop(context);
                                                    },
                                                    child: const Text('Update')),
                                                TextButton(
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                    child: const Text('Cancel')),
                                              ],
                                            ),
                                          ],
                                        );
                                      });
                                },
                                child: const Icon(
                                  CupertinoIcons.pen,
                                  color: CupertinoColors.activeOrange,
                                  size: 30,
                                ),
                              ),
                              const Text(
                                'Edit',
                                style: TextStyle(fontSize: 20),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  )
                : const SafeArea(
                    child: Center(
                      child: Text('No contact selected.'),
                    ),
                  ),
          )
        : Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: const Text('Contact'),
            ),
            resizeToAvoidBottomInset: false,
            body: SafeArea(
              child: (contact != null)
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Card(
                          elevation: 5,
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 150,
                              ),
                              CircleAvatar(
                                maxRadius: 69,
                                backgroundImage:
                                    FileImage(File(contact!.image)),
                              ),
                              const SizedBox(
                                height: 25,
                              ),
                              Text(
                                contact!.name,
                                style: const TextStyle(
                                    fontSize: 30, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                contact!.phone,
                                style: const TextStyle(
                                  fontSize: 26,
                                ),
                              ),
                              const SizedBox(
                                height: 36,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Column(
                                    children: [
                                      IconButton(
                                        style: ButtonStyle(
                                            backgroundColor:
                                                WidgetStateProperty.all(
                                                    Colors.orangeAccent)),
                                        onPressed: () async {
                                          await launchUrl(Uri.parse(
                                              'tel:' '+91${contact!.phone}'));
                                        },
                                        icon: const Icon(
                                          Icons.call,
                                          color: Colors.white,
                                        ),
                                      ),
                                      const Text(
                                        'Call',
                                        style: TextStyle(fontSize: 20),
                                      )
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      IconButton(
                                        style: ButtonStyle(
                                            backgroundColor:
                                                WidgetStateProperty.all(
                                                    Colors.orangeAccent)),
                                        onPressed: () async {
                                          await launchUrl(Uri.parse(
                                              'sms:' '+91 ${contact!.phone}'));
                                        },
                                        icon: const Icon(
                                          Icons.messenger,
                                          color: Colors.white,
                                        ),
                                      ),
                                      const Text(
                                        'Massage',
                                        style: TextStyle(fontSize: 20),
                                      )
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      IconButton(
                                          onPressed: () {
                                            showDialog(
                                                context: context,
                                                builder: (context) {
                                                  return AlertDialog(
                                                    title:
                                                        const Text('Are you sure?'),
                                                    actions: [
                                                      TextButton(
                                                        onPressed: () {
                                                          Navigator.pop(
                                                              context);
                                                          // contacts.removeContact(data: contact);
                                                        },
                                                        child: const Text('Cancle'),
                                                      ),
                                                      TextButton(
                                                        onPressed: ()  {
                                                          contacts
                                                              .removeContact(
                                                                  data:
                                                                      contact!);
                                                          Navigator.pop(context);
                                                          Navigator.pop(context);
                                                        },
                                                        child: const Text('Delete'),
                                                      ),
                                                    ],
                                                  );
                                                });
                                          },
                                          style: ButtonStyle(
                                              backgroundColor:
                                                  WidgetStateProperty.all(
                                                      Colors.orangeAccent)),
                                          icon: const Icon(
                                            Icons.delete,
                                            color: Colors.white,
                                            size: 30,
                                          )),
                                      const Text(
                                        'Delete',
                                        style: TextStyle(fontSize: 20),
                                      )
                                    ],
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 25,
                              ),
                              Column(
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      showDialog(
                                          context: context,
                                          builder: (context) {
                                            return AlertDialog(
                                              title: const Text('Edit Contact'),
                                              actions: [
                                                Center(
                                                  child: CircleAvatar(
                                                    radius: 36,
                                                    backgroundImage: FileImage(
                                                        File(contact!.image)),
                                                  ),
                                                ),
                                                TextField(
                                                  textInputAction:
                                                      TextInputAction.next,
                                                  keyboardType:
                                                      TextInputType.name,
                                                  controller: nameController,
                                                ),
                                                TextField(
                                                  textInputAction:
                                                      TextInputAction.done,
                                                  keyboardType:
                                                      TextInputType.number,
                                                  controller: phoneController,
                                                  maxLength: 10,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    TextButton(
                                                        onPressed: () {
                                                          contact!.name =
                                                              nameController
                                                                  .text;
                                                          contact!.phone =
                                                              phoneController
                                                                  .text;
                                                          ContactModel
                                                              updatedContact =
                                                              ContactModel(
                                                            name: nameController
                                                                .text,
                                                            phone:
                                                                phoneController
                                                                    .text,
                                                            image:
                                                                contact!.image,
                                                          );
                                                          contacts.updateContact(
                                                              updatedContact); // Update using the provider
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        child: const Text('Update')),
                                                    TextButton(
                                                        onPressed: () {
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        child: const Text('Cancel')),
                                                  ],
                                                ),
                                              ],
                                            );
                                          });
                                    },
                                    style: ButtonStyle(
                                        backgroundColor:
                                            WidgetStateProperty.all(
                                                Colors.orangeAccent)),
                                    icon: const Icon(
                                      Icons.edit,
                                      color: Colors.white,
                                    ),
                                  ),
                                  const Text(
                                    'Edit',
                                    style: TextStyle(fontSize: 20),
                                  ),
                                  const SizedBox(
                                    height: 25,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
                  : const Center(
                      child: Text('No contact selected.'),
                    ),
            ));
  }
}
