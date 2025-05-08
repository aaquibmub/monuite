import 'dart:developer';

class DropdownItem<T> {
  T value;
  final String text;

  DropdownItem(
    this.value,
    this.text,
  );

  factory DropdownItem.fromJson(dynamic json) {
    return DropdownItem(
      json != null ? json['value'] as T : null,
      json != null ? json['text'] as String : null,
    );
  }

  Map<String, dynamic> toJson() => {
        'value': value,
        'text': text,
      };
}
