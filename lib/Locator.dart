import 'package:meby/services/dynamic_links/dynamic_link_service.dart';
import 'package:meby/services/navigation_service.dart';
import 'package:get_it/get_it.dart';
import 'package:meby/util/Api.dart';
import 'package:meby/util/UsuarioCRUD.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => Api('usuarios'));
  locator.registerLazySingleton(() => UsuarioCRUD());
  locator.registerLazySingleton(() => DynamicLinkService());
  locator.registerLazySingleton(() => NavigationService());
}
