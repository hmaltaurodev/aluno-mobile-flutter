enum Bimester {
  first,
  second,
  third,
  fourth
}

extension BimesterExtension on Bimester {
  String getDescription() {
    switch (this) {
      case Bimester.first:
        return '1º Bimestre';
      case Bimester.second:
        return '2º Bimestre';
      case Bimester.third:
        return '3º Bimestre';
      case Bimester.fourth:
        return '4º Bimestre';
    }
  }

  int toInt() {
    switch (this) {
      case Bimester.first:
        return 1;
      case Bimester.second:
        return 2;
      case Bimester.third:
        return 3;
      case Bimester.fourth:
        return 4;
    }
  }
}
