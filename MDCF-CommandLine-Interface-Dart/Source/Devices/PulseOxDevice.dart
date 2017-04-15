library ClinicianConsole.Class.Devices.PulseOxDevice;
import '../Misc/Range.dart';
import '../Misc/Point.dart';
class PulseOxDevice {
  int id;
  int status;
  //Specific
  Range BPRange;
  Range HRRange;
  bool changeStatus;
  double graph1Min;
  double graph1Max;
  double graph2Min;
  double graph2Max;
  List<Point> bpPoints;
  List<Point> hrPoints;
  PulseOxDevice(i, s) {
    id = i;
    status = s;
    BPRange = new Range(0.0, 200.0);
    HRRange = new Range(0.0, 200.0);
    changeStatus = true;
    bpPoints = new List();
    hrPoints = new List();
  }
  String getName() {
    return "Pulse Oximeter";
  }
  String statusToString() {
    if (status == 0) {
      return "Online";
    }
    if (status == 1) {
      return "Warning";
    }
    if (status == 2) {
      return "Error";
    }
    if (status == 3) {
      return "Offline";
    }
    return null;
  }
  void addBPPoint(Point point) {
    bpPoints.add(point);
  }
  void addHRPoint(Point point) {
    hrPoints.add(point);
  }
  void setStatus(bool status) {
    status = status;
  }
}