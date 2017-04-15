library ClinicianConsole.Classes.Consoles.AppDevicesConsole.AppSidebar;
//import 'dart:html';
import '../../Data/Data.dart';
import '../../Apps/App.dart';
//import 'package:animation/animation.dart';
class AppSidebar {
  List<App> _cellApps = new List();
  App _selectedCell = null;
  Data data;
  int errorApps = 0;
  int warningApps = 0;
  AppSidebar(Data d) {
    data = d;
    /*
    addSidebarDivComponent();
    addTitleDivComponent();
    addContainerDivComponent();
    addLaunchButtonComponent();
    */
    updateCellPositions(true);
  }
  void toggleAppWarning(App a) {
    if (a.warning) { //Warning was turned on
      if (a.error == false) {
        _cellApps.remove(a);
        _cellApps.insert(0 + errorApps + warningApps, a);
        warningApps += 1;
      }
    } else { //Warning was turned off
      if (a.error == false) {
        warningApps -= 1;
        _cellApps.remove(a);
        _cellApps.insert(0+errorApps+warningApps, a);
      }
    }
    updateCellPositions(true);
  }
  void toggleAppError(App a) {
    if (a.error) { //Error turned on
      if (a.warning) {
        warningApps -= 1;
      }
      _cellApps.remove(a);
      _cellApps.insert(0 + errorApps, a);
      errorApps += 1;
    } else { //Error turned off
      errorApps -= 1;
      _cellApps.remove(a);
      if (a.warning) {
        _cellApps.insert(0 + errorApps + warningApps, a);
        warningApps += 1;
      } else {
        _cellApps.insert(0+errorApps+warningApps,a);
      }
    }
    updateCellPositions(true);
  }
  void setSelectedApp(App a) {
    setSelectedCell(getCellNum(a));
    //Because we want apps recently selected, move them to the top
    _cellApps.remove(a);
    if (a.error == false && a.warning == false) {
      _cellApps.insert(0 + errorApps + warningApps, a);
    } else if (a.error == true) {
      _cellApps.insert(0, a);
    } else if (a.warning == true) {
      _cellApps.insert(0 + errorApps, a);
    }
    updateCellPositions(true);
  }
  void summaryClicked() {
    setSelectedCell(-1);
    //_sidebarTitleContainer.style..backgroundColor = "rgb(255,255,205)";
    //data.mainGUI.appDevicesConsole.displaySummaryView();
  }
  //DivElement getDiv() {
  //  return _appSidebar;
  //}
  void addApp(App app) {

    //_appContainer.append(app.getLabelDiv());
    _cellApps.add(app);
    //app.getLabelDiv().onMouseDown.listen((var d) {
    //  itemClicked(app);
    //});
    updateCellPositions(true);

    //_sidebarTitle.text = "Running Apps (${_cellApps.length})";
  }
  void removeApp(App app) {
    //app.getLabelDiv().remove();
    _cellApps.remove(app);
    updateCellPositions(true);
    //_sidebarTitle.text = "Apps (${_cellApps.length} running)";
    if (app.error) {
      errorApps -= 1;
    } else if (app.warning) {
      warningApps -= 1;
    }
  }
  void itemClicked(App app) {
    setSelectedCell(_cellApps.indexOf(app));
    //data.mainGUI.appDevicesConsole.clickedApp(app);
  }
  void setSelectedCell(int n) {
    //_sidebarTitleContainer.style.backgroundColor = "white";
    if (n == -1 || _cellApps.length <= n) {
      _selectedCell = null;
    } else {
      _selectedCell = _cellApps[n];
    }
    //Loop through cells and set style
    for (int i = 0; i < _cellApps.length; i++) {
      App app = _cellApps[i];
      //DivElement c = app.getLabelDiv();
      //c.style..backgroundColor = "white";
      if (app == _selectedCell) {
        app.getLabel().backgroundColor = "rgb(255,255,205)";
      } else {
        app.getLabel().backgroundColor = "white";
      }
    }
    if (_selectedCell != null) {
      //_selectedCell.getLabelDiv().style..backgroundColor = "rgb(255,255,205)";
    }
  }
  void removeCellForApp(app) {
    removeCellNum(getCellNum(app));
  }
  void removeCellNum(n) {
    App app = _cellApps[n];
    //DivElement cell = app.getLabelDiv();
    if (_selectedCell == app) {
      setSelectedCell(-1);
    }
    //cell.remove();
    _cellApps.removeAt(n);
    updateCellPositions(true);

    //_sidebarTitle.text = "Apps (${_cellApps.length-1} running)";
  }
  void updateCellPositions(animated) {
    var duration = 0;
    if (animated) {
      duration = 400;
    }
    for (int i = 0; i < _cellApps.length; i++) {
      //_cells[i].style.top = "${49*i}";
      //animate(_cellApps[i].getLabelDiv(), duration: duration, properties: {
      //  'top': (49 * (i))
      //});
    }
  }
  int getCellNum(App app) {
    for (int i = 0; i < _cellApps.length; i++) {
      App c = _cellApps[i];
      if (c == app) {
        return i;
      }
    }
    return -1;
  }

  /**************** Create GUI Components **************/
  /*
  DivElement _appSidebar = null;
  DivElement _appContainer = null;
  SpanElement _sidebarTitle;
  DivElement _sidebarTitleContainer;
  DivElement summaryCell;
  void addSidebarDivComponent() {
    //create sidebar
    _appSidebar = new DivElement();
    _appSidebar.id = "AppSidebar";
    _appSidebar.className = "appSidebar";
  }
  void addTitleDivComponent() {
    _sidebarTitleContainer = new DivElement();
    _sidebarTitleContainer.id = "AppSidebar";
    _sidebarTitleContainer.className = "sidebarTitleContainer";
    _sidebarTitle = new SpanElement();
    _sidebarTitle.text = "Running Apps";
    _sidebarTitleContainer.append(_sidebarTitle);
    _appSidebar.append(_sidebarTitleContainer);
    HRElement topHR = new HRElement();

    topHR.id = "AppSidebar";
    topHR.className = "topHR";

    _appSidebar.append(topHR);
    _sidebarTitleContainer.onMouseDown.listen((var d) {
          summaryClicked();
        });
  }
  void addContainerDivComponent() {
    //Add container
    _appContainer = document.createElement('div');

    _appContainer.id = "AppSidebar";
    _appContainer.className = "appContainer";

    _appSidebar.append(_appContainer);
  }
  void addLaunchButtonComponent() {
    //Add launch button
    DivElement launchBtn = new DivElement();
    launchBtn.id = "AppSidebar";
    launchBtn.className = "launchBtn";
    launchBtn.onClick.listen((var e) {
      data.mainGUI.launchWindowGUI.display();
    });
    SpanElement s = new SpanElement();
    s.text = "Launch App";
    launchBtn.append(s);
    _appSidebar.append(launchBtn);
  }
  */
}