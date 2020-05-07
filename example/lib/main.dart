import 'dart:async';

import 'package:flutter/material.dart';
 
import 'app.dart';
import 'app_webview.dart';
import 'app_browser.dart';

 
Future main() async { 
  runApp(new MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    print("main:initState");
  }
  @override
  void dispose() {
    super.dispose();
    print("main:dispose");
  }
  @override
  Widget build(BuildContext context) {
    print("main:build");
    return MaterialApp(
        title: "民为天商城",
        debugShowCheckedModeBanner: false,
        theme: new ThemeData(
          primarySwatch: Colors.red,
        ),
        initialRoute: '/',
        routes: {
          // '/': (context) => InAppBrowserExampleScreen(), 
          '/': (context) => AppBrower(), 
        }
    );
  }
}




Drawer myDrawer({@required BuildContext context}) {
  return Drawer(
    child: ListView(
      padding: EdgeInsets.zero,
      children: <Widget>[
        DrawerHeader(
          child: Text('flutter_inappbrowser example'),
          decoration: BoxDecoration(
            color: Colors.blue,
          ),
        ),
        ListTile(
          title: Text('InAppBrowser'),
          onTap: () {
            Navigator.pushReplacementNamed(context, '/InAppBrowser');
          },
        ),
        ListTile(
          title: Text('ChromeSafariBrowser'),
          onTap: () {
            Navigator.pushReplacementNamed(context, '/ChromeSafariBrowser');
          },
        ),
        ListTile(
          title: Text('InAppWebView'),
          onTap: () {
            Navigator.pushReplacementNamed(context, '/');
          },
        ),
      ],
    ),
  );
}
