import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  String text = "Stop";
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Service demo"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Center(
            child: Column(
              children: [
                const Text("Demo"),
                ElevatedButton(
                  child: const Text("Foreground Mode"),
                  onPressed: () {
                    FlutterBackgroundService().invoke("setAsForeground");
                  },
                ),
                ElevatedButton(
                  child: const Text("Background Mode"),
                  onPressed: () {
                    FlutterBackgroundService().invoke("setAsBackground");
                  },
                ),
                ElevatedButton(
                  child: Text(text),
                  onPressed: () async {
                    final service = FlutterBackgroundService();
                    var isRunning = await service.isRunning();
                    if (isRunning) {
                      service.invoke("stopService");
                    } else {
                      service.startService();
                    }
                    if (!isRunning) {
                      text = 'Stop';
                    } else {
                      text = 'Start';
                    }
                    setState(() {});
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
