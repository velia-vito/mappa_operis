part of '../json.dart';

class DeSerClass extends GeneratorForAnnotation<PickleClass> {
  static final constructorTree = <String, String>{};
  static final fieldTree = <String, Map<String, String>>{};

  @override
  void generateForAnnotatedElement(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) {
    if (element is ClassElement) {
      fieldTree[element.name] = {
        for (var field in element.accessors.where(
          (field) => field.metadata.any(
            (annotation) => _getMetadataDisplayName(annotation) == 'PickleField',
          ),
        ))
          field.name:
              field.metadata
                  .firstWhere((annotation) => _getMetadataDisplayName(annotation) == 'PickleField')
                  .computeConstantValue()!
                  .getField('field')!
                  .toStringValue()!,
      };

      constructorTree[element.name] = annotation.read('constructor').stringValue;
    }

    for (var classEntry in fieldTree.keys) {
      for (var fieldEntry in fieldTree[classEntry]!.keys) {
        if (fieldEntry.startsWith('_')) {
          throw ArgumentError('Private fields cannot be pickled; $classEntry.$fieldEntry');
        }
      }
    }
  }

  String _getMetadataDisplayName(ElementAnnotation annotationElement) =>
      annotationElement.computeConstantValue()!.type!.getDisplayString(withNullability: false);
}
