library ClinicianConsole.Classes.Apps.Components.GraphController;
//import 'dart:html';

double _pointWidth = 2.0;
double _lowBound = 0.05,
    _highBound = 0.05; //The ratio of the height that the line's max and min are at
double _valueMargin = 1.0; //Graph value margin for lowest and highest values

class GraphController {
  String _lineColor;
  double _minValue = 0.0,
      _maxValue = 0.0;
  int _width = 0,
      _height = 0;
  //CanvasElement _canvas;
  List<GraphPoint> _data = new List();
  double _lowestValue, _highestValue;
  double _mouseX = 0.0,
      _mouseY = 0.0;
  bool _showMouse = false;
  bool _enableMouse = false;
  double _mouseGraphValue;
  //ImageElement warningImage, warningImageSmall;
  bool _isShowing = false;
  double _pointScale = 1.0;

  GraphController(String lineColor, double min, double max, {bool enableMouse: false}) {
    _lineColor = lineColor;
    _minValue = min;
    _maxValue = max;
    _enableMouse = enableMouse;

    //warningImageSmall = new ImageElement(src: "Resources/WarningSmall.png");
    //warningImage = new ImageElement(src: "Resources/Warning.png");

    //makeCanvas();
  }
  void updateDisplay() {
    updateGraph();
  }
  void clear() {
    _data.clear();
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
  void addData(int verticalHeight, bool warning, bool error, [bool updateDisplay=true]) {
    if (verticalHeight == null) {return;}
    _data.add(new GraphPoint(verticalHeight.toDouble(), warning, error));
    if (updateDisplay) {
      updateGraph();
    }
  }
  //HtmlElement getGraphCanvas() {
  //  return _canvas;
  //}
  void minusClick() {
    if (_pointScale > 0.01) {
      _pointScale /= 2;
      updateGraph();
    }
  }
  void plusClick() {
    if (_pointScale < 4) {
      _pointScale *= 2;
      updateGraph();
    }
  }
  double getPointScale() {
    return _pointScale;
  }
  void updateGraph() {
    if (_isShowing) {

      draw();
    }
  }
  void draw() {
    /*
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

    if (_data.length > 0) {
      if (_data.last.yellowAlarm) {
        ctx.drawImage(warningImage, 10, 10);
      }
    }

    if (_enableMouse == false) {
      calculateLowestHighestWithWidthScale(1.0, 1.0);
    } else {
      calculateLowestHighest();
    }

    if (_lowestValue != null) {
      int offset = 0;
      if (_enableMouse) {
        offset = 40;
      }
      if (_enableMouse) {
        //Draw side numbers
        double minTextDistance = 15.0;
        double textDistance = (_canvas.height - _lowBound * _canvas.height - _highBound * _canvas.height) / ((_highestValue - _valueMargin) - (_lowestValue + _valueMargin));
        int skipValue = 1;
        if (textDistance < minTextDistance) {
          skipValue = (minTextDistance / textDistance).ceil();
        }
        double start = _lowestValue;
        if (start < 0) {
          start = 0.0;
        }
        double end = _highestValue;
        if (end > 100) {
          end = 100.0;
        }
        for (double i = start; i <= end; i += skipValue) {
          double v2 = graphValue(i);
          ctx.beginPath();
          ctx.strokeStyle = "rgba(0,0,0,1.0)";
          ctx.moveTo(_canvas.width.floor() - offset, v2.round());
          ctx.lineTo(_canvas.width.floor() - offset + 10, v2.round());
          ctx.stroke();
          //Calculate the value
          ctx.fillStyle = "Black";
          ctx.textAlign = "right";
          ctx.font = "15px Helvetic";
          ctx.fillText("${i.round()}", _canvas.width.floor() - 2, v2.round() + 5);
        }


        //Draw divider
        ctx.beginPath();
        ctx.moveTo(_canvas.width - offset, 0);
        ctx.strokeStyle = "Black";
        ctx.lineTo(_canvas.width - offset, _canvas.height);
        ctx.stroke();
      }
      double pointScale = _pointWidth * _pointScale;


      if (_data.length > 0) {
        int start = _data.length > _canvas.width / pointScale ? _data.length - _canvas.width ~/ pointScale : 0;

        //Draw grey areas signifying null values
        bool makingGrey = false;
        double greyStart = 0.0;
        ctx.beginPath();
        ctx.fillStyle = "rgba(100,100,100,0.2)";
        for (int i = start; i < _data.length; i++) {
          double pointValue = _data[i].value;
          double xPos = _canvas.width - _data.length * pointScale + i.toDouble() * pointScale + pointScale;
          if (pointValue == -1 && makingGrey == false) {
            makingGrey = true;
            greyStart = xPos;
          } else if ((pointValue != -1 || i == _data.length - 1) && makingGrey == true) {
            ctx.rect(greyStart - offset, 0, xPos - greyStart, _canvas.height);
            makingGrey = false;
          }
        }
        ctx.fill();

        //Draw yellow alarms
        bool makingYellow = false;
        double yellowStart = 0.0;
        ctx.beginPath();
        ctx.fillStyle = "rgba(150,150,0,0.5)";
        for (int i = start; i < _data.length; i++) {
          bool alarm = _data[i].yellowAlarm;
          double xPos = _canvas.width - _data.length * pointScale + i.toDouble() * pointScale + pointScale;
          if (alarm == true && makingYellow == false) {
            makingYellow = true;
            yellowStart = xPos;
          } else if ((alarm == false || i == _data.length - 1) && makingYellow == true) {
            ctx.rect(yellowStart - offset, 0, xPos - yellowStart, _canvas.height);
            makingYellow = false;
          }
        }
        ctx.fill();

        //Draw red alarms
        bool makingRed = false;
        double redStart = 0.0;
        ctx.beginPath();
        ctx.fillStyle = "rgba(120,0,0,0.5)";
        for (int i = start; i < _data.length; i++) {
          bool alarm = _data[i].redAlarm;
          double xPos = _canvas.width - _data.length * pointScale + i.toDouble() * pointScale + pointScale;
          if (alarm == true && makingRed == false) {
            makingRed = true;
            redStart = xPos;
          } else if ((alarm == false || i == _data.length - 1) && makingRed == true) {
            ctx.rect(redStart - offset, 0, xPos - redStart, _canvas.height);
            makingRed = false;
          }
        }
        ctx.fill();

        //Draw points
        double lastValue = -1.0;
        String lastColor = null;
        for (int i = start; i < _data.length; i++) {
          double pointValue = _data[i].value;
          double xPos = _canvas.width - _data.length * pointScale + i.toDouble() * pointScale + pointScale;
          String lineColor = _lineColor;
          if (pointValue == -1) {
            pointValue = lastValue;
            lineColor = "Black";
          }
          lastValue = pointValue;

          if (i == start) {
            lastColor = lineColor;
            ctx.beginPath();
            ctx.strokeStyle = lineColor;
            if (_enableMouse) {
              ctx.moveTo(xPos - pointScale - offset, graphValue(pointValue));
            } else {
              ctx.moveTo(xPos - pointScale - offset, graphValueHeight(pointValue, _canvas.height));
            }
          }
          if (lastColor != lineColor) {
            if (_enableMouse) {
              ctx.lineTo(xPos - offset, graphValue(pointValue));
            } else {
              ctx.lineTo(xPos - offset, graphValueHeight(pointValue, _canvas.height));
            }
            ctx.stroke();
            ctx.beginPath();
            if (_enableMouse) {
              ctx.moveTo(xPos - offset, graphValue(pointValue));
            } else {
              ctx.moveTo(xPos - offset, graphValueHeight(pointValue, _canvas.height));
            }
            lastColor = lineColor;
            ctx.strokeStyle = lineColor;
          } else {
            if (_enableMouse) {
              ctx.lineTo(xPos - offset, graphValue(pointValue));
            } else {
              ctx.lineTo(xPos - offset, graphValueHeight(pointValue, _canvas.height));
            }
          }
          if (i == _data.length - 1) {
            ctx.stroke();
          }
        }
      }
      //Draw Mouse
      if (_showMouse) {
        double v = reverseGraphValue(_mouseY);

        if (_mouseGraphValue == null) {
          _mouseGraphValue = v;
        } else if ((_mouseGraphValue - v).abs() > 0.9) {
          _mouseGraphValue = v.roundToDouble();
        }

        double v2 = graphValue(_mouseGraphValue.roundToDouble());
        ctx.beginPath();
        ctx.strokeStyle = "black";
        ctx.moveTo(0, v2.round());
        ctx.lineTo(_canvas.width.floor() - offset, v2.round());
        ctx.stroke();
        //Calculate the value
        ctx.fillStyle = "black";
        ctx.textAlign = "Right";
        ctx.font = "30px Helvetic";

        ctx.fillText("${_mouseGraphValue.round()}", _mouseX - 13 - 15, v2.round() - 2);
      }
    }
    */
  }
  //**** Calculation Functions
  /*
  void calculateLowestHighest() {
    _lowestValue = null;
    _highestValue = null;
    double pointScale = _pointWidth * _pointScale;
    for (int i = _data.length - 1; i > (_data.length > _canvas.width / pointScale ? _data.length - _canvas.width ~/ pointScale : 0); i--) {
      double point = _data[i].value;
      if (point != -1) {
        if (_lowestValue == null) {
          _lowestValue = point - _valueMargin;
          _highestValue = point + _valueMargin;
        } else {
          if (_lowestValue + _valueMargin > point) {
            _lowestValue = point - _valueMargin;
          }
          if (_highestValue - _valueMargin < point) {
            _highestValue = point + _valueMargin;
          }
        }
      }
    }
  }
  void calculateLowestHighestWithWidthScale(double pointWidth, double pointScale) {
    _lowestValue = null;
    _highestValue = null;
    double pScale = pointWidth * pointScale;
    for (int i = _data.length - 1; i > (_data.length > _canvas.width / pScale ? _data.length - _canvas.width ~/ pScale : 0); i--) {
      double point = _data[i].value;
      if (point != -1) {
        if (_lowestValue == null) {
          _lowestValue = point - _valueMargin;
          _highestValue = point + _valueMargin;
        } else {
          if (_lowestValue + _valueMargin > point) {
            _lowestValue = point - _valueMargin;
          }
          if (_highestValue - _valueMargin < point) {
            _highestValue = point + _valueMargin;
          }
        }
      }
    }
  }
  */
  /*
  double graphValue(double v) {
    double _valueScale = _height * (1 - _highBound - _lowBound);
    double scale = _valueScale / (_highestValue - _lowestValue);
    double newValue = v - _lowestValue;
    newValue *= scale;
    newValue += _lowBound * _height;
    return (_height - newValue).floorToDouble();
  }
  double graphValueHeight(double v, int height) {
    double _valueScale = height * (1 - _highBound - _lowBound);
    double scale = _valueScale / (_highestValue - _lowestValue);
    double newValue = v - _lowestValue;
    newValue *= scale;
    newValue += _lowBound * height;
    return height - newValue;
  }
  double reverseGraphValue(double newValue) {
    double _valueScale = _height * (1 - _highBound - _lowBound);
    double scale = _valueScale / (_highestValue - _lowestValue);
    double v = _canvas.height - newValue;
    v -= _lowBound * _height;
    v /= scale;
    v = v + _lowestValue;
    return v;
  }*/

  //******* GUI Creation
  /*
  void makeCanvas() {
    //[{Name: spO2, Line Color: Red, Type: Graph}]
    _canvas = new CanvasElement();
    _canvas.id = "GraphComponent";
    _canvas.className = "canvas";
    if (_enableMouse) {
      _canvas.onMouseMove.listen((MouseEvent me) {
        _mouseX = me.client.x - _canvas.getBoundingClientRect().left;
        _mouseY = me.client.y - _canvas.getBoundingClientRect().top;
        if (_mouseX > 0 && _mouseX < _canvas.getBoundingClientRect().width &&
            _mouseY > 0 && _mouseY < _canvas.getBoundingClientRect().height) {
          _showMouse = true;
        }
        updateGraph();
      });
      _canvas.onMouseEnter.listen((MouseEvent me) {
        _mouseX = me.client.x - _canvas.getBoundingClientRect().left;
        _mouseY = me.client.y - _canvas.getBoundingClientRect().top;
        _showMouse = true;
        updateGraph();
      });
      _canvas.onMouseLeave.listen((MouseEvent me) {
        _mouseX = me.client.x - _canvas.getBoundingClientRect().left;
        _mouseY = me.client.y - _canvas.getBoundingClientRect().top;
        _showMouse = false;
        updateGraph();
      });
    }
  }*/
}
class GraphPoint {
  bool redAlarm = false;
  bool yellowAlarm = false;
  double value;
  GraphPoint(double v, bool y, bool r) {
    value = v;
    yellowAlarm = y;
    redAlarm = r;
  }
}