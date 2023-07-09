import 'levels.dart';

class Hard extends Levels {
  @override
  int minOperations = 5;
  @override
  int maxOperations = 6;
  @override
  double addProb = 0.3;
  @override
  double subProb = 0.3;
  @override
  int minNumberToGenerate = 2;
  @override
  int maxNumberToGenerate = 299;
  @override
  int maxResult = 49999;
  @override
  int gridLength = 6;
}
