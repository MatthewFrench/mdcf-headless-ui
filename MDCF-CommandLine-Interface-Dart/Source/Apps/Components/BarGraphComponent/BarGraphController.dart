library ClinicianConsole.Classes.Apps.Components.BarGraphController;
//import 'dart:html';

double _pointWidth = 2.0;
double _lowBound = 0.05,
    _highBound = 0.05; //The ratio of the height that the line's max and min are at
double _valueMargin = 1.0; //Graph value margin for lowest and highest values

class BarGraphController {
  String _lineColor;
  int _minDataValue = null,
      _maxDataValue = null;
  int _largestDataValueAmount = 0;
  int _width = 0,
      _height = 0;
  bool _showNumbers;
  bool _showAlarm = false;
  //CanvasElement _canvas;
  List<BarGraphPoint> _data = new List();
  //ImageElement warningImage;
  bool _isShowing = false;
  double margin = 1.0;
  

  BarGraphController({bool showNumbers: true}) {
    _showNumbers = showNumbers;

    //warningImage = new ImageElement(src: "Resources/Warning.png");

    makeCanvas();
  }
  void updateDisplay() {
    updateGraph();
  }
  void clear() {
    _data.clear();
    int _minDataValue = null,
        _maxDataValue = null;
    int _largestDataValueAmount = 0;
    int _width = 0,
        _height = 0;
    updateGraph();
  }
  void setShowing(bool isShowing) {
    _isShowing = isShowing;
    updateGraph();
  }
  void setGraphSize(int w, int h) {
    _width = w;
    _height = h;
    //_canvas.width = w;
    //_canvas.height = h;
    updateGraph();
  }
  void addData(int value, bool warning, bool error, [bool updateDisplay=true]) {
    if (value == null) {return;}
    BarGraphPoint p = _data.firstWhere((e) => (e.getValue() == value), orElse: () => null);
    if (p == null) {
      p = new BarGraphPoint(value);
      BarGraphPoint greaterP = _data.firstWhere((e) => (e.getValue() > value), orElse: () => null);
      if (greaterP != null) {
        _data.insert(_data.indexOf(greaterP), p);
      } else {
        _data.add(p);
      }
      if (_minDataValue == null) {
        _minDataValue = value;
        _maxDataValue = value;
        _largestDataValueAmount = 1;
      }
      if (value > _maxDataValue) {
        _maxDataValue = value;
      }
      if (value < _minDataValue) {
        _minDataValue = value;
      }
    } else {
      p.increaseAmount();
      if (p.getAmount() > _largestDataValueAmount) {
        _largestDataValueAmount = p.getAmount();
      }
    }
    _showAlarm = warning;
    if (updateDisplay) {
      updateGraph();
    }
  }
  //HtmlElement getGraphCanvas() {
  //  return _canvas;
  //}
  void updateGraph() {
    if (_isShowing) {
      //draw();
    }
  }
  /*
  void draw() {
    CanvasRenderingContext2D ctx = _canvas.getContext('2d');
    if (_canvas.clientWidth != 0) {
      if (_canvas.clientWidth != _canvas.width || _canvas.clientHeight != _canvas.height) {
        _width = _canvas.clientWidth;
        _height = _canvas.clientHeight;
        _canvas.width = _width;
        _canvas.height = _height;
      }
    }

    ctx.clearRect(0, 0, _canvas.width, _canvas.height);
    ctx.lineWidth = 2.0;

    if (_showAlarm) {
      ctx.drawImage(warningImage, 10, 10);
    }

    if (_data.length > 0) {
      double barWidth = _width / _data.length - (_data.length-1*margin)/_data.length;
      for (int i = 0; i < _data.length; i++) {
        BarGraphPoint p = _data[i];
        double x = i * barWidth + (i*margin);
        double y = 0.0;
        double w = barWidth;
        double h = _height / _largestDataValueAmount * p.getAmount();
        ctx.fillStyle = "rgb(${(255 * p.getAmount() / _largestDataValueAmount).round()}, 0, 0)";
        ctx.fillRect(x, _height - h, w, h);
        x = x + barWidth/2;
        y = h + 5;
        int fontSize = 18;
        if (barWidth*2/3 < fontSize) {fontSize = (barWidth*2/3).floor();}
        ctx.textAlign = "center";
        ctx.textBaseline = "bottom";
        if (_height - y < 25) {ctx.textBaseline = "top"; y -= 10;}
        ctx.font = '${fontSize}px Arial';
        ctx.strokeStyle = "white";
        ctx.strokeText(p.getValue().toString(), x, _height-y);
        ctx.fillStyle = "black";
        ctx.fillText(p.getValue().toString(), x, _height-y);
      }
    }
  }
*/
  //******* GUI Creation
  void makeCanvas() {
    //_canvas = new CanvasElement();
    //_canvas.id = "BarGraphComponent";
    //_canvas.className = "canvas";
  }
}
class BarGraphPoint {
  int _value;
  int _amount;
  BarGraphPoint(int v) {
    _value = v;
    _amount = 1;
  }
  void increaseAmount() {
    _amount += 1;
  }
  int getAmount() {
    return _amount;
  }
  int getValue() {
    return _value;
  }
}