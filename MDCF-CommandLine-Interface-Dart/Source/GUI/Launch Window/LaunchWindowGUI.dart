library ClinicianConsole.Classes.Consoles.AppDevicesConsole.LaunchWindow.LaunchWindowGUI;
//import 'dart:html';
import 'TableController.dart';
import 'MatchingTableController.dart';
import '../../Data/Data.dart';
//import 'package:animation/animation.dart';
import 'ZenoProgressBar.dart';
import 'dart:async';
class LaunchWindowGUI {
  TableController launchAppTableController = null;
  MatchingTableController launchDeviceTableController = null;
  Data data;
  ZenoProgressBar progressBar;
  //DivElement launchButtonLockOverlay;
  bool locked = false;


  LaunchWindowGUI(Data d) {
    data = d;
    /*
    createWindow();
    createAppTable();
    createDeviceTable();
    createLaunchButton();
    createLaunchText();
    createAppLabelAndBackBtn();
    */

    launchAppTableController = new TableController(/*appTable*/);
    launchDeviceTableController = new MatchingTableController(/*deviceTable*/);

    launchAppTableController.callbackFunction = appTableClicked;
    launchDeviceTableController.callbackFunction = deviceTableChanged;

    progressBar = new ZenoProgressBar(40.0, 60.0, 520.0, 30.0);

    reset();
  }
  void updateAppLaunchPermissions() {
    for (int i = 0; i < data.launchableAppList.length; i++) {
      String a = data.launchableAppList[i];
      //SpanElement cell = launchAppTableController.getCellForObject(a);
      /*
      if (cell != null) {
        if (data.permissions.getAppLaunchPermission(a)) {
          cell.className = "cell";
        } else {
          cell.className = "cellBlocked";
        }
      }
      */
    }
  }
  void setLocked() {
    locked = true;
    //launchBtn.append(launchButtonLockOverlay);
    //launchTextSpan.text = "You can't launch without permissions";
    //window.append(launchText);
    updateAppLaunchPermissions();
  }
  void setUnlocked() {
    locked = false;
    //launchButtonLockOverlay.remove();
    //launchTextSpan.text = "All attributes must be filled before the app can launch.";
    //launchText.remove();
    updateAppLaunchPermissions();
  }
  void deviceTableChanged() {
    if (launchDeviceTableController.allAttributesMatched()) {
      //launchBtn.className = "launchBtnHighlighted";
    } else {
      //launchBtn.className = "launchBtn";
    }
  }
  void appTableClicked(int index) {
    String app = data.launchableAppList[index];

    if (data.permissions.getAppLaunchPermission(app)) {
      //appTitleLabel.text = "App Selected: ${data.launchableAppList[index]}";
      //Send the clicked app to the server so it can send back a device list
      Timer t = new Timer(new Duration(milliseconds: 250), () {
        Map m = new Map();
        m['Title'] = 'Get Device List';
        m['App'] = data.launchableAppList[index];
        data.networkingController.Send(m);
        launchDeviceTableController.clearTable();
      });

      //showLoadingBar();
    }
  }
  //void deviceTableClicked(int index) {
    //showLaunchButton();
  //}
  void display() { //Appends them over entire body
    //Send notification to the server that the launch window is getting displayed
    //So the server can update the apps
    Map m = new Map();
          m['Title'] = 'Get App List';
          data.networkingController.Send(m);
    
    //Make sure it's reset
    reset();

    //Add background overlay element - Place it before top status bar so can log in
    //data.mainGUI.mainView.append(background);
    //data.mainGUI.mainView.insertBefore(background, data.mainGUI.topStatusBar.getDiv());
    //Add window
    //data.mainGUI.mainView.append(window);
    /*
    background.style.opacity = '0.0';
    window.style.opacity = '0.0';
    //Add app label and table
    window.append(appTable);
    window.append(appTableLabel);
    appTable.style.opacity = "1.0";
    appTableLabel.style.opacity = "1.0";
    */
    /*
    animate(background, duration: 500, properties: {
      'opacity': 1.0
    });
    animate(window, duration: 500, properties: {
      'opacity': 1.0
    });
*/
    /*
    if (locked) {
      launchTextSpan.text = "You can't launch without permissions";
      window.append(launchText);
      launchText.style.opacity = "1";
    } else {
      launchTextSpan.text = "All attributes must be filled before the app can launch.";
      launchText.remove();
      launchText.style.opacity = "0";
    }*/
    updateAppLaunchPermissions();
  }
  void updateAppList() {
    //launchAppTableController.clearTable();
    for (int i = 0; i < data.launchableAppList.length; i++) {
      String a = data.launchableAppList[i];
      launchAppTableController.addString(a, a);
    }
    updateAppLaunchPermissions();
  }
  void updateMatchingResultList() {
    launchDeviceTableController.clearTable();
    launchDeviceTableController.fillTable(data.matchingResultList);
      //launchDeviceTableController.addString(a['Feature'] + "-" + a['Device Name'], a);
    //}
    Timer t = new Timer(new Duration(milliseconds: 250), showDeviceList);
    progressBar.setComplete(250);
  }
  /*
  void close(MouseEvent m) {
    data.mainGUI.mainView.append(foregroundBlock);
    animate(background, duration: 500, properties: {
      'opacity': 0.0
    });
    animate(window, duration: 500, properties: {
      'opacity': 0.0
    }).onComplete.listen((var d) {
      reset();
    });
  }
  */
  /*
  void launchApp(MouseEvent m) {
    if (!locked) {
      if (launchDeviceTableController.allAttributesMatched()) {
        Map m = new Map();
        m['Title'] = 'Launch App';
        m['App Name'] = launchAppTableController.getSelectedObject();

        //Send all selected ports
        m['Device Information'] = launchDeviceTableController.getMatchingMap();

        data.networkingController.Send(m);
        close(null);
      } else {
        showLaunchText();
      }
      // else {
      //window.alert('Cannot Launch App until all Attributes are filled with a device port.');
      //}
    }
  }

  void backButtonClicked(MouseEvent m) {
    animate(deviceTable, duration: 250, properties: {
      'opacity': 0.0
    });
    animate(progressBar.getDiv(), duration: 250, properties: {
      'opacity': 0.0
    });
    animate(backButton, duration: 250, properties: {
      'opacity': 0.0
    });
    animate(appTitleLabel, duration: 250, properties: {
      'opacity': 0.0
    });
    animate(deviceTableLabel, duration: 250, properties: {
      'opacity': 0.0
    });
    animate(launchBtn, duration: 250, properties: {
      'opacity': 0.0
    }).onComplete.listen((var d) {
      deviceTable.remove();
      progressBar.getDiv().remove();
      backButton.remove();
      appTitleLabel.remove();
      deviceTableLabel.remove();
      launchBtn.remove();
      launchText.remove();
      launchAppTableController.deselectAllItems();
      appTable.style.opacity = "0.0";
      appTableLabel.style.opacity = "0.0";
      window.append(appTable);
      window.append(appTableLabel);
      animate(appTable, duration: 250, properties: {
        'opacity': 1.0
      });
      animate(appTableLabel, duration: 250, properties: {
        'opacity': 1.0
      });
    });
    updateAppLaunchPermissions();
  }
  void showLoadingBar() {
    int windowWidth = window.clientWidth;
    if (windowWidth <= 80) {
      windowWidth = 520;
    }
    progressBar.setWidth(windowWidth - 80);
    animate(appTable, duration: 250, properties: {
      'opacity': 0.0
    });
    animate(appTableLabel, duration: 250, properties: {
      'opacity': 0.0
    }).onComplete.listen((var d) {
      appTable.remove();
      appTableLabel.remove();
      progressBar.reset();
      progressBar.start();
      progressBar.setOpacity(0.0);
      appTitleLabel.style.opacity = "0.0";
      backButton.style.opacity = "0.0";
      window.append(progressBar.getDiv());
      window.append(appTitleLabel);
      window.append(backButton);
      animate(progressBar.getDiv(), duration: 250, properties: {
        'opacity': 1.0
      });
      animate(appTitleLabel, duration: 250, properties: {
        'opacity': 1.0
      });
      animate(backButton, duration: 250, properties: {
        'opacity': 1.0
      });
    });
  }
  */
  void showDeviceList() {
    deviceTableChanged();
    //if (appTable.parent != null) return;
    /*
    animate(deviceTable, duration: 250, properties: {
      'opacity': 1.0
    });
    animate(deviceTableLabel, duration: 250, properties: {
      'opacity': 1.0
    });
    window.append(deviceTable);
    window.append(deviceTableLabel);
    animate(progressBar.getDiv(), duration: 250, properties: {
      'opacity': 0.0
    }).onComplete.listen((var d) {

      progressBar.getDiv().remove();
      showLaunchButton();
    });
    */
  }
  /*
  void showLaunchButton() {
    animate(launchBtn, duration: 250, properties: {
      'opacity': 1.0
    });
    window.append(launchBtn);
  }
  void showLaunchText() {
      animate(launchText, duration: 250, properties: {
        'opacity': 1.0
      });
      window.append(launchText);
    }
    */
  void reset() {
    /*
    background.style.opacity = "0.0";
    window.style.opacity = "0.0";
    foregroundBlock.style.opacity = "0.0";
    appTable.style.opacity = "0.0";
    appTableLabel.style.opacity = "0.0";
    deviceTable.style.opacity = "0.0";
    deviceTableLabel.style.opacity = "0.0";
    progressBar.getDiv().style.opacity = "0.0";
    launchBtn.style.opacity = "0.0";
    launchText.style.opacity = "0.0";
    appTitleLabel.style.opacity = "0.0";
    backButton.style.opacity = "0.0";
    launchBtn.className = "launchBtn";

    background.remove();
    window.remove();
    foregroundBlock.remove();
    appTable.remove();
    appTableLabel.remove();
    deviceTable.remove();
    deviceTableLabel.remove();
    progressBar.getDiv().remove();
    launchBtn.remove();
    launchText.remove();
    appTitleLabel.remove();
    backButton.remove();
    */

    //launchAppTableController.deselectAllItems();

    updateAppLaunchPermissions();
  }

  /**************** Create GUI Components **************/
  /*
  DivElement background = null,
        foregroundBlock,
        window,
        deviceTable,
        launchBtn, launchText,
        deviceTableLabel,
        appTableLabel,
        appTitleLabel,
        backButton,
        appTable;
  SpanElement launchTextSpan;
  void createWindow() {
    background = new DivElement();
    background.id = "LaunchWindow";
    background.className = "background";
    foregroundBlock = new DivElement();
    foregroundBlock.id = "LaunchWindow";
    foregroundBlock.className = "foregroundBlock";
    window = new DivElement();
    window.id = "LaunchWindow";
    window.className = "window";
    //Add components to window
    DivElement closeBtn = new DivElement();
    closeBtn.id = "LaunchWindow";
    closeBtn.className = "closeBtn";
    closeBtn.onClick.listen(close);
    SpanElement s = new SpanElement();
    s.text = "X";
    closeBtn.append(s);
    window.append(closeBtn);
  }
  void createAppTable() {
    appTable = new DivElement();
    appTable.id = "LaunchWindow";
    appTable.className = "appTable";
    appTableLabel = new DivElement();
    appTableLabel.id = "LaunchWindow";
    appTableLabel.className = "appTableLabel";
    SpanElement s = new SpanElement();
    s.text = "Apps";
    appTableLabel.append(s);
  }
  void createDeviceTable() {
    deviceTable = new DivElement();
    deviceTable.id = "LaunchWindow";
    deviceTable.className = "deviceTable";
    deviceTableLabel = new DivElement();
    deviceTableLabel.id = "LaunchWindow";
    deviceTableLabel.className = "deviceTableLabel";
    SpanElement s = new SpanElement();
    s.text = "App Setup";
    deviceTableLabel.append(s);
  }
  void createLaunchButton() {
    launchBtn = new DivElement();
    launchBtn.id = "LaunchWindow";
    launchBtn.className = "launchBtn";

    launchBtn.onClick.listen(launchApp);
    SpanElement s = new SpanElement();
    s.text = "Launch";
    launchBtn.append(s);

    launchButtonLockOverlay = new DivElement();
    launchButtonLockOverlay.id = "MainGUI";
    launchButtonLockOverlay.className = "lockOverlay";
    SpanElement lockOverlayText = new SpanElement();
    lockOverlayText.id = "MainGUI";
    lockOverlayText.className = "lockOverlayText";
    lockOverlayText.text = "Locked";
    launchButtonLockOverlay.append(lockOverlayText);
  }
  void createLaunchText() {
    launchText = new DivElement();
    launchText.id = "LaunchWindow";
    launchText.className = "launchText";

    launchTextSpan = new SpanElement();
    launchTextSpan.text = "All attributes must be filled before the app can launch.";
    launchText.append(launchTextSpan);
  }
  void createAppLabelAndBackBtn() {
    appTitleLabel = new DivElement();
    appTitleLabel.id = "LaunchWindow";
    appTitleLabel.className = "appTitleLabel";
    SpanElement s = new SpanElement();
    s.text = "App Selected: ";
    appTitleLabel.append(s);

    backButton = new DivElement();
    backButton.id = "LaunchWindow";
    backButton.className = "backButton";

    backButton.onClick.listen(backButtonClicked);
    s = new SpanElement();
    s.text = "Back";
    backButton.append(s);
  }
  */
}