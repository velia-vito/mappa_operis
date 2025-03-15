part of '../json.dart';

class AnnotatedClassEnumerate extends GeneratorForAnnotation<TrackClass> {
  static final annotatedClasses = <ClassElement>[];

  @override
  void generateForAnnotatedElement(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) {
    if (element is! ClassElement) {
      throw InvalidGenerationSourceError(
        'Generator cannot target `$element` (only classes may be annotated with `TypeMap`).',
      );
    }

    AnnotatedClassEnumerate.annotatedClasses.add(element);
  }
}
