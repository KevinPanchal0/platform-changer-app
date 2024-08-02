import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:platform_changer_app/pages/add_contact_page.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../providers/contact_provider.dart';
import '../providers/interface_change_provider.dart';
import 'detail_page.dart';

class ContactPage extends StatelessWidget {
  const ContactPage({super.key});

  @override
  Widget build(BuildContext context) {
    final contact =
        Provider.of<ContactProvider>(context, listen: false).contactList;
    if ((Provider.of<InterfaceChangeProvider>(context)
        .interfaceChangeModel
        .isAndroid)) {
      return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          middle: Text('Contact'),
          trailing: IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    CupertinoPageRoute(
                        builder: (context) => const AddContactPage()));
              },
              icon: Icon(CupertinoIcons.add)),
        ),
        child: (Provider.of<ContactProvider>(context).contactList.isNotEmpty)
            ? SafeArea(
                child: SizedBox(
                  height: MediaQuery.of(context).size.height / 1.3,
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount:
                          Provider.of<ContactProvider>(context, listen: false)
                              .contactList
                              .length,
                      itemBuilder: (context, index) => CupertinoListTile(
                            leading: CircleAvatar(
                              backgroundImage: FileImage(
                                File(contact[index].image),
                              ),
                            ),
                            title: Text(contact[index].name),
                            subtitle: Text(contact[index].phone),
                            trailing: IconButton(
                                onPressed: () async {
                                  await launchUrl(Uri.parse(
                                      'tel:' '+91${contact[index].phone}'));
                                },
                                icon: Icon(Icons.call)),
                            onTap: () {
                              Navigator.push(
                                context,CupertinoPageRoute(
                                builder: (context) => DetailPage(contact: contact[index]),
                              ),
                              );
                            },
                          )),
                ),
              )
            : SafeArea(
                child: const Center(
                    child: Text(
                'Add Contact',
              ))),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Contact'),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, '/addPage');
          },
          child: const Icon(Icons.add),
        ),
        body: (Provider.of<ContactProvider>(context).contactList.isNotEmpty)
            ? ListView.builder(
                itemCount: Provider.of<ContactProvider>(context, listen: false)
                    .contactList
                    .length,
                itemBuilder: (context, index) {
                  final contact =
                      Provider.of<ContactProvider>(context, listen: false)
                          .contactList;
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundImage: FileImage(
                        File(contact[index].image),
                      ),
                    ),
                    title: Text(contact[index].name),
                    subtitle: Text(contact[index].phone),
                    trailing: IconButton(
                        onPressed: () async {
                          await launchUrl(
                              Uri.parse('tel:' '+91${contact[index].phone}'));
                        },
                        icon: Icon(Icons.call)),
                    onTap: () {
                      Navigator.push(
                        context,
                        CupertinoPageRoute(
                          builder: (context) => DetailPage(contact: contact[index]),
                        ),
                      );
                    },
                  );
                })
            : const Center(child: Text('Add Contact')),
      );
    }
  }
}