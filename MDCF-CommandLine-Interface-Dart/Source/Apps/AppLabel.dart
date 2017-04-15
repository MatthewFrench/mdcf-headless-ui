library ClinicianConsole.Classes.Apps.AppLabel;
//import 'dart:html';
import 'App.dart';
import 'Components/Component.dart';

class AppLabel {
  App _app;
  //DivElement _main;
  //DivElement _nameDiv;
  //DivElement _guidDiv;
  //CanvasElement _contentCanvas;
  Component _component;
  int numberOfPoints;
  bool showing = false;
  //SpanElement statusSpan;

  AppLabel(App a) {
    _app = a;
    /*
    addMainDivComponent();
    addContentDivComponent();
    addNameDivComponent();
    addGuidDivComponent();
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
  String backgroundColor = "White";
  void warningUpdate() {
    if (_app.warning) {
      warningColor = 255;
      if (_app.error == false) {
        //statusSpan.text = " (Warning)";
        //statusSpan.style.color = "Black";
      }
    } else {
      //_main.style.background = backgroundColor;
      if (_app.error == false) {
        //statusSpan.text = " (Online)";
        //statusSpan.style.color = "rgb(0,180,0)";
      }
    }
    numberOfPoints=0;//Force update
  }
  int warningColor = 255;
  bool warningIncreasing = true;
  int warningSpeed = 8;
  void errorUpdate() {
    if (_app.error) {
      errorColor = 255;
      //statusSpan.text = " (Error)";
      //statusSpan.style.color = "Black";
    } else {
      //_main.style.background = backgroundColor;
      if (_app.warning) {
        //statusSpan.text = " (Warning)";
        //statusSpan.style.color = "Black";
      } else {
        //statusSpan.text = " (Online)";
        //statusSpan.style.color = "rgb(0,180,0)";
      }
    }
    numberOfPoints=0;//Force update
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
    //  _component.drawSubcanvas(_contentCanvas);
    //}
    //}
  }
  void Message(Map message) {
    //{Name: spO2, Data: 99, Title: Component Update}
  }
  /*
  void show() {
    showing = true;
  }
  void hide() {
    showing = false;
  }*/

  /**************** Create GUI Components **************/
/*
  void addMainDivComponent() {
    _main = new DivElement();
    _main.id = "AppLabel";
    _main.className = "main.dart";
  }
  void addNameDivComponent() {
    _nameDiv = new DivElement();
    _nameDiv.id = "AppLabel";
    _nameDiv.className = "nameDiv";
    SpanElement s = new SpanElement();
    SpanElement s2 = new SpanElement();
    s2.id = "AppLabel";
    s2.className = "nameSpan2";
    s2.text = _app.getName();
    s.append(s2);
    statusSpan = new SpanElement();
    statusSpan.id = "AppLabel";
    statusSpan.className = "statusSpan";
    statusSpan.text = " (Online)";
    s.append(statusSpan);
    _nameDiv.append(s);
    _main.append(_nameDiv);
  }
  void addGuidDivComponent() {
    _guidDiv = new DivElement();
    _guidDiv.id = "AppLabel";
    _guidDiv.className = "guidDiv";
    SpanElement s = new SpanElement();
    s.id = "AppLabel";
    s.className = "guidDivSpan";
    s.text = "GUID: " + _app.getGUID();
    _guidDiv.append(s);
    _main.append(_guidDiv);
  }
  void addContentDivComponent() {
    _contentCanvas = new CanvasElement();
    _contentCanvas.id = "AppLabel";
    _contentCanvas.className = "contentCanvas";
    _main.append(_contentCanvas);

    HRElement bottomSeparator = new HRElement();
    bottomSeparator.id = "AppLabel";
    bottomSeparator.className = "bottomSeparator";
    _main.append(bottomSeparator);
  }
  */
}
