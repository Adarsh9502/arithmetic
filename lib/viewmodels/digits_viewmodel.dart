import 'package:arithmetic/model/levels.dart';
import 'package:arithmetic/viewmodels/shake_widget_viewmodel.dart';
import 'package:get/get.dart';

import '../model/level_hard.dart';
import '../model/number_generator.dart';
import '../utils/stack.dart';
import '../utils/svg_strings.dart';

class DigitsViewModel extends GetxController {
  static Levels level = Hard();

  bool isRevealed = false;

  late int result;
  late List<String> steps;
  late List<int> numbers;
  late List<int> operatedNumbers;
  late NumberGeneratorModel numberGeneratorModel;

  final Map<String, String> operations = {
    '+': SvgStrings.add,
    '-': SvgStrings.subtract,
    '*': SvgStrings.multiply,
    '/': SvgStrings.divide
  };

  List<ShakeWidgetViewModel> get shakeKey => List.generate(numbers.length,
      (index) => Get.put(ShakeWidgetViewModel(), tag: '$index'));

  @override
  void onInit() {
    initialize(level);
    super.onInit();
  }

  void initialize(Levels level) {
    numberGeneratorModel = NumberGeneratorModel(
        minOperations: level.minOperations,
        maxOperations: level.maxOperations,
        minNumberToGenerate: level.minNumberToGenerate,
        maxNumberToGenerate: level.maxNumberToGenerate,
        addProb: level.addProb,
        subProb: level.subProb);

    do {
      result = numberGeneratorModel.initilaize();
    } while (result <= level.maxNumberToGenerate || result > level.maxResult);

    steps = numberGeneratorModel.steps;
    operatedNumbers = numberGeneratorModel.operatedNumbers;
    numbers = initializeNumbersToBeDisplayed(
      operatedNumbers,
      level.minNumberToGenerate,
      level.maxNumberToGenerate,
      level.gridLength,
    );
    push(numbers);
    update();
  }

  int? _selectedNumber;
  int? get selectedNumber => _selectedNumber;
  set selectedNumber(int? val) {
    _selectedNumber = val;
    update();
  }

  String? _selectedOperation;
  String? get selectedOperation => _selectedOperation;
  set selectedOperation(String? val) {
    _selectedOperation = val;
    update();
  }

  final Stack stack = Stack<List>();

  push(List<int> numbers) {
    stack.push([...numbers]);
    numbers = stack.top();
    // deselectAll();
    update();
  }

  pop() {
    if (stack.size() < 2) return;
    stack.pop();
    numbers = [...stack.top()];
    deselectAll();
    update();
  }

  deselectAll() {
    selectedNumber = null;
    selectedOperation = null;
  }

  bool operate(int idx1, int idx2, String opr) {
    switch (opr) {
      case '+':
        numbers[idx2] = numbers[idx1] + numbers[idx2];
        break;
      case '-':
        numbers[idx2] = (numbers[idx1] - numbers[idx2]).abs();
        break;
      case '*':
        numbers[idx2] = numbers[idx1] * numbers[idx2];
        break;
      case '/':
        numbers[idx2] = numbers[idx1] ~/ numbers[idx2];
        break;
    }
    numbers[idx1] = -1;
    push(numbers);
    return true;
  }

  void isOperationPossible(int index) {
    if (selectedOperation != null && selectedNumber != null) {
      if ((numbers[selectedNumber!] % numbers[index] != 0) &&
          selectedOperation == '/') {
        shakeKey[index].shake();
        shakeKey[selectedNumber!].shake();
        deselectAll();
      } else {
        operate(selectedNumber!, index, selectedOperation!);
        selectedNumber = index;
        selectedOperation = null;
      }
    } else {
      selectedOperation = null;
      selectedNumber = selectedNumber == index ? null : index;
    }
  }

  List<int> initializeNumbersToBeDisplayed(List<int> numbers,
      int minNumberToGenerate, int maxNumberToGenerate, int gridLength) {
    List<int> displayedNumbers = [...numbers];
    if (numbers.length < gridLength) {
      int diff = gridLength - numbers.length;
      var temp = numberGeneratorModel.generateRandomNumbers(
          diff, minNumberToGenerate, maxNumberToGenerate);
      for (var element in temp) {
        displayedNumbers.insert(
            numberGeneratorModel.generateRandomIndex(numbers.length), element);
      }
    }
    return displayedNumbers;
  }

  bool isNumVisible(int index) => numbers[index] != -1;
  bool isNumSelected(int index) => selectedNumber == index;
  void selectOperator(String e) {
    if (selectedNumber == null) return;
    selectedOperation = selectedOperation == e ? null : e;
  }

  generateNext() {
    stack.clearStack();
    deselectAll();
    steps = [];
    numbers = [];
    operatedNumbers = [];
    result = 0;
    isRevealed = false;
    initialize(level);
  }
}
