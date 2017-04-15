library ClinicianConsole.Classes.Consoles.AppDevicesConsole.AppDevicesConsole;
//import 'dart:html';
import 'AppSidebar.dart';
import 'DeviceSidebar.dart';
import '../../Data/Data.dart';
//import 'package:animation/animation.dart';
import '../../Apps/App.dart';
import 'SummaryDisplay.dart';
import 'dart:async';

class AppDevicesConsole {
  Data data;
  String name = "AppDevicesConsole";
  //Variables
  //DivElement mainView; //Div contains everything
  AppSidebar appSidebarController; //Left app sidebar
  DeviceSidebar deviceSidebarController; //Right device sidebar
  //DivElement contentView; //The view that holds the current app
  App currentDisplayApp; //Current app's display
  SummaryDisplay summaryDisplay;
  Timer updateTimer;

  AppDevicesConsole(this.data) {
    //addMainDivComponent();
    //addContentViewDivComponent();
    summaryDisplay = new SummaryDisplay(data);
    appSidebarController = new AppSidebar(data);
    deviceSidebarController = new DeviceSidebar(data);
    updateTimer = new Timer.periodic(new Duration(milliseconds: 16), (_){
      logic(1000.0/60.0);
    });
  }
  void updateLock() {
    for (App a in data.appController.apps) {
      a.updateLock();
    }
  }
  void toggleAppWarning(App app) {
    appSidebarController.toggleAppWarning(app);
  }
  void toggleAppError(App app) {
    appSidebarController.toggleAppError(app);
    }
  void appAdded(App app) {
    appSidebarController.addApp(app);
    summaryDisplay.addApp(app);
    if (currentDisplayApp == null) {
      app.showSubdisplay();
    }
    app.updateLock();
  }
  /*
  void appRemoved(App app) {
      appSidebarController.removeApp(app);
      summaryDisplay.removeApp(app);
        displaySummaryView();
    }
    */
  void deviceAdded(String device) {
    deviceSidebarController.addDevice(device);
  }
  void deviceRemoved(String device) {
    deviceSidebarController.removeDevice(device);
  }
  void logic(num t) {
    summaryDisplay.logic(t);
    for (App a in data.appController.apps) {
      a.update();
    }
  }
  void display(/*DivElement parentDiv*/) {
    //parentDiv.append(mainView);
    //displaySideBars(parentDiv);
  }/*
  void displaySideBars(DivElement parentDiv) {
    DivElement devicesDiv = deviceSidebarController.getDiv();
    mainView.append(devicesDiv);
    devicesDiv.style.right = '-200px';
    animate(devicesDiv, duration: 400, properties: {
      'right': 0
    });
    DivElement sidebarDiv = appSidebarController.getDiv();
    mainView.append(sidebarDiv);
    sidebarDiv.style.left = '-200px';
    animate(sidebarDiv, duration: 400, properties: {
      'left': 0
    }).onComplete.listen((var d) {
      displayContentView();
    });
    appSidebarController.summaryClicked();
  }
  void displaySummaryView() {
    if (currentDisplayApp != null) {
      currentDisplayApp.getDisplayDiv().remove();
      currentDisplayApp.hideDisplay();
      currentDisplayApp = null;
    }
    contentView.append(summaryDisplay.getDiv());
    for (App a in data.appController.apps) {
      a.showSubdisplay();
    }
  }
  void displayContentView() {
    mainView.insertBefore(contentView, mainView.firstChild);
    if (currentDisplayApp != null) {
      contentView.append(currentDisplayApp.getDisplayDiv());
      currentDisplayApp.showDisplay();
    }
    contentView.style.opacity = '0.0';
    animate(contentView, duration: 500, properties: {
      'opacity': 1.0
    });
  }
  void clickedApp(App app) {
    appSidebarController.setSelectedApp(app);
    if (currentDisplayApp != null) {
      currentDisplayApp.getDisplayDiv().remove();
      currentDisplayApp.hideDisplay();
      currentDisplayApp = null;
    } else {
      summaryDisplay.getDiv().remove();
      for (App a in data.appController.apps) {
        a.hideSubdisplay();
      }
    }
    currentDisplayApp = app;
    contentView.append(currentDisplayApp.getDisplayDiv());
    app.showDisplay();
  }
  */
  void terminateApp(App app) {
    data.appController.removeApp(app.getName());
  }
  void removeApp(App app) {
    if (app == currentDisplayApp) {
      //currentDisplayApp.getDisplayDiv().remove();
      currentDisplayApp.hideDisplay();
      currentDisplayApp = null;
      //displaySummaryView();
    }
    appSidebarController.removeCellForApp(app);
    appSidebarController.removeApp(app);
    summaryDisplay.removeApp(app);
  }
  //DivElement getDiv() {
  //  return mainView;
  //}

  /**************** Create GUI Components **************/
/*
  void addMainDivComponent() {
    mainView = new DivElement();
    mainView.id = "AppDevicesConsole";
    mainView.className = "mainView";
  }
  void addContentViewDivComponent() {
    contentView = new DivElement();
    contentView.id = "AppDevicesConsole";
    contentView.className = "contentView";
  }
  */
}