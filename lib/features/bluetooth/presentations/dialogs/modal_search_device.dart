import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:roboeducacional/features/bluetooth/presentations/dialogs/dialog_base.dart';
import 'package:roboeducacional/features/bluetooth/presentations/widgets/robot_widget.dart';

class SearchDeviceDialog extends StatelessWidget {
  const SearchDeviceDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return DialogBase(
      content: Padding(
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
