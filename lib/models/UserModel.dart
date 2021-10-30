class UserModel {
  String? firstName;
  String? lastName;
  String? username;
  String? email;
  String? farmerId;
  bool isHRAdmin;
  bool isSezilMotherTrialFarmer;

  UserModel({
    this.firstName,
    this.lastName,
    this.username,
    this.email,
    this.farmerId,
    this.isHRAdmin = false,
    this.isSezilMotherTrialFarmer = true,
  });
}
