abstract class Human {
  Human(
      {required this.Family,
      required this.Name,
      required this.Patronymic,
      required this.User_lk_type_id});
  final String Family;
  final String Name;
  final String Patronymic;
  final String User_lk_type_id;
}

class Fl extends Human {
  Fl(
      {required this.Email,
      required this.Tel,
      required this.Snils,
      required this.Inn,
      required this.Password,
      required this.RepeatPassword,
      required String Family,
      required String Name,
      required String Patronymic,
      required String User_lk_type_id})
      : super(
            Family: Family,
            Name: Name,
            Patronymic: Patronymic,
            User_lk_type_id: User_lk_type_id);
  final String Inn;
  final String Snils;
  final String Tel;
  final String Email;
  final String Password;
  final String RepeatPassword;
}

class Ip extends Human {
  Ip(
      {required String Family,
      required String Name,
      required String Patronymic,
      required String User_lk_type_id,
      required this.tel,
      required this.email,
      required this.inn,
      required this.ogrnip,
      required this.Password,
      required this.RepeatPassword,
      required this.dl})
      : super(
            Family: Family,
            Name: Name,
            Patronymic: Patronymic,
            User_lk_type_id: User_lk_type_id);
  final String inn;
  final String ogrnip;
  final String tel;
  final String email;
  final Dl? dl;
  final String Password;
  final String RepeatPassword;
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
    required this.dl,
    required this.Password,
    required this.RepeatPassword
  });
  final String FullName;
  final String Name;
  final String Inn;
  final String Orgnip;
  final String Kpp;
  final String Tel;
  final String Email;
  final String Password;
  final String RepeatPassword;
  final Dl? dl;
}

class Dl {
  Dl(
      {required this.TelDL,
      required this.EmailDL,
      required this.Family,
      required this.Name,
      required this.Patronymic
      });
  final String TelDL;
  final String EmailDL;
  final String Family;
  final String Name;
  final String Patronymic;

}
