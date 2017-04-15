library UserStatusBar;
//import 'dart:html';
//import 'package:css_animation/css_animation.dart';
import 'dart:async';
import '../../Data/Data.dart';

class UserStatusBar {
  //DivElement bar;
  bool showing = false;
  /*
  SpanElement statusText;
  DivElement lockUnlockButton;
  DivElement idleDiv;
  */
  String user = "Sir Professor PhD Dr. Grand Duke Captain Mr President Awesome";
  bool locked = false;
  Timer updateIdleTimer = null;
  Stopwatch idleWatch = new Stopwatch();
  Data data;
  //SelectElement roleSelector;
  List<String> _roleList;

  UserStatusBar(this.data) {
    //createBarView();
    //createLoginStatusText();
    //createLockUnlockButton();
    //createIdleCounter();
    //createRoleSelector();
    setLocked();

    /*
    window.onClick.listen((_){resetIdleTimer();});
    window.onMouseMove.listen((_){resetIdleTimer();});
    window.onKeyPress.listen((_){resetIdleTimer();});
    */
  }
  void resetIdleTimer() {
    idleWatch.reset();
  }

  void lockUnlockButtonClicked() {
    if (!locked) {
      /****SEND LOCK MESSAGE***/
      Map m = new Map();
      m['Title'] = 'Lock';
      data.networkingController.Send(m);

      //data.client.setLocked();
      //setLocked();
    } else {
      data.mainGUI.loginWindow.display(/*data.mainGUI.mainView*/);
      //setUnlocked();
    }
  }

  void setLocked() {
    if (!locked) {
      /*
      bar.id = "TopStatusBar";
      bar.className = "barViewLoggedOut";
      statusText.id = "TopStatusBar";
      statusText.className = "loginStatusTextLocked";
      statusText.text = "Locked";
      lockUnlockButton.id = "TopStatusBar";
      lockUnlockButton.className = "loginStatusUnlockButton";
      lockUnlockButton.text = "Unlock";
      */
      if (updateIdleTimer != null) {
        updateIdleTimer.cancel();
        updateIdleTimer = null;
      }
      //idleDiv.remove();
      //roleSelector.remove();
      locked = true;
    }
  }
  void setUnlocked() {
    if (locked) {
      /*
      bar.id = "TopStatusBar";
      bar.className = "barViewLoggedIn";
      statusText.id = "TopStatusBar";
      statusText.className = "loginStatusTextUnlocked";
      statusText.text = "Unlocked as ${user}";
      lockUnlockButton.id = "TopStatusBar";
      lockUnlockButton.className = "loginStatusLockButton";
      lockUnlockButton.text = "Lock";
      bar.append(idleDiv);
      bar.append(roleSelector);
      */
      idleWatch.reset();
      idleWatch.start();
      //idleDiv.text = "4:59";
      updateIdleTimer = new Timer.periodic(new Duration(seconds:1), (_){
        int seconds = idleWatch.elapsed.inSeconds.toInt();
        int minutes = idleWatch.elapsed.inMinutes.toInt();
        seconds -= minutes*60;
        seconds = 59 - seconds;
        minutes = 4 - minutes;
        if (seconds < 10) {
          //idleDiv.text = "${minutes}:0${seconds}";
        } else {
          //idleDiv.text = "${minutes}:${seconds}";
        }
        if (idleWatch.elapsed.inMinutes.toInt() >= 5) {
          Map m = new Map();
          m['Title'] = 'Lock';
          data.networkingController.Send(m);
        }
      });
      locked = false;
    }
  }

  void display(/*DivElement parentDiv*/) {
    if (!showing) {
      //parentDiv.append(bar);
      //var appearanceAnimation = new CssAnimation('height', '0px', '60px');
/*
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
    bar.className = "barViewLoggedOut";
  }
  void createLoginStatusText() {
    statusText = new SpanElement();
    statusText.id = "TopStatusBar";
    statusText.className = "loginStatusTextLocked";
    bar.append(statusText);
  }
  void createLockUnlockButton() {
    lockUnlockButton = new DivElement();
    lockUnlockButton.id = "TopStatusBar";
    lockUnlockButton.className = "loginStatusLockButton";
    lockUnlockButton.onClick.listen((_){
      lockUnlockButtonClicked();
    });
    bar.append(lockUnlockButton);
  }

  void createIdleCounter() {
    idleDiv = new DivElement();
    idleDiv.id = "TopStatusBar";
    idleDiv.className = "loginStatusIdleDiv";
  }
*/
  /*
  void createRoleSelector() {
    roleSelector = new SelectElement();
    roleSelector.id = "TopStatusBar";
    roleSelector.className = "roleSelector";

    roleSelector.append(new OptionElement(data:'Default Data', value:'Default Value', selected: true));

    roleSelector.onChange.listen((_){
      Map m = new Map();
      m['Title'] = 'Set Active Role';
      m['Role Name'] = _roleList[roleSelector.selectedIndex];
      data.networkingController.Send(m);
    });
  }
  */

  void setRoleList(List<String> roleList) {
    _roleList = roleList;
    //roleSelector.children.clear();
    //for (String role in roleList) {
    //  roleSelector.append(new OptionElement(data:role, value:role, selected: false));
    //}
  }
  void setActiveRole(String activeRole) {
    //roleSelector.selectedIndex = _roleList.indexOf(activeRole);
  }


}