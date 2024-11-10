import 'package:dart_shared/dart_shared.dart';
import 'package:dart_client/repositories/owner_repository.dart';
import 'package:dart_client/utils/effects.dart';
import 'package:dart_client/utils/menu_choices.dart';

List<String> userOptions = [
  '1. Create a new owner',
  '2. Show me all owners',
  '3. Edit an owner',
  '4. Remove an owner',
  '5. Go back to start screen',
  'q. Quit',
];
OwnerRepository repository = OwnerRepository();

Future<void> ownerScreen() async {
  int? userInput;
  clearScreen();

  while (userInput != 5) {
    printGreeting('You can now administrate owners. What do you wanna do?');
    userInput = checkIntOption(
        question: 'Choose an option (1-5): ',
        maxNumber: 5,
        menu: true,
        userOptions: userOptions);
    clearScreen();
    printGreeting('You chose: ${userOptions.elementAt(userInput - 1)}');
    switch (userInput) {
      case 1: // add owner
        await showAddOwnerScreen();
        break;
      case 2: // list owner
        await showOwnerListScreen();
        break;
      case 3: // edit owner
        await showUpdateOwnerScreen();
        break;
      case 4: // remove owner
        await showRemoveOwnerScreen();

        break;
      case 6:
        exitCli();
      default:
        break;
    }
  }
}

Future<void> showAddOwnerScreen() async {
  String name = checkInputStringValues(question: 'Name on new owner: ');
  String ssn =
      checkInputSsnValues(question: 'Ssn for new owner (YYMMDDNNNN): ');
  Owner newOwner = Owner(name: name, ssn: ssn);
  bool success = await repository.addToList(item: newOwner);
  if (success) {
    printAdd(newOwner.toString());
  }
  printContinue();
}

Future<void> showOwnerListScreen() async {
  List<Owner>? ownerList = await repository.getList();
  if (ownerList != null && ownerList.isEmpty) {
    print('The list of owners are empty');
  } else if (ownerList != null) {
    for (var item in ownerList) {
      print('* $item');
    }
  }
  printContinue();
}

Future<void> showUpdateOwnerScreen() async {
  List<Owner>? ownerList = await repository.getList();
  if (ownerList == null) {
    print('Try again later');
  } else if (ownerList.isEmpty) {
    print('There is no owners to edit.');
  } else {
    int editNo = checkIntOption(
        question: 'What number do you want to edit? ',
        maxNumber: ownerList.length,
        userOptions: ownerList,
        menu: false);
    Owner editOwner = Owner(name: 'name', ssn: 'ssn'); //ownerList[editNo - 1];
    bool changeName =
        checkBoolOption(question: 'Do you want to change name? (y?): ');
    if (changeName) {
      String name = checkInputStringValues(
          question: 'What name to you want to change to?: ');
      editOwner.name = name;
    }
    bool changeSsn =
        checkBoolOption(question: 'Do you want to change ssn? (y?): ');
    if (changeSsn) {
      String ssn =
          checkInputSsnValues(question: 'What ssn to you want to change to?: ');
      editOwner.ssn = ssn;
    }
    String editId = ownerList[editNo - 1].id;
    bool success = await repository.update(id: editId, item: editOwner);
    if (success) {
      printAction('Owner has been updated');
    }
  }
  printContinue();
}

Future<void> showRemoveOwnerScreen() async {
  List<Owner>? ownerList = await repository.getList();
  if (ownerList == null) {
    print('Try again later');
  } else if (ownerList.isEmpty) {
    print('There is no owners to remove.');
  } else {
    int removeNo = checkIntOption(
        question: 'What number do you want to remove? ',
        maxNumber: ownerList.length,
        menu: false,
        userOptions: ownerList);
    String removeId = ownerList[removeNo - 1].id;
    bool success = await repository.remove(id: removeId);
    if (success) {
      printAction('List of owners has been updated.');
    }
  }
  printContinue();
}
