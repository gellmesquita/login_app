import 'package:flutter_modular/flutter_modular.dart';
import 'package:login_app/application/resources/app_routes.dart' as Routes;
import 'package:login_app/data/repositories/login_repository_imp.dart';
import 'package:login_app/data/webservices/implementation/login_webservice_imp.dart';
import 'package:login_app/data/webservices/login_webservice.dart';
import 'package:login_app/data/webservices/test/login_webservice_test.dart';
import 'package:login_app/domain/repositories/login_repository.dart';
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
    i.add<LoginWebservice>(_testMode ? LoginWebserviceTest.new : LoginWebserviceImp.new);
  }

  static controllerDependencies(Injector i){
    i.add(LoginController.new);
    i.add(InformationCaptureController.new);
  }

  static repositoryDependencies(Injector i){
    i.add<LoginRepository>(LoginRepositoryImp.new);
  }

}