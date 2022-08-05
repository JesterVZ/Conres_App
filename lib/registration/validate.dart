String validate(String error){
  switch(error){
    case "error_exists_Phone":
      return "Данный номер уже существует";
    case "error_exists_INN":
      return "Данный ИНН уже существует";
    case "error_email":
      return "Email некорректен";
    case "error_password":
      return "Пароль некорректен";
    case "error_confirm":
      return "Ошибка подтверждения пароля";
    case "error_inn_company":
      return "Данный ИНН компании уже существует";
    case "error_ogrn":
      return "ОГРНИП некорректен";
  }
  return "";
}