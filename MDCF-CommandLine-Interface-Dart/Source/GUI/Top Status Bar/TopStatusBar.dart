library TopStatusBar;
//import 'dart:html';
//import 'package:animation/animation.dart';
//import 'package:css_animation/css_animation.dart';
import '../../Data/Data.dart';
import 'ConnectionStatusBar.dart';
import 'UserStatusBar.dart';
import 'dart:async';

class TopStatusBar {
  //DivElement barViewHolder;
  UserStatusBar userStatusBar;
  ConnectionStatusBar connectionStatusBar;
  int shownBars = 0;
  int prevShownBars = 0;
  Data data;
  //CssAnimation appearanceAnimation, appearanceAnimation2, appearanceAnimation3;
  TopStatusBar(this.data) {
    //createBarViewComponent();
    userStatusBar = new UserStatusBar(data);
    connectionStatusBar = new ConnectionStatusBar(data);
  }
  void display(/*DivElement parentDiv*/) {
    //parentDiv.append(barViewHolder);
    /*
    new Future.delayed(new Duration(seconds: 1), (){

      showUserStatus();
      showConnectionStatus();
      connectionStatusBar.showReconnecting();
      resizeTopBarAndMainView();
    });

    new Future.delayed(new Duration(seconds: 5), (){
      connectionStatusBar.showConnected();
      //hideUserStatus();
      //hideConnectionStatus();
      //resizeTopBarAndMainView();
    });

    new Future.delayed(new Duration(seconds: 6), (){
      hideConnectionStatus();
      resizeTopBarAndMainView();
      //showUserStatus();
      //showConnectionStatus();
      //resizeTopBarAndMainView();
    });


    new Future.delayed(new Duration(seconds: 10), (){
      userStatusBar.setUnlocked();
      //hideUserStatus();
      //hideConnectionStatus();
      //resizeTopBarAndMainView();
    });
    */
/*
    new Future.delayed(new Duration(seconds: 25), (){

      showConnectionStatus();
      resizeTopBarAndMainView();
    });

    new Future.delayed(new Duration(seconds: 30), (){

      showUserStatus();
      resizeTopBarAndMainView();
    });

    new Future.delayed(new Duration(seconds: 35), (){

      hideConnectionStatus();
      resizeTopBarAndMainView();
    });

    new Future.delayed(new Duration(seconds: 40), (){

      hideUserStatus();
      resizeTopBarAndMainView();
    });*/
  }
  void showUserStatus() {
    if (!userStatusBar.showing) {shownBars++;}
    userStatusBar.display(/*barViewHolder*/);
  }
  void hideUserStatus() {
    if (userStatusBar.showing) {shownBars--;}
    userStatusBar.remove();
  }
  void showConnectionStatus() {
    if (!connectionStatusBar.showing) {shownBars++;}
    connectionStatusBar.display(/*barViewHolder*/);
  }
  void hideConnectionStatus() {
    if (connectionStatusBar.showing) {shownBars--;}
    connectionStatusBar.remove();
  }
  void resizeTopBarAndMainView() {
    if (prevShownBars == shownBars) {
      return;
    }
    //Resize the bar view to the amount of shown bars
/*
    if (appearanceAnimation != null) {appearanceAnimation.destroy();}
    appearanceAnimation = new CssAnimation('height', '${prevShownBars*60}px', '${shownBars*60}px');
    appearanceAnimation.apply(barViewHolder,
        iterations: 1,
        alternate: false,
        duration: 500,
        onComplete: () {appearanceAnimation = null;}
    );
*/

    //Resize the main.dart view
    /*
    if (appearanceAnimation2 != null) {appearanceAnimation2.destroy();}
    appearanceAnimation2 = new CssAnimation('height', 'calc(100% - ${prevShownBars*60}px)', 'calc(100% - ${shownBars*60}px)');
    appearanceAnimation2.apply(this.data.mainGUI.appDevicesConsole.getDiv(),
        iterations: 1,
        alternate: false,
        duration: 500,
        onComplete: () {appearanceAnimation2 = null;}
    );
    */

    prevShownBars = shownBars;
  }

  //DivElement getDiv() {
   // return barViewHolder;
  //}
/*
  void createBarViewComponent() {
    barViewHolder = new DivElement();
    barViewHolder.id = "TopStatusBar";
    barViewHolder.className = "barViewHolder";
  }
  */
}