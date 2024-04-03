//firebase
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Initialize Firestore
  FirestoreService() {
    initializeFirestore();
  }

  Future<void> initializeFirestore() async {
    await Firebase.initializeApp();
  }

  // Add User to Firestore
  Future<void> addUser(
    String name,
    String prenom,
    String email,
    String adress,
    String id,
    String mdp,
  ) async {
    await _firestore.collection('Utilisateurs').add({
      'NomUtilisateur': name,
      'PrenomUtilisateur': prenom,
      'MailUtilisateur': email,
      'AdressUtilisateur': adress,
      'IDUtilisateur': id,
      'MDPUtilisateur': mdp,
    });
  }

  // Add Admin to Firestore
  Future<void> addAdmin(
    String name,
    String prenom,
    String id,
    String mdp,
    String email,
  ) async {
    await _firestore.collection('Admin').add({
      'NomAdmin': name,
      'PrenomAdmin': prenom,
      'IDAdmin': id,
      'MDPAdmin': mdp,
      'MailAdmin': email,
    });
  }

  // Add Eboueur to Firestore
  Future<void> addEbouaur(
    String name,
    String prenom,
    String email,
    String id,
    String mdp,
  ) async {
    await _firestore.collection('Eboueurs').add({
      'NomEboueur': name,
      'PrenomEboueur': prenom,
      'MailEboueur': email,
      'IDEboueur': id,
      'MDPEboueur': mdp,
    });
  }

  // Add Amenageur to Firestore
  Future<void> addAmenageurs(
    int tarif,
    String numTel,
    String localisation,
    String matricul,
    String evaluation,
    String typeV,
    String name,
    String prenom,
    String email,
    String id,
    String mdp,
  ) async {
    await _firestore.collection('Amenageurs').add({
      'NomAmenageur': name,
      'PrenomAmenageur': prenom,
      'MailAmenageur': email,
      'IDAmenageur': id,
      'MDPAmenageur': mdp,
      'TypeVehiculeAmenageur': typeV,
      'TarifAmenageur': tarif,
      'NumTlfAmenageur': numTel,
      'LocalisationAmenageur': localisation,
      'ImmatriculationAmenageur': matricul,
      'EvaluationAmenageur': evaluation,
    });
  }

  // Get all users from Firestore
  Stream<List<DocumentSnapshot>> getUsers() {
    return _firestore.collection('Utilisateurs').snapshots().map((snapshot) {
      return snapshot.docs;
    });
  }

  // Get all users from Firestore
  Stream<List<DocumentSnapshot>> getAdmins() {
    return _firestore.collection('Admin').snapshots().map((snapshot) {
      return snapshot.docs;
    });
  }

  // Get all users from Firestore
  Stream<List<DocumentSnapshot>> getEboueurs() {
    return _firestore.collection('Eboueurs').snapshots().map((snapshot) {
      return snapshot.docs;
    });
  }

  // Get all users from Firestore
  Stream<List<DocumentSnapshot>> getAmenageurs() {
    return _firestore.collection('Amenageurs').snapshots().map((snapshot) {
      return snapshot.docs;
    });
  }

  // Other Firestore operations (e.g., update, delete, etc.) can be added here
}
