List<int> generateFibonacci(int n) {
  List<int> fib = [];

  for (int i = 0; i < n; i++) {
    if (i == 0)
      fib.add(0);
    else if (i == 1)
      fib.add(1);
    else
      fib.add(fib[i - 1] + fib[i - 2]);
  }

  return fib;
}

void main() {
  int n = 10; 
  print(generateFibonacci(n));
}