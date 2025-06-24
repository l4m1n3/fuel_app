class Station {
  final int id;
  final String name;
  final String address;
  final double latitude;
  final double longitude;
  final List<String> fuelTypes;

  Station({
    required this.id,
    required this.name,
    required this.address,
    required this.latitude,
    required this.longitude,
    required this.fuelTypes,
  });

  // Convertir une station depuis une Map (pour Sqflite)
  factory Station.fromMap(Map<String, dynamic> map) {
    return Station(
      id: map['id'] as int,
      name: map['name'] as String,
      address: map['address'] as String,
      latitude: map['latitude'] as double,
      longitude: map['longitude'] as double,
      fuelTypes: (map['fuelTypes'] as String).split(','), // Stocké comme chaîne dans la DB
    );
  }

  // Convertir une station en Map (pour Sqflite)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'address': address,
      'latitude': latitude,
      'longitude': longitude,
      'fuelTypes': fuelTypes.join(','), // Stocké comme chaîne dans la DB
    };
  }
}