class Dog {
  final int? id;
  final String name;
  final int age;

  Dog({this.id, required this.name, required this.age});

  // convert a dog into a map
  Map<String, dynamic> toMap() {
    return {'id': id, 'name': name, 'age': age};
  }

  // extract a dog object from a map
  factory Dog.fromMap(Map<String, dynamic> map) {
    return Dog(id: map['id'], name: map['name'], age: map['age']);
  }
}
