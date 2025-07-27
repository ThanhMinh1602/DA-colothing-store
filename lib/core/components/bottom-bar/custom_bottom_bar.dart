import 'package:flutter/widgets.dart';

class CustomBottomBar extends StatelessWidget {
  const CustomBottomBar({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: IntrinsicHeight(child: child),
    );
  }
}
