// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// ignore_for_file: unnecessary_brace_in_string_interps,annotate_overrides,always_declare_return_types,implicit_dynamic_return,invalid_assignment,map_value_type_not_assignable,implicit_dynamic_parameter

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

// ignore: unnecessary_new
final messages = new MessageLookup();

// ignore: unused_element
final _keepAnalysisHappy = Intl.defaultLocale;

// ignore: non_constant_identifier_names
typedef MessageIfAbsent(String message_str, List args);

class MessageLookup extends MessageLookupByLibrary {
  get localeName => 'en';

  final  messages = _notInlinedMessages(_notInlinedMessages) as Map<String, Function>  ;
  static dynamic _notInlinedMessages(dynamic val) => <String, Function> {
    'hello' : MessageLookupByLibrary.simpleMessage('Hello'),
    'title' : MessageLookupByLibrary.simpleMessage('Hello world App')
  };
}
