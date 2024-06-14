class Check {
  final int? from;
  final bool isDouble;
  final bool isChecked;
  const Check({
    this.from,
    this.isDouble = false,
    this.isChecked = false,
  });

  @override
  String toString() {
    return 'Check{from: $from, isDouble: $isDouble, isChecked: $isChecked}';
  }
}
