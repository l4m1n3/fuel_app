import '../models/transaction.dart';
import '../models/station.dart';
import '../models/fuel_card.dart';

class StaticData {
  static final List<FuelCard> fuelCards = [
    FuelCard(id: 1, cardNumber: 'CARD123', balance: 25000.0, userId: 1),
    FuelCard(id: 2, cardNumber: 'CARD456', balance: 15000.0, userId: 1),
  ];

  static final List<Transaction> transactions = [
    Transaction(
      id: 1,
      fuelCardId: 1,
      stationName: 'Station Niamey Centre',
      amount: 5000.0,
      date: '15/05/2025 14:30',
      fuelType: 'Essence',
        status: 'Termine'
    ),
    Transaction(
      id: 2,
      fuelCardId: 1,
      stationName: 'Station Aéroport',
      amount: 7000.0,
      date: '10/05/2025 09:15',
      fuelType: 'Diesel',
        status: 'Termine'
    ),
    Transaction(
      id: 3,
      fuelCardId: 2,
      stationName: 'Station Zinder',
      amount: 3000.0,
      date: '05/05/2025 16:45',
      fuelType: 'Essence',
      status: 'Termine'
    ),
  ];

  static final List<Station> stations = [
    Station(
      id: 1,
      name: 'Station Niamey Centre',
      latitude: 13.5137,
      longitude: 2.1098,
      address: 'Rue du Marché, Niamey',
      fuelTypes: ['Essence', 'Diesel'],
    ),
    Station(
      id: 2,
      name: 'Station Aéroport',
      latitude: 13.4834,
      longitude: 2.1836,
      address: 'Aéroport Diori Hamani, Niamey',
      fuelTypes: ['Essence', 'Diesel'],
    ),
    Station(
      id: 3,
      name: 'Station Zinder',
      latitude: 13.8053,
      longitude: 8.9853,
      address: 'Route Principale, Zinder',
      fuelTypes: ['Essence'],
    ),
  ];
}