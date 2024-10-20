import 'dart:io';
import 'dart:convert';

import 'package:dart_client/owner_screen.dart';
import 'package:dart_client/parking_lot_screen.dart';
import 'package:dart_client/parking_screen.dart';
import 'package:dart_client/vehicle_screen.dart';
import 'package:dart_client/repositories/owner_repository.dart';
import 'package:dart_client/repositories/parking_lot_repository.dart';
import 'package:dart_client/repositories/parking_repository.dart';
import 'package:dart_client/repositories/vehicle_repository.dart';
import 'package:dart_client/utils/effects.dart';
import 'package:dart_client/utils/menu_choices.dart';

List<String> userOptions = [
  '1. Owners',
  '2. Vehicles',
  '3. Parkinglots',
  '4. Parkings',
  'q. Quit'
];

const JsonDecoder decoder = JsonDecoder();
String filePath = 'db/storage.json';

void readFromFile() {
  OwnerRepository ownerRepository = OwnerRepository();
  ownerRepository.readJsonFile(filePath);

  VehicleRepository vehicleRepository = VehicleRepository();
  vehicleRepository.readJsonFile(filePath);

  ParkingLotRepository parkinglotRepository = ParkingLotRepository();
  parkinglotRepository.readJsonFile(filePath);

  ParkingRepository parkingRepository = ParkingRepository();
  parkingRepository.readJsonFile(filePath);
}

void createParkingCli() async {
  // readFromFile(); // Fix later

  clearScreen();
  printGreeting('Welcome to FindMeASpot!');
  int? userInput;

  while (userInput != 5) {
    stdout.writeln('What do you want to do? ');
    userInput = checkIntOption(
        question: 'Choose an option (1-4): ',
        maxNumber: 4,
        userOptions: userOptions,
        menu: true);
    switch (userInput) {
      case 1:
        await ownerScreen();
        break;
      case 2:
        vehicleScreen();
        break;
      case 3:
        parkingLotScreen();
        break;
      case 4:
        parkingScreen();
        break;
      default:
        break;
    }
  }

  exitCli();
}
