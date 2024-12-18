import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'solve_ai_di.config.dart';

final locator = GetIt.instance;

@InjectableInit()
void configureDependencies() => locator.init();
