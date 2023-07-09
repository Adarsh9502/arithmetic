import 'levels.dart';

class Medium extends Levels {
  @override
  int minOperations = 4;
  @override
  int maxOperations = 6;
  @override
  double addProb = 0.4;
  @override
  double subProb = 0.4;
  @override
  int minNumberToGenerate = 2;
  @override
  int maxNumberToGenerate = 199;
  @override
  int maxResult = 999;
  @override
  int gridLength = 6;
}
