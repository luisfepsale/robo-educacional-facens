import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:roboeducacional/features/bluetooth/presentations/dialogs/dialog_base.dart';
import 'package:roboeducacional/features/bluetooth/presentations/dialogs/modal_connected.dart';
import 'package:roboeducacional/features/bluetooth/presentations/widgets/robot_widget.dart';

class SearchDeviceDialog extends StatefulWidget {
  const SearchDeviceDialog({super.key});

  @override
  State<SearchDeviceDialog> createState() => _SearchDeviceDialogState();
}

class _SearchDeviceDialogState extends State<SearchDeviceDialog> {
  @override
  void initState() {
    super.initState();
    FlutterBlue.instance.connectedDevices.then((devices) {
      for (var device in devices) {
        if (device.id.toString() == '24:D7:EB:15:AE:52') {
          showDialog(
            context: context,
            builder: (context) => ModalBluetoothConnected(device: device),
          );
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return DialogBase(
      content: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 25.0),
              child: StreamBuilder<List<ScanResult>>(
                stream: FlutterBlue.instance.scanResults,
                initialData: const [],
                builder: (c, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return _ScanResult(snapshot.data!);
                },
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              FlutterBlue.instance.startScan(
                timeout: const Duration(seconds: 2),
              );
            },
            child: const Text('SCAN'),
          ),
        ],
      ),
    );
  }
}

class _ScanResult extends StatelessWidget {
  const _ScanResult(this.scanResults);

  final List<ScanResult> scanResults;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () =>
          FlutterBlue.instance.startScan(timeout: const Duration(seconds: 4)),
      child: ListView.separated(
        itemBuilder: (context, index) => RobotWidget(
          item: scanResults[index],
        ),
        separatorBuilder: (context, index) => const SizedBox(height: 10),
        itemCount: scanResults.length,
      ),
    );
  }
}
