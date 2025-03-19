part of '../json.dart';

class DeSer extends GeneratorForAnnotation<PickleClass> {
  static final classTree = <String, Iterable<String>>{};

  @override
  void generateForAnnotatedElement(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) {
    if (element is ClassElement) {
      var itb =
          annotation.read('allFields').boolValue
              ? element.fields.map<String>((fieldElement) => fieldElement.name)
              : element.fields
                  .where(
                    (fieldElement) => fieldElement.metadata.any(
                      (annotation) => getMetadataDisplayName(annotation) == 'PickleField',
                    ),
                  )
                  .map<String>((filedElement) => filedElement.name);

      DeSer.classTree[element.name] = itb;
    }
  }

  String getMetadataDisplayName(ElementAnnotation annotationElement) =>
      annotationElement.computeConstantValue()!.type!.getDisplayString(withNullability: false);
}
