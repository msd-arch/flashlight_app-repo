import 'package:flutter/material.dart';
import 'package:torch_controller/torch_controller.dart';
import 'package:permission_handler/permission_handler.dart';

void main() => runApp(FlashlightApp());

class FlashlightApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flashlight App',
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.yellow,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: FlashlightHomePage(),
    );
  }
}

class FlashlightHomePage extends StatefulWidget {
  @override
  _FlashlightHomePageState createState() => _FlashlightHomePageState();
}

class _FlashlightHomePageState extends State<FlashlightHomePage> {
  bool _isOn = false;
  late TorchController _torchController;

  @override
  void initState() {
    super.initState();
    _torchController = TorchController();
    _requestPermissions();
  }

  Future<void> _requestPermissions() async {
    await Permission.camera.request();
  }

  void _toggleFlashlight() {
    _torchController.toggle();
    setState(() {
      _isOn = !_isOn;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      body: Center(
        child: Container(
          width: 380,
          height: 800,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(40),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                spreadRadius: 5,
                blurRadius: 20,
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                height: 60,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.yellow,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
                ),
                child: Center(
                  child: Text(
                    'Flashlight',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  _buildIconButton('SOS'),
                  _buildIconButton('Flash'),
                  _buildIconButton('Morse'),
                ],
              ),
              SizedBox(height: 40),
              GestureDetector(
                onTap: _toggleFlashlight,
                child: Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: _isOn
                          ? [Colors.yellow.shade200, Colors.yellow]
                          : [Colors.grey.shade300, Colors.grey],
                      radius: 0.85,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Icon(
                      Icons.power_settings_new,
                      size: 100,
                      color: _isOn ? Colors.yellow.shade800 : Colors.grey.shade800,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Icon(Icons.brightness_low, color: Colors.grey),
                  Expanded(
                    child: Slider(
                      value: _isOn ? 1 : 0,
                      onChanged: (value) {},
                      activeColor: Colors.yellow,
                      inactiveColor: Colors.grey,
                    ),
                  ),
                  Icon(Icons.brightness_high, color: Colors.yellow),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildIconButton(String label) {
    return Column(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.yellow,
          ),
          child: IconButton(
            icon: Icon(Icons.circle, color: Colors.white),
            onPressed: () {},
          ),
        ),
        SizedBox(height: 8),
        Text(label, style: TextStyle(color: Colors.black)),
      ],
    );
  }
}
