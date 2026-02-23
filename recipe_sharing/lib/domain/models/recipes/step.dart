class Step {
  String description;
  double durationMinutes;

  Step({required this.description, required this.durationMinutes});

  factory Step.fromMap(Map<String, dynamic> map) {
    return Step(
      description: map["description"],
      durationMinutes: map["durationMinutes"] is int
          ? (map["durationMinutes"] as int).toDouble()
          : (map["durationMinutes"] as double),
    );
  }

  Map<String, dynamic> toMap() {
    return {'description': description, 'durationMinutes': durationMinutes};
  }
}
