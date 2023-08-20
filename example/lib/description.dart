import 'package:copy_with_template/copy_with_template.dart';

part 'description.g.dart';

@Copyable(
  fields: {
    'int': ['id'],
    'String': ['title', 'author', 'text'],
    'String?': ['description', 'category'],
  },
  resetableFields: ['description', 'category'],
)
class Note {}

@Copyable(
  fields: {
    'String': ['name', 'surname'],
    'DateTime': ['birthday'],
  },
)
class Person {}
