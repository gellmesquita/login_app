import 'package:flutter_modular/flutter_modular.dart';
import 'package:login_app/domain/services/navigation_service.dart';
import 'package:login_app/application/resources/app_routes.dart' as Routes;

class NavigationServiceImp implements NavigationService{
  @override
  void navigateToLogin() {
    Modular.to.navigate(Routes.loginRoute);
  }
  
  @override
  void navigateToActivies() {
    Modular.to.navigate(Routes.activityRoute);
  }
  
  @override
  void navigateToBack() {
    Modular.to.pop();
  }
  
  @override
  void navigateToProfile() {
    Modular.to.navigate(Routes.profileRoute);
  }

}