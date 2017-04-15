import "Client.dart";

Client client;
bool logIn = false, gotAppList = false, gotDeviceList = false, launchedApp = false;

void main(List<String> arguments) {
  var ip = "localhost";
  if (arguments.length > 0) {
    ip = arguments[0];
  }
  client = new Client(ip, eventMessages);

}

void eventMessages(Map msg) {
  switch(msg["Title"]) {
    case "Account Update":
      if (logIn == false) {
        logIn = true;
        loginAsAlice();
      } else {
        if (msg["Username"] == "alice") {
          print("Logged in as Alice");

          //Get app list
          if (gotAppList == false) {
            gotAppList = true;
            getAppList();
          }
        }
      }
      break;
    case "App List":
      print("Got app list");
      if (gotDeviceList == false) {
        gotDeviceList = true;
        getCase3AppDeviceList();
      }
      break;
    case "Matching Results":
      print("Got matching results");
      if (launchedApp == false) {
        launchedApp = true;
        launchCase3App();
      }
      break;
  }
}

void loginAsAlice() {
  Map m = new Map();
  m['Title'] = 'Login';
  m['Username'] = 'alice';
  m['Password'] = 'alice';
  client.data.networkingController.Send(m);
  print("Logging in as Alice");
}

void getAppList() {
  Map m = new Map();
  m['Title'] = 'Get App List';
  client.data.networkingController.Send(m);
  print("Requesting app list");
}

void getCase3AppDeviceList() {
  Map m = new Map();
  m['Title'] = 'Get Device List';
  m['App'] = "Case3";
  client.data.networkingController.Send(m);
  print("Getting device list for Case3");
}

void launchCase3App() {
  Map m = new Map();
  m['Title'] = 'Launch App';
  m['App Name'] = "Case3";//client.data.mainGUI.launchWindowGUI.launchDeviceTableController.

  //launchAppTableController.getSelectedObject();

  //Send all selected ports
  m['Device Information'] = client.data.mainGUI.launchWindowGUI.launchDeviceTableController.getMatchingMap();

  client.data.networkingController.Send(m);
}