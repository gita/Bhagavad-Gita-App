import 'package:bhagavad_gita/services/navigator_service.dart';
import 'package:get_it/get_it.dart';

final locator = GetIt.instance;

setupServiceLocator() {
  locator.registerLazySingleton(() => NavigationService());
}
