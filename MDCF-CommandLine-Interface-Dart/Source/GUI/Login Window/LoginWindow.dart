library LoginWindow;
import '../../Data/Data.dart';
//import 'dart:html';

class LoginWindow {
  /*
  DivElement background;
  DivElement window;
  InputElement userInput;
  InputElement passwordInput;
  ButtonElement loginButton;
  */

  Data data;
  LoginWindow(this.data) {
    createBackground();
    createWindow();
  }
  void loginClick() {
    Map m = new Map();
    m['Title'] = 'Login';
    //m['Username'] = userInput.value;
    //m['Password'] = passwordInput.value;
    data.networkingController.Send(m);

    remove();
    //data.mainGUI.topStatusBar.showUserStatus();
    //data.client.setUnlocked();
    //data.mainGUI.topStatusBar.userStatusBar.setUnlocked();
  }
  void display(/*DivElement parentDiv*/) {

    //userInput.value = "";
    //passwordInput.value = "";
    //userInput.focus();
  }
  void remove() {
    //background.remove();
    //window.remove();
  }
  void createBackground() {
    /*
    background = new DivElement();
    background.id = "LoginWindow";
    background.className = "background";
    background.onClick.listen((_){
      remove();
    });
    */
  }
  void createWindow() {
    /*
    window = new DivElement();
    window.id = "LoginWindow";
    window.className = "window";
    */

    /*
    SpanElement loginTitle = new SpanElement();
    loginTitle.id = "LoginWindow";
    loginTitle.className = "loginTitle";
    loginTitle.text = "Log In";
    window.append(loginTitle);
    */

    /*
    userInput = new InputElement(type:"text");
    userInput.id = "LoginWindow";
    userInput.className = "userInput";
    userInput.placeholder = "User";
    window.append(userInput);
    passwordInput = new InputElement(type:"password");
    passwordInput.id = "LoginWindow";
    passwordInput.className = "passwordInput";
    passwordInput.placeholder = "Password";
    passwordInput.onKeyPress.listen((KeyboardEvent e){
      if (e.keyCode == KeyCode.ENTER) {
        loginClick();
      }
    });
    window.append(passwordInput);
    loginButton = new ButtonElement();
    loginButton.id = "LoginWindow";
    loginButton.className = "loginButton";
    loginButton.text = "Log In";
    loginButton.onClick.listen((_){loginClick();});
    window.append(loginButton);
    */
  }
}