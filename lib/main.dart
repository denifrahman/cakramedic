import 'package:cakramedic/screens/page_bottom_menu.dart';
import 'package:cakramedic/screens/page_login.dart';
import 'package:cakramedic/screens/page_portal.dart';
import 'package:cakramedic/screens/page_splash.dart';
import 'package:cakramedic/utils/DataProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<DataProvider>(
          create: (_) => DataProvider(),
        )
      ],
      child: Consumer<DataProvider>(
        builder: (context, DataProvider notifier, child) => MaterialApp(
          title: 'Flutter Theme Provider',
          theme: !notifier.darkTheme ? dark : light,
          home: SplaceScreen(),
          initialRoute: '/',
          routes: {
            '/splace-screen': (context) => SplaceScreen(),
            '/portal': (context) => page_portal(),
            '/login': (context) => LoginPage(),
            '/dashboard': (context) => BottomMenu(),
          },
        ),
      ),
    );
  }
}
