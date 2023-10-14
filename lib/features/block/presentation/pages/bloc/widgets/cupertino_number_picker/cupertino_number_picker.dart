import 'package:flutter/cupertino.dart';

class CupertinoNumberPicket extends StatelessWidget {
  const CupertinoNumberPicket(
      {super.key, required this.initialNumber, this.onChanged});
  final double _kItemExtent = 32.0;
  final int initialNumber;
  final ValueChanged<int>? onChanged;

  static Future<int?> show(context, [int initialNumber = 1]) async {
    int selectedNumber = initialNumber;
    await showCupertinoModalPopup<int>(
      context: context,
      builder: (BuildContext context) => Container(
        height: 216,
        padding: const EdgeInsets.only(top: 6.0),
        margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        color: CupertinoColors.systemBackground.resolveFrom(context),
        child: SafeArea(
          top: false,
          child: CupertinoNumberPicket(
            initialNumber: initialNumber,
            onChanged: (int value) {
              selectedNumber = value + 1;
            },
          ),
        ),
      ),
    );

    return selectedNumber == 0 ? 1 : selectedNumber;
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPicker(
      magnification: 1.22,
      squeeze: 1.2,
      useMagnifier: true,
      itemExtent: _kItemExtent,
      scrollController: FixedExtentScrollController(
        initialItem: initialNumber,
      ),
      onSelectedItemChanged: onChanged,
      children: List<Widget>.generate(10, (int index) {
        return Center(child: Text('${index + 1}'));
      }),
    );
  }
}
