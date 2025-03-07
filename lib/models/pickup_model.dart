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
      id: json['id']?.toString() ?? '', // Ensure id is never null
      documentId: json['documentId']?.toString() ?? 'Unknown', // Handle possible null
      progress: json['progress']?.toString() ?? 'Pending', // Default status if null
      createdAt: json['createdAt'] != null
          ? DateTime.tryParse(json['createdAt'].toString()) ?? DateTime.now()
          : DateTime.now(), // Fallback to current time if parsing fails
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
