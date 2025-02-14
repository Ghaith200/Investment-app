// import 'dart:convert';
// import 'dart:developer';

// import 'package:investement_app/core/constants/storage_keys.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class Storage {
//   static final Storage _instance = Storage._();

//   late SharedPreferences prefs;

//   Storage._();

//   static Storage get instance => _instance;

//   /// Initialize SharedPreferences
//   Future<void> initStorage() async {
//     prefs = await SharedPreferences.getInstance();
//     if (prefs.getString(StorageKeys.user) == null) {
//       return;
//     }
//     final fuser = FirebaseAuth.instance.currentUser;
//     final data = await FirebaseFirestore.instance
//         .collection(FirebaseStrings.users)
//         .doc(user.uid)
//         .get();
//     if (data.exists == false && fuser == null) {
//       logout();
//       return;
//     }
//     user = UserModel.fromJson(
//         {"uid": data.id, "phoneNumber": fuser!.phoneNumber, ...data.data()!});
//   }

//   /// Getter and Setter for Dark Mode Preference
//   bool get isDarkMood => false;

//   set isDarkMood(bool isDarkMood) =>
//       prefs.setBool(StorageKeys.isDarkMood, isDarkMood);

//   /// Getter and Setter for First Time Usage
//   bool get isFirstTime => prefs.getBool(StorageKeys.isFirstTime) ?? true;

//   set isFirstTime(bool isFirstTime) =>
//       prefs.setBool(StorageKeys.isFirstTime, isFirstTime);

//   bool get isAuth {
//     final userdata = prefs.getString(StorageKeys.user);
//     log("User Data $userdata");
//     if (userdata == null) {
//       return false;
//     } else {
//       return true;
//     }
//   }

//   UserModel get user =>
//       UserModel.fromJson(json.decode(prefs.getString(StorageKeys.user)!));

//   set user(UserModel user) =>
//       prefs.setString(StorageKeys.user, json.encode(user.toJson()));

//   Future<void> logout() async => await prefs.remove(StorageKeys.user);
//   bool get isAdmin => user.userType == UserTypeEnum.admin;
// }
