import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bluetooth Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BluetoothScreen(),
    );
  }
}

class BluetoothScreen extends StatefulWidget {
  const BluetoothScreen({Key key}) : super(key: key);

  @override
  _BluetoothScreenState createState() => _BluetoothScreenState();
}

class _BluetoothScreenState extends State<BluetoothScreen> {
  FlutterBlue flutterBlue = FlutterBlue.instance;
  List<BluetoothDevice> devices = [];
  BluetoothDevice connectedDevice;

  @override
  void initState() {
    super.initState();
    searchDevices();
  }

  void searchDevices() async {
    flutterBlue.startScan(timeout: const Duration(seconds: 4));

    flutterBlue.scanResults.listen((results) {
      for (ScanResult result in results) {
        if (!devices.contains(result.device)) {
          setState(() {
            devices.add(result.device);
          });
        }
      }
    });

    await Future.delayed(Duration(seconds: 4));
    flutterBlue.stopScan();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          border: Border.all(
            width: 3,
            color: Colors.blue,
          ),
        ),
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Bluetooth Teste',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Color(0xFF2E9AD1),
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: Color(0xFF585858),
                  ),
                ),
                SizedBox(height: 20),
              ],
            ),
            ListView.builder(
              shrinkWrap: true,
              itemCount: devices.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(devices[index].name),
                  onTap: () {
                    connectToDevice(devices[index]);
                  },
                );
              },
            ),
            ElevatedButton(
              onPressed: () {
                sendListToDevice();
              },
              child: Text('Enviar Lista'),
            ),
          ],
        ),
      ),
    );
  }

  void connectToDevice(BluetoothDevice device) async {
    await device.connect();
    setState(() {
      connectedDevice = device;
    });
  }

  void sendListToDevice() async {
    if (connectedDevice != null) {
      List<int> listToSend = [
        1,
        2,
        3,
        4,
        5
      ]; // Sua lista de dados a ser enviada

      List<BluetoothService> services =
          await connectedDevice.discoverServices();
      BluetoothCharacteristic characteristic;

      for (BluetoothService service in services) {
        for (BluetoothCharacteristic c in service.characteristics) {
          if (c.properties.write) {
            characteristic = c;
            break;
          }
        }
      }

      if (characteristic != null) {
        await connectedDevice.writeCharacteristic(
          characteristic,
          listToSend,
          type: CharacteristicWriteType.withResponse,
        );
      }
    }
  }
}
