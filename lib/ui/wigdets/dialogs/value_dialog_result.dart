

import 'package:insta_following/ui/wigdets/dialogs/enums.dart';

class ValueDialogResult<T> {
  ValueDialogResult(this.dialogResult, {this.value});

  final DialogResult dialogResult;

  final T value;
}
