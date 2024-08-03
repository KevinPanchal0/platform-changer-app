import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:platform_changer_app/pages/add_contact_page.dart';
import 'package:platform_changer_app/pages/contact_page.dart';
import 'package:platform_changer_app/pages/detail_page.dart';
import 'package:platform_changer_app/pages/home_page.dart';
import 'package:platform_changer_app/pages/profile_page.dart';
import 'package:platform_changer_app/pages/settings_page.dart';
import 'package:platform_changer_app/providers/bottom_tab_provider.dart';
import 'package:platform_changer_app/providers/contact_provider.dart';
import 'package:platform_changer_app/providers/interface_change_provider.dart';
import 'package:platform_changer_app/providers/profile_provider.dart';
import 'package:platform_changer_app/providers/theme_toggle_provider.dart';
import 'package:platform_changer_app/utils/theme.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
        create: (BuildContext context) => InterfaceChangeProvider()),
    ChangeNotifierProvider(create: (BuildContext context) => ThemeProvider()),
    ChangeNotifierProvider(create: (BuildContext context) => BottomTabProvider()),
    ChangeNotifierProvider(create: (BuildContext context) => ContactProvider()),
    ChangeNotifierProvider(create: (BuildContext context) => ProfileProvider()),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    if ((Provider.of<InterfaceChangeProvider>(context)
        .interfaceChangeModel
        .isCupertino)) {
      return CupertinoApp(
        theme: (Provider.of<ThemeProvider>(context).themeModel.isDark)
            ? ThemeToggle().darkThemeCupertino
            : ThemeToggle().lightThemeCupertino,
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          '/': (context) => const HomePage(),
          'settings': (context) => const SettingsPage(),
          'addPage': (context) => const AddContactPage(),
          'contactPage': (context) => const ContactPage(),
          'detailPage': (context) => const DetailPage(),
          'profilePage': (context) => const ProfilePage(),
        },

      );
    } else {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeToggle().lightTheme,
        darkTheme: ThemeToggle().darkTheme,
        themeMode: (Provider.of<ThemeProvider>(context).themeModel.isDark)
            ? ThemeMode.dark
            : ThemeMode.light,
        initialRoute: '/',
        routes: {
          '/': (context) => const HomePage(),
          '/settings': (context) => const SettingsPage(),
          '/addPage': (context) => const AddContactPage(),
          '/contactPage': (context) => const ContactPage(),
          '/detailPage': (context) => const DetailPage(),
          '/profilePage': (context) => const ProfilePage(),
        },
      );
    }
  }
}