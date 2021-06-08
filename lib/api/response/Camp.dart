class Camp {
  final int campId;
  final String name;
  final String address;
  final double latitude;
  final double longitude;
  final String? campImage;
  final String phone;
  final String description;

  Camp({
    required this.campId,
    required this.name,
    required this.address,
    required this.latitude,
    required this.longitude,
    required this.campImage,
    required this.phone,
    required this.description
  });

  factory Camp.fromJson(Map<String, dynamic> json) {
    return Camp(
      campId: json['camp_id'],
      name: json['name'],
      address: json['address'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      campImage: json['camp_image'],
      phone: json['phone'],
      description: json['description']
    );
  }
}