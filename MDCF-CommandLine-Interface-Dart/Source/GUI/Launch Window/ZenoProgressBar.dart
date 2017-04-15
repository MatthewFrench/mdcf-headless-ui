library ZenoProgressBar;
//import 'dart:html';
import 'dart:async';
class ZenoProgressBar {
  double _x, _y, _progress, _width, _height;
  //DivElement _progressBar, _progressBarAmount;
  Timer _timer;
  double _progressAmount, _progressStepAmount;
  bool _isCompleted = false;
  //double _maxAmount = 10.0/100.0/60.0; //Ten percent per second
  ZenoProgressBar(double x, double y, double width, double height) {
    //_progressBar = new DivElement();
    _x = x;
    _y = y;
    _width = width;
    _height = height;
    /*
    _progressBar.id = "ZenoProgressBar";
    _progressBar.className = "progressBar";
    _progressBar.style
        ..top = "${_y.toString()}px"
        ..left = "${_x.toString()}px"
        ..width = "${_width.toString()}px"
        ..height = "${_height.toString()}px";
        */
    _progressAmount = 0.0;
    //makeProgressBarAmount();
  }
  void setWidth(int width) {
    _width = width.toDouble();
    //_progressBar.style.width = "${_width.toString()}px";
  }
  void reset() {
    stop();
    _isCompleted = false;
    _progressAmount = 0.0;
    _progressStepAmount = 0.5;
    //_progressBarAmount.style.width = "${_progressAmount*100}%";
  }
  void start() {
    _timer = new Timer.periodic(new Duration(milliseconds: 16), logic);
  }
  void stop() {
    if (_timer != null) {
      _timer.cancel();
      _timer = null;
    }
  }
  void setComplete(int milliseconds) {
    //stop();
    //_progressAmount = 1.0;
    //_progressBarAmount.style.width = "${_progressAmount*100}%";
    _isCompleted = true;
    _progressStepAmount = (1.0 - _progressAmount) / milliseconds * 1000;
  }
  void logic(_) {
    if (!_isCompleted) {
      _progressStepAmount = _progressStepAmount - (_progressStepAmount / 2 / 60);
    }
    _progressAmount += _progressStepAmount / 60;
    if (_isCompleted && _progressAmount >= 1.0) {
      _progressAmount = 1.0;
      stop();
    }
    //_progressBarAmount.style.width = "${_progressAmount*100}%";
  }
  void setOpacity(double opacity) {
    //_progressBar.style.opacity = opacity.toString();
  }
  /*
  DivElement getDiv() {
    return _progressBar;
  }
  */
  /*
  void makeProgressBarAmount() {
    _progressBarAmount = new DivElement();
    _progressBarAmount.id = "ZenoProgressBar";
    _progressBarAmount.className = "progressBarAmount";
    _progressBar.append(_progressBarAmount);
  }
  */
}
