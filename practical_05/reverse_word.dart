String reverseWords(String sentence) {
  List<String> words = sentence.split(" ");
  return words.reversed.join(" ");
}

void main() {
  String input = "My name is Michele";
  print(reverseWords(input));
}