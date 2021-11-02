import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:videotutorial/apiservice/apiservice.dart';
import 'package:videotutorial/model/LoginModel.dart';
import 'package:videotutorial/model/UnAuthorizedModel.dart';


part 'login_state.dart';
part 'login_event.dart';

class LoginBloc extends Bloc<LoginEvent,LoginState>{

  ApiService apiservices = ApiService();
  LoginModel _loginModel;
  UnAuthorizedModel _unAuthorizedModel;
  @override
  LoginState get initialState => LoginInitial();


  @override
  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async*{
    if(event is FetchLoginInfo){
      yield checkingLogin();
      var apiCallBackModel = await apiservices.UserLogin(event.username,event.password);
      if(apiCallBackModel is LoginModel){
        _loginModel = apiCallBackModel;
        yield LoginInOperationSuccess(apiCallBackModel);
      }
      else if (apiCallBackModel is UnAuthorizedModel){
        _unAuthorizedModel = apiCallBackModel;
        yield LoginFailed(apiCallBackModel);
        print(_unAuthorizedModel);
      }
      print(_loginModel);
    }
  }
}