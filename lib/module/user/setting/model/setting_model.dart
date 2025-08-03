class SettingModel {
  final int id;
  final String name;

  SettingModel({required this.id, required this.name});

  factory SettingModel.fromJson(Map<String, dynamic> json) {
    return SettingModel(
      id: json['id'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
      };
}
