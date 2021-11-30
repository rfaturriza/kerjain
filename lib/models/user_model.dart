import 'package:hive/hive.dart';

part 'user_model.g.dart';

@HiveType(typeId: 2)
class UserModel {
  @HiveField(0)
  final String firstName;
  @HiveField(1)
  final String lastName;
  @HiveField(2)
  final String uid;

  UserModel(
      {required this.uid, required this.firstName, required this.lastName});

  Map<String, dynamic> toJson(data) {
    return {
      'uid': uid,
      'firstName': firstName,
      'lastName': lastName,
    };
  }

  factory UserModel.fromJson(data) {
    return UserModel(
      uid: data['uid'],
      firstName: data['firstName'],
      lastName: data['lastName'],
    );
  }
}
