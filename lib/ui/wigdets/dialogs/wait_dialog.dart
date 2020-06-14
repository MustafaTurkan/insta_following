import 'package:flutter/material.dart';
import 'package:insta_following/helpers/l10n/localizer.dart';
import 'package:insta_following/ui/theme/theme.dart';
import 'package:provider/provider.dart';


typedef WaitableFunction<T> = T Function(WaitDialog scope);

/// Sample Usage
/// try {
///   wait.show();
///   await Future.delayed(Duration(seconds: 3));
///   wait.update('messageText');
///   await Future.delayed(Duration(seconds: 3));
/// } finally {
///   wait.hide();
/// }

class WaitDialog {
  WaitDialog(this.context);
  BuildContext context;

  WaitDialogMessage dialogMessage;

  void show([String messageText, TextStyle messageTextStyle]) {
    if (dialogMessage?.isShowing ?? false) {
      update(messageText, messageTextStyle);
      return;
    }

    dialogMessage = WaitDialogMessage();
    dialogMessage.isShowing = true;
    dialogMessage.messageText = messageText;
    dialogMessage.messageStyle = messageTextStyle;

    showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return WillPopScope(
              onWillPop: () {
                return Future.value(false);
              },
              child: _WaitDialogBody(dialogMessage));
        });
  }

  void update(String messageText, [TextStyle messageTextStyle]) {
    if (dialogMessage == null || !dialogMessage.isShowing) {
      return;
    }

    if ((messageText != null && dialogMessage.messageText != messageText) ||
        (messageTextStyle != null && dialogMessage.messageStyle == messageTextStyle)) {
      dialogMessage.messageText = messageText;
      dialogMessage.messageStyle = messageTextStyle;

      dialogMessage.notifyListeners();
    }
  }

  Future<bool> hide() {
    if (dialogMessage == null || !dialogMessage.isShowing) {
      return Future.value(true);
    }
    try {
      dialogMessage.isShowing = false;
      Navigator.of(context).pop(true);
      return Future.value(true);
    } catch (e) {
      debugPrint(e.toString());
      return Future.value(false);
    }
  }

  bool get isShowing {
    return dialogMessage?.isShowing ?? false;
  }

  static Future<T> scope<T>({
    @required BuildContext context,
    @required WaitableFunction<Future<T>> call,
    String waitMessage,
  }) async {
    T result;
    var wait = WaitDialog(context);
    try {
      wait.show(waitMessage ?? Localizer.of(context).loading);
      result = await call(wait);
    } finally {
      await wait.hide();
    }
    return result;
  }
}

class _WaitDialogBody extends StatefulWidget {
  _WaitDialogBody(this.dialogMessage);

  final _WaitDialogBodyState _state = _WaitDialogBodyState();
  final WaitDialogMessage dialogMessage;

  @override
  State<StatefulWidget> createState() {
    return _state;
  }
}

class _WaitDialogBodyState extends State<_WaitDialogBody> {
  void _update() {
    setState(() {});
  }
  

  @override
  void initState() {
    widget.dialogMessage.addListener(_update);
    super.initState();
  }

  @override
  void didUpdateWidget(_WaitDialogBody oldWidget) {
    oldWidget.dialogMessage.removeListener(_update);
    super.didUpdateWidget(oldWidget);
  }
 

  @override
  void dispose() {
    widget.dialogMessage.isShowing = false;
    widget.dialogMessage.dispose();
    super.dispose();
  }

  static const RoundedRectangleBorder shape =
      RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5)));
  @override
  Widget build(BuildContext context) {
    var    mediaQueryData = MediaQuery.of(context);
    var appTheme = Provider.of<AppTheme>(context);
    var localizer = Localizer.of(context);
    return AnimatedPadding(
      padding: MediaQuery.of(context).viewInsets + const EdgeInsets.symmetric(horizontal: 0, vertical: 24),
      duration: const Duration(milliseconds: 100),
      child: MediaQuery.removeViewInsets(
        removeLeft: true,
        removeTop: true,
        removeRight: true,
        removeBottom: true,
        context: context,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Center(
            child: Material(
              color: appTheme.data.canvasColor,
              shape: shape,
              type: MaterialType.card,
              child: Container(
                width: mediaQueryData.size.width,
                child: ConstrainedBox(
                  constraints: BoxConstraints.loose(Size(mediaQueryData.size.width, 110)),
                  child: Column(children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: _circularProgressIndicator(color:appTheme.data.colorScheme.primary),
                    ),
                    Expanded(
                        child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Text(widget.dialogMessage.messageText ?? localizer.loading,
                                textAlign: TextAlign.justify,
                                style: widget.dialogMessage.messageStyle ?? appTheme.data.textTheme.bodyText1.copyWith(color:appTheme.data.colorScheme.primary))))
                  ]),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

    Widget _circularProgressIndicator({Color color, double size, double boxSize}) {
    assert(boxSize == null || size <= boxSize);

    var indicatorColor = color == null ? null : AlwaysStoppedAnimation<Color>(color);
    if (boxSize != null) {
      return SizedBox(
        height: boxSize,
        width: boxSize,
        child: SizedBox(
          height: size,
          width: size,
          child: CircularProgressIndicator(
            strokeWidth: 3,
            valueColor: indicatorColor,
          ),
        ),
      );
    }

    if (size != null) {
      return SizedBox(
        height: size,
        width: size,
        child: CircularProgressIndicator(
          strokeWidth: 3,
          valueColor: indicatorColor,
        ),
      );
    }
    return CircularProgressIndicator(
      strokeWidth: 3,
      valueColor: indicatorColor,
    );
    
  }




}

class WaitDialogMessage extends ChangeNotifier {
  bool isShowing = false;
  String messageText;
  TextStyle messageStyle;

  @override
// ignore:unnecessary_overrides
  void notifyListeners() {
    super.notifyListeners();
  }
}


