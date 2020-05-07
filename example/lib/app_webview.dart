import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

import 'main.dart';

class MyInAppBrowser extends InAppBrowser {
  @override
  Future onBrowserCreated() async {
    print("\n\nBrowser Created!\n\n");
  }

  @override
  Future onLoadStart(String url) async {
    print("\n\nStarted $url\n\n");
  }

  @override
  Future onLoadStop(String url) async {
    print("\n\nStopped $url\n\n");
  }

  @override
  void onLoadError(String url, int code, String message) {
    print("Can't load $url.. Error: $message");
  }

  @override
  void onProgressChanged(int progress) {
    print("Progress: $progress");
  }

  @override
  void onExit() {
    print("\n\nBrowser closed!\n\n");
  }

  @override
  void shouldOverrideUrlLoading(String url) {
    print("\n\n override $url\n\n");
    this.webViewController.loadUrl(url: url);
  }

  @override
  void onLoadResource(LoadedResource response) {
    print("Started at: " +
        response.startTime.toString() +
        "ms ---> duration: " +
        response.duration.toString() +
        "ms " +
        response.url);
  }

  @override
  void onConsoleMessage(ConsoleMessage consoleMessage) {
    print("""
    console output:
      message: ${consoleMessage.message}
      messageLevel: ${consoleMessage.messageLevel.toValue()}
   """);
  }
}

class InAppWebviewExampleScreen extends StatefulWidget {
  final MyInAppBrowser browser = new MyInAppBrowser();

  @override
  _InAppWebviewExampleScreenState createState() =>
      new _InAppWebviewExampleScreenState();
}

class _InAppWebviewExampleScreenState extends State<InAppWebviewExampleScreen>  with WidgetsBindingObserver{

  InAppWebViewController webView;
  String url = "";
  double progress = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    print("app:initState");
    // widget.browser.open(
    //     url: "http://www.mwt315.com/",
    //     options: InAppBrowserClassOptions(
    //         inAppBrowserOptions: InAppBrowserOptions(),
    //         androidInAppBrowserOptions: AndroidInAppBrowserOptions(
    //           closeOnCannotGoBack: true,
    //         ),
    //         iosInAppBrowserOptions: IosInAppBrowserOptions(),
    //         inAppWebViewWidgetOptions: InAppWebViewWidgetOptions()));
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print("--" + state.toString());
    switch (state) {
      case AppLifecycleState.inactive: // 处于这种状态的应用程序应该假设它们可能在任何时候暂停。 
        break;
      case AppLifecycleState.resumed:// 应用程序可见，前台 
        break;
      case AppLifecycleState.paused: // 应用程序不可见，后台 
        break; 
      case AppLifecycleState.detached: 
        // TODO: Handle this case.
        break;
    }
  } 
  @override
  Widget build(BuildContext context) {
    return new WillPopScope(
        onWillPop: () async {
          print("onWillPop");
          // await Webview.flutterWebViewPlugin.close();
          // AndroidBackTop.backDeskTop();
          return false;
        },
        child: Scaffold(
            appBar: AppBar(
                title: Text(
              "民为天商城",
            )),
            body: InAppWebView(
                    initialUrl: "http://www.mwt315.com/",
                    initialHeaders: {},
                    initialOptions: InAppWebViewWidgetOptions(
                        inAppWebViewOptions: InAppWebViewOptions(
                          debuggingEnabled: true,
                        )
                    ),
                    onWebViewCreated: (InAppWebViewController controller) {
                      webView = controller;
                    },
                    onLoadStart: (InAppWebViewController controller, String url) {
                      setState(() {
                        this.url = url;
                      });
                    },
                    onLoadStop: (InAppWebViewController controller, String url) async {
                      setState(() {
                        this.url = url;
                      });
                    },
                    onProgressChanged: (InAppWebViewController controller, int progress) {
                      setState(() {
                        this.progress = progress / 100;
                      });
                    },
                  ),
            )
            );
  }
}
