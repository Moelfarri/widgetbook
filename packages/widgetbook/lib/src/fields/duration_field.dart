import 'package:flutter/material.dart';

import 'field.dart';
import 'field_codec.dart';
import 'field_type.dart';

class DurationField extends Field<Duration> {
  DurationField({
    required super.name,
    super.initialValue = defaultDuration,
    @Deprecated('Fields should not be aware of their context') super.onChanged,
  }) : super(
          type: FieldType.duration,
          codec: FieldCodec(
            toParam: (value) => value.inMilliseconds.toString(),
            toValue: (param) {
              return param == null
                  ? null
                  : Duration(
                      milliseconds: int.tryParse(param) ?? 0,
                    );
            },
          ),
        );

  static const defaultDuration = Duration.zero;

  @override
  Widget toWidget(
    BuildContext context,
    String group,
    Duration? value,
  ) {
    return TextFormField(
      initialValue: codec.toParam(value ?? initialValue ?? defaultDuration),
      keyboardType: TextInputType.number,
      decoration: const InputDecoration(
        suffix: Text('ms'),
      ),
      onChanged: (value) => updateField(
        context,
        group,
        codec.toValue(value) ?? initialValue ?? defaultDuration,
      ),
    );
  }
}
