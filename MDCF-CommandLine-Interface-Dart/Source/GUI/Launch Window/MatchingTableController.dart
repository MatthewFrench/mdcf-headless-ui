library ClinicianConsole.Classes.Consoles.AppDevicesConsole.LaunchWindow.MatchingTableController;

//import 'dart:html';
import 'MatchingAttribute.dart';
//import 'package:css_animation/css_animation.dart';

class MatchingTableController {
  //DivElement tableDiv;
  List<PortDetails> portDetails = new List();
  List<MatchingAttribute> matchingAttributes = new List();
  //Map<DivElement, int> attributeClientHeights = new Map();
  //Map<DivElement, bool> attributeClosingBool = new Map();
  var callbackFunction = null;

  MatchingTableController(/*DivElement td*/) {
    //tableDiv = td;
  }
  void fillTable(var matchingResultList) {
    matchingAttributes.clear();
    portDetails.clear();
    //attributeClientHeights.clear();
    //attributeClosingBool.clear();
    /*
       Title : Matching Results
       Requirements (list)
          Requirement Name : (name)
          Attributes (list)
            Attribute Name : (name)
            Devices (list)
              Device Model
              Device GUID
              Exchanges
                Exchange name
                Ports
                  String
     */
    for (int i = 0; i < matchingResultList.length; i++) {
      Map requirement = matchingResultList[i];
      String requirementName = requirement["Requirement Name"];
      List attributes = requirement["Attributes"];

      //DivElement requirementCell = CreateRequirementCell(requirementName);

      //addElement(requirementCell);

      //DivElement foldablePocket = new DivElement();
      //requirementCell.append(foldablePocket);

      for (int i = 0; i < attributes.length; i++) {
        Map attribute = attributes[i];
        String attributeName = attribute["Attribute Name"];
        MatchingAttribute matchingAttribute = new MatchingAttribute(
            requirementName, attributeName, null, null, null, null);
        matchingAttributes.add(matchingAttribute);
        //DivElement attributeCell = CreateAttributeCell(attributeName);

        /*Add arrow to attribute cell*/
        /*
        DivElement attributeArrow = new DivElement();
        attributeArrow.id = "MatchingTableController";
        attributeArrow.className = "attributeArrow";
        attributeCell.append(attributeArrow);

        DivElement foldablePocket = new DivElement();
        foldablePocket.style.overflow = "hidden";


        attributeCell.onMouseDown.listen((_){
          int originalHeight = foldablePocket.clientHeight;
          int height = foldablePocket.clientHeight;

          if (!attributeClientHeights.containsKey(attributeCell) && height != 0) {
            attributeClientHeights[attributeCell] = height;
          } else {
            height = attributeClientHeights[attributeCell];
          }
          if (originalHeight > height) {
            attributeClientHeights[attributeCell] = originalHeight;
            height = originalHeight;
          }

          if (height == 0) {
            height = 2000;
          }

          bool isClosing = false;
          if (attributeClosingBool.containsKey(attributeCell)) {
            isClosing = !attributeClosingBool[attributeCell];
            attributeClosingBool[attributeCell] = isClosing;
          }
          attributeClosingBool[attributeCell] = isClosing;

          if (isClosing) {
            CssAnimation animation = new CssAnimation('max-height', '${originalHeight}px', '${height}px');
            animation.apply(foldablePocket,
                iterations: 1,
                alternate: false,
                duration: 500,
                onComplete: () {foldablePocket.style.maxHeight = "";}
            );
            CssAnimation animation2 = new CssAnimation('transform', 'rotate(-90deg)', 'rotate(0deg)');
            animation2.apply(attributeArrow,
                iterations: 1,
                alternate: false,
                duration: 500,
                onComplete: () {}
            );
          } else {
            CssAnimation animation = new CssAnimation('max-height', '${originalHeight}px', '0px');
            animation.apply(foldablePocket,
                iterations: 1,
                alternate: false,
                duration: 500,
                onComplete: () {}
            );
            CssAnimation animation2 = new CssAnimation('transform', 'rotate(0deg)', 'rotate(-90deg)');
            animation2.apply(attributeArrow,
                iterations: 1,
                alternate: false,
                duration: 500,
                onComplete: () {}
            );
          }
        });*/

        //attributeCell.append(foldablePocket);
        //requirementCell.append(attributeCell);
        //requirementCell.append(foldablePocket);
        //foldablePocket.append(attributeCell);
        //addElement(CreateAttributeCell(attributeName));

        //var p = CreatePortCell("None", true);
        //            var pd = new PortDetails(p, requirementName, attributeName, "None", "None", "None", true);
        //            portDetails.add(pd);
        //            p.onMouseDown.listen((_){clickedPort(pd);});
        //            addElement(p);

        List devices = attribute["Devices"];
        //print("Got devices: ${devices}");
        for (int i = 0; i < devices.length; i++) {
          Map device = devices[i];
          String deviceModel = device['Device Model'];
          String deviceGUID = device['Device GUID'];
          bool permissionAllowed = device['Permission Allowed'];
          //foldablePocket.append(CreateDeviceCell(deviceModel, deviceGUID));
          List exchanges = device['Exchanges'];
          for (int i = 0; i < exchanges.length; i++) {
            Map exchange = exchanges[i];
            String exchangeName = exchange["Exchange Name"];
            List ports = exchange["Ports"];
            //Need to do something with this data
            //var p = CreatePortCell(exchangeName, false, permissionAllowed);
            var pd = new PortDetails(
                //p,
                matchingAttribute,
                requirementName,
                attributeName,
                deviceModel,
                deviceGUID,
                exchangeName,
                ports,
                false,
                permissionAllowed);
            portDetails.add(pd);
            if (permissionAllowed) {

              clickedPort(pd);
              ////p.onMouseDown.listen((_) {
                //attributeCell.className = "attributeCellFilled";
              //  clickedPort(pd);
              //});
            }
            //foldablePocket.append(p);
          }
        }
      }
    }
  }

  bool allAttributesMatched() {
    for (int i = 0; i < matchingAttributes.length; i++) {
      //print("${matchingAttributes[i].deviceGUID}, ${matchingAttributes[i].requirementName}, ${matchingAttributes[i].attributeName}");
      if (matchingAttributes[i].deviceGUID == null) {
        return false;
      }
    }
    return true;
  }

  void clickedPort(PortDetails pd) {
    //Set other ports with the same matching result to unselected
    for (int i = 0; i < portDetails.length; i++) {
      PortDetails pd2 = portDetails[i];
      if (pd.requirementName == pd2.requirementName &&
          pd.attributeName == pd2.attributeName) {
        pd2.selected = false;
        //pd2.portCell.style.backgroundColor = "white";
      }
    }
    pd.selected = true;
    pd.matchingAttribute.deviceGUID = pd.deviceGUID;
    pd.matchingAttribute.deviceModel = pd.deviceModel;
    pd.matchingAttribute.exchange = pd.exchange;
    pd.matchingAttribute.ports = pd.ports;
    //print("Set matching attribute to ${pd.deviceGUID}");
    //pd.portCell.style.backgroundColor = "rgb(255,255,205)";

    if (callbackFunction != null) {callbackFunction();}
  }
/*
  void addElement(HtmlElement s) {
    tableDiv.append(s);
  }
*/
  void clearTable() {
    /*
    while (tableDiv.hasChildNodes()) {
      tableDiv.lastChild.remove();
    }*/
    portDetails = new List();
  }
/*
  DivElement CreateRequirementCell(String text) {
    DivElement wrapper = new DivElement();

    DivElement cell = new DivElement();
    cell.id = "MatchingTableController";
    cell.className = "requirementCell";
    SpanElement spanCell = new SpanElement();
    spanCell.id = "MatchingTableController";
    spanCell.className = "requirementSpanCell";
    spanCell.text = text;
    cell.append(spanCell);
    var hr = new HRElement();
    hr.id = "MatchingTableController";
    hr.className = "requirementHR";
    cell.append(hr);
    //cell.onMouseDown.listen((_){cellMouseDown(cell);});
    wrapper.append(cell);
    return wrapper;
  }
*/

/*
  DivElement CreateAttributeCell(String text) {
    //DivElement wrapper = new DivElement();
    DivElement cell = new DivElement();
    cell.id = "MatchingTableController";
    cell.className = "attributeCellUnfilled";
    SpanElement spanCell = new SpanElement();
    spanCell.id = "MatchingTableController";
    spanCell.className = "attributeSpanCell";
    spanCell.text = text;
    cell.append(spanCell);
    var hr = new HRElement();
    hr.id = "MatchingTableController";
    hr.className = "attributeHR";
    cell.append(hr);

    //cell.onMouseDown.listen((_){cellMouseDown(cell);});
    return cell;
    //wrapper.append(cell);
    //return wrapper;
  }

  DivElement CreateDeviceCell(String text, String text2) {
    DivElement cell = new DivElement();
    cell.id = "MatchingTableController";
    cell.className = "deviceCell";
    SpanElement spanCell = new SpanElement();
    spanCell.id = "MatchingTableController";
    spanCell.className = "deviceSpanCell";
    spanCell.text = text;
    cell.append(spanCell);
    SpanElement spanCell2 = new SpanElement();
    spanCell2.id = "MatchingTableController";
    spanCell2.className = "deviceSpanCell2";
    spanCell2.text = text2;
    cell.append(spanCell2);
    var hr = new HRElement();
    hr.id = "MatchingTableController";
    hr.className = "deviceHR";
    hr.style.marginBottom = "0px";
    cell.append(hr);

    DivElement shape = new DivElement();
    shape.id = "square";
    cell.append(shape);

    //cell.onMouseDown.listen((_){cellMouseDown(cell);});
    return cell;
  }

  DivElement CreatePortCell(String text, bool selected, bool permissionAllowed) {
    DivElement cell = new DivElement();
    if (selected) {
      cell.style.backgroundColor = "rgb(255,255,205)";
    }
    if (!permissionAllowed) {
      cell.style.backgroundColor = "rgb(200,200,200)";
    }
    cell.id = "MatchingTableController";
    cell.className = "portCell";
    SpanElement spanCell = new SpanElement();
    spanCell.id = "MatchingTableController";
    spanCell.className = "portSpanCell";
    spanCell.text = text;
    cell.append(spanCell);
    if (!permissionAllowed) {
      SpanElement spanCell2 = new SpanElement();
      spanCell2.id = "MatchingTableController";
      spanCell2.className = "portSpanCell2";
      spanCell2.text = "Permission not allowed.";
      cell.append(spanCell2);
    }
    var hr = new HRElement();
    hr.id = "MatchingTableController";
    hr.className = "portHR";
    cell.append(hr);

    DivElement shape = new DivElement();
    shape.id = "circle";
    cell.append(shape);

    //cell.onMouseDown.listen((_){cellMouseDown(cell);});
    return cell;
  }
*/
  List getMatchingMap() {
    List l = new List();
    for (int i = 0; i < matchingAttributes.length; i++) {
      MatchingAttribute pd = matchingAttributes[i];
      Map m = new Map();
      m['Device GUID'] = pd.deviceGUID;
      m['Device Model'] = pd.deviceModel;
      m['Requirement'] = pd.requirementName;
      m['Attribute'] = pd.attributeName;
      m['Exchange'] = pd.exchange;
      m['Ports'] = pd.ports;
      l.add(m);
    }
    return l;
  }
}

class PortDetails {
  //HtmlElement portCell;
  String requirementName;
  String attributeName;
  String deviceModel;
  String deviceGUID;
  String exchange;
  List<String> ports;
  bool selected;
  bool permissionAllowed;
  MatchingAttribute matchingAttribute;
  PortDetails(
      //this.portCell,
      this.matchingAttribute,
      this.requirementName,
      this.attributeName,
      this.deviceModel,
      this.deviceGUID,
      this.exchange,
      this.ports,
      this.selected,
  this.permissionAllowed) {}
}
