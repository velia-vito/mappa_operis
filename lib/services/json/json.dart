library;

// Package imports:
import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

// Annotations.
part 'metadata/track_variable.dart';
part 'metadata/track_method.dart';
part 'metadata/track_class.dart';

// Generators.
part 'generator/annotated_class_enumerate.dart';
part 'generator/required_types_enumerate.dart';
part 'generator/type_map.dart';
part 'generator/type_map_consolidate.dart';
part 'generator/type_map_imports.dart';

// Builders.
part 'builder/builders.dart';
