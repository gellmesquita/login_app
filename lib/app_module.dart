import 'package:flutter_modular/flutter_modular.dart';
import 'package:login_app/application/resources/app_routes.dart' as Routes;
import 'package:login_app/application/usecases/user_use_case_imp.dart';
import 'package:login_app/data/datasources/local/preferences/activity_preferences.dart';
import 'package:login_app/data/datasources/local/preferences/user_preferences.dart';
import 'package:login_app/data/repositories/activity_repository_imp.dart';
import 'package:login_app/data/repositories/user_repository_imp.dart';
import 'package:login_app/data/webservices/implementation/user_webservice_imp.dart';
import 'package:login_app/data/webservices/user_webservice.dart';
import 'package:login_app/data/webservices/test/login_webservice_test.dart';
import 'package:login_app/domain/repositories/activity_repository.dart';
import 'package:login_app/domain/repositories/user_repository.dart';
import 'package:login_app/domain/usecases/user_use_case.dart';
import 'package:login_app/presenter/controllers/information_capture_controller.dart';
import 'package:login_app/presenter/controllers/login_controller.dart';
import 'package:login_app/presenter/views/information_capture_view.dart';
import 'package:login_app/presenter/views/login_view.dart';

class AppModule extends Module{
 
  @override
  void binds(i) {
    AppDependencies.controllerDependencies(i);
    AppDependencies.repositoryDependencies(i);
    AppDependencies.webServiceDependencies(i);
    AppDependencies.useCaseDependencies(i);
    AppDependencies.preferencesDependencies(i);
  }

  @override
  void routes(r) {
    r.child(
      Routes.loginRoute, 
      child: (context) => LoginView(controller: Modular.get()),
      transition: TransitionType.rightToLeft,
    );
    r.child(
      Routes.activityRoute, 
      child: (context) => InformationCaptureView(controller: Modular.get()),
      transition: TransitionType.rightToLeft,
    );
  }
  
}

class AppDependencies {
  static bool get _testMode => true;

  static webServiceDependencies(Injector i){
    i.add<UserWebservice>(_testMode ? UserWebserviceTest.new : UserWebserviceImp.new);
  }

  static controllerDependencies(Injector i){
    i.add(LoginController.new);
    i.add(InformationCaptureController.new);
  }

  static preferencesDependencies(Injector i){
    i.add(UserPreferences.new);
    i.add(ActivityPreferences.new);
  }

  static repositoryDependencies(Injector i){
    i.add<UserRepository>(UserRepositoryImp.new);
    i.add<ActivityRepository>(ActvityRepositoryImp.new);
  }

  static useCaseDependencies(Injector i){
    i.add<UserUseCase>(UserUseCaseImp.new);
  }

}