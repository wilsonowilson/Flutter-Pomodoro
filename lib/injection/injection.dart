import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'injection.config.dart';

final getIt = GetIt.instance;

/// Configures Dependency Injection
@InjectableInit(preferRelativeImports: true)
Future<void> configureInjection(String env) async {
  await $initGetIt(getIt, environment: env);
}
