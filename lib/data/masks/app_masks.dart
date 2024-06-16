import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class AppMasks{

  static RegExp regex = RegExp(r'^[a-zA-Z0-9.!#$%&*+-/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$');

  static var cepMask = MaskTextInputFormatter(
      mask: '#####-###',
      filter: { "#": RegExp(r'[0-9]') },
      type: MaskAutoCompletionType.lazy
  );
}