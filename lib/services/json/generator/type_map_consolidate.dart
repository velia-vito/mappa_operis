part of '../json.dart';

class TypeMapConsolidate extends GeneratorForAnnotation<TrackClass> {
  @override
  String? generateForAnnotatedElement(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) {
    if (element is! ClassElement) {
      throw InvalidGenerationSourceError(
        'Generator cannot target `$element` (only classes may be annotated with `TypeMap`).',
      );
    }

    // ignore: prefer_interpolation_to_compose_strings, for readability.
    return AnnotatedClassEnumerate.annotatedClasses.fold<String>(
          'final typeMap = {\n\t',
          (prevString, annotatedClass) =>
              prevString +=
                  '${annotatedClass.name}: ${annotatedClass.name.toLowerCase()}TypeMap,\n\t',
        ) +
        '};';
  }
}
