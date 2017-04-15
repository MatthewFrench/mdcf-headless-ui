library ClinicianConsole.Classes.Data.AppController;
import "../Apps/App.dart";
import "Data.dart";
class AppController {
  Data data;
  List<App> apps;
  AppController(Data data) {
    this.data = data;
    apps = new List();
  }
  void addApp(Map m) {
    String guid = m['GUID'];
    Map guiSpec = m['GUI Specification'];
    List devices = m['Connected Devices'];
    App app = new App(guid, guiSpec, data, devices);
    apps.add(app);
    data.mainGUI.appDevicesConsole.appAdded(app);
  }
  void message(Map m) {
    String guid = m['GUID'];
    App app = null;
    for (int i = 0; i < apps.length; i++) {
      App a = apps[i];
      if (apps[i].getGUID() == guid) {
        app = a;
        i = apps.length;
      }
    }
    if (app != null) {
      app.Message(m['Message']);
    }
  }
  void removeApp(String guid) {
    for (int i = 0; i < apps.length; i++) {
      App a = apps[i];
      if (a.getGUID() == guid) {
        data.mainGUI.appDevicesConsole.removeApp(a);
        apps.removeAt(i);
        i = apps.length;
      }
    }
  }
  void clearApps() {
    while(apps.length > 0) {
      App a = apps[0];
        data.mainGUI.appDevicesConsole.removeApp(a);
        apps.removeAt(0);
    }
  }
}
