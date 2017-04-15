library Permissions;

class Permissions {
  List<String> permissionNames = new List();
  bool lockedRole = true;
  List<ComponentPermission> componentPermissions = new List<ComponentPermission>();
  List<AppPermission> appLaunchPermissions = new List<AppPermission>();
  List<AppPermission> appTerminatePermissions = new List<AppPermission>();

  void setPermissionsList(List<Map> permissionList) {
    lockedRole = true;
    componentPermissions.clear();
    appLaunchPermissions.clear();
    appTerminatePermissions.clear();
    for (Map permissionMap in permissionList) {
      permissionNames.add(permissionMap["name"]);
      if (permissionMap["lockedRole"] == false) {
        lockedRole = false;
      }
      List cpList = permissionMap["componentPermissions"];
      List alpList = permissionMap["appLaunchPermissions"];
      List atpList = permissionMap["appTerminatePermissions"];
      for (Map m in cpList) {
        componentPermissions.add(new ComponentPermission(m["appName"], m["componentName"], m["allowed"]));
      }
      for (Map m in alpList) {
        appLaunchPermissions.add(new AppPermission(m["appName"], m["allowed"]));
      }
      for (Map m in atpList) {
        appTerminatePermissions.add(new AppPermission(m["appName"], m["allowed"]));
      }
    }
    //Permission map:
    //componentPermissions
    //  appName
    //  componentName
    //  allowed
    //appLaunchPermissions
    //  appName
    //  allowed
    //appTerminatePermissions
    //  appName
    //  allowed
  }

  bool getComponentPermission(String appName, String componentName) {
    for (ComponentPermission cp in componentPermissions) {
      if (cp.appName == appName && cp.componentName == componentName) {
        if (cp.isAllowed()) {
          return true;
        }
      }
    }
    return false;
  }
  bool getAppLaunchPermission(String appName) {
    for (AppPermission ap in appLaunchPermissions) {
      if (ap.appName == appName) {
        if (ap.isAllowed()) {
          return true;
        }
      }
    }
    return false;
  }
  bool getAppTerminatePermission(String appName) {
    for (AppPermission ap in appTerminatePermissions) {
      if (ap.appName == appName) {
        if (ap.isAllowed()) {
          return true;
        }
      }
    }
    return false;
  }
  bool getLockedRole() {
    return lockedRole;
  }
  //Permission map:
  //componentPermissions
  //  appName
  //  componentName
  //  allowed
  //appLaunchPermissions
  //  appName
  //  allowed
  //appTerminatePermissions
  //  appName
  //  allowed
}
class AppPermission {
  String appName;
  bool allowed;
  AppPermission(this.appName, this.allowed) {

  }
  bool isAllowed() {
    return allowed;
  }
}
class ComponentPermission {
  String appName;
  String componentName;
  bool allowed;
  ComponentPermission(this.appName, this.componentName, this.allowed) {

  }
  bool isAllowed() {
    return allowed;
  }
}