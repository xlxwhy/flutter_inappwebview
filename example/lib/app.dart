import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

import 'key.dart';

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
    if (url.contains("https://wx.tenpay.com")) {
      this.webViewController.loadUrl(url: url, headers: {"Referer": "http://www.mwt315.com"});
    }else{
      this.webViewController.loadUrl(url: url);
    }
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

class InAppBrowserExampleScreen extends StatefulWidget {
  final MyInAppBrowser browser = new MyInAppBrowser();

  @override
  _InAppBrowserExampleScreenState createState() =>
      new _InAppBrowserExampleScreenState();
}

class _InAppBrowserExampleScreenState extends State<InAppBrowserExampleScreen>
    with WidgetsBindingObserver {
  InAppWebViewController webView;
  String url = "";
  double progress = 0;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    print("app:initState");
    this.open();
  }

  void open() {
    widget.browser.open(
        url: "http://www.mwt315.com/",
        options: InAppBrowserClassOptions(
            inAppBrowserOptions: InAppBrowserOptions(),
            androidInAppBrowserOptions: AndroidInAppBrowserOptions(
              closeOnCannotGoBack: false,
            ),
            iosInAppBrowserOptions: IosInAppBrowserOptions(),
            inAppWebViewWidgetOptions: InAppWebViewWidgetOptions(
                inAppWebViewOptions:
                    InAppWebViewOptions(useShouldOverrideUrlLoading: false))));
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
      case AppLifecycleState.resumed: // 应用程序可见，前台
        bool isOpened = widget.browser.isOpened();
        if (isOpened) {
          print("hide");

          // widget.browser.hide();
          // widget.browser.close();
          // AndroidBackTop.backDeskTop();
        } else {
          print("show");
          // this.open();
        }
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
    print("app:build");
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
            body: Center(
              child: RaisedButton(
                  onPressed: () {
                    this.open();
                  },
                  child: Text("进入商城")),
            )));
  }
}
