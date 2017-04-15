library ClinicianConsole.GUI.MainGUI;
import 'dart:core';
import 'App & Devices/AppDevicesConsole.dart';
import '../Data/Data.dart';
import 'Launch Window/LaunchWindowGUI.dart';
import 'Top Status Bar/TopStatusBar.dart';
import 'Login Window/LoginWindow.dart';
import 'Top Status Bar/PatientBar.dart';

class MainGUI {
  //DivElement mainView;
  LaunchWindowGUI launchWindowGUI;
  AppDevicesConsole appDevicesConsole;
  TopStatusBar topStatusBar;
  PatientBar patientBar;
  LoginWindow loginWindow;

  Data data;
  MainGUI(Data d) {
    data = d;
    data.mainGUI = this;
    //createMainViewComponent();

    loginWindow = new LoginWindow(data);
    launchWindowGUI = new LaunchWindowGUI(data);
    appDevicesConsole = new AppDevicesConsole(data);
    topStatusBar = new TopStatusBar(data);
    patientBar = new PatientBar();

    //appDevicesConsole.display(mainView);
    //topStatusBar.display(mainView);

    //appDevicesConsole.getDiv().append(patientBar.getDiv());
    //patientBar.getDiv().style.opacity = '0.0';
    //animate(patientBar.getDiv(), duration: 400, properties: {
    //  'opacity': 1.0
    //}).onComplete.listen((var d) {});
  }

  //void display(HtmlElement parentElement) {
  //  parentElement.append(mainView);
  //}
  //DivElement getDiv() {
  //  return mainView;
  //}

  //void createMainViewComponent() {
  //  mainView = new DivElement();
  //  mainView.id = "MainGUI";
  //  mainView.className = "mainView";
  //}
}