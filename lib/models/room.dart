class Room {
  final String name;
  final double latitude;
  final double longitude;

  const Room({
    required this.name,
    required this.latitude,
    required this.longitude,
  });

  factory Room.fromJson(Map<String, dynamic> json) {
    return Room(
      name: json['room'] as String,
      latitude: json['geo']['lat'] as double,
      longitude: json['geo']['lng'] as double,
    );
  }
}
