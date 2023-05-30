import 'package:get_it/get_it.dart';
import 'package:github_painter/services/convert.dart';

import 'cubit/grid_cubit.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Bloc/Cubit
  sl.registerFactory(() => GridCubit());

  // Services
  sl.registerLazySingleton<ConvertService>(() => ConvertService());
}
