library ClinicianConsole.Classes.Devices.Device;

abstract class Device {
  int id;
  int status;
  String getName();
  String statusToString();
}