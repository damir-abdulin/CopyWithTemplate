import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:copy_with_template/src/copyable.dart';
import 'package:copy_with_template/src/string_extensions.dart';
import 'package:dart_style/dart_style.dart';
import 'package:source_gen/source_gen.dart';

class CopyableGenerator extends GeneratorForAnnotation<Copyable> {
  @override
  String generateForAnnotatedElement(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) {
    final generatedElementName = element.name!;
    final fields = _getClassFields(annotation);
    final resetableFields = _getResetableFields(annotation);

    final code = '''
    class $generatedElementName {
      ${_generateDecalarationSection(fields)}

      ${_generateConstructor(generatedElementName, fields)}

      ${_generateCopyWith(generatedElementName, fields, resetableFields)}
    }
    ''';

    return DartFormatter().format(code);
  }

  Map<String, List<String>> _getClassFields(ConstantReader annotation) {
    return annotation.objectValue.getField('fields')!.toMapValue()!.map(
          (key, value) => MapEntry(
            key!.toStringValue()!,
            value!.toListValue()!.map((e) => e.toStringValue()!).toList(),
          ),
        );
  }

  List<String>? _getResetableFields(ConstantReader annotation) {
    return annotation.objectValue
        .getField('resetableFields')!
        .toListValue()
        ?.map((e) => e.toStringValue()!)
        .toList();
  }

  String _generateDecalarationSection(Map<String, List<String>> fields) {
    final declarationSection = StringBuffer();

    for (final type in fields.entries) {
      for (final fieldName in type.value) {
        declarationSection.writeln('final ${type.key} $fieldName;');
      }
    }

    return declarationSection.toString();
  }

  String _generateConstructor(
    String className,
    Map<String, List<String>> fields,
  ) {
    final initSection = StringBuffer();

    for (final type in fields.entries) {
      for (final fieldName in type.value) {
        initSection.writeln('required this.$fieldName,');
      }
    }

    return 'const $className({$initSection});';
  }

  String _generateCopyWith(
    String className,
    Map<String, List<String>> fields,
    List<String>? resetableFields,
  ) {
    var declarationSection = '';
    var initSection = '';

    for (final type in fields.entries) {
      for (final fieldName in type.value) {
        final typeName = type.key.toNonNullable();

        if (resetableFields != null && resetableFields.contains(fieldName)) {
          final resetablFieldName = 'reset${fieldName.capitalize()}';

          declarationSection += _generateResetableDeclaration(
            resetablFieldName,
            typeName,
            fieldName,
          );

          initSection += _generateResetableInit(
            resetablFieldName,
            fieldName,
          );
        } else {
          declarationSection += '$typeName? $fieldName,';
          initSection += '$fieldName: $fieldName ?? this.$fieldName,';
        }
      }
    }

    return '$className copyWith({$declarationSection}) '
        '{return $className($initSection);}';
  }

  String _generateResetableDeclaration(
    String resetablFieldName,
    String typeName,
    String fieldName,
  ) =>
      '$typeName? $fieldName, bool $resetablFieldName = false,';

  String _generateResetableInit(
    String resetablFieldName,
    String fieldName,
  ) =>
      '$fieldName: $resetablFieldName ? $fieldName ?? this.$fieldName : null,';
}
