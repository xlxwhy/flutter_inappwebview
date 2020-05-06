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

class ChromeSafariBrowserExampleScreen extends StatefulWidget {
  final ChromeSafariBrowser browser =
      new MyChromeSafariBrowser(new InAppBrowser());

  @override
  _ChromeSafariBrowserExampleScreenState createState() =>
      new _ChromeSafariBrowserExampleScreenState();
}

class _ChromeSafariBrowserExampleScreenState
    extends State<ChromeSafariBrowserExampleScreen> {
  @override
  void initState() {
    super.initState();
    widget.browser.open(
        url: "http://www.mwt315.com/",
        options: ChromeSafariBrowserClassOptions(
            androidChromeCustomTabsOptions:
                AndroidChromeCustomTabsOptions(addShareButton: false),
            iosSafariOptions: IosSafariOptions(barCollapsingEnabled: true)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(
        //     title: Text(
        //   "ChromeSafariBrowser",
        // )),
        // drawer: myDrawer(context: context),
        body: Center(
          child: RaisedButton(
              onPressed: () async {
                await widget.browser.open(
                    url: "http://www.mwt315.com/",
                    options: ChromeSafariBrowserClassOptions(
                        androidChromeCustomTabsOptions:
                            AndroidChromeCustomTabsOptions(
                                addShareButton: false),
                        iosSafariOptions:
                            IosSafariOptions(barCollapsingEnabled: true)));
              },
              child: Text("进入商城首页")),
        ));
  }
}
