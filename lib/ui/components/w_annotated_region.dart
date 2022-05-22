import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class WAnnotatedRegion extends StatelessWidget {
  final Widget scaffold;

  const WAnnotatedRegion({
    required this.scaffold,
    Key? key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light.copyWith(
          systemNavigationBarColor: Theme.of(context).primaryColor,
          statusBarColor: Theme.of(context).primaryColor
      ),
      child: SafeArea(
        child: scaffold,
      ),
    );
  }
}
