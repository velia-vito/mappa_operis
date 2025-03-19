part of '../json.dart';

class DeSerClassTranslation extends Generator {
  @override
  FutureOr<String> generate(LibraryReader library, BuildStep buildStep) {
    
    var output = '';

    for (var className in DeSerClass.classTree.keys) {
      output += '/// Serialize [$className].\n';
      output += 'Map<String, dynamic> serialize$className($className instance) => {\n';

      for (var fieldName in DeSerClass.classTree[className]!.keys) {
        output += "'$fieldName': instance.$fieldName, \n";
      }

      output += '};\n\n';
    }

    return output;
  }
}
