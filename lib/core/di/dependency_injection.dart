import 'package:get_it/get_it.dart';
import '../networking/api_service.dart';
import '../../features/home/data/repos/home_repo_impl.dart';
import '../../features/home/domain/repos/home_repo.dart';
import '../../features/home/presentation/logic/home_cubit.dart';

final getIt = GetIt.instance;

Future<void> setupGetIt() async {
  // Networking
  getIt.registerLazySingleton<ApiService>(() => ApiService());

  // Home Feature
  getIt.registerLazySingleton<HomeRepo>(() => HomeRepoImpl(getIt<ApiService>()));
  getIt.registerFactory<HomeCubit>(() => HomeCubit(getIt<HomeRepo>()));
}
