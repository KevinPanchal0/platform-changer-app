import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:platform_changer_app/pages/profile_page.dart';
import 'package:platform_changer_app/providers/interface_change_provider.dart';
import 'package:platform_changer_app/providers/profile_provider.dart';
import 'package:platform_changer_app/providers/theme_toggle_provider.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final profile = Provider.of<ProfileProvider>(context).profileModel;
    return (Provider.of<InterfaceChangeProvider>(context, listen: true)
            .interfaceChangeModel
            .isCupertino)
        ?  CupertinoPageScaffold(
        navigationBar: const CupertinoNavigationBar(
          middle: Text('Settings'),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Card(
                elevation: 12,
                color: (Provider.of<ThemeProvider>(
                  context,
                ).themeModel.isDark)
                    ? CupertinoColors.inactiveGray
                    : CupertinoColors.white,
                child: SizedBox(
                  height: MediaQuery.of(context).size.height / 4,
                  width: MediaQuery.of(context).size.width / 1.06,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Name:'),
                            Text(profile.name),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Phone:'),
                            Text(profile.phone),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Email:'),
                            Text(profile.email),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Gender:'),
                            Text(profile.gender),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Date of Birth:'),
                            Text(profile.dob),
                          ],
                        ),
                        CupertinoButton(
                          color: (Provider.of<ThemeProvider>(
                            context,
                          ).themeModel.isDark)
                              ? CupertinoColors.activeBlue
                              : CupertinoColors.link,
                          minSize: 25,
                          borderRadius: BorderRadius.circular(100),
                          onPressed: () {
                            Navigator.push(
                                context,
                                CupertinoPageRoute(
                                    builder: (context) =>
                                    const ProfilePage()));
                          },
                          child: const Icon(
                            Icons.edit,
                            size: 20,
                            color: Colors.white,
                          ),
                        ),
                        const Text(
                          'Edit Profile',
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  elevation: 12,
                  color: (Provider.of<ThemeProvider>(
                    context,
                  ).themeModel.isDark)
                      ? CupertinoColors.inactiveGray
                      : CupertinoColors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Expanded(
                          child: ListTile(
                            title: const Text('Change Interface'),
                            trailing: CupertinoSwitch(
                                value: Provider.of<InterfaceChangeProvider>(
                                  context,
                                ).interfaceChangeModel.isCupertino,
                                onChanged: (val) {
                                  Provider.of<InterfaceChangeProvider>(
                                      context,
                                      listen: false)
                                      .changeInterface();
                                }),
                            onTap: () {
                              Provider.of<InterfaceChangeProvider>(context,
                                  listen: false)
                                  .changeInterface();
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  elevation: 12,
                  color: (Provider.of<ThemeProvider>(
                    context,
                  ).themeModel.isDark)
                      ? CupertinoColors.inactiveGray
                      : CupertinoColors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Expanded(
                          child: ListTile(
                            title: const Text('Change Theme'),
                            trailing: CupertinoSwitch(
                                value: Provider.of<ThemeProvider>(
                                  context,
                                ).themeModel.isDark,
                                onChanged: (val) {
                                  Provider.of<ThemeProvider>(context,
                                      listen: false)
                                      .changeTheme();
                                }),
                            onTap: () {
                              Provider.of<ThemeProvider>(context,
                                  listen: false)
                                  .changeTheme();
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ))
        : Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Settings'),
      ),
      body: Column(
        children: [
          Card(
            child: SizedBox(
              height: MediaQuery.of(context).size.height / 4,
              width: MediaQuery.of(context).size.width / 1.06,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Name:'),
                        Text(profile.name),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Phone:'),
                        Text(profile.phone),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Email:'),
                        Text(profile.email),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Gender:'),
                        Text(profile.gender),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Date of Birth:'),
                        Text(profile.dob),
                      ],
                    ),
                    IconButton(
                      style: ButtonStyle(
                          backgroundColor: WidgetStateProperty.all(
                              Colors.orangeAccent)),
                      onPressed: () {
                        Navigator.pushNamed(context, '/profilePage');
                      },
                      icon: const Icon(
                        Icons.edit,
                        size: 20,
                        color: Colors.white,
                      ),
                    ),
                    const Text(
                      'Edit Profile',
                      style: TextStyle(fontSize: 16),
                    )
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                      child: SwitchListTile(
                          title: const Text('Change Interface'),
                          value: Provider.of<InterfaceChangeProvider>(
                            context,
                          ).interfaceChangeModel.isCupertino,
                          onChanged: (val) {
                            Provider.of<InterfaceChangeProvider>(context,
                                listen: false)
                                .changeInterface();
                          }),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                      child: SwitchListTile(
                          title: const Text('Change Theme'),
                          value: Provider.of<ThemeProvider>(
                            context,
                          ).themeModel.isDark,
                          onChanged: (val) {
                            Provider.of<ThemeProvider>(context,
                                listen: false)
                                .changeTheme();
                          }),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
