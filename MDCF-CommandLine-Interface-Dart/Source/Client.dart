library ClinicianConsole.Client;

import 'dart:core';
import 'Data/Data.dart';
import 'ClientMessageHandler.dart';
import 'dart:async';

class Client {
  Data data;
  ClientMessageHandler messageHandler;



  Client(ip, eventMessageCallback) {
    data = new Data(this);
    messageHandler = new ClientMessageHandler(data);
    data.createAppController();
    data.createDeviceController();
    data.createNetworkController(ip, eventMessageCallback);
    data.createMainUI();
    //data.mainGUI.display(document.body);

    //Try for network and login
    new Future.delayed(new Duration(seconds: 0), () {
      data.mainGUI.topStatusBar.showConnectionStatus();
      data.mainGUI.topStatusBar.resizeTopBarAndMainView();
    });
  }
  void setLocked() {
    data.mainGUI.topStatusBar.showUserStatus();
    data.mainGUI.topStatusBar.userStatusBar.setLocked();
    data.mainGUI.launchWindowGUI.setLocked();
    data.mainGUI.appDevicesConsole.updateLock();
    data.mainGUI.appDevicesConsole.summaryDisplay.clearSearchText();
  }
  void setUnlocked() {
    data.mainGUI.topStatusBar.showUserStatus();
    data.mainGUI.topStatusBar.userStatusBar.setUnlocked();
    data.mainGUI.launchWindowGUI.setUnlocked();
    data.mainGUI.appDevicesConsole.updateLock();
  }
  void connectedToServer() {
    new Future.delayed(new Duration(seconds: 1), () {
      data.mainGUI.topStatusBar.connectionStatusBar.showConnected();

      //Do login
      setLocked();
      //data.mainGUI.topStatusBar.showUserStatus();

      data.mainGUI.topStatusBar.resizeTopBarAndMainView();

      new Future.delayed(new Duration(seconds: 1), () {
        data.mainGUI.topStatusBar.hideConnectionStatus();
        data.mainGUI.topStatusBar.resizeTopBarAndMainView();
      });
    });
  }

  void disconnectedFromServer() {
    /*
    setLocked();
    data.mainGUI.topStatusBar.hideUserStatus();
    data.mainGUI.topStatusBar.showConnectionStatus();
    data.mainGUI.topStatusBar.connectionStatusBar.showReconnecting();
    data.mainGUI.topStatusBar.resizeTopBarAndMainView();
    data.deviceController.clearDevices();
    data.appController.clearApps();
    new Future.delayed(new Duration(seconds: 1), ()
    {
      data.networkingController.connectToServer();
    });
    */
  }
}