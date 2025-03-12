class DropdownItem<T> {
  T value;
  final String text;

  DropdownItem(
    this.value,
    this.text,
  );

  factory DropdownItem.fromJson(dynamic json) => DropdownItem(
        json != null ? json['value'] as T : null,
        json != null ? json['text'] as String : null,
      );
}
