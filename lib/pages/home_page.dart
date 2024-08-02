import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:platform_changer_app/pages/settings_page.dart';
import 'package:platform_changer_app/providers/bottom_tab_provider.dart';
import 'package:platform_changer_app/providers/interface_change_provider.dart';
import 'package:provider/provider.dart';

import 'contact_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  CupertinoTabController cupertinoTabController = CupertinoTabController();
  PageController pageController = PageController();
  @override
  Widget build(BuildContext context) {
    return (Provider.of<InterfaceChangeProvider>(context)
            .interfaceChangeModel
            .isAndroid)
        ? CupertinoTabScaffold(
            controller: cupertinoTabController,
            tabBar: CupertinoTabBar(
              onTap: (val) {},
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(CupertinoIcons.phone_circle_fill),
                  label: 'Phone',
                ),
                BottomNavigationBarItem(
                  icon: Icon(CupertinoIcons.settings),
                  label: 'Settings',
                ),
              ],
            ),
            tabBuilder: (BuildContext context, int index) {
              return CupertinoTabView(
                builder: (BuildContext context) {
                  return Column(
                    children: [
                      (index == 0) ? const ContactPage() : const SettingsPage()
                    ],
                  );
                },
              );
            },
          )
        : Scaffold(
            bottomNavigationBar: NavigationBar(
              selectedIndex: Provider.of<BottomTabProvider>(context)
                  .bottomTabModel
                  .currentIndex,
              onDestinationSelected: (index) {
                Provider.of<BottomTabProvider>(context, listen: false)
                    .changeIndex(index: index);
                pageController.animateToPage(index,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut);
              },
              destinations: const [
                NavigationDestination(
                    icon: Icon(Icons.contacts), label: 'Contact'),
                NavigationDestination(
                    icon: Icon(Icons.settings), label: 'Settings'),
              ],
            ),
            body: PageView(
              controller: pageController,
              onPageChanged: (index) {
                Provider.of<BottomTabProvider>(context, listen: false)
                    .changeIndex(index: index);
              },
              children: const [ContactPage(), SettingsPage()],
            ),
          );
  }
}
