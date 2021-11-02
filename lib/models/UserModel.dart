class UserModel {
  String? firstName;
  String? lastName;
  String? username;
  String? password;
  String? email;
  String? farmerId;
  String? crop;
  bool isHRAdmin;
  bool isSezilMotherTrialFarmer;

  UserModel({
    this.firstName,
    this.lastName,
    this.username,
    this.password,
    this.email,
    this.farmerId,
    this.crop,
    this.isHRAdmin = false,
    this.isSezilMotherTrialFarmer = true,
  });
}
