library ClinicianConsole.Classes.Consoles.AppDevicesConsole.LaunchWindow.MatchingAttribute;

class MatchingAttribute {
  String requirementName;
  String attributeName;
  String deviceGUID;
  String deviceModel;
  String exchange;
  List<String> ports;
  MatchingAttribute(this.requirementName, this.attributeName, this.deviceGUID, this.deviceModel, this.exchange, this.ports);
}