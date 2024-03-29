library conres_app.consts;

import 'dart:ui';

import 'package:conres_app/model/TU.dart';
import 'package:conres_app/model/object_pu.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

//load link
String loadLink = "${domain}lk/load_ticket_addit_file?link=";
String claimLoadLink = "${domain}lk/claim_load?t=1&link=";
String? store_id;
String? user_id;
String? user_inn;
List? cookiesList;
List<ObjectPuModel>? objectsList = []; // полный список объектов
ObjectPuModel? selectedObject; //выбранный объект
List<TuModel>? tuFullList = []; // полный список точек учета
List<TuModel>? tuFromObjectList = []; // список точке учета от объекта

String title = "тестовая компания";
String lkTitle = "Личный кабинет потребителя";
String lkChooseType = "Выберите тип";
String fl = "Физическое лицо";
String ip = "ИП";
String ul = "Юридическое лицо";
String forgotPassword = "Забыли пароль?";
String reg = "Зарегестрироваться";
String regTitle = "Регистрация";
String login = "Войти";
String back = "Вернуться";
String loginAccount = "Войдите в свой аккаунт";
String lkInputText = "Лицевой счёт, телефон, email,  ИНН";
String lkPasswordText = "Пароль";
String repeatPassword = "Повторите пароль";
String clearPassword = "Сбросить пароль";
String inn = "ИНН";
String email = "Email";
String successRed = "Регистрация прошла успешно!";
String sendLogin = "Ваш логин и пароль отправлен Вам на почту";
String next = "Далее";

String family = "Фамилия";
String familyIP = "Фамилия руководителя";
String familyDL = "Фамилия ДЛ";
String name = "Имя";
String nameIP = "Имя руководителя";
String nameDL = "Имя ДЛ";
String patronymic = "Отчество";
String patronymicIP = "Отчество руководителя";
String patronymicDL = "Отчество ДЛ";
String fullNameUL = "Полное наименование компании";
String nameUL = "Сокращённое наименование компании";
String kpp = "КПП";
String telDL = "Телефон  ДЛ";
String emailDL = "Email  ДЛ";

String snils = "СНИЛС";
String ofrnip = "ОГРНИП";
String contacts = "Контакты";
String profile = "Ваш профиль";
String gpINN = "Лицевой счёт ГП";
String needDogovor = "Вам нужно заключить договор";
String emailProfile = "Электронная почта";
String address = "Адрес";
String ls = "Лицевой счет";
String confidant = "Доверенное лицо";

String step1 = "Шаг 1";
String step2 = "Шаг 2";
String step3 = "Шаг 3";

//bottom navigation
String mainPage = "Главная";
String contractsPage = "Договоры";
String reportsPage = "Заявления";
String chatPage = "Обращения";
String moreAction = "Ещё";
//claim
String claimStep1 = "Оформление нового заявления - Шаг 1";
String claimStep2 = "Оформление нового заявления - Шаг 2";
String claimStep3 = "Оформление нового заявления - Шаг 3";
String claimStep4 = "Оформление нового заявления - Шаг 4";
String claimStep5 = "Оформление нового заявления - Шаг 5";
String claimStep6 = "Оформление нового заявления - Шаг 6";
String claimStep7 = "Оформление нового заявления - Шаг 7";
String claimInfo = "Информация о заявителе";
String passportData = "Паспортные данные";
String seriesPassport = "Серия";
String numberPassport = "Номер";
String fio = "ФИО";
String factAddress = "Фактический адрес";
String place = "Кем выдан";
String date = "Дата выдачи";
String claimAdd = "Заявление на присоединение энергопринимающих устройств";
String cause = "В связи с";
String choose = "Выберите причину";
String warning = "Прошу осуществить технологическое присоединение устройств";
String objectName = "Наименование объекта";
String objectAddress = "Адрес объекта";
String cadastrNumber = "Кадастровый номер (необязательно)";
String addObject = "Добавить объект";
String maxPowerWarning =
    "Максимальная мощность энергопринимающих устройств (присоединяемых и ранее присоединенных) составляет";
String maxPower = "Максимальная мощность (всего) на напряжении:";
String kVT = "кВт";
String vt = "Вт";
String previouslyConnectedPower =
    "Ранее присоединенная мощность на напряжении:";
String repeatlyConnectedPower = "Вновь присоединяемая мощность на напряжении:";
String terms =
    "Сроки проектирования и поэтапного введения в эксплуатацию объекта (в том числе по этапам и очередям), планируемое поэтапное распределение максимальной мощности:";
String stage = "Этап (очередь) строительства";
String desighTime =
    "Планируемый срок проектирования энергоприниюмающих устройств(месяц, год)";
String inputTime =
    "Планируемый срок введения энергопринимающих устройств в эксплуатацию(месяц, год)";
String maxPowerDevices =
    "Максимальная мощность энергопринимаю-щих устройств (кВт)";
String reliabilityCategory =
    "Категория надежности энергопринимаю-щих устройств ";
String guaranteeing = "Укажите гарантирующего поставщика и тип договора";
String guaranteeingName = "Наименование Гарантирующего Поставщика";
String contractType = "Тип договора:";
String chooseContract = "Выберите договор";
String addDocuments = "Приложите документы";
//contracts
String contractsTitle = "Договора";
String currentLs = "Текущий ЛС";
String dateAdded = "Дата добавления:";
String underConsideration = "На рассмотрении";
String closed = "Закрытый";
String linkNewLs = "Привязать новый счет";
String newLs = "Новый ЛС";
String numberLS = "Номер лицевого счёта";
String sendLinkRequest = "Отправить запрос на привязку";
String deleteObject = "Удалить объект";
//login
String domain = "https://promo.dev.conres.ru/";
String ws = "wss://promo.dev.conres.ru";
//String protocol = "https://";
int loginType = 2;
//testimony
String sendTestimony = "Передача показаний";
String namePU = "Наименование ПУ";
String numberPU = "Номер ПУ";
String numberPoint = "Номер точки учёта";
String addressPoint = "Адрес точки учёта";
String typePU = "Тип ПУ";
String tarifPU = "Тарифная зона ПУ";
String multi = "Множитель показаний";
String linkPU = "Привязать ПУ";
String linkNewPu = "Привязать новый ПУ";
String addRequest = "Отправить запрос";
String puInfo = "Информация о ПУ";
String editPU = "Редактировать";
String editPuTitle = "Редактировать ПУ";
String testimonyNotFound =
    "По данному лицевому счёту не найдены приборы учёта, отправьте заявку на привязку ПУ и дождитесь подтверждения.";

Color colorMain = const Color(0xFF4574F7);
Color colorGray = const Color(0xFF4F5A6E);
Color colorGrayClaim = const Color(0xFF9B9BAE);
Color colorGrayText = const Color(0xFF4F5A6E);
Color inputBorder = Color.fromARGB(255, 199, 199, 206);
Color defaultBackground = const Color(0xFFFFFFFF);
Color colorLogo = const Color(0xFFE7EEFE);
Color profileColor = const Color(0xFFFDFDFF);
Color borderProfileColor = const Color(0xFFCBD4F5);
Color profileLabelColor = const Color(0xFFA3A5BC);
Color contractBtnColor = const Color(0xFFE4ECFE);
Color lsButtonColor = const Color(0xFfE8EDFF);
Color meterDataColor = const Color(0xFF606a7c);
Color whiteGrayColor = const Color(0xFFa7adb7);
Color redColor = const Color(0xFFE63757);
Color claimLabelColor = const Color(0xFFa7acb7);
Color yellowColor = const Color(0xFFFFAE34);
Color greenColor = const Color(0xFF28b938);
Color yellowStatusColor = const Color(0xFFFDE7C6);
Color whiteBlueColor = const Color(0xFFE4EAFF);
Color whiteLabelColor = const Color(0xFFA3A5BC);
Color dashedColor = const Color(0xFF4E648A);
Color messageColor = const Color(0xFFECF2FE);
Color pageColor = const Color(0xFFF4F5FA);

/* Стили */

TextStyle claimTextStyle =
    TextStyle(color: colorMain, fontSize: 18.0, fontFamily: 'Bubicon-Bold');
TextStyle labelTextStyle = TextStyle(color: colorGrayText, fontSize: 16.0);
TextStyle buttonTextStyle = const TextStyle(fontSize: 18.0);
TextStyle profileHeaderTextStyle =
    const TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold);
TextStyle warningTextStyle = TextStyle(fontSize: 16.0, color: whiteGrayColor);
TextStyle contractLabelTextStyle =
    const TextStyle(fontSize: 14.0, color: Colors.white);
TextStyle claimLabelTextStyle =
    TextStyle(fontSize: 16.0, color: claimLabelColor);
TextStyle puTextStyle = TextStyle(fontSize: 13.0, color: whiteLabelColor);

double defaultSidePadding = 17;

BorderRadius buttonRadius = BorderRadius.circular(10);
