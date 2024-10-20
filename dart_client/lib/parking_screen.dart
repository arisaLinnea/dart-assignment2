import 'dart:io';

import 'package:dart_client/models/parking.dart';
import 'package:dart_client/models/parkinglot.dart';
import 'package:dart_client/models/vehicle.dart';
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

void parkingScreen() async {
  ParkingRepository repository = ParkingRepository();
  VehicleRepository vehicleRepository = VehicleRepository();
  ParkingLotRepository parkingLotRepository = ParkingLotRepository();
  int? userInput;
  clearScreen();

  List<Vehicle> vehicleList = await vehicleRepository.getList();
  List<ParkingLot> lotList = await parkingLotRepository.getList();

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
        if (vehicleList.isEmpty) {
          print(
              'To add a parking you need a vehicle. Press any key to go back to main menu and choose to add a vehicle.');
          stdin.readLineSync();
          clearScreen();
          userInput = 5;
          break;
        }
        printListInfo('This is the vehicles you can add:');
        int vehicleIndex = checkIntOption(
            question:
                'Enter number of the vehicle you would like to add to this parking: ',
            maxNumber: vehicleList.length,
            userOptions: vehicleList,
            menu: false);
        Vehicle vehicle = vehicleList[vehicleIndex - 1];

        if (lotList.isEmpty) {
          print(
              'To add a parking you need a parking lot. Press any key to go back to main menu and choose to add a parking lot.');
          stdin.readLineSync();
          clearScreen();
          userInput = 5;
          break;
        }
        printListInfo('This is the parking lots you can add:');
        int lotIndex = checkIntOption(
            question:
                'Enter number of the parking lot you would like to add to this parking: ',
            maxNumber: lotList.length,
            userOptions: lotList,
            menu: false);
        ParkingLot parkingLot = lotList[lotIndex - 1];

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
          endTime = DateTime.now()
              .add(Duration(hours: setHours, minutes: setMinutes));
        }

        Parking newParking = Parking(
            vehicle: vehicle,
            parkinglot: parkingLot,
            startTime: startTime,
            endTime: endTime);
        repository.addToList(item: newParking);
        printAdd(newParking.toString());
        printContinue();
        break;
      case 2: // list parkings
        List<Parking> parkingList = await repository.getList();
        if (parkingList.isEmpty) {
          print('The list of parkings are empty');
        } else {
          for (var item in parkingList) {
            print("* $item");
          }
        }
        printContinue();
        break;
      case 3: // edit parking lot
        List<Parking> parkingList = await repository.getList();
        if (parkingList.isEmpty) {
          print('There is no parkings to edit.');
        } else {
          int editNo = checkIntOption(
              question: 'What number do you want to edit? ',
              maxNumber: parkingList.length,
              userOptions: parkingList,
              menu: false);
          Parking editParking = parkingList[editNo - 1];

          bool changeVehicle = checkBoolOption(
              question: 'Do you want to change vehicle? (y?): ');
          if (changeVehicle) {
            if (vehicleList.isEmpty) {
              print('No vehicle to change to');
            } else {
              int vehicleIndex = checkIntOption(
                  question:
                      'Enter number of the vehicle you would like to add to this vehicle: ',
                  maxNumber: vehicleList.length,
                  userOptions: vehicleList,
                  menu: false);
              Vehicle vehicle = vehicleList[vehicleIndex - 1];
              editParking.vehicle = vehicle;
            }
          }

          bool changeLot = checkBoolOption(
              question: 'Do you want to change parking lot? (y?): ');
          if (changeLot) {
            if (lotList.isEmpty) {
              print('No parking lot to change to');
            } else {
              int lotIndex = checkIntOption(
                  question:
                      'Enter number of the parking lot you would like to add to this vehicle: ',
                  maxNumber: lotList.length,
                  userOptions: lotList,
                  menu: false);
              ParkingLot parkinglot = lotList[lotIndex - 1];
              editParking.parkingLot = parkinglot;
            }
          }
          // antar att starttid inte kan ändras (isf får man ta bort befintlig och starta en ny)
          bool changeEndTime = checkBoolOption(
              question: 'Do you want to change end time? (y?): ');
          if (changeEndTime) {
            int setHours = checkHourOption(
                question:
                    "How many hours from now do you want the parking to end? (0 for now): ");
            int setMinutes = checkHourOption(
                question:
                    "How many minutes from now (+ $setHours) do you want the parking to end? (0 for now): ");
            DateTime endTime = DateTime.now()
                .add(Duration(hours: setHours, minutes: setMinutes));
            editParking.endTime = endTime;
          }
          repository.update(index: editNo - 1, item: editParking);
          printAction('Parking lot has been updated');
        }
        printContinue();
        break;
      case 4: // remove parking
        List<Parking> parkingList = await repository.getList();
        if (parkingList.isEmpty) {
          print('There is no parkings to remove.');
        } else {
          int removeNo = checkIntOption(
              question: 'What number do you want to remove? ',
              maxNumber: parkingList.length,
              userOptions: lotList,
              menu: false);
          repository.remove(index: removeNo - 1);
          printAction('List of parkings has been updated.');
        }

        printContinue();
        break;
      case 6:
        exitCli();
      default:
        break;
    }
  }
}
