List removeDuplicates(List list) {
  return list.toSet().toList();
}

void main() {
  var numbers = [1, 2, 2, 3, 4, 4, 5];
  var result = removeDuplicates(numbers);
  print(result);
}