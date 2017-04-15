library ConnectionStatusBar;

//import 'dart:html';
//import 'package:css_animation/css_animation.dart';
import '../../Data/Data.dart';

class ConnectionStatusBar {
  //DivElement bar;
  bool showing = false;
  //SpanElement statusText;
  //DivElement spinner;
  bool showingReconnecting = false;
  Data data;

  ConnectionStatusBar(this.data) {
    //createBarView();
    //createSpinner();
    //createStatusText();
    showReconnecting();
  }

  void showReconnecting() {
    if (!showingReconnecting) {
      showingReconnecting = true;
      //statusText.text = "Connecting...";
      //bar.append(spinner);
    }
  }

  void showConnected() {
    if (showingReconnecting) {
      showingReconnecting = false;
      //statusText.text = "Connected";
      //spinner.remove();
    }
  }

  void display(/*DivElement parentDiv*/) {
    if (!showing) {
      /*
      parentDiv.append(bar);
      var appearanceAnimation = new CssAnimation('height', '0px', '60px');

      appearanceAnimation.apply(bar,
          iterations: 1,
          alternate: false,
          duration: 500,
          onComplete: () {});
          */

      showing = true;
    }
  }

  void remove() {
    if (showing) {
      /*
      var appearanceAnimation = new CssAnimation('height', '60px', '0px');

      appearanceAnimation.apply(bar,
          iterations: 1,
          alternate: false,
          duration: 500,
          onComplete: () {
            bar.remove();
          });
          */

      showing = false;
    }
  }
/*
  void createBarView() {
    bar = new DivElement();
    bar.id = "TopStatusBar";
    bar.className = "barViewConnection";
  }
  void createStatusText() {
    statusText = new SpanElement();
    statusText.id = "TopStatusBar";
    statusText.className = "connectionStatusText";
    statusText.text = "Connecting...";
    bar.append(statusText);
  }
  void createSpinner() {
    spinner = new DivElement();
    spinner.id = "TopStatusBar";
    spinner.className = "spinner";
  }
  */
}