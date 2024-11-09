import 'package:dart_shared/dart_shared.dart';
import 'package:dart_client/repositories/parking_lot_repository.dart';
import 'package:dart_client/utils/effects.dart';
import 'package:dart_client/utils/menu_choices.dart';

List<String> userOptions = [
  '1. Create a new parking lot',
  '2. Show me all parking lots',
  '3. Edit a parking lot',
  '4. Remove a parking lot',
  '5. Go back to start screen',
  'q. Quit',
];
ParkingLotRepository repository = ParkingLotRepository();

Future<void> parkingLotScreen() async {
  int? userInput;
  clearScreen();

  while (userInput != 5) {
    printGreeting(
        'You can now administrate parking lots. What do you wanna do?');
    userInput = checkIntOption(
        question: 'Choose an option (1-5): ',
        maxNumber: 5,
        menu: true,
        userOptions: userOptions);
    clearScreen();
    printGreeting('You chose: ${userOptions.elementAt(userInput - 1)}');
    switch (userInput) {
      case 1: // add parking lot
        await showAddParkingLotScreen();
        break;
      case 2: // list parking lots
        await showParkingLotListScreen();
        break;
      case 3: // edit parking lot
        await showUpdateParkingLotScreen();
        break;
      case 4: // remove parking lot
        await showRemoveParkingLotScreen();
        break;
      case 6:
        exitCli();
      default:
        break;
    }
  }
}

Future<void> showAddParkingLotScreen() async {
  String streetName = checkInputStringValues(
      question: 'Streetname and number for the parking lot: ');
  String zipCode =
      checkInputStringValues(question: 'Zipcode for the parking lot: ');
  String city = checkInputStringValues(question: 'City for the parking lot: ');
  Address address = Address(street: streetName, zipCode: zipCode, city: city);
  double hourlyPrice =
      checkDoubleOption(question: 'Hourly price for this parking lot: ');

  ParkingLot newLot = ParkingLot(address: address, hourlyPrice: hourlyPrice);
  await repository.addToList(item: newLot);
  printAdd(newLot.toString());
  printContinue();
}

Future<void> showParkingLotListScreen() async {
  List<ParkingLot> lotList = await repository.getList();
  if (lotList.isEmpty) {
    print('The list of parking lots are empty');
  } else {
    for (var item in lotList) {
      print("* $item");
    }
  }
  printContinue();
}

Future<void> showUpdateParkingLotScreen() async {
  List<ParkingLot> lotList = await repository.getList();

  if (lotList.isEmpty) {
    print('There is no parking lots to edit.');
  } else {
    int editNo = checkIntOption(
        question: 'What number do you want to edit? ',
        maxNumber: lotList.length,
        userOptions: lotList,
        menu: false);
    ParkingLot editLot = lotList[editNo - 1];

    bool changeAddress =
        checkBoolOption(question: 'Do you want to change address? (y?): ');
    if (changeAddress) {
      String streetName = checkInputStringValues(
          question: 'Streetname and number for the parking lot: ');
      String zipCode =
          checkInputStringValues(question: 'Zipcode for the parking lot: ');
      String city =
          checkInputStringValues(question: 'City for the parking lot: ');
      Address address = Address(
          id: editLot.address.id,
          street: streetName,
          zipCode: zipCode,
          city: city);
      editLot.address = address;
    }
    bool changePrice =
        checkBoolOption(question: 'Do you want to change hourly price (y?): ');
    if (changePrice) {
      double hourlyPrice =
          checkDoubleOption(question: 'Hourly price for this parking lot: ');
      editLot.hourlyPrice = hourlyPrice;
    }
    String editId = lotList[editNo - 1].id;
    bool success = await repository.update(id: editId, item: editLot);
    if (success) {
      printAction('Parkinglot has been updated.');
    } else {
      printError('Failed to update parkinglot');
    }
  }
  printContinue();
}

Future<void> showRemoveParkingLotScreen() async {
  List<ParkingLot> lotList = await repository.getList();
  if (lotList.isEmpty) {
    print('There is no parking lots to remove.');
  } else {
    int removeNo = checkIntOption(
        question: 'What number do you want to remove? ',
        maxNumber: lotList.length,
        userOptions: lotList,
        menu: false);
    String removeId = lotList[removeNo - 1].id;
    bool success = await repository.remove(id: removeId);
    if (success) {
      printAction('List of parkinglots has been updated.');
    } else {
      printError('Failed to remove parkinglot');
    }
  }

  printContinue();
}
