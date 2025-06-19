class BillItemModel {
  final String label;
  final String value;
  final bool isFree;
  final bool isTotal;

  BillItemModel({
    required this.label,
    required this.value,
    required this.isFree,
    required this.isTotal,
  });
}
