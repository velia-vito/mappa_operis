/// Deserialization / Serialization library
///
/// ### Process
/// 1. Take an Object `OBJ`.
///
/// 1. We set `OBJ` as a root-node on a graph.
///
/// 1. We Create a look-up table from `OBJ` to `OBJ_ID` & `OBJ` to `OBJ_CONSTRUCTOR`.
///
/// 1. We recurse over *primary properties* (properties required at object creation) of `OBJ`.
///
/// 1. For every property-obj, if the abject exists in `OBJ->OBJ_ID` look-up table, we emit a
///    reference to the object a.k.a `OBJ_REF`. If it doesn't exist, we create a new object and add
///    it to the look-up table and emit `OBJ_REF`.
///
/// 1. Each property-obj is added to the graph as a sub-node. All property-objects are added as
///    `OBJ_REF`s.
///
///    - We consider only *primary properties* because they can't be cyclic. Think about it, lets say
///      `OBJ_A` requires `OBJ_B`, and `OBJ_B` requires `OBJ_C`, and `OBJ_C` requires `OBJ_A` during
///      its construction. This is not possible, because `OBJ_A` can't be constructed until `OBJ_B`
///      is constructed, and `OBJ_B` can't be constructed until `OBJ_C` is constructed, and `OBJ_C`
///      can't be constructed until `OBJ_A` is constructed – an impossible situation.
///
///    - Only Directed Acyclic Graphs have any meaningful topological sort. So, by only considering
///      *primary properties* we can be sure that the graph is a Directed Acyclic Graph.
///
/// 1. We Obtain the **Reverse Topological Sort** of the graph, that is, each node (property)
///    appears before all nodes (objects / property-objects) that depend on it.
///
///    - This simplifies deserialization, because if we just deserialize the objects in the order
///      it appears on file (reverse topological sort), we basically will always have
///      property-objects already deserialized before the parent object is deserialized.
///
/// 1. We go through the **Topological Sort** and update an `OBJ_ID -> OBJ_SECONDARY_SETTER ->
///    SECONDARY_PROPERTY_OBJ_REF` look-up table. The additional objects added to the `OBJ -> OBJ_ID`
///    look-up table  & `OBJ -> OBJ_CONSTRUCTOR` look-up table are **appended** to the **Reverse
///    Topological Sort**.
/// 
///    - This is done because the extra secondary properties are not required at object creation
///      and to minimize memory usage, we can defer their deserialization till after object creation
///      and before secondary property assignment.
/// 
/// 1. Save `OBJ -> OBJ_ID`, `OBJ -> OBJ_CONSTRUCTOR`, & `OBJ_ID -> OBJ_SECONDARY_SETTER ->
///    SECONDARY_PROPERTY_OBJ_REF` look-up tables to file. JSON-ify objects in the **Reverse
///    Topological Sort** order and save them to file.
library;

// Graph - Related.
part 'deser/graph_tools/graph.dart';
part 'deser/graph_tools/node.dart';