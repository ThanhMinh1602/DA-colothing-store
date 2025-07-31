import 'package:intl/intl.dart';

extension VndStringFormatting on String {
  String formatAsVND() {
    try {
      double amount = double.parse(this);

      final formatter = NumberFormat.currency(
        locale: "vi_VN",
        symbol: "₫",
        decimalDigits: 0,
      );

      return formatter.format(amount);
    } catch (e) {
      return this;
    }
  }
}
