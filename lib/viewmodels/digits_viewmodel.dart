import 'package:arithmetic/viewmodels/shake_widget_viewmodel.dart';
import 'package:get/get.dart';

import '../model/levels.dart';
import '../model/number_generator.dart';
import '../helpers/stack.dart';
import '../helpers/levels_list.dart';
import '../utils/svg_strings.dart';

class DigitsViewModel extends GetxController {
  int result = 0;
  int currResult = 0;
  bool isRevealed = false;

  Levels level = Easy();
  List<int> numbers = [];
  List<int> operatedNumbers = [];
  List<String> userSteps = [];
  List<String> resultSteps = [];

  late NumberGeneratorModel numberGeneratorModel;

  final Map<String, String> operations = {
    '+': SvgStrings.add,
    '-': SvgStrings.subtract,
    '*': SvgStrings.multiply,
    '/': SvgStrings.divide
  };

  List<ShakeWidgetViewModel> get shakeKey => List.generate(numbers.length,
      (index) => Get.put(ShakeWidgetViewModel(), tag: '$index'));

  void initializeLevel(LevelsList levelsList) {
    switch (levelsList) {
      case LevelsList.easy:
        level = Easy();
        break;
      case LevelsList.medium:
        level = Medium();
        break;
      case LevelsList.hard:
        level = Hard();
        break;
    }
    initialize(level);
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

    resultSteps = numberGeneratorModel.steps;
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

  final Stack numberStack = Stack<List<int>>();

  push(List<int> numbers) {
    numberStack.push([...numbers]);
    numbers = numberStack.top();
    // deselectAll();
    update();
  }

  pop() {
    if (numberStack.size() < 2) return;
    numberStack.pop();
    numbers = [...numberStack.top()];
    userSteps.removeLast();
    deselectAll();
    update();
  }

  deselectAll() {
    selectedNumber = null;
    selectedOperation = null;
  }

  void operate(int idx1, int idx2, String opr) {
    int num1 = numbers[idx1];
    int num2 = numbers[idx2];
    currResult = 0;
    switch (opr) {
      case '+':
        currResult = num1 + num2;
        break;
      case '-':
        currResult = (num1 - num2).abs();
        break;
      case '*':
        currResult = num1 * num2;
        break;
      case '/':
        currResult = num1 ~/ num2;
        break;
    }
    numbers[idx1] = -1;
    numbers[idx2] = currResult;
    userSteps.add("$num1 $opr $num2 = ${numbers[idx2]}");
    push(numbers);
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
        // deselectAll();
      }
    } else {
      selectedOperation = null;
      selectedNumber = selectedNumber == index ? null : index;
    }
  }

  bool isResultAchieved() {
    return result == currResult;
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
    numberStack.clearStack();
    deselectAll();
    resultSteps = [];
    userSteps = [];
    numbers = [];
    operatedNumbers = [];
    result = 0;
    isRevealed = false;
    initialize(level);
  }
}
