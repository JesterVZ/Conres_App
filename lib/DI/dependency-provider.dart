import 'package:conres_app/bloc/auth/auth-block.dart';
import 'package:conres_app/http.dart';
import 'package:conres_app/repositories/auth-repo.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: must_be_immutable
class DependencyProvider extends InheritedWidget{
  HttpClient? _httpClient;
  AuthBloc? _authBloc;
  AuthRepo? _authRepo;
  SharedPreferences? _sharedPreferences;

  DependencyProvider({Key? key, Widget? child})
      : assert(child != null),
        super(key: key, child: child!);

  Future<SharedPreferences> get sharedPreferences async{
    _sharedPreferences ??= await SharedPreferences.getInstance();
    return _sharedPreferences!;
  }

  HttpClient get httpClient {
    _httpClient ??= HttpClient();
    return _httpClient!;
  }

  AuthRepo get authRepo {
    _authRepo ??= AuthRepo(httpClient: httpClient);
    return _authRepo!;
  }

  AuthBloc get authBloc {
    _authBloc ??= AuthBloc(authRepo);
    return _authBloc!;
  }


  static DependencyProvider? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<DependencyProvider>();
  }


  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => true;
}