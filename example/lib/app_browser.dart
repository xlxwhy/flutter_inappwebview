import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class MyChromeSafariBrowser extends ChromeSafariBrowser {
  MyChromeSafariBrowser(browserFallback) : super(bFallback: browserFallback);

  @override
  void onOpened() {
    print("ChromeSafari browser opened");
  }

  @override
  void onLoaded() {
    print("ChromeSafari browser loaded");
  }

  @override
  void onClosed() {
    print("ChromeSafari browser closed");
  }
}

class AppBrower extends StatefulWidget {
  final ChromeSafariBrowser browser =
      new MyChromeSafariBrowser(new InAppBrowser());

  @override
  _AppBrowerState createState() =>
      new _AppBrowerState();
}

class _AppBrowerState
    extends State<AppBrower> {
  @override
  void initState() {
    super.initState();
    this.open();
  }

  void open() {
    widget.browser.open(
        url: "http://www.mwt315.com/",
        options: ChromeSafariBrowserClassOptions(
            androidChromeCustomTabsOptions: AndroidChromeCustomTabsOptions(addShareButton: false),
            iosSafariOptions: IosSafariOptions(barCollapsingEnabled: true)
        ));
  }

  @override
  Widget build(BuildContext context) {
    print("app:build");
    return Scaffold(
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
        ));
  }
}
