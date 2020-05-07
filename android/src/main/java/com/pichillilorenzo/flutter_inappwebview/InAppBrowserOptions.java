package com.pichillilorenzo.flutter_inappwebview;

public class InAppBrowserOptions extends Options {

  public static final String LOG_TAG = "InAppBrowserOptions";

  public boolean hidden = false;
  public boolean toolbarTop = true;
  public String toolbarTopBackgroundColor = "";
  public String toolbarTopFixedTitle = "";
  public boolean hideUrlBar = true;

  public boolean hideTitleBar = false;
  public boolean closeOnCannotGoBack = false;
  public boolean progressBar = true;
}
