class Student {
  String? name;
  int? age;
  double? marks;

  // Method to set student details
  void setDetails(String name, int age, double marks) {
    this.name = name;
    this.age = age;
    this.marks = marks;
  }

  // Method to print student details
  void printDetails() {
    print("Name: $name");
    print("Age: $age");
    print("Marks: $marks");
  }
}

void main() {
  Student student = Student();

  // Using method to set details
  student.setDetails("Umesha", 24, 89.0);

  // Printing details
  student.printDetails();
}