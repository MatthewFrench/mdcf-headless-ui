library ClinicianConsole.Classes.Apps.AppSubdisplay;
//import 'dart:html';
import 'App.dart';
import 'Components/Component.dart';

class AppSubdisplay {
  App _app;
  /*
  DivElement _main;
  DivElement _nameDiv;
  DivElement _guidDiv;
  DivElement _contentDiv;
  */
  Component _component;
  //int numberOfPoints;
  bool showing = false;

  AppSubdisplay(App a) {
    _app = a;
    /*
    addMainDivComponent();
    addNameDivComponent();
    addGuidDivComponent();
    addContentDivComponent();
    */
  }
  void setComponent(Component component) {
    _component = component;
  }
  //DivElement getDiv() {
  //  return _main;
  //}
  App getApp() {
    return _app;
  }
  void setLocked() {

  }
  void setUnlocked() {

  }
  void warningUpdate() {
    if (_app.warning) {
      warningColor = 255;
    } else {
      //_main.style.background = "White";
    }
    //numberOfPoints=0;//Force update
  }
  int warningColor = 255;
  bool warningIncreasing = true;
  int warningSpeed = 8;
  void errorUpdate() {
    if (_app.error) {
      errorColor = 255;
    } else {
      //_main.style.background = "White";
    }
    //numberOfPoints=0;//Force update
  }
  int errorColor = 255;
  bool errorIncreasing = true;
  int errorSpeed = 4;
  void update() {
    if (_app.error) {
      if (errorIncreasing) {
        errorColor += errorSpeed;
        if (errorColor >= 255) {
          errorIncreasing = false;
        }
      } else {
        errorColor -= errorSpeed;
        if (errorColor <= 0) {
          errorIncreasing = true;
        }
      }
      //_main.style.background = "rgb(255,${errorColor},${errorColor})";
    } else if (_app.warning) {
      if (warningIncreasing) {
        warningColor += warningSpeed;
        if (warningColor >= 255) {
          warningIncreasing = false;
        }
      } else {
        warningColor -= warningSpeed;
        if (warningColor <= 0) {
          warningIncreasing = true;
        }
      }
      //_main.style.background = "rgb(255,255,${warningColor})";
    }

    //if (showing) {
      //if (numberOfPoints != _component.getNumberOfPoints()) {
      //  numberOfPoints = _component.getNumberOfPoints();
      //  if (_contentCanvas.clientWidth != _contentCanvas.width || _contentCanvas.clientHeight != _contentCanvas.height) {
      //    _contentCanvas.width = _contentCanvas.clientWidth;
      //    _contentCanvas.height = _contentCanvas.clientHeight;
      //  }
        //_component.drawSubcanvas(_contentCanvas);
      //}
    //}
  }
  void Message(Map message) {
    //{Name: spO2, Data: 99, Title: Component Update}
  }
  void show() {
    showing = true;
    if (_component != null) {
      //_contentDiv.append(_component.getSubdisplayDiv());
      //_component.setSubdisplaySize(_contentDiv.clientWidth, _contentDiv.clientHeight);
      _component.setSubdisplayShowing(true);
    }
  }
  void hide() {
    showing = false;
  }

  /**************** Create GUI Components **************/
/*
  void addMainDivComponent() {
    _main = new DivElement();
    _main.id = "AppSubdisplay";
    _main.className = "main.dart";
  }
  void addNameDivComponent() {
    _nameDiv = new DivElement();
    _nameDiv.id = "AppSubdisplay";
    _nameDiv.className = "nameDiv";
    _nameDiv.text = _app.getName();
    _main.append(_nameDiv);
  }
  void addGuidDivComponent() {
    _guidDiv = new DivElement();
    _guidDiv.id = "AppSubdisplay";
    _guidDiv.className = "guidDiv";
    _guidDiv.text = _app.getGUID();
    _main.append(_guidDiv);
  }
  void addContentDivComponent() {
    _contentDiv = new DivElement();
    _contentDiv.id = "AppSubdisplay";
    _contentDiv.className = "contentDiv";
    _main.append(_contentDiv);
  }
  */
}
