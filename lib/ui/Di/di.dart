import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'di.config.dart'; // this must be generated with build_runner

final getIt = GetIt.instance;

@injectableInit
Future<void> configureDependencies() async {
  await getIt.init(); // do NOT return this directly without await

}

