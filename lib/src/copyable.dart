class Copyable {
  final Map<String, List<String>> fields;
  final List<String>? resetableFields;

  const Copyable({
    required this.fields,
    this.resetableFields,
  });
}
