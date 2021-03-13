import 'package:flutter/material.dart';
import 'package:kandostum2/app/shared/widgets/containers/centered_circular_progress.dart';
import 'package:kandostum2/app/shared/widgets/containers/centered_message.dart';

class BusyContainer extends StatelessWidget {
  final bool busy;
  final Widget child;
  final String message;
  final IconData icon;
  final int length;

  const BusyContainer({
    Key key,
    @required this.busy,
    @required this.child,
    this.message = 'Boş',
    this.icon,
    this.length,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (busy) {
      return CenteredCircularProgress();
    }

    if (length != null) {
      if (length == 0) {
        return CenteredMessage(
          message: message ?? '',
          icon: icon,
        );
      }
    }

    return child;
  }
}
