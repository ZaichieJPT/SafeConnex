import 'package:firebase_database/firebase_database.dart';
import 'package:safeconnex/api/dependecy_injector/injector.dart';
import 'package:safeconnex/backend_code/firebase_scripts/firebase_init.dart';
import 'package:safeconnex/backend_code/firebase_scripts/safeconnex_authentication.dart';

class SafeConnexAgencyDatabase{
  final DatabaseReference _dbAgencyReference = FirebaseDatabase.instanceFor(
      app: FirebaseInit.firebaseApp,
      databaseURL: "https://safeconnex-92054-default-rtdb.asia-southeast1.firebasedatabase.app/")
      .ref("agency");

  final DatabaseReference _dbUserReference = FirebaseDatabase.instanceFor(
      app: FirebaseInit.firebaseApp,
      databaseURL: "https://safeconnex-92054-default-rtdb.asia-southeast1.firebasedatabase.app/")
      .ref("users");

  String? selectedAgencyType;
  Map<String, String> agencyData = {};
  String? frontIdLink;
  String? backIdLink;
  String? selfieLink;

  Future<void> setAgencyData(String role, String agencyName, String locationOfAgency,
      String phoneNumber, String telephoneNumber, String emailAddress, String facebookLink,
      String agencyWebsite) async {
    agencyData = {
      "agencyRole": role,
      "agencyName": agencyName,
      "agencyLocation": locationOfAgency,
      "agencyPhoneNumber": phoneNumber,
      "agencyTelephoneNumber": telephoneNumber,
      "agencyEmailAddress": emailAddress,
      "facebookLink": facebookLink,
      "agencyWebsite": agencyWebsite
    };
  }

  Future<void> joinTheAgency() async {
    final selectedAgencySplit = selectedAgencyType!.split(' ');
    DataSnapshot snapshot = await _dbAgencyReference.child((selectedAgencySplit[0] + selectedAgencySplit[1]).toString()).child(agencyData["agencyName"]!.replaceAll(' ', '').toString()).get();
    if(selectedAgencyType != null) {
      if(snapshot.exists == false){
        await _dbAgencyReference.child((selectedAgencySplit[0] + selectedAgencySplit[1]).toString())
            .child(agencyData["agencyName"]!.replaceAll(' ', '').toString())
            .set({
          "agencyLocation": agencyData["agencyLocation"].toString(),
          "agencyPhoneNumber": agencyData["agencyPhoneNumber"].toString(),
          "agencyTelephoneNumber": agencyData["agencyTelephoneNumber"].toString(),
          "agencyEmailAddress": agencyData["agencyEmailAddress"].toString(),
          "facebookLink": agencyData["facebookLink"].toString(),
          "agencyWebsite": agencyData["agencyWebsite"].toString(),
        });
      }

      await _dbAgencyReference.child((selectedAgencySplit[0] + selectedAgencySplit[1])).child(agencyData["agencyName"]!.replaceAll(" ", ""))
          .child("employees").child(DependencyInjector().locator<SafeConnexAuthentication>().currentUser!.uid).set({
        "role": agencyData["agencyRole"].toString(),
      });

      await _dbUserReference.child(DependencyInjector().locator<SafeConnexAuthentication>().currentUser!.uid).update({
        "role": "Agency",
        "agencyType": selectedAgencyType!,
        "agencyName": agencyData["agencyName"]!.replaceAll(' ', '')
      });

    }else if(selectedAgencyType == null){
      print("selectedAgency is null");
    }
  }


  Future<void> updateAgencyMain(String agencyName, String agencyRole) async {
    selectedAgencyType = DependencyInjector().locator<SafeConnexAuthentication>().authAgencyData["agencyType"]!;
    final selectedAgencySplit = selectedAgencyType!.split(' ');
    DataSnapshot agencySnapshot = await _dbAgencyReference.child((selectedAgencySplit[0] + selectedAgencySplit[1]).toString()).child(DependencyInjector().locator<SafeConnexAuthentication>().authAgencyData["agencyName"]!.replaceAll(' ', '').toString()).get();

    if(selectedAgencyType != null) {
      if(agencySnapshot.exists){

        agencyData = {
          "agencyLocation": agencySnapshot.child("agencyLocation").value.toString(),
          "agencyPhoneNumber": agencySnapshot.child("agencyPhoneNumber").value.toString(),
          "agencyTelephoneNumber": agencySnapshot.child("agencyTelephoneNumber").value.toString(),
          "agencyEmailAddress": agencySnapshot.child("agencyEmailAddress").value.toString(),
          "facebookLink": agencySnapshot.child("facebookLink").value.toString(),
          "agencyWebsite": agencySnapshot.child("agencyWebsite").value.toString(),
          "agencyRole": agencySnapshot.child("employees").child(DependencyInjector().locator<SafeConnexAuthentication>().currentUser!.uid).child("role").value.toString()
        };

        await _dbAgencyReference.child((selectedAgencySplit[0] + selectedAgencySplit[1]).toString()).child(DependencyInjector().locator<SafeConnexAuthentication>().authAgencyData["agencyName"]!.replaceAll(' ', '').toString()).remove();

        await _dbAgencyReference.child((selectedAgencySplit[0] + selectedAgencySplit[1]).toString())
            .child(agencyName.replaceAll(' ', '').toString())
            .set({
          "agencyLocation": agencyData["agencyLocation"],
          "agencyPhoneNumber": agencyData["agencyPhoneNumber"],
          "agencyTelephoneNumber": agencyData["agencyTelephoneNumber"],
          "agencyEmailAddress": agencyData["agencyEmailAddress"],
          "facebookLink": agencyData["facebookLink"],
          "agencyWebsite": agencyData["agencyWebsite"],
        });

        await _dbAgencyReference.child((selectedAgencySplit[0] + selectedAgencySplit[1]).toString()).child(agencyName.replaceAll(' ', '').toString()).child("employees").child(DependencyInjector().locator<SafeConnexAuthentication>().currentUser!.uid).update({
          "role": agencyRole
        });

        await _dbUserReference.child(DependencyInjector().locator<SafeConnexAuthentication>().currentUser!.uid).update({
          "role": "Agency",
          "agencyName": agencyName.replaceAll(' ', '')
        });
      }
    }
  }

  Future<void> updateAgencyData(String? agencyLocation, String? agencyPhoneNumber, String? agencyTelephoneNumber, String? agencyEmail, String? facebookLink, String? agencyWebsite) async {
    selectedAgencyType = DependencyInjector().locator<SafeConnexAuthentication>().authAgencyData["agencyType"]!;
    final selectedAgencySplit = selectedAgencyType!.split(' ');
    DataSnapshot snapshot = await _dbAgencyReference.child((selectedAgencySplit[0] + selectedAgencySplit[1]).toString()).child(DependencyInjector().locator<SafeConnexAuthentication>().authAgencyData["agencyName"]!.replaceAll(' ', '').toString()).get();
    if(selectedAgencyType != null) {
      if(snapshot.exists){
        await _dbAgencyReference.child((selectedAgencySplit[0] + selectedAgencySplit[1]).toString())
            .child(DependencyInjector().locator<SafeConnexAuthentication>().authAgencyData["agencyName"]!.replaceAll(' ', '').toString())
            .update({
          "agencyLocation": agencyLocation,
          "agencyPhoneNumber": agencyPhoneNumber,
          "agencyTelephoneNumber": agencyTelephoneNumber,
          "agencyEmailAddress": agencyEmail,
          "facebookLink": facebookLink,
          "agencyWebsite": agencyWebsite,
        });
      }
      print("data Updated");
    }else if(selectedAgencyType == null){
      print("selectedAgency is null");
    }
  }

  Future<void> revertToUser() async {
    await _dbUserReference.child(DependencyInjector().locator<SafeConnexAuthentication>().currentUser!.uid).update({
      "role": "user",
    });
  }

  Future<void> revertToAgency() async {
    await _dbUserReference.child(DependencyInjector().locator<SafeConnexAuthentication>().currentUser!.uid).update({
      "role": "Agency",
    });
  }

  Future<void> getMyAgencyData() async {
    DataSnapshot userSnapshot = await _dbUserReference.child(DependencyInjector().locator<SafeConnexAuthentication>().currentUser!.uid).get();
    selectedAgencyType = userSnapshot.child("agencyType").value.toString();
    final selectedAgencySplit = selectedAgencyType!.split(" ");
    DataSnapshot agencySnapshot = await _dbAgencyReference.child((selectedAgencySplit[0] + selectedAgencySplit[1])).child(userSnapshot.child("agencyName").value.toString()).get();

    if(agencySnapshot.exists){
      if(agencyData.isEmpty){
        agencyData = {
          "agencyType": (selectedAgencySplit[0] + selectedAgencySplit[1]).toString(),
          "agencyName": agencySnapshot.key.toString(),
          "agencyLocation": agencySnapshot.child("agencyLocation").value.toString(),
          "agencyPhoneNumber": agencySnapshot.child("agencyPhoneNumber").value.toString(),
          "agencyTelephoneNumber": agencySnapshot.child("agencyTelephoneNumber").value.toString(),
          "agencyEmailAddress": agencySnapshot.child("agencyEmailAddress").value.toString(),
          "facebookLink": agencySnapshot.child("facebookLink").value.toString(),
          "agencyWebsite": agencySnapshot.child("agencyWebsite").value.toString(),
          "agencyRole": agencySnapshot.child("employees").child(DependencyInjector().locator<SafeConnexAuthentication>().currentUser!.uid).child("role").value.toString()
        };
      }else if(agencyData.isNotEmpty){
        agencyData.clear();
        agencyData = {
          "agencyType": (selectedAgencySplit[0] + selectedAgencySplit[1]).toString(),
          "agencyName": agencySnapshot.key.toString(),
          "agencyLocation": agencySnapshot.child("agencyLocation").value.toString(),
          "agencyPhoneNumber": agencySnapshot.child("agencyPhoneNumber").value.toString(),
          "agencyTelephoneNumber": agencySnapshot.child("agencyTelephoneNumber").value.toString(),
          "agencyEmailAddress": agencySnapshot.child("agencyEmailAddress").value.toString(),
          "facebookLink": agencySnapshot.child("facebookLink").value.toString(),
          "agencyWebsite": agencySnapshot.child("agencyWebsite").value.toString(),
          "agencyRole": agencySnapshot.child("employees").child(DependencyInjector().locator<SafeConnexAuthentication>().currentUser!.uid).child("role").value.toString()
        };
      }
    }else{
      print("Agency does not exist");
    }
  }
}