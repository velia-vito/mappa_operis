part of '../json.dart';

class RequiredTypeEnumerate extends GeneratorForAnnotation<TrackClass> {
  static final requiredTypes = <DartType>[];

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

    for (var f in element.fields) {
      if (!requiredTypes.contains(f.type)) {
        requiredTypes.add(f.type);
      }
    }
  }
}
