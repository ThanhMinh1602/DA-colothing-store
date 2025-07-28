import 'package:flutter/widgets.dart';

class CustomBottomBar extends StatelessWidget {
  const CustomBottomBar({super.key, required this.child, this.padding});
  final Widget child;
  final EdgeInsetsGeometry? padding;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? EdgeInsets.symmetric(vertical: 16.0),
      child: IntrinsicHeight(child: child),
    );
  }
}
