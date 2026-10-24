enum AssetType {
  meter,
  generator,
}

class Asset {
  final String id;
  final String name;
  final AssetType type;

  const Asset({
    required this.id,
    required this.name,
    required this.type,
  });

  static final RegExp _idPattern = RegExp(r'^[A-Z]-\d{3}$');

  static bool isValidId(String id) {
    return _idPattern.hasMatch(id);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'type': type.name,
    };
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is Asset &&
            other.id == id &&
            other.name == name &&
            other.type == type;
  }

  @override
  int get hashCode => Object.hash(id, name, type);
}