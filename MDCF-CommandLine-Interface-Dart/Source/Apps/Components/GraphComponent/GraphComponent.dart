library ClinicianConsole.Classes.Apps.Components.GraphComponent;
//import 'dart:html';
import '../../App.dart';
import '../Component.dart';
import 'GraphController.dart';

class GraphComponent implements Component {
  String _displayName;
  String _dataName;
  App _app;
  //DivElement _displayZoomControl, _displayZoomPercentDiv;
  //DivElement _componentDisplayDiv, _componentSubdisplayDiv;
  GraphController _displayGraphController, _subdisplayGraphController;
  //DivElement lockOverlay, lockOverlaySubdisplay;

  GraphComponent(App app, String displayName, String dataName, String lineColor, double min, double max) {
    _app = app;
    _displayName = displayName;
    _dataName = dataName;
    //createDisplayDiv();
    //createSubdisplayDiv();
    _displayGraphController = new GraphController(lineColor, min, max, enableMouse: true);
    _subdisplayGraphController = new GraphController(lineColor, min, max, enableMouse: false);
    //_componentDisplayDiv.append(_displayGraphController.getGraphCanvas());
    //_componentSubdisplayDiv.append(_subdisplayGraphController.getGraphCanvas());
    //addZoomToDisplay();
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
    _componentDisplayDiv.id = "GraphComponent";
    _componentDisplayDiv.className = "componentDisplayDiv";
  }
  void addZoomToDisplay() {
    _displayZoomControl = new DivElement();
    _displayZoomControl.id = "GraphComponent";
    _displayZoomControl.className = "displayZoomControl";
    _componentDisplayDiv.append(_displayZoomControl);

    DivElement minusDiv = new DivElement();
    minusDiv.id = "GraphComponent";
    minusDiv.className = "minusDiv";
    minusDiv.text = "–";
    _displayZoomControl.append(minusDiv);
    minusDiv.onClick.listen((_) {
      _displayGraphController.minusClick();
      _displayZoomPercentDiv.text = "${(_displayGraphController.getPointScale()*100).round()}%";
    });

    DivElement plusDiv = new DivElement();
    plusDiv.id = "GraphComponent";
    plusDiv.className = "plusDiv";
    plusDiv.text = "+";
    _displayZoomControl.append(plusDiv);
    plusDiv.onClick.listen((_) {
      _displayGraphController.plusClick();
      _displayZoomPercentDiv.text = "${(_displayGraphController.getPointScale()*100).round()}%";
    });

    _displayZoomPercentDiv = new DivElement();
    _displayZoomPercentDiv.id = "GraphComponent";
    _displayZoomPercentDiv.className = "displayZoomPercentDiv";
    _displayZoomPercentDiv.text = "100%";
    _displayZoomControl.append(_displayZoomPercentDiv);

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
    _componentSubdisplayDiv.id = "GraphComponent";
    _componentSubdisplayDiv.className = "componentSubdisplayDiv";

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