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
  }
  return "";
}