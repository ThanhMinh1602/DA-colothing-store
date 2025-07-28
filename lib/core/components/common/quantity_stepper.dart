import 'package:flutter/material.dart';
import 'package:male_clothing_store/core/constants/app_color.dart';
import 'package:male_clothing_store/core/components/button/custom_outline_circle_button.dart';
import 'package:male_clothing_store/core/components/text/custom_text.dart';
import 'package:male_clothing_store/core/constants/app_style.dart';

class QuantityStepper extends StatelessWidget {
  final int value;
  final ValueChanged<int> onChanged;
  final int minValue;
  final int maxValue;

  const QuantityStepper({
    super.key,
    required this.value,
    required this.onChanged,
    this.minValue = 1,
    this.maxValue = 100,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CustomOutlineCircleButton(
          iconData: Icons.remove,
          onTap: () {
            if (value > minValue) {
              onChanged(value - 1);
            }
          },
        ),
        const SizedBox(width: 12.0),
        CustomText('$value', style: AppStyle.titleMedium),
        const SizedBox(width: 12.0),
        CustomOutlineCircleButton(
          iconData: Icons.add,
          onTap: () {
            if (value < maxValue) {
              onChanged(value + 1);
            }
          },
        ),
      ],
    );
  }
}
