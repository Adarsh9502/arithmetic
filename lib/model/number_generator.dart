import 'dart:math';

class NumberGeneratorModel {
  int minOperations;
  int maxOperations;
  int minNumberToGenerate;
  int maxNumberToGenerate;
  double addProb;
  double subProb;
  List<int> numbers = [];
  List<String> steps = [];
  late List<int> operatedNumbers;

  NumberGeneratorModel(
      {required this.minOperations,
      required this.maxOperations,
      required this.minNumberToGenerate,
      required this.maxNumberToGenerate,
      this.addProb = 0.4,
      this.subProb = 0.4});

  int initilaize() {
    int numberCount = generateNumberBetween(minOperations, maxOperations);
    operatedNumbers = generateRandomNumbers(
        numberCount, minNumberToGenerate, maxNumberToGenerate);
    numbers = [...operatedNumbers];
    steps = [];
    // print('Operated numbers: $numbers');

    for (int i = 0; i < numberCount - 1; i++) {
      int index1 = generateRandomIndex(numbers.length);
      int index2 = generateRandomIndex(numbers.length, exclude: index1);

      int num1 = numbers[index1];
      int num2 = numbers[index2];
      
      int result =
          performOperation(num1, num2, addProb: addProb, subProb: subProb);
      numbers = updateNumbersList(numbers, index1, index2, result);

      steps.add("$num1 ${operationSymbol(result, num1, num2)} $num2 = $result");
      // print("$num1 ${operationSymbol(result, num1, num2)} $num2 = $result");
      // print("Updated list: $numbers");
    }
    return numbers[0];
  }

  int generateNumberBetween(int min, int max) {
    Random random = Random();
    int number = random.nextInt(max - min + 1) + min;
    return number;
  }

  List<int> generateRandomNumbers(int count, int min, int max) {
    List<int> numbers = [];

    while (numbers.length < count) {
      int randomNumber = Random().nextInt(max - min + 1) + min;
      if (!numbers.contains(randomNumber)) {
        numbers.add(randomNumber);
      }
    }

    return numbers;
  }

  int generateRandomIndex(int max, {int exclude = -1}) {
    int index;

    do {
      index = Random().nextInt(max);
    } while (index == exclude);

    return index;
  }

  int performOperation(int num1, int num2,
      {double addProb = 0.4, double subProb = 0.4}) {
    if (num1 % num2 == 0) {
      return num1 ~/ num2; // Use integer division
    } else {
      double randomValue = Random().nextDouble();
      if (randomValue < addProb) {
        return num1 + num2;
      } else if (randomValue < (addProb + subProb)) {
        return (num1 - num2).abs();
      } else {
        return num1 * num2;
      }
    }
  }

  List<int> updateNumbersList(
      List<int> numbers, int index1, int index2, int result) {
    int maxIndex = max(index1, index2);
    int minIndex = min(index1, index2);

    numbers.removeAt(maxIndex);
    numbers.removeAt(minIndex);
    numbers.add(result);

    return numbers;
  }

  String operationSymbol(int result, int num1, int num2) {
    if (result == num1 + num2) {
      return '+';
    } else if (result == (num1 - num2).abs()) {
      return '-';
    } else if (result == num1 * num2) {
      return '*';
    } else {
      return '/';
    }
  }
}
