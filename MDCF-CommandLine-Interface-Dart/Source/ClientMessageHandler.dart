library ClientMessageHandler;
import 'Data/Data.dart';
import 'Apps/App.dart';
import 'Apps/Components/Component.dart';

class ClientMessageHandler {
  Data data;
  ClientMessageHandler(this.data) {

  }
  void Message(Map m) {
    switch (m['Title']) {
      case 'App History Update':
        {
          //App Name
          //Component List - List
          //  Name
          //  Data
          String appName = m['App Name'];
          String guid = m['App GUID'];
          for (App app in data.appController.apps) {
            if (app.getName() == appName && app.getGUID() == guid) {
              List componentList = m['Component List'];
              for (Map cMap in componentList) {
                String componentName = cMap['Name'];
                List componentData = cMap['Data'];

                for (Component c in app.getComponents()) {
                  if (c.getDataName() == componentName) {
                    for (int i = 0; i < componentData.length; i++) {
                      c.setData(componentData[i], false);
                    }
                  }
                }
              }
              app.updateComponentDisplays();
            }
          }
        }
        break;
      case 'App List':
        {
          List<String> appNames = m['List'];
          data.launchableAppList = appNames;
          data.mainGUI.launchWindowGUI.updateAppList();
        }
        break;
      case 'Matching Results':
        {
          List<Map> results = m['Requirements'];
          data.matchingResultList = results;
          data.mainGUI.launchWindowGUI.updateMatchingResultList();
        }
        break;
      case 'App Started':
        {
          data.appController.addApp(m);
        }
        break;
      case 'App Message':
        {
          data.appController.message(m);
        }
        break;
      case 'Add Device':
        {
          data.deviceController.addDevice(m);
        }
        break;
      case 'Bind Device':
        {
          String appID = m['App ID'];
          String deviceGUID = m['Device GUID'];
          App app = data.appController.apps[int.parse(appID)];
          app.devices.add(deviceGUID);
        }
        break;
      case 'Unbind Device':
        {
          //m['Device GUID'];
          //m['App ID'];
        }
        break;
      case 'Remove Device':
        {
          data.deviceController.removeDevice(m['GUID']);
        }
        break;
      case 'Account Update': {
        String username = m['Username'];
        String displayName = m['Display Name'];

        String activeRole = m['Role Name'];
        print("Setting active role to: " + activeRole);
        List<String> roleList = m['Role Name List'];
        data.mainGUI.topStatusBar.userStatusBar.setRoleList(roleList);
        data.mainGUI.topStatusBar.userStatusBar.setActiveRole(activeRole);
        
        //Setting Username in GUI Status Bar
        data.mainGUI.topStatusBar.userStatusBar.user = username;        
        
        List<Map> permissionsList = m['Permissions List'];
        data.permissions.setPermissionsList(permissionsList);
        if (data.permissions.getLockedRole()) {
          data.client.setLocked();
        } else {
          data.client.setUnlocked();
        }
      }
      break;

      case 'Patient Update': {
        data.mainGUI.patientBar.setPatientData(m["Patient Data"]);
      }
      break;
    }
  }
}