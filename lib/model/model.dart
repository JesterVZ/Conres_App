abstract class Human {
  Human({
    required this.Family,
    required this.Name,
    required this.Patronymic,
    required this.Password,
    required this.RepeatPassword,
  });
  final String Family;
  final String Name;
  final String Patronymic;
  final String Password;
  final String RepeatPassword;
}

class Fl extends Human {
  Fl(this.Inn, this.Snils, this.Tel, this.Email,
      {required String Family,
      required String Name,
      required String Patronymic,
      required String Password,
      required String RepeatPassword})
      : super(
            Family: Family,
            Name: Name,
            Patronymic: Patronymic,
            Password: Password,
            RepeatPassword: RepeatPassword);
  final String Inn;
  final String Snils;
  final String Tel;
  final String Email;
}

class Ip extends Human {
  Ip(
      {required String Family,
      required String Name,
      required String Patronymic,
      required String Password,
      required String RepeatPassword})
      : super(
            Family: Family,
            Name: Name,
            Patronymic: Patronymic,
            Password: Password,
            RepeatPassword: RepeatPassword);
}

class Ul {
  Ul({
    required this.Orgnip,
    required this.Kpp,
    required this.Tel,
    required this.Email,
    required this.FullName,
    required this.Name,
    required this.Inn,
  });
  final String FullName;
  final String Name;
  final String Inn;
  final String Orgnip;
  final String Kpp;
  final String Tel;
  final String Email;
}

class Dl extends Human {
  Dl(
      {required this.TelDL,
      required this.EmailDL,
      required String Family,
      required String Name,
      required String Patronymic,
      required String Password,
      required String RepeatPassword})
      : super(
            Family: Family,
            Name: Name,
            Patronymic: Patronymic,
            Password: Password,
            RepeatPassword: RepeatPassword);
  final String TelDL;
  final String EmailDL;
}
