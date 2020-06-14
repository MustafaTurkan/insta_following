import 'package:flutter/material.dart';
import 'package:insta_following/helpers/l10n/localizer.dart';


class InputDialog extends StatelessWidget {
  InputDialog(
      {@required this.title,
      @required this.content,
      @required this.onOkPressed,
      @required this.onCancelPressed,
      this.titlePadding,
      this.titleTextStyle,
      this.backgroundColor,
      this.elevation,
      this.semanticLabel,
      this.shape,
      this.additionalActions,
      Key key})
      : super(key: key);

  final Widget title;

  final Widget content;

  final EdgeInsetsGeometry titlePadding;

  final TextStyle titleTextStyle;

  final Color backgroundColor;

  final double elevation;

  final String semanticLabel;

  final ShapeBorder shape;

  final VoidCallback onCancelPressed;

  final VoidCallback onOkPressed;

  final List<Widget> additionalActions;

  @override
  Widget build(BuildContext context) {
    var localizer = Localizer.of(context);
    var actions = additionalActions ?? <Widget>[];
    actions.add(FlatButton(
      onPressed: onCancelPressed,
      child: Text(localizer.cancel),
    ));
    actions.add(FlatButton(
      onPressed: onOkPressed,
      child: Text(localizer.ok),
    ));
    return AlertDialog(
        backgroundColor: backgroundColor,
        elevation: elevation,
        semanticLabel: semanticLabel,
        shape: shape,
        titlePadding: titlePadding,
        title: title,
        actions: actions,
        content: content);
  }
}
