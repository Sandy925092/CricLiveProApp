import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:web_socket_channel/io.dart';


class WebsocketDemo extends StatefulWidget {
  const WebsocketDemo({Key? key}) : super(key: key);

  @override
  State<WebsocketDemo> createState() => _WebsocketDemoState();
}

class _WebsocketDemoState extends State<WebsocketDemo> {
  String btcUsdtPrice = "0";
  final channel = IOWebSocketChannel.connect(
   //   'wss://stream.binance.com:9443/ws/btcusdt@trade');
   //   'wss://echo.websocket.org');
      'wss://ws.coinapi.io/v1/');
  @override
  void initState() {
    super.initState();
    streamListener();
  }

  streamListener() {
    print('call');
    channel.stream.listen((message) {
      print('inside');
      // channel.sink.add('received!');
      // channel.sink.close(status.goingAway);
   /*   Map getData = jsonDecode(message);
      setState(() {
        btcUsdtPrice = getData['p'];
      });*/
      print(message);
      // print(getData['p']);

    });
  }

  @override
  void dispose() {
    channel.sink.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "BTC/USDT Price",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 30),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                btcUsdtPrice,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 250, 194, 25),
                    fontSize: 30),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
