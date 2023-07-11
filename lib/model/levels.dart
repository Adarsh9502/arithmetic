export 'package:arithmetic/model/levels.dart';
export 'package:arithmetic/model/level_easy.dart';
export 'package:arithmetic/model/level_medium.dart';
export 'package:arithmetic/model/level_hard.dart';

abstract class Levels {
  int get minOperations;
  int get maxOperations;
  double get addProb;
  double get subProb;
  int get minNumberToGenerate;
  int get maxNumberToGenerate;
  int get maxResult;
  int get gridLength;
}
