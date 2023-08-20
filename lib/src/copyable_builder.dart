import 'package:build/build.dart';
import 'package:copy_with_template/src/copyable_generator.dart';
import 'package:source_gen/source_gen.dart';

Builder copyableBuilder(BuilderOptions options) =>
    SharedPartBuilder([CopyableGenerator()], 'copy_with');
