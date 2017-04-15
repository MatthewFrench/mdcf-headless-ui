library ClinicianConsole.Classes.Consoles.AppDevicesConsole.SummaryDisplay;
//import 'dart:html';
import '../../Data/Data.dart';
import '../../Apps/App.dart';
import 'dart:math';
import 'dart:convert';

class SummaryDisplay {
  //DivElement main.dart;
  Data data;
  List<Block> searchBlocks = new List<Block>(),
      blocks = new List<Block>();
  int bWidth = 160,
      bHeight = 100;
  int xSidePadding = 50,
      ySidePadding = 100;
  int xBlockPadding = 10,
      yBlockPadding = 10;
  int currentWindowWidth = -1;
  Block currentSelectedBlock = null;
  int mouseX, mouseY, mouseStartX, mouseStartY;
  int clickTimer = 0,
      clickTimerMax = 20;
  bool blockWasMoved = false;
  //DivElement searchBar;
  //InputElement searchInput;
  bool searchActive = false;
  //Storage localStorage = window.localStorage;
  List<String> savedBlocks = null;
  int millisecondsPerFrame = 16;
  int arrangeTimer = 0;
  int arrangeWidthChange = 0;
  int arrangeTimerMax = 20;
  double addDelta = 0.0;

  //Make lists for blocks needing calculating, blocks moving and blocks not moving
  //This will relieve a lot of the stress when stuff's moving

  SummaryDisplay(Data d) {
    data = d;
    /*
    addMainComponent();
    addTitleComponent();
    addSearchComponent();
    */
    //if (localStorage['blocks'] != null) {
    //  savedBlocks = JSON.decode(localStorage['blocks']);
    //}
    for (int i = 0; i < data.appController.apps.length; i++) {
      addApp(data.appController.apps[i]);
    }
  }
  void clearSearchText() {
    //searchInput.value = "";
    //searchBarTextChange();
  }
  /*
  void searchBarTextChange() {
    var text = searchInput.value.toLowerCase();
    if (text.length != 0) {
      searchActive = true;
      //Loop through all blocks to see if there are matches
      searchBlocks.clear();
      for (int i = 0; i < blocks.length; i++) {
        Block b = blocks[i];
        if (b.app.getName().toLowerCase().contains(text) || b.app.getGUID().toLowerCase().contains(text)) {
          b.destVisibility = 1.0;
          searchBlocks.add(b);
        } else {
          b.destVisibility = 0.0;
        }
      }
    } else if (searchActive == true) {
      for (int i = 0; i < blocks.length; i++) {
        Block b = blocks[i];
        b.destVisibility = 1.0;
      }
      searchActive = false;
    }
    arrangeBlocks();
  }
  */
  void addApp(App app) {
    Block b = new Block();
    b.app = app;
    /*
    b.div = new DivElement();
    b.div.id = "SummaryDisplay";
    b.div.className = "block";
    b.div.style
        ..width = "${bWidth}px"
        ..height = "${bHeight}px";
        */
    app.hideSubdisplay();
    //contentView.append(currentDisplayApp.getDisplayDiv());
    app.showDisplay();
    app.showSubdisplay();
    /*
    b.div.append(app.getSubDisplayDiv());
    main.dart.append(b.div);
    b.div.onMouseDown.listen((var e) {
      blockMouseDown(b, e.client.x, e.client.y);
    });
    b.div.onMouseUp.listen((var e) {
      blockMouseUp(b, e.client.x, e.client.y);
    });
    main.dart.onMouseMove.listen((var e) {
      mouseMove(e.client.x, e.client.y);
    });
    */

    //Now check what we have in local storage and arrange stuff properly
    if (savedBlocks != null) {
      int position = blocks.length;
      for (int i = 0; i < savedBlocks.length; i++) {
        String guid = savedBlocks[i];
        if (app.getGUID() == guid) {
          position = i;
          i = savedBlocks.length;
        }
      }
      //Insert block at the position
      if (position >= blocks.length) {
        blocks.add(b);
      } else {
        blocks.insert(position, b);
      }
    } else {
      blocks.add(b);
    }

    //searchBarTextChange();
    arrangeBlocks();
  }
  void removeApp(App app) {
    for (int i = 0; i < blocks.length; i++) {
      Block b = blocks[i];
      if (b.app == app) {
        //b.div.remove();
        blocks.remove(b);
      }
    }
    //searchBarTextChange();
    arrangeBlocks();
  }
  void blockMouseDown(Block b, int x, int y) {
    mouseStartX = x;
    mouseStartY = y;
    mouseX = x;
    mouseY = y;
    currentSelectedBlock = b;
    clickTimer = 0;
    //b.div.parentNode.append(b.div);
    blockWasMoved = false;
  }
  void blockMouseUp(Block b, int x, int y) {
    mouseX = x;
    mouseY = y;
    if (clickTimer < clickTimerMax && blockWasMoved == false && currentSelectedBlock == b && (mouseStartX - x).abs() < bWidth && (mouseStartY - y).abs() < bHeight) {
      arrangeBlocks();
      blockClicked(currentSelectedBlock);
    } else {
      arrangeBlocks();
    }
    currentSelectedBlock = null;
  }
  void mouseMove(int x, int y) {
    if (currentSelectedBlock != null) {

      List blockArray = null;
      if (searchActive) {
        blockArray = searchBlocks;
      } else {
        blockArray = blocks;
      }

      int moveX = x - mouseX;
      int moveY = y - mouseY;

      mouseX = x;
      mouseY = y;

      currentSelectedBlock.currentX += moveX;
      currentSelectedBlock.currentY += moveY;
      currentSelectedBlock.destX = currentSelectedBlock.currentX;
      currentSelectedBlock.destY = currentSelectedBlock.currentY;
      //currentSelectedBlock.div.style.left = '${currentSelectedBlock.currentX}px';
      //currentSelectedBlock.div.style.top = '${currentSelectedBlock.currentY}px';

      //Get the current approximate position in the grid for the block
      int blocksInRow = currentWindowWidth ~/ (bWidth + xBlockPadding);
      int bX = (currentSelectedBlock.currentX - xSidePadding + (bHeight + yBlockPadding) / 2) ~/ (bWidth + xBlockPadding);
      int bY = (currentSelectedBlock.currentY - ySidePadding + (bHeight + yBlockPadding) / 2) ~/ (bHeight + yBlockPadding);
      int linearPosition = bY * blocksInRow + bX;
      if (linearPosition > blockArray.length - 1) {
        linearPosition = blockArray.length - 1;
      }
      if (linearPosition < 0) {
        linearPosition = 0;
      }
      int prevPosition = blockArray.indexOf(currentSelectedBlock);
      if (prevPosition != linearPosition) {
        blockWasMoved = true;
        blockArray.removeAt(prevPosition);
        blockArray.insert(linearPosition, currentSelectedBlock);
        arrangeBlocks();
      }
    }
  }
  void blockClicked(Block b) {
    //Switch to that app's view
    //data.mainGUI.appDevicesConsole.clickedApp(b.app);
  }
  void logic(num t) {
    double delta = t / millisecondsPerFrame;
    if (delta >= 1.25 && addDelta == 0.0) {
      addDelta = delta;
      //return;
    }
    delta += addDelta;
    addDelta = 0.0;
    //print("Delta: ${delta}");
    //Run click timer
    if (currentSelectedBlock != null) {
      clickTimer += 1;
    }
    bool arrange = false;

    //If our blocks are unnarranged, we need to arrange them
    //if ((currentWindowWidth == -1 || currentWindowWidth != main.dart.offsetWidth - xSidePadding * 2) && main.dart.offsetWidth != 0) {
      //The window is resized or blocks unnarranged
      //if (currentWindowWidth == -1) {
      //  arrange = true;
        //currentWindowWidth = main.dart.offsetWidth - xSidePadding * 2;
      //}

      /*
      if (arrangeWidthChange != main.dart.offsetWidth - xSidePadding * 2) {
        arrangeWidthChange = main.dart.offsetWidth - xSidePadding * 2;
        currentWindowWidth = main.dart.offsetWidth - xSidePadding * 2;
        arrangeTimer = arrangeTimerMax;
        //for (App a in data.apps) {
        //  a.setSubdisplayUpdateDelay(arrangeTimerMax);
        //}
      }*/
    //}
    if (arrangeTimer == 0) {
      arrange = true;
      arrangeTimer = arrangeTimerMax;
    } else {
      arrangeTimer -= 1;
    }
    
    for (int i = 0; i < blocks.length; i++) {
      Block block = blocks[i];
      //If our blocks want to move, let em
      if (block != currentSelectedBlock && (block.destX != block.currentX || block.destY != block.currentY)) {
        int xDist = block.destX - block.currentX;
        int yDist = block.destY - block.currentY;
        double r = atan2(yDist, xDist);
        double dist = sqrt(xDist * xDist + yDist * yDist) / 10 * delta;
        if (dist < 4) {
          dist = 4.0;
        }
        double moveX = cos(r) * dist;
        double moveY = sin(r) * dist;
        int mX = moveX.round();
        int mY = moveY.round();

        if (moveX != 0) {
          if (xDist.abs() < moveX.abs()) {
            block.currentX = block.destX;
          } else {
            block.currentX += mX;
          }

          //block.div.style.left = '${block.currentX}px';
        }
        if (moveY != 0) {
          if (yDist.abs() < moveY.abs()) {
            block.currentY = block.destY;
          } else {
            block.currentY += mY;
          }
          //block.div.style.top = '${block.currentY}px';
        }
      }
      //If blocks wanna change visibility, let em
      if (block.destVisibility != block.currentVisibility) {
        double dist = (block.destVisibility - block.currentVisibility) / 5 * delta;
        if (dist.abs() < 0.05) {
          if (dist < 0.0) {
            dist = -0.05;
          } else {
            dist = 0.05;
          }
        }
        block.currentVisibility += dist;
        if (block.currentVisibility < 0.0) {
          block.currentVisibility = 0.0;
        }
        if (block.currentVisibility > 1.0) {
          block.currentVisibility = 1.0;
        }
        if (block.currentVisibility == 0.0 && block.destVisibility == 0.0 && block.isAdded) {
          block.isAdded = false;
          //block.div.remove();
        }
        if (block.currentVisibility != 0.0 && !block.isAdded) {
          block.isAdded = true;
          //main.dart.append(block.div);
        }
        //block.div.style.opacity = "${block.currentVisibility}";
      }
    }
    //Loop through search blocks and remove invisible ones
    if (searchActive) {
      for (int i = 0; i < searchBlocks.length; i++) {
        Block block = searchBlocks[i];
        if (block.destVisibility == 0.0 && block.currentVisibility == 0.0) {
          arrange = true;
          searchBlocks.removeAt(i);
          i--;
        }
      }
    }
    if (arrange) {
      arrangeBlocks();
    }
  }
  void arrangeBlocks() {
    List blockArray = null;
    if (searchActive) {
      blockArray = searchBlocks;
    } else {
      blockArray = blocks;
    }
    List<String> saveBlocks = new List();

    /*
    int windowWidth = main.dart.offsetWidth - xSidePadding * 2;
    if (windowWidth < arrangeWidthChange) {
      windowWidth = arrangeWidthChange;
    }

    if (windowWidth < 400) {
      windowWidth = 400;
    }*/

    /*
    int blocksInRow = windowWidth ~/ (bWidth + xBlockPadding);
    if (blocksInRow == 0) {
      blocksInRow = 1;
    }
    for (int i = 0; i < blockArray.length; i++) {
      int filledColumns = i ~/ blocksInRow;
      int y = filledColumns * bHeight + ySidePadding + filledColumns * yBlockPadding;
      int x = (i - (filledColumns * blocksInRow)) * bWidth + xSidePadding + (i - (filledColumns * blocksInRow)) * xBlockPadding + xBlockPadding;
      Block b = blockArray[i];
      b.destX = x;
      b.destY = y;

      saveBlocks.add(b.app.getGUID());
    }
    //Save the blocks
    localStorage['blocks'] = JSON.encode(saveBlocks);
    */
  }
  /*
  DivElement getDiv() {
    return main.dart;
  }
  */

  /**************** Create GUI Components **************/
  /*
  void addMainComponent() {
    main.dart = new DivElement();
    main.dart.id = "SummaryDisplay";
    main.dart.className = "main.dart";
  }
  void addTitleComponent() {
    SpanElement s = new SpanElement();
    s.id = "SummaryDisplay";
    s.className = "titleText";
    s.text = "Overview";
    main.dart.append(s);
  }
  void addSearchComponent() {
    searchBar = new DivElement();
    searchBar.id = "SummaryDisplay";
    searchBar.className = "searchBar";
    main.dart.append(searchBar);
    searchInput = new InputElement();
    searchInput.id = "SummaryDisplay";
    searchInput.className = "searchInput";
    searchInput.placeholder = 'Search';
    searchInput.onInput.listen((var d) {
      searchBarTextChange();
    });
    searchBar.append(searchInput);
    ImageElement img = new ImageElement(src: "Resources/search.png");
    img.id = "SummaryDisplay";
    img.className = "searchImage";
    searchBar.append(img);
  }
  */
}

class Block {
  //DivElement div;
  App app;
  int currentX = 0;
  int currentY = 0;
  int destX = 0;
  int destY = 0;
  double currentVisibility = 1.0;
  double destVisibility = 1.0;
  bool isAdded = false;
  Block() {
  }
}