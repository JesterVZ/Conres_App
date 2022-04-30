class Profile {
  final String? personal;
  final String? inn;
  final String? personalGP;
  final String? email;
  final String? address;
  final String? userName;

  Profile(
      {required this.personal,
      required this.inn,
      this.personalGP,
      required this.email,
      required this.address,
      this.userName});

  factory Profile.fromMap(Map<dynamic, dynamic> map) {
    Map<dynamic, dynamic> profile = map;
    return Profile(
        inn: profile['userINN'],
        email: profile['userBaseEmail'],
        personal: profile['userAccountNumber'],
        address: profile['user_address'],
        userName: profile['userName']);
  }
}
