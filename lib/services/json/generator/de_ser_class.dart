part of '../json.dart';

class DeSerClass extends GeneratorForAnnotation<PickleClass> {
  static final classTree = <String, Map<String, String>>{};

  @override
  void generateForAnnotatedElement(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) {
    if (element is ClassElement) {
      DeSerClass.classTree[element.name] =
          annotation.read('allFields').boolValue
              ? {
                for (var field in element.accessors)
                  field.name: field.type.getDisplayString(
                    withNullability: field.type.nullabilitySuffix == NullabilitySuffix.question,
                  ),
              }
              : {
                for (var field in element.accessors.where(
                  (field) => field.metadata.any(
                    (annotation) => _getMetadataDisplayName(annotation) == 'PickleField',
                  ),
                ))
                  field.name: field.type.getDisplayString(
                    withNullability: field.type.nullabilitySuffix == NullabilitySuffix.question,
                  ),
              };
    }

    for (var classEntry in DeSerClass.classTree.keys) {
      for (var fieldEntry in DeSerClass.classTree[classEntry]!.keys) {
        if (fieldEntry.startsWith('_')) {
          throw ArgumentError('Private fields cannot be pickled; $classEntry.$fieldEntry');
        }
      }
    }
  }

  String _getMetadataDisplayName(ElementAnnotation annotationElement) =>
      annotationElement.computeConstantValue()!.type!.getDisplayString(withNullability: false);
}
