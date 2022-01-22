class Ingredient {
  late String name;
  late String unit;
  late String amount;

  Ingredient(String n, String u, String a) {
    name = n;
    unit = u;
    amount = a;
  }

  @override
  String toString() {
    return "$amount $unit of $name";
  }
}
