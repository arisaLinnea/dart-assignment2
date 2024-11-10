import 'dart:io';

import 'package:dart_shared/dart_shared.dart';
import 'package:dart_client/repositories/parking_lot_repository.dart';
import 'package:dart_client/repositories/parking_repository.dart';
import 'package:dart_client/repositories/vehicle_repository.dart';
import 'package:dart_client/utils/effects.dart';
import 'package:dart_client/utils/menu_choices.dart';

List<String> userOptions = [
  '1. Create a new parking',
  '2. Show me all parkings',
  '3. Edit a parking',
  '4. Remove a parking',
  '5. Go back to start screen',
  'q. Quit',
];
List<Vehicle>? vehicleList = [];
List<ParkingLot>? lotList = [];
ParkingRepository repository = ParkingRepository();
VehicleRepository vehicleRepository = VehicleRepository();
ParkingLotRepository parkingLotRepository = ParkingLotRepository();

Future<void> parkingScreen() async {
  vehicleList = await vehicleRepository.getList();
  lotList = await parkingLotRepository.getList();
  int? userInput;
  clearScreen();

  while (userInput != 5) {
    printGreeting('You can now administrate parkings. What do you wanna do?');
    userInput = checkIntOption(
        question: 'Choose an option (1-5): ',
        maxNumber: 5,
        userOptions: userOptions,
        menu: true);
    clearScreen();
    printGreeting('You chose: ${userOptions.elementAt(userInput - 1)}');
    switch (userInput) {
      case 1: // add parking
        if (vehicleList == null) {
          print('Try again later');
          break;
        } else if (vehicleList == []) {
          print(
              'To add a parking you need a vehicle. Press any key to go back to main menu and choose to add a vehicle.');
          stdin.readLineSync();
          clearScreen();
          userInput = 5;
          break;
        }
        if (lotList == null) {
          print('Try again later');
          break;
        } else if (lotList == []) {
          print(
              'To add a parking you need a parking lot. Press any key to go back to main menu and choose to add a parking lot.');
          stdin.readLineSync();
          clearScreen();
          userInput = 5;
          break;
        }
        await addParkingScreen();
        break;
      case 2: // list parkings
        await showParkingListScreen();
        break;
      case 3: // edit parking lot
        await showUpdateParkingScreen();
        break;
      case 4: // remove parking
        await showRemoveParkingScreen();
        break;
      case 6:
        exitCli();
      default:
        break;
    }
  }
}

Future<void> addParkingScreen() async {
  printListInfo('This is the vehicles you can add:');
  int vehicleIndex = checkIntOption(
      question:
          'Enter number of the vehicle you would like to add to this parking: ',
      maxNumber: vehicleList?.length ?? 0,
      userOptions: vehicleList ?? [],
      menu: false);
  Vehicle? vehicle = vehicleList?[vehicleIndex - 1];

  printListInfo('This is the parking lots you can add:');
  int lotIndex = checkIntOption(
      question:
          'Enter number of the parking lot you would like to add to this parking: ',
      maxNumber: lotList?.length ?? 0,
      userOptions: lotList ?? [],
      menu: false);
  ParkingLot? parkingLot = lotList?[lotIndex - 1];

  DateTime startTime = DateTime.now();

  bool setEndDate =
      checkBoolOption(question: 'Do you want to set an end time (y?): ');
  DateTime? endTime;
  if (setEndDate) {
    int setHours = checkHourOption(
        question:
            "How many hours from now do you want the parking to end? (0 for now): ");
    int setMinutes = checkHourOption(
        question:
            "How many minutes from now (+ $setHours hours) do you want the parking to end? (0 for now): ");
    endTime =
        DateTime.now().add(Duration(hours: setHours, minutes: setMinutes));
  }

  Parking newParking = Parking(
      vehicle: vehicle,
      parkinglot: parkingLot,
      startTime: startTime,
      endTime: endTime);
  bool success = await repository.addToList(item: newParking);
  if (success) {
    printAdd(newParking.toString());
  }
  printContinue();
}

Future<void> showParkingListScreen() async {
  List<Parking>? parkingList = await repository.getList();
  if (parkingList != null && parkingList.isEmpty) {
    print('The list of parkings are empty');
  } else if (parkingList != null) {
    for (var item in parkingList) {
      print("* $item");
    }
  }
  printContinue();
}

Future<void> showUpdateParkingScreen() async {
  List<Parking>? parkingList = await repository.getList();
  if (parkingList == null) {
    print('Try again later');
  } else if (parkingList.isEmpty) {
    print('There is no parkings to edit.');
  } else {
    int editNo = checkIntOption(
        question: 'What number do you want to edit? ',
        maxNumber: parkingList.length,
        userOptions: parkingList,
        menu: false);
    Parking editParking = parkingList[editNo - 1];

    bool changeVehicle =
        checkBoolOption(question: 'Do you want to change vehicle? (y?): ');
    if (changeVehicle) {
      if (vehicleList == null || vehicleList == []) {
        print('No vehicle to change to');
      } else {
        int vehicleIndex = checkIntOption(
            question:
                'Enter number of the vehicle you would like to add to this vehicle: ',
            maxNumber: vehicleList?.length ?? 0,
            userOptions: vehicleList ?? [],
            menu: false);
        Vehicle? vehicle = vehicleList?[vehicleIndex - 1];
        editParking.vehicle = vehicle;
      }
    }

    bool changeLot =
        checkBoolOption(question: 'Do you want to change parking lot? (y?): ');
    if (changeLot) {
      if (lotList == null || lotList == []) {
        print('No parking lot to change to');
      } else {
        int lotIndex = checkIntOption(
            question:
                'Enter number of the parking lot you would like to add to this vehicle: ',
            maxNumber: lotList?.length ?? 0,
            userOptions: lotList ?? [],
            menu: false);
        ParkingLot? parkinglot = lotList?[lotIndex - 1];
        editParking.parkinglot = parkinglot;
      }
    }
    // antar att starttid inte kan ändras (isf får man ta bort befintlig och starta en ny)
    bool changeEndTime =
        checkBoolOption(question: 'Do you want to change end time? (y?): ');
    if (changeEndTime) {
      int setHours = checkHourOption(
          question:
              "How many hours from now do you want the parking to end? (0 for now): ");
      int setMinutes = checkHourOption(
          question:
              "How many minutes from now (+ $setHours) do you want the parking to end? (0 for now): ");
      DateTime endTime =
          DateTime.now().add(Duration(hours: setHours, minutes: setMinutes));
      editParking.endTime = endTime;
    }
    String editId = parkingList[editNo - 1].id;
    bool success = await repository.update(id: editId, item: editParking);
    if (success) {
      printAction('Parking has been updated.');
    }
  }
  printContinue();
}

Future<void> showRemoveParkingScreen() async {
  List<Parking>? parkingList = await repository.getList();
  if (parkingList == null) {
    print('Try again later');
  } else if (parkingList.isEmpty) {
    print('There is no parkings to remove.');
  } else {
    int removeNo = checkIntOption(
        question: 'What number do you want to remove? ',
        maxNumber: parkingList.length,
        userOptions: parkingList,
        menu: false);
    String removeId = parkingList[removeNo - 1].id;
    bool success = await repository.remove(id: removeId);
    if (success) {
      printAction('List of parkings has been updated.');
    }
  }

  printContinue();
}
