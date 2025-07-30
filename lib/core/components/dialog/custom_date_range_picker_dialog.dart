import 'package:flutter/material.dart';
import 'package:male_clothing_store/core/components/text/custom_text.dart';
import 'package:male_clothing_store/core/constants/app_color.dart';
import 'package:male_clothing_store/core/constants/app_style.dart';

class CustomDateRangePickerDialog extends StatefulWidget {
  final DateTime firstDate;
  final DateTime lastDate;

  const CustomDateRangePickerDialog({
    super.key,
    required this.firstDate,
    required this.lastDate,
  });

  @override
  // ignore: library_private_types_in_public_api
  _CustomDateRangePickerDialogState createState() =>
      _CustomDateRangePickerDialogState();
}

class _CustomDateRangePickerDialogState
    extends State<CustomDateRangePickerDialog> {
  DateTimeRange? selectedRange;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColor.dialogBg,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Container(
        width: 600,
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const CustomText(
              'Chọn khoảng thời gian',
              style: AppStyle.semiBold14,
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 400,
              child: CalendarDatePicker(
                initialDate: widget.lastDate,
                firstDate: widget.firstDate,
                lastDate: widget.lastDate,
                onDateChanged: (DateTime date) {
                  // Cần logic để chọn khoảng ngày, CalendarDatePicker chỉ chọn 1 ngày
                  // Dùng DateRangePickerDialog thay thế
                },
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const CustomText('Hủy', style: AppStyle.caption),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context, selectedRange);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColor.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const CustomText('Xác nhận', style: AppStyle.caption),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
