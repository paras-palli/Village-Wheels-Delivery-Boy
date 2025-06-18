class StateModel {
  int? id;
  String? name;

  StateModel({this.id, this.name});

  factory StateModel.fromJson(Map<String, dynamic> json) {
    return StateModel(
      id: json['id'] as int?,
      name: json['name'] as String?,
    );
  }

  @override
  String toString() {
    return name ?? 'NA';
  }
}
