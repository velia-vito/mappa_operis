part of '../../deser.dart';

class Node<T> {
  List<Node> children = [];

  final T value;

  T get type => T;

  Node(this.value);

  void addChild(Node child) {
    children.add(child);
  }
}
