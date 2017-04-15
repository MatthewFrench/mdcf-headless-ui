library ClinicianConsole.Classes.Consoles.AppDevicesConsole.DeviceSidebar;
//import 'dart:html';
import '../../Data/Data.dart';
//import 'package:animation/animation.dart';
class DeviceSidebar {
  bool sort = true;
  //List<DivElement> cells = new List();
  List<String> devices = new List();
  Data data;
  //SpanElement sidebarTitle;
  DeviceSidebar(Data d) {
    data = d;
    /*
    addSidebarComponent();
    addTitleComponent();
    addDeviceContainerComponent();
    */
  }
  void addDevice(String device) {
    //DivElement cell = createDeviceComponent(device);
    //deviceContainer.append(cell);
    //cells.add(cell);
    devices.add(device);
    //updateCellStatuses();
    //organizeCells();

    //sidebarTitle.text = "Devices (${devices.length} running)";
  }
  void removeDevice(String device) {
    int i = devices.indexOf(device);
    //DivElement cell = cells[i];
    //cell.remove();
    //cells.removeAt(i);
    devices.removeAt(i);
    //updateCellStatuses();
    //organizeCells();

    //sidebarTitle.text = "Devices (${devices.length} running)";
  }
  //DivElement getDiv() {
  //  return deviceSidebar;
  //}
  /*
  void updateCellStatuses() {
    for (int i = 0; i < cells.length; i++) {
      DivElement cell = cells[i];
    }
  }
  void organizeCells() {
    for (int i = 0; i < cells.length; i++) {
      animate(cells[i], duration: 400, properties: {
        'top': (110 * i)
      });
    }
  }
  */

  /**************** Create GUI Components **************/
  /*
  DivElement deviceSidebar, deviceContainer, selectedCell;
  DivElement createDeviceComponent(String device) {
    DivElement cell = new DivElement();
    cell.id = "DeviceSidebar";
    cell.className = "cell";
    
    String deviceName = "Unknown Device";
    deviceName = device.substring(device.lastIndexOf('.')+1, device.length - 13);
    //deviceName = deviceName.split(new RegExp(r"[A-Z]|[0-9]")).join(" ");
    deviceName = deviceName.splitMapJoin((new RegExp(r'[A-Z]|[0-9]')),
        onMatch:    (m) {return m.group(0);},
        onNonMatch: (n) {return '$n ';});
    deviceName = deviceName.trimRight();
    //Turn "Simple P C A" to "Simple PCA"
    for (var i = 0; i < deviceName.length-2; i++) {
      bool firstLetterCapitalized = deviceName[i].toUpperCase() == deviceName[i];
      bool secondLetterSpace = deviceName[i+1] == ' ';
      bool thirdLetterCapitalized = deviceName[i+2].toUpperCase() == deviceName[i+2];
      if (firstLetterCapitalized && secondLetterSpace && thirdLetterCapitalized) {
        deviceName = deviceName.substring(0,i+1) + deviceName.substring(i+2);
      }
    }

    DivElement text = new DivElement();
    text.id = "DeviceSidebar";
    text.className = "cellText";
    DivElement title = new DivElement();
    title.id = "DeviceSidebar";
    title.className = "cellTitle";
    title.text = deviceName;
    text.append(title);
    
    DivElement fullDevice = new DivElement();
    fullDevice.id = "DeviceSidebar";
    fullDevice.className = "fullDevice";
    fullDevice.text = device;
        text.append(fullDevice);
    
    text.append(new DivElement());

    SpanElement statusText = new SpanElement();
    text.append(statusText);

    cell.append(text);
    return cell;
  }
  void addSidebarComponent() {
    //create sidebar
    deviceSidebar = new DivElement();
    deviceSidebar.id = "DeviceSidebar";
    deviceSidebar.className = "deviceSidebar";
  }
  void addTitleComponent() {
    //add top title
    DivElement text = new DivElement();
    text.id = "DeviceSidebar";
    text.className = "titleText";
    sidebarTitle = new SpanElement();
    sidebarTitle.text = "Devices";
    text.append(sidebarTitle);
    deviceSidebar.append(text);
    
    HRElement topHR = new HRElement();
    topHR.id = "DeviceSidebar";
    topHR.className = "titleTopHR";
  }
  void addDeviceContainerComponent() {
    //Add container
    deviceContainer = new DivElement();
    deviceContainer.id = "DeviceSidebar";
    deviceContainer.className = "deviceContainer";
    deviceSidebar.append(deviceContainer);
  }
  */
}