import 'levels.dart';

class Easy extends Levels {
  @override
  int minOperations = 4;
  @override
  int maxOperations = 5;
  @override
  double addProb = 0.45;
  @override
  double subProb = 0.45;
  @override
  int minNumberToGenerate = 2;
  @override
  int maxNumberToGenerate = 49;
  @override
  int maxResult = 499;
  @override
  int gridLength = 6;
}
