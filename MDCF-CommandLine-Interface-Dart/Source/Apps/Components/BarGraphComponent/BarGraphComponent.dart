library ClinicianConsole.Classes.Apps.Components.BarGraphComponent;
//import 'dart:html';
import '../../App.dart';
import '../Component.dart';
import 'BarGraphController.dart';

class BarGraphComponent implements Component {
  String _displayName;
  String _dataName;
  App _app;
  //DivElement _displayZoomControl, _displayZoomPercentDiv;
  //DivElement _componentDisplayDiv, _componentSubdisplayDiv;
  BarGraphController _displayGraphController, _subdisplayGraphController;
  //DivElement lockOverlay, lockOverlaySubdisplay;

  BarGraphComponent(App app, String displayName, String dataName) {
    _app = app;
    _displayName = displayName;
    _dataName = dataName;
    //createDisplayDiv();
    //createSubdisplayDiv();
    _displayGraphController = new BarGraphController();
    _subdisplayGraphController = new BarGraphController(showNumbers: false);
    //_componentDisplayDiv.append(_displayGraphController.getGraphCanvas());
    //_componentSubdisplayDiv.append(_subdisplayGraphController.getGraphCanvas());
  }
  void setLocked() {
    //_componentDisplayDiv.append(lockOverlay);
    //_componentSubdisplayDiv.append(lockOverlaySubdisplay);
    _displayGraphController.clear();
    _subdisplayGraphController.clear();
  }
  void setUnlocked() {
    //lockOverlay.remove();
    //lockOverlaySubdisplay.remove();
  }
  void setDisplaySize(int width, int height) {
    _displayGraphController.setGraphSize(width, height);
  }
  void setDisplayShowing(bool isShowing) {
    _displayGraphController.setShowing(isShowing);
  }
  void setSubdisplaySize(int width, int height) {
    _subdisplayGraphController.setGraphSize(width, height);
  }
  void setSubdisplayShowing(bool isShowing) {
    _subdisplayGraphController.setShowing(isShowing);
  }
  void setData(var value, [bool updateDisplay=true]) {
    _displayGraphController.addData(value, _app.warning, _app.error, updateDisplay);
    _subdisplayGraphController.addData(value, _app.warning, _app.error, updateDisplay);
  }
  void updateDisplay() {
    _displayGraphController.updateDisplay();
    _subdisplayGraphController.updateDisplay();
  }
  /*
  HtmlElement getDisplayDiv() {
    return _componentDisplayDiv;
  }
  HtmlElement getSubdisplayDiv() {
    return _componentSubdisplayDiv;
  }*/
  String getDisplayName() {
    return _displayName;
  }
  String getDataName() {
    return _dataName;
  }
/*
  void createDisplayDiv() {
    _componentDisplayDiv = new DivElement();
    _componentDisplayDiv.id = "BarGraphComponent";
    _componentDisplayDiv.className = "componentDisplayDiv";

    lockOverlay = new DivElement();
    lockOverlay.id = "MainGUI";
    lockOverlay.className = "lockOverlay";
    SpanElement lockOverlayText = new SpanElement();
    lockOverlayText.id = "MainGUI";
    lockOverlayText.className = "lockOverlayText";
    lockOverlayText.text = "Redacted";
    lockOverlay.append(lockOverlayText);
  }
  void createSubdisplayDiv() {
    _componentSubdisplayDiv = new DivElement();
    _componentSubdisplayDiv.id = "BarGraphComponent";
    _componentSubdisplayDiv.className = "componentSubdisplayDiv";

    lockOverlaySubdisplay = new DivElement();
    lockOverlaySubdisplay.id = "MainGUI";
    lockOverlaySubdisplay.className = "lockOverlay";
    SpanElement lockOverlayText = new SpanElement();
    lockOverlayText.id = "MainGUI";
    lockOverlayText.className = "lockOverlayText";
    lockOverlayText.text = "Redacted";
    lockOverlaySubdisplay.append(lockOverlayText);
  }*/
}