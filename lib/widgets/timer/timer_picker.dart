import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TimerPickerHelper {

static Future<Duration?> showDurationPicker(BuildContext context, Duration initialDuration) async {
    Duration tempDuration = initialDuration;
    return await showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) => Container(
        height: 300,
        color: Colors.white,
        child: Column(
          children: [
            Container(
              color: Colors.grey[200],
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CupertinoButton(
                    child: const Text('Done'),
                    onPressed: () => Navigator.pop(context,tempDuration),
                  ),
                ],
              ),
            ),
            // منقي الوقت الفعلي
            Expanded(
              child: CupertinoTimerPicker(
                mode: CupertinoTimerPickerMode.hms, // ساعات، دقائق، ثواني
                initialTimerDuration: initialDuration,
                onTimerDurationChanged: (Duration newDuration) {
                    tempDuration = newDuration; // تحديث القيمة في الصفحة
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}