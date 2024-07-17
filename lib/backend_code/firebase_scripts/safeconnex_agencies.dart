
import 'package:firebase_database/firebase_database.dart';
import 'package:safeconnex/api/dependecy_injector/injector.dart';
import 'package:safeconnex/backend_code/firebase_scripts/firebase_init.dart';

class SafeConnexAgencies{
  final DatabaseReference _dbAgencyReference = FirebaseDatabase.instanceFor(
      app: FirebaseInit.firebaseApp,
      databaseURL: "https://safeconnex-92054-default-rtdb.asia-southeast1.firebasedatabase.app/")
      .ref("agency");

  List<Map<String, dynamic>> fireAgencyContacts = [];
  List<Map<String, dynamic>> crimeAgencyContacts = [];
  List<Map<String, dynamic>> medicalAgencyContacts = [];
  List<Map<String, dynamic>> naturalAgencyContacts = [];

  Future<void> _getFireAgencyContacts() async {
    DataSnapshot fireAgencySnapshot = await _dbAgencyReference.child("FireIncident").get();

    if(fireAgencySnapshot.exists){
      if(fireAgencyContacts.isEmpty){
        for(var agencies in fireAgencySnapshot.children){
          fireAgencyContacts.add({
            'agencyName': agencies.key.toString(),
            'location': agencies.child("agencyLocation").value.toString(),
            'mobile': agencies.child("agencyPhoneNumber").value.toString(),
            'telephone': agencies.child("agencyTelephoneNumber").value.toString(),
            'email': agencies.child("agencyEmailAddress").value.toString(),
            'fb': agencies.child("facebookLink").value.toString(),
            'website': agencies.child("agencyWebsite").value.toString(),
          });
        }
      }
      else if(fireAgencyContacts.isNotEmpty){
        fireAgencyContacts.clear();
        for(var agencies in fireAgencySnapshot.children){
          fireAgencyContacts.add({
            'agencyName': agencies.key.toString(),
            'location': agencies.child("agencyLocation").value.toString(),
            'mobile': agencies.child("agencyPhoneNumber").value.toString(),
            'telephone': agencies.child("agencyTelephoneNumber").value.toString(),
            'email': agencies.child("agencyEmailAddress").value.toString(),
            'fb': agencies.child("facebookLink").value.toString(),
            'website': agencies.child("agencyWebsite").value.toString(),
          });
        }
      }
    }

    print("Fire: $fireAgencyContacts");
  }

  Future<void> _getCrimeAgencyContacts() async {
    DataSnapshot fireAgencySnapshot = await _dbAgencyReference.child("CrimeIncident").get();

    if(fireAgencySnapshot.exists){
      if(crimeAgencyContacts.isEmpty){
        for(var agencies in fireAgencySnapshot.children){
          crimeAgencyContacts.add({
            'agencyName': agencies.key.toString(),
            'location': agencies.child("agencyLocation").value.toString(),
            'mobile': agencies.child("agencyPhoneNumber").value.toString(),
            'telephone': agencies.child("agencyTelephoneNumber").value.toString(),
            'email': agencies.child("agencyEmailAddress").value.toString(),
            'fb': agencies.child("facebookLink").value.toString(),
            'website': agencies.child("agencyWebsite").value.toString(),
          });
        }
      }
      else if(crimeAgencyContacts.isNotEmpty){
        crimeAgencyContacts.clear();
        for(var agencies in fireAgencySnapshot.children){
          crimeAgencyContacts.add({
            'agencyName': agencies.key.toString(),
            'location': agencies.child("agencyLocation").value.toString(),
            'mobile': agencies.child("agencyPhoneNumber").value.toString(),
            'telephone': agencies.child("agencyTelephoneNumber").value.toString(),
            'email': agencies.child("agencyEmailAddress").value.toString(),
            'fb': agencies.child("facebookLink").value.toString(),
            'website': agencies.child("agencyWebsite").value.toString(),
          });
        }
      }
    }
  }

  Future<void> _getMedicalAgencyContacts() async {
    DataSnapshot fireAgencySnapshot = await _dbAgencyReference.child("MedicalEmergency").get();

    if(fireAgencySnapshot.exists){
      if(medicalAgencyContacts.isEmpty){
        for(var agencies in fireAgencySnapshot.children){
          medicalAgencyContacts.add({
            'agencyName': agencies.key.toString(),
            'location': agencies.child("agencyLocation").value.toString(),
            'mobile': agencies.child("agencyPhoneNumber").value.toString(),
            'telephone': agencies.child("agencyTelephoneNumber").value.toString(),
            'email': agencies.child("agencyEmailAddress").value.toString(),
            'fb': agencies.child("facebookLink").value.toString(),
            'website': agencies.child("agencyWebsite").value.toString(),
          });
        }
      }
      else if(medicalAgencyContacts.isNotEmpty){
        medicalAgencyContacts.clear();
        for(var agencies in fireAgencySnapshot.children){
          medicalAgencyContacts.add({
            'agencyName': agencies.key.toString(),
            'location': agencies.child("agencyLocation").value.toString(),
            'mobile': agencies.child("agencyPhoneNumber").value.toString(),
            'telephone': agencies.child("agencyTelephoneNumber").value.toString(),
            'email': agencies.child("agencyEmailAddress").value.toString(),
            'fb': agencies.child("facebookLink").value.toString(),
            'website': agencies.child("agencyWebsite").value.toString(),
          });
        }
      }
    }
  }

  Future<void> _getNaturalAgencyContacts() async {
    DataSnapshot fireAgencySnapshot = await _dbAgencyReference.child("NaturalDisaster").get();

    if(fireAgencySnapshot.exists){
      if(naturalAgencyContacts.isEmpty){
        for(var agencies in fireAgencySnapshot.children){
          naturalAgencyContacts.add({
            'agencyName': agencies.key.toString(),
            'location': agencies.child("agencyLocation").value.toString(),
            'mobile': agencies.child("agencyPhoneNumber").value.toString(),
            'telephone': agencies.child("agencyTelephoneNumber").value.toString(),
            'email': agencies.child("agencyEmailAddress").value.toString(),
            'fb': agencies.child("facebookLink").value.toString(),
            'website': agencies.child("agencyWebsite").value.toString(),
          });
        }
      }
      else if(naturalAgencyContacts.isNotEmpty){
        naturalAgencyContacts.clear();
        for(var agencies in fireAgencySnapshot.children){
          naturalAgencyContacts.add({
            'agencyName': agencies.key.toString(),
            'location': agencies.child("agencyLocation").value.toString(),
            'mobile': agencies.child("agencyPhoneNumber").value.toString(),
            'telephone': agencies.child("agencyTelephoneNumber").value.toString(),
            'email': agencies.child("agencyEmailAddress").value.toString(),
            'fb': agencies.child("facebookLink").value.toString(),
            'website': agencies.child("agencyWebsite").value.toString(),
          });
        }
      }
    }
  }

  Future<void> getAgenciesData() async {
    await _getFireAgencyContacts();
    await _getCrimeAgencyContacts();
    await _getMedicalAgencyContacts();
    await _getNaturalAgencyContacts();
  }
}