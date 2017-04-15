library ClinicianConsole.NetworkingController;
import 'dart:typed_data';
import 'dart:convert';
import 'Data/Data.dart';
import 'dart:io';
import 'dart:async';

class NetworkingController {
  Data data;
  WebSocket websocket;
  bool connected = false;
  Function eMessageCallback;
  NetworkingController(Data d, ip, eventMessageCallback) {
    eMessageCallback = eventMessageCallback;
    data = d;
    connectToServer(ip);
  }
  void connectToServer(ip) {
    print("Trying to connect to server");
    //String address = "localhost";

    WebSocket.connect('ws://${ip}:7777').then((WebSocket ws){
      websocket = ws;
      onopen();
    });
    //socket.add('Hello, World!');

    /*
    websocket = new WebSocket('ws://${address}:7777');
    websocket.binaryType = 'arraybuffer';
    websocket.onOpen.listen(onopen);
    websocket.onClose.listen(onclose);
    websocket.onMessage.listen(onmessage);
    */
  }
  void onopen() {
    print("Connected to server");
    websocket.listen(onmessage, onDone: onclose, onError: onerror);

    connected = true;
    data.client.connectedToServer();
  }
  void onerror(var error) {
    // an error occurred when sending/receiving data
    print('Websocket error: ' + error);
  }
  void onclose() {
    print("Connection closed");
    connected = false;
    data.client.disconnectedFromServer();
    //Try a reconnect in 2 seconds
    //new Timer(new Duration(seconds:2), connectToServer);
  }
  void onmessage(String msg) {
    //if (e.data is String) {
      Map m = JSON.decode(msg);
      print("Got Message: " + msg);
      data.client.messageHandler.Message(m);
      eMessageCallback(m);
    //}
    /*
    else if (e.data is ByteBuffer) {
      ByteBuffer b = e.data;
      ByteData bdata = new ByteData.view(b);
      data.client.BinaryMessage(bdata);
    }*/
  }
  void Send(Map msg) {
    var text = JSON.encode(msg);
    print("Sent Message: " + text);
    var outputAsUint8List = new Uint8List.fromList(text.codeUnits);
    websocket.addUtf8Text(outputAsUint8List);
    //websocket.add(JSON.encode(text));
  }
  void SendBinary(ByteBuffer msg) {
    websocket.add(msg);
    //websocket.send(msg);
  }
}