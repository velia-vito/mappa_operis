library;

// Package imports:
import 'dart:async';

import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/nullability_suffix.dart';
import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

// Annotations.
part 'metadata/pickle_class.dart';
part 'metadata/pickle_field.dart';

// Generators.
part 'generator/de_ser_class.dart';
part 'generator/de_ser_class_translation.dart';

// Builders.
part 'builder/enumeration_tree_builder.dart';
