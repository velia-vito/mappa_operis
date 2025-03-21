part of '../json.dart';

class DeSerClassTranslation extends Generator {
  @override
  FutureOr<String> generate(LibraryReader library, BuildStep buildStep) {
    var output = '';

    for (var className in DeSerClass.fieldTree.keys) {
      output += '\n/// Serialize [$className].\n';
      output += 'Map<String, dynamic> serialize$className($className instance) => {\n';

      for (var fieldName in DeSerClass.fieldTree[className]!.keys) {
        output += "'$fieldName': instance.$fieldName, \n";
      }

      output += '};\n';

      output += '\n/// Deserialize [$className].\n';
      output +=
          '$className deserialize$className(Map<String, dynamic> json) => $className.${DeSerClass.constructorTree[className]!}(\n';

      for (var fieldName in DeSerClass.fieldTree[className]!.keys) {
        output += "${DeSerClass.fieldTree[className]![fieldName]}: json['$fieldName'], \n";
      }

      output += ');\n';
    }

    return output;
  }
}
