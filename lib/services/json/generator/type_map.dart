part of '../json.dart';

class TypeMap extends GeneratorForAnnotation<TrackClass> {
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

    var oString = 'var ${element.name.toLowerCase()}TypeMap = {';

    element.fields.forEach((field) {
      oString +=
          "\t'${field.name}': ${field.type.getDisplayString(withNullability: true)},";
    });

    oString += '};';

    return oString;
  }
}
