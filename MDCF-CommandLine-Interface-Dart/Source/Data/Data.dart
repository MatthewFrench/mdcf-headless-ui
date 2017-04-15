library ClinicianConsole.Classes.Data.Data;
import '../NetworkingController.dart';
import '../Client.dart';
import '../GUI/MainGUI.dart';
import 'AppController.dart';
import 'DeviceController.dart';
import 'Permissions.dart';

class Data {
  Client client;
  NetworkingController networkingController;
  List<String> launchableAppList = new List<String>();
  //Map is in the key format: "Device Name", "Feature"
  List<Map> matchingResultList = new List<Map>();
  AppController appController;
  DeviceController deviceController;
  MainGUI mainGUI;
  Permissions permissions = new Permissions();

  Data(this.client);
  void createNetworkController(ip, eventMessageCallback) {
    networkingController = new NetworkingController(this, ip, eventMessageCallback);
  }
  void createAppController() {
    appController = new AppController(this);
  }
  void createDeviceController() {
    deviceController = new DeviceController(this);
  }
  void createMainUI() {
    mainGUI = new MainGUI(this);
  }
}