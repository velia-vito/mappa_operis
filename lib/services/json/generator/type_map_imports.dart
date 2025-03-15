part of '../json.dart';

class TypeMapImports extends GeneratorForAnnotation<TrackClass> {
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
    return RequiredTypeEnumerate.requiredTypes.fold<String>('', (
          prevString,
          type,
        ) {
          var libraryCallSign = type.element!.library.toString().substring(8);

          return libraryCallSign == 'dart:core'
              ? prevString
              : "${prevString}import '$libraryCallSign';\n";
        }) +
        '\n';
  }
}
