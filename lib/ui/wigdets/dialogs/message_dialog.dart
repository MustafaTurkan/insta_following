import 'package:flutter/material.dart';
import 'package:insta_following/helpers/l10n/localizer.dart';
import 'package:insta_following/ui/theme/app_theme.dart';
import 'package:insta_following/ui/theme/theme.dart';
import 'package:insta_following/ui/wigdets/dialogs/enums.dart';
import 'package:provider/provider.dart';
import 'package:insta_following/helpers/extensions/string_extensions.dart';

List<Widget> _createDialogButtons(
  BuildContext context,
  DialogButton buttons,
  Color textColor,
) {
  var localizer = Localizer.of(context);
  return [
    //order important, dont change order!
    if (buttons.index == DialogButton.yesCancel.index)
      FlatButton(
          textColor: textColor,
          onPressed: () {
            Navigator.pop(context, DialogResult.cancel);
          },
          child: Text(localizer.cancel)),
    if (buttons.index == DialogButton.yesNo.index)
      FlatButton(
          textColor: textColor,
          onPressed: () {
            Navigator.pop(context, DialogResult.no);
          },
          child: Text(localizer.no)),
    if (buttons.index > DialogButton.ok.index)
      FlatButton(
          textColor: textColor,
          onPressed: () {
            Navigator.pop(context, DialogResult.yes);
          },
          child: Text(localizer.yes)),
    if (buttons == DialogButton.ok)
      FlatButton(
          textColor: textColor,
          onPressed: () {
            Navigator.pop(context, DialogResult.ok);
          },
          child: Text(localizer.ok)),
  ];
}

class MessageDialog {
  static Future<DialogResult> error({
    @required BuildContext context,
    @required String content,
    String title,
    DialogButton buttons,
  }) async {
    return _show(
      context,
      title ?? Localizer.of(context).error,
      content,
      buttons: buttons,
      color: Provider.of<AppTheme>(context).colors.error,
    );
  }

  static Future<DialogResult> warning({
    @required BuildContext context,
    @required String content,
    String title,
    DialogButton buttons,
  }) async {
    return _show(
      context,
      title ?? Localizer.of(context).warning,
      content,
      buttons: buttons,
      color:Provider.of<AppTheme>(context).colors.warning,
    );
  }

  static Future<DialogResult> info({
    @required BuildContext context,
    @required String content,
    String title,
    DialogButton buttons,
  }) async {
    return _show(
      context,
      title ?? Localizer.of(context).information,
      content,
      buttons: buttons,
      color: Provider.of<AppTheme>(context).colors.info,
    );
  }

    static Future<DialogResult> question({
    @required BuildContext context,
    @required String content,
    String title,
    DialogButton buttons,
  }) async {
    return _show(
      context,
      title ?? Localizer.of(context).question,
      content,
      buttons: buttons,
      color: Provider.of<AppTheme>(context).colors.primary,
    );
  } 

  static Future<DialogResult> message({
    @required BuildContext context,
    @required String content,
    String title,
    DialogButton buttons,
  }) async {
    buttons ??= DialogButton.ok;
    return _show(
      context,
      title,
      content,
      buttons: buttons,
    );
  }

  static Future<DialogResult> _show(
    BuildContext context,
    String title,
    String content, {
    DialogButton buttons,
    Color color,
  }) async {
    assert(content != null);
    final appTheme = Provider.of<AppTheme>(context);
    buttons ??= DialogButton.ok;
    var titleTextStyle = appTheme.data.textTheme.subtitle1.copyWith(fontWeight: FontWeight.w500);
    color ??= appTheme.colors.primary;
    return showDialog<DialogResult>(
        barrierDismissible: buttons == DialogButton.ok,
        context: context,
        builder: (context) {
          return AlertDialog(
            titlePadding: EdgeInsets.symmetric(horizontal: 0),
            titleTextStyle: titleTextStyle,
            title: title.isNullOrEmpty()
                ? null
                : Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Text(
                          title,
                          style: titleTextStyle,
                        ),
                      ),
                      Divider(
                        thickness: 1,
                        color: color,
                      )
                    ],
                  ),
            content: SingleChildScrollView(child: Center(child: Text(content))),
            actions: _createDialogButtons(context, buttons, color),
          );
        });
  }
}

class MessageSheet {
  static Future<DialogResult> error({
    @required BuildContext context,
    @required String content,
    String title,
    DialogButton buttons,
  }) async {
    final appTheme = Provider.of<AppTheme>(context);
    return _show(context, title ?? Localizer.of(context).error, content,
        buttons: buttons, color: appTheme.colors.error, icon: AppIcons.alertCircleOutline);
  }

  static Future<DialogResult> warning({
    @required BuildContext context,
    @required String content,
    String title,
    DialogButton buttons,
  }) async {
    final appTheme = Provider.of<AppTheme>(context);
    return _show(context, title ?? Localizer.of(context).warning, content,
        buttons: buttons, color: appTheme.colors.warning, icon: AppIcons.alertOutline);
  }

  static Future<DialogResult> info({
    @required BuildContext context,
    @required String content,
    String title,
    DialogButton buttons,
  }) async {

    return _show(context, title ?? Localizer.of(context).information, content,
        buttons: buttons, color: Provider.of<AppTheme>(context).colors.info, icon: AppIcons.informationOutline);
  }

  static Future<DialogResult> question({
    @required BuildContext context,
    @required String content,
    String title,
    DialogButton buttons,
  }) async {

    return _show(context, title ?? Localizer.of(context).question, content,
        buttons: buttons, color: Provider.of<AppTheme>(context).colors.info, icon: AppIcons.helpCircleOutline);
  }

  static Future<DialogResult> message({
    @required BuildContext context,
    @required String content,
    String title,
    DialogButton buttons,
    IconData icon,
  }) async {
    icon ??= AppIcons.messageOutline;
    return _show(context, title ?? Localizer.of(context).message, content,
        buttons: buttons, color: Provider.of<AppTheme>(context).colors.primary, icon: AppIcons.messageOutline);
  }

  static Future<DialogResult> _show(
    BuildContext context,
    String title,
    String content, {
    DialogButton buttons,
    Color color,
    IconData icon,
  }) {
    buttons ??= DialogButton.ok;
    return showModalBottomSheet(
      context: context,
      enableDrag: buttons == DialogButton.ok,
      isScrollControlled: true,
      isDismissible: buttons == DialogButton.ok,
      builder: (BuildContext context) {
        final appTheme = Provider.of<AppTheme>(context);
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              width: double.infinity,
              color: color,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    title,
                    style: appTheme.data.textTheme.headline6.copyWith(color: Colors.white),
                    textAlign: TextAlign.start,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: SingleChildScrollView(
                      child: icon != null
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Expanded(
                                  child: Text(
                                    content,
                                    style: appTheme.data.textTheme.bodyText1.copyWith(color: Colors.white),
                                  ),
                                ),
                                SizedBox(
                                  width: 16,
                                ),
                                Icon(
                                  icon,
                                  size: 52,
                                  color: Colors.white,
                                )
                              ],
                            )
                          : Text(
                              content,
                              style: appTheme.data.textTheme.bodyText1.copyWith(color: Colors.white),
                            ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(8),
              color: appTheme.colors.darken(color),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: _createDialogButtons(context, buttons, Colors.white),
              ),
            )
          ],
        );
      },
    );
  }
}
