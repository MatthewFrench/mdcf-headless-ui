library ClinicianConsole.Classes.Data.DeviceController;
import "Data.dart";
class DeviceController {
  Data data;
  List<String> devices;
  DeviceController(Data data) {
    this.data = data;
    devices = new List();
  }
  void addDevice(Map m) {
    String guid = m['GUID'];
    devices.add(guid);
    data.mainGUI.appDevicesConsole.deviceAdded(guid);
  }
  void removeDevice(String guid) {
    devices.remove(guid);
    data.mainGUI.appDevicesConsole.deviceRemoved(guid);
  }
  void clearDevices() {
    while(devices.length > 0) {
      String device = devices[0];
      devices.remove(device);
      data.mainGUI.appDevicesConsole.deviceRemoved(device);
    }
  }
}
