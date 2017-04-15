library ClinicianConsole.Classes.Apps.AppDisplay;
//import 'dart:html';
import 'Components/Component.dart';
import 'App.dart';
import 'dart:async';

class AppDisplay {
  App _app;

  /*
  DivElement _main;
  DivElement _tabContainer, _summaryDiv, _buttonsDiv, _summaryBarItem, _showingCurrentDiv;
  ButtonElement terminateAppButton;
  SpanElement terminateAppButtonSpan;
  */
  ComponentDisplay showingComponent;
  //List <DivElement> _tabDivs = new List();
  bool locked = false;

  List displayDivs;
  int _displayDivWidth = 0,
      _displayDivHeight = 0,
      _windowWidth = 0,
      _windowHeight = 0;
  List<ComponentDisplay> _componentDisplays = new List();
  List<ComponentBlock> _componentBlocks = new List();
  bool showing = false;

  AppDisplay(App a) {
    _app = a;
    /*
    addMainComponent();
    addTitle();
    addGUID();
    addBarDiv();
    addDisplayContainer();
    addSummary();
    */
    summaryBarItemClick();
    //window.onResize.listen((_) {updateTabs();blockLogic();});
  }
  void setLocked() {
    locked = true;
    //terminateAppButton.append(terminateButtonLockOverlay);
    /*
    terminateAppButtonSpan.text = "Locked";
    terminateAppButton.className = "terminateAppButtonLocked";
    terminateAppButtonSpan.id = "MainGUI";
    terminateAppButtonSpan.className = "lockOverlayText";
    */
  }
  void setUnlocked() {
    locked = false;
    //terminateButtonLockOverlay.remove();
    /*
    terminateAppButtonSpan.text = "Terminate App";
    terminateAppButton.className = "terminateAppButton";
    terminateAppButtonSpan.id = "";
    terminateAppButtonSpan.className = "";
    */
  }
  void updateTabs() {
    /*
    int w = _buttonsDiv.clientWidth;
          int tabWidth = (w-40) ~/ _tabDivs.length;
          if (tabWidth > 150) {tabWidth = 150;}
          for (int i = 0; i < _tabDivs.length; i++) {
            DivElement e = _tabDivs[i];
            e.style.width = "${tabWidth}px";
            e.style.left = "${w/2 - tabWidth/2 - ((_tabDivs.length/2-(i+0.5))*tabWidth)}px";
          }
          */
  }
  void warningUpdate() {
    if (_app.warning) {
      warningColor = 255;
    } else {
      //_main.style.background = "White";
    }
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
    //blockLogic();
  }
  void summaryBarItemClick() {
    /*
    _summaryBarItem.style.backgroundColor = "rgb(200,200,200)";
    for (ComponentDisplay cd in _componentDisplays) {
      cd.barItem.style.backgroundColor = "white";
    }
    if (_showingCurrentDiv != null) {
      _showingCurrentDiv.remove();
    }
    if (showingComponent != null) {
      showingComponent.component.setDisplayShowing(false);
      showingComponent = null;
    }
    _showingCurrentDiv = _summaryDiv;
    _tabContainer.append(_showingCurrentDiv);
    */
    //Showing summary items
    for (ComponentBlock cb in _componentBlocks) {
            //cb.blockContent.append(cb.component.getSubdisplayDiv());
            cb.component.setSubdisplaySize(cb.contentWidth, cb.contentHeight);
            cb.component.setSubdisplayShowing(true);
          }
    //blockLogic();
  }
  void componentBarItemClick(ComponentDisplay clickedCD) {
    /*
    _summaryBarItem.style.backgroundColor = "white";
    for (ComponentDisplay cd in _componentDisplays) {
      cd.barItem.style.backgroundColor = "white";
    }
    clickedCD.barItem.style.backgroundColor = "rgb(200,200,200)";
    if (_showingCurrentDiv != null) {
      _showingCurrentDiv.remove();
    }
    if (showingComponent != null) {
      showingComponent.component.setDisplayShowing(false);
    }
    showingComponent = clickedCD;
    showingComponent.component.setDisplaySize(_tabContainer.clientWidth, _tabContainer.clientHeight);
    showingComponent.component.setDisplayShowing(true);
    _showingCurrentDiv = clickedCD.displayDiv;
    clickedCD.displayDiv.append(showingComponent.component.getDisplayDiv());
    _tabContainer.append(_showingCurrentDiv);
    */
  }

  void show() {
    showing = true;
    if (showingComponent != null) {
      //Showing a single component
      //showingComponent.component.setDisplaySize(_tabContainer.clientWidth, _tabContainer.clientHeight);
      showingComponent.component.setDisplayShowing(true);
    } else {
      //Showing the summary view
      for (ComponentBlock cb in _componentBlocks) {
        cb.component.setSubdisplaySize(cb.contentWidth, cb.contentHeight);
        cb.component.setSubdisplayShowing(true);
      }
      summaryBarItemClick();
    }
    new Future(updateTabs);
    //new Future(blockLogic);
  }
  void hide() {
    showing = false;
    if (showingComponent != null) {
      showingComponent.component.setDisplayShowing(false);
    }
  }
  void addComponent(Component component) {
    //{Name: spO2, Line Color: Red, Type: Graph}
    /*
    ComponentDisplay cd = new ComponentDisplay(component);
    _componentDisplays.add(cd);
    _buttonsDiv.append(cd.barItem);
    _tabDivs.add(cd.barItem);
    cd.barItem.onClick.listen((_) {
      componentBarItemClick(cd);
    });
    ComponentBlock cb = new ComponentBlock(component);
    _componentBlocks.add(cb);
    _summaryDiv.append(cb.blockDiv);
    cb.blockDiv.onClick.listen((_) {
      componentBarItemClick(cd);
    });
    */
  }
  //DivElement getDiv() {
  //  return _main;
  //}
  App getApp() {
    return _app;
  }
  /**************** Create GUI Components **************/
  /*
  void addMainComponent() {
    _main = new DivElement();
    _main.id = "AppDisplay";
    _main.className = "main.dart";
  }
  void addTitle() {
    SpanElement title = new SpanElement();
    title.id = "AppDisplay";
    title.className = "title";
    title.text = _app.getName() + ' App';
    _main.append(title);
  }
  void addGUID() {
    SpanElement guid = new SpanElement();
    guid.id = "AppDisplay";
    guid.className = "guid";
    guid.text = '${_app.getGUID()}';
    _main.append(guid);
  }
  void addBarDiv() {
    DivElement barDiv = new DivElement();
    barDiv.id = "AppDisplay";
    barDiv.className = "barDiv";
    _main.append(barDiv);

    HRElement barHR = new HRElement();
    barHR.id = "AppDisplay";
    barHR.className = "barHR";
    barDiv.append(barHR);
    _buttonsDiv = new DivElement();
    _buttonsDiv.id = "AppDisplay";
    _buttonsDiv.className = "buttonsDiv";
    barDiv.append(_buttonsDiv);
  }
  void addSummary() {
    _summaryBarItem = new DivElement();
    _summaryBarItem.id = "AppDisplay";
    _summaryBarItem.className = "summaryBarItem";

    SpanElement summaryText = new SpanElement();

    summaryText.id = "AppDisplay";
    summaryText.className = "summaryText";

    summaryText.text = "Summary";
    _summaryBarItem.append(summaryText);
    _buttonsDiv.append(_summaryBarItem);
    
    _tabDivs.insert(0,_summaryBarItem);

    _summaryBarItem.onClick.listen((_) {
      summaryBarItemClick();
    });

    _summaryDiv = new DivElement();
    _summaryDiv.id = "AppDisplay";
    _summaryDiv.className = "summaryDiv";
    
    SpanElement span = new SpanElement();
    span.text = "Devices: ";
    for (String device in _app.devices) {
      span.text += device;
    }
    span.id = "AppDisplay";
    span.className = "summaryDevicesSpan";
    _summaryDiv.append(span);

    terminateAppButton = new ButtonElement();
    terminateAppButton.id = "AppDisplay";
    terminateAppButton.className = "terminateAppButton";

    terminateAppButtonSpan = new SpanElement();
    terminateAppButtonSpan.text = "Terminate App";
    terminateAppButton.append(terminateAppButtonSpan);

    terminateAppButton.onClick.listen((_) {
      if (!locked) {
        _app.terminate();
      }
    });
    _summaryDiv.append(terminateAppButton);


    ButtonElement button = new ButtonElement();
    button.id = "AppDisplay";
    button.className = "toggleWarningButton";

    button.text = "Toggle Warning";
    _summaryDiv.append(button);
    button.onClick.listen((_) {
      _app.toggleWarning();
    });
    button = new ButtonElement();
    button.id = "AppDisplay";
    button.className = "toggleErrorButton";

    button.text = "Toggle Error";
    _summaryDiv.append(button);
    button.onClick.listen((_) {
      _app.toggleError();
    });
  }
  void addDisplayContainer() {
    _tabContainer = new DivElement();
    _tabContainer.id = "AppDisplay";
    _tabContainer.className = "tabContainer";
    _main.append(_tabContainer);
  }

  /***********FOR ARRANGING THE BLOCKS*******/
  int _bWidth = 140,
      _bHeight = 70;
  int _xSidePadding = 20,
      _ySidePadding = 20;
  int _xBlockPadding = 10,
      _yBlockPadding = 10;
  int _currentWindowWidth = -1;
  int _arrangeWidthChange = 0;

  void blockLogic() {
    //If our blocks are unnarranged, we need to arrange them
    if ((_currentWindowWidth == -1 || _currentWindowWidth != _main.offsetWidth - _xSidePadding * 2) && _main.offsetWidth != 0) {
      //The window is resized or blocks unnarranged
      if (_arrangeWidthChange != _main.offsetWidth - _xSidePadding * 2) {
        _arrangeWidthChange = _main.offsetWidth - _xSidePadding * 2;
        arrangeBlocks();
      }
    }
    //Update the canvases
    //if (showing) {
    //  for (ComponentBlock block in _componentBlocks) {
     //   if (block.numberOfPoints != block.component.getNumberOfPoints()) {
     //     block.numberOfPoints = block.component.getNumberOfPoints();
     //     block.component.drawSubcanvas(block.blockCanvas);
     //   }
    //  }
    //}
  }
  void arrangeBlocks() {
    List blockArray = _componentBlocks;
    _currentWindowWidth = _main.offsetWidth - _xSidePadding * 2;

    int blocksInRow = _currentWindowWidth ~/ (_bWidth + _xBlockPadding);
    for (int i = 0; i < blockArray.length; i++) {
      int filledColumns = i ~/ blocksInRow;
      int y = filledColumns * _bHeight + _ySidePadding + filledColumns * _yBlockPadding;
      int x = (i - (filledColumns * blocksInRow)) * _bWidth + _xSidePadding + (i - (filledColumns * blocksInRow)) * _xBlockPadding + _xBlockPadding;
      ComponentBlock b = blockArray[i];
      b.blockDiv.style.left = "${x}px";
      b.blockDiv.style.top = "${y}px";
    }
  }
  */
}
class ComponentDisplay {
  Component component;
  //DivElement barItem;
  //DivElement displayDiv;
  ComponentDisplay(Component c) {
    component = c;

    /*
    barItem = new DivElement();
    barItem.id = "AppDisplay";
    barItem.className = "componentDisplayBarItem";

    SpanElement summaryText = new SpanElement();

    summaryText.id = "AppDisplay";
    summaryText.className = "componentDisplaySummaryText";

    summaryText.text = c.getDisplayName();
    barItem.append(summaryText);
    displayDiv = new DivElement();

    displayDiv.id = "AppDisplay";
    displayDiv.className = "componentDisplayDisplayDiv";

    displayDiv.append(component.getSubdisplayDiv());
    */
  }
}
class ComponentBlock {
  Component component;
  /*
  SpanElement name;
  DivElement blockDiv;
  DivElement blockContent;
  */
  int contentWidth = 140;
  int contentHeight = 50;
  //int numberOfPoints = 0;
  ComponentBlock(Component c) {
    component = c;
    /*
    blockDiv = new DivElement();

    blockDiv.id = "AppDisplay";
    blockDiv.className = "componentBlockDiv";

    name = new SpanElement();
    name.text = component.getDisplayName();

    name.id = "AppDisplay";
    name.className = "componentBlockName";

    blockDiv.append(name);
    blockContent = new DivElement();

    blockContent.id = "AppDisplay";
    blockContent.className = "componentBlockContent";

    blockDiv.append(blockContent);
    */
  }
}