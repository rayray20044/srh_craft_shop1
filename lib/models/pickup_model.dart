class Pickup {
  final String id; // identifier of the pickup
  final String documentId; //   pickup id
  final String progress; //pickup status
  final DateTime createdAt;

  Pickup({
    required this.id,
    required this.documentId,
    required this.progress,
    required this.createdAt,
  });

  // converts a json object into a pickup one
  factory Pickup.fromJson(Map<String, dynamic> json) {
    return Pickup(
      id: json['id'].toString(),
      documentId: json['documentId'], // gets documentid from json
      progress: json['progress'], // gets pickup status from json
      createdAt: DateTime.parse(json['createdAt']), // converts timestamp string to DateTime
    );
  }

  // converts a Pickup object into a json map for api requests
  Map<String, dynamic> toJson() {
    return {
      'id': id.toString(),
      'documentId': documentId,
      'progress': progress,
      'createdAt': createdAt.toIso8601String(),
    };
  }
}
