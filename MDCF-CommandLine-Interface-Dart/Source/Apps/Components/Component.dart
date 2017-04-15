library ClinicianConsole.Classes.Apps.Components.Component;
//import 'dart:html';
import '../App.dart';

class Component {
  String _displayName;
  String _dataName;
  App _app;
  bool _displayShowing = false, _subdisplayShowing = false;
  int _displayWidth = 0, _displayHeight = 0, _subdisplayWidth = 0, _subdisplayHeight = 0;
  /*
  DivElement _componentDisplayDiv, _componentSubdisplayDiv;
  SpanElement _componentDisplayText, _componentSubdisplayText;
  DivElement lockOverlay, lockOverlaySubdisplay;
  */

  Component(App app, String displayName, String dataName) {
    _app = app;
    _displayName = displayName;
    _dataName = dataName;
    //createDisplayDiv();
    //createSubdisplayDiv();
  }
  void setLocked() {
    //_componentDisplayDiv.append(lockOverlay);
    //_componentSubdisplayDiv.append(lockOverlaySubdisplay);
  }
  void setUnlocked() {
    //lockOverlay.remove();
    //lockOverlaySubdisplay.remove();
  }
  void setDisplaySize(int width, int height) {
    _displayWidth = width; _displayHeight = height;
  }
  void setDisplayShowing(bool isShowing) {
    _displayShowing = isShowing;
  }
  void setSubdisplaySize(int width, int height) {
    _subdisplayWidth = width; _subdisplayHeight = height;
  }
  void setSubdisplayShowing(bool isShowing) {
    _subdisplayShowing = isShowing;
  }
  void setData(var value, [bool updateDisplay=true]) {
    //_componentDisplayText.text = value.toString();
    //_componentSubdisplayText.text = value.toString();
  }
  void updateDisplay() {

  }
  /*
  HtmlElement getDisplayDiv() {
    return _componentDisplayDiv;
  }
  HtmlElement getSubdisplayDiv() {
    return _componentSubdisplayDiv;
  }
  */
  String getDisplayName() {
    return _displayName;
  }
  String getDataName() {
    return _dataName;
  }

  /*
  void createDisplayDiv() {
    _componentDisplayDiv = new DivElement();
    _componentDisplayDiv.id = "Component";
    _componentDisplayDiv.className = "componentDisplayDiv";

    _componentDisplayText = new SpanElement();
    _componentDisplayText.id = "Component";
    _componentDisplayText.className = "componentDisplayText";
    _componentDisplayText.text = "0";
    _componentDisplayDiv.append(_componentDisplayText);

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
    _componentSubdisplayDiv.id = "Component";
    _componentSubdisplayDiv.className = "componentSubdisplayDiv";

    _componentSubdisplayText = new SpanElement();
    _componentSubdisplayText.id = "Component";
    _componentSubdisplayText.className = "componentSubdisplayText";
    _componentSubdisplayText.text = "0";
    _componentSubdisplayDiv.append(_componentSubdisplayText);

    lockOverlaySubdisplay = new DivElement();
    lockOverlaySubdisplay.id = "MainGUI";
    lockOverlaySubdisplay.className = "lockOverlay";
    SpanElement lockOverlayText = new SpanElement();
    lockOverlayText.id = "MainGUI";
    lockOverlayText.className = "lockOverlayText";
    lockOverlayText.text = "Redacted";
    lockOverlaySubdisplay.append(lockOverlayText);
  }
  */
}