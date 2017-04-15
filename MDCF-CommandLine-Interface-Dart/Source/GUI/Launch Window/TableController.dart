library ClinicianConsole.Classes.Consoles.AppDevicesConsole.LaunchWindow.TableController;
//import 'dart:html';

class TableController {
  //DivElement tableDiv;
  //List<SpanElement> cells = new List<SpanElement>();
  List objects = new List();
  //SpanElement selectedCell = null;
  var callbackFunction;
  TableController(/*DivElement td*/) {
    //tableDiv = td;
  }
  void addString(String item, var object) {
    /*
    SpanElement cell = CreateCell(item);
    cells.add(cell);
    objects.add(object);
    tableDiv.append(cell);
    */
  }
  /*
  void addElement(SpanElement s, var object) {
    cells.add(s);
    objects.add(object);
    tableDiv.append(s);
  }
  SpanElement getCellForObject(var object) {
    for (int i = 0; i < objects.length; i++) {
      var item = objects[i];
      if (item == object) {
        return cells[i];
      }
    }
    return null;
  }
  void removeItem(int itemNum) {
    cells[itemNum].remove();
    cells.removeAt(itemNum);
    objects.removeAt(itemNum);
  }
  int getIndexOfObject(var object) {
    return objects.indexOf(object);
  }
  void deselectAllItems() {
    for (int i = 0; i < cells.length; i++) {
          var c = cells[i];
          c.style.borderStyle="";
          c.style.borderColor = "";
          c.style.borderWidth="";
      c.style.borderBottomStyle = "solid";
        }
  }
  void itemClicked(SpanElement cell) {
    selectedCell = cell;
    deselectAllItems();
    //cell.id = "TableController";
    //cell.className = "cellSelected";
    cell.style.borderColor = "black";
    cell.style.borderStyle="solid";
    cell.style.borderWidth="2px";
    if (callbackFunction != null) {
      callbackFunction(cells.indexOf(cell));
    }
  }
  Object getObjectOfIndex(int i) {
    return objects[i];
  }
  SpanElement getSelectedCell() {
    return selectedCell;
  }
  Object getSelectedObject() {
    if (selectedCell == null) {
      return null;
    }
    int i = cells.indexOf(selectedCell);
    return objects[i];
  }
  int getSelectedIndex() {
    for (int i = 0; i < cells.length; i++) {
      if (selectedCell == cells[i]) {
        return i;
      }
    }
    return -1;
  }
  void clearTable() {
    while (tableDiv.hasChildNodes()) {
      tableDiv.lastChild.remove();
    }
    cells = new List();
    objects = new List();
    selectedCell = null;
  }
  void cellMouseDown(SpanElement cell) {
    itemClicked(cell);
  }
  SpanElement CreateCell(String text) {
    SpanElement cell = new SpanElement();
    cell.id = "TableController";
    cell.className = "cell";
    cell.text = text;
    cell.onMouseDown.listen((_){cellMouseDown(cell);});
    return cell;
  }
  */
}
