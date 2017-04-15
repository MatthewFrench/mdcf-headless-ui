library ClinicianConsole.Classes.Apps.App;
import 'AppDisplay.dart';
import 'AppSubdisplay.dart';
import 'AppLabel.dart';
//import 'dart:html';
import 'Components/GraphComponent/GraphComponent.dart';
import '../Data/Data.dart';
import 'Components/BarGraphComponent/BarGraphComponent.dart';
import 'Components/Component.dart';

class App {
  String _guid;
  String _name;
  AppDisplay _display;
  AppSubdisplay _subdisplay;
  AppLabel _label;
  List _componentMaps;
  List<Component> _components = new List();
  bool warning = false;
  bool error = false;
  Data data;
  List<String> devices;
  App(String g, Map guiSpec, Data data, List devices) {
    //map.put("Connected Devices", connectedDevices);
    this.devices = devices;
    this.data = data;
    _guid = g;
    _name = guiSpec["App Name"];
    _componentMaps = guiSpec["Components"];
    //Gui Spec Format: {Components: [{Name: spO2, Line Color: Red, Type: Graph}], App Name: Case 3}
    _display = new AppDisplay(this);
    _subdisplay = new AppSubdisplay(this);
    _label = new AppLabel(this);

    for (int i = 0; i < _componentMaps.length; i++) {
      Map componentMap = _componentMaps[i];
      switch (componentMap["Type"]) {
        case "Graph":
          {
            String displayName = componentMap["Display Name"];
            String dataName = componentMap["Data Name"];
            double min = double.parse(componentMap["Min"]);
            double max = double.parse(componentMap["Max"]);
            String lineColor = componentMap["Line Color"];
            GraphComponent cmpt = new GraphComponent(this, displayName, dataName, lineColor, min, max);
            _components.add(cmpt);
            _display.addComponent(cmpt);
          }
          break;
        case "Bar Graph":
          {
          String displayName = componentMap["Display Name"];
          String dataName = componentMap["Data Name"];
            BarGraphComponent cmpt = new BarGraphComponent(this, displayName, dataName);
            _components.add(cmpt);
            _display.addComponent(cmpt);
          }
          break;
        default: //Anything else just turns into normal value component
          {
          String displayName = componentMap["Display Name"];
          String dataName = componentMap["Data Name"];
            Component cmpt = new Component(this, displayName, dataName);
            _components.add(cmpt);
            _display.addComponent(cmpt);
          }
          break;
      }
    }
    String subcomponentName = guiSpec["Subdisplay"];
    Component chosenSubcomponent = null;
    for (Component g in _components) {
      if (g.getDisplayName() == subcomponentName) {
        chosenSubcomponent = g;
      }
    }
    if (chosenSubcomponent == null && _components.length > 0) {
      chosenSubcomponent = _components.first;
    }
    if (chosenSubcomponent != null) {
        _subdisplay.setComponent(chosenSubcomponent);
        _label.setComponent(chosenSubcomponent);
    }
  }

  void updateLock() {
    //Display has terminate button
    if (data.permissions.getAppTerminatePermission(_name)) {
      _display.setUnlocked();
    } else {
      _display.setLocked();
    }
    for (Component c in _components) {
      if (data.permissions.getComponentPermission(_name, c.getDataName())) {
        c.setUnlocked();
      } else {
        c.setLocked();
      }
    }
    //
    /*
    for (Component c in _components) {
      c.setLocked();
    }
    _display.setLocked();
    _subdisplay.setLocked();
    */
  }
/*
  void setLocked() {
    locked = true;
    for (Component c in _components) {
      c.setLocked();
    }
    _display.setLocked();
    _subdisplay.setLocked();
  }
  void setUnlocked() {
    locked = false;
    for (Component c in _components) {
      c.setUnlocked();
    }
    _display.setUnlocked();
    _subdisplay.setLocked();
  }
*/
  void update() {
    //for (int i = 0; i < _components.length; i++) {
    //  Component c = _components[i];
      //c.update();
    //}
    _display.update();
    _subdisplay.update();
    _label.update();
  }
  void terminate() {
    data.appController.removeApp(_guid);
  }
  void toggleWarning() {
    warning = !warning;
    _display.warningUpdate();
    _subdisplay.warningUpdate();
    _label.warningUpdate();
    data.mainGUI.appDevicesConsole.toggleAppWarning(this);
  }
  void toggleError() {
    error = !error;
    _display.errorUpdate();
    _subdisplay.errorUpdate();
    _label.errorUpdate();
    data.mainGUI.appDevicesConsole.toggleAppError(this);
  }
  void updateComponentDisplays() {
    for (int i = 0; i < _components.length; i++) {
      Component c = _components[i];
      c.updateDisplay();
    }
  }
  void Message(Map message) {
    //{Name: spO2, Data: 99, Title: Component Update}
    if (message["Title"] == "Component Update") {
      for (int i = 0; i < _components.length; i++) {
        Component c = _components[i];
        if (c.getDataName() == message['Name']) {
          var data = message["Data"];
          if (data != null) {
            c.setData(data);
          }
        }
      }
    }
  }
  String getName() {
    return _name;
  }
  String getGUID() {
    return _guid;
  }
  /*
  HtmlElement getDisplayDiv() {
    return _display.getDiv();
  }
  HtmlElement getSubDisplayDiv() {
    return _subdisplay.getDiv();
  }
  HtmlElement getLabelDiv() {
    return _label.getDiv();
  }
  */
  void showDisplay() {
    _display.show();
  }
  void hideDisplay() {
    _display.hide();
  }
  void showSubdisplay() {
    _subdisplay.show();
  }
  void hideSubdisplay() {
    _subdisplay.hide();
  }
  AppLabel getLabel() {
    return _label;
  }
  List<Component> getComponents() {
    return _components;
  }
}