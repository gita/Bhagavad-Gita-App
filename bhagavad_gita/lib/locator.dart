import 'package:bhagavad_gita/services/last_read_services.dart';
import 'package:bhagavad_gita/services/navigator_service.dart';
import 'package:bhagavad_gita/services/shared_preferences.dart';
import 'package:get_it/get_it.dart';

final locator = GetIt.instance;

setupServiceLocator() {
  locator.registerLazySingleton(() => NavigationService());
  locator.registerLazySingleton(() => SharedPref());
  locator.registerLazySingleton(() => LastReadVerseService());
}
