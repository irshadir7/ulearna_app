import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

import '../data/datasources/video_remote_data_source.dart';
import '../data/repositories/video_repository.dart';
import '../data/repositories/video_repository_impl.dart';
import '../domain/usecases/get_videos.dart';
import '../presentation/bloc/video_bloc.dart';

final injector = GetIt.instance;

Future<void> setupInjector() async {
  injector.registerLazySingleton<http.Client>(() => http.Client());

  injector.registerLazySingleton<VideoRemoteDataSource>(
          () => VideoRemoteDataSourceImpl(client: injector()));

  injector.registerLazySingleton<VideoRepository>(
          () => VideoRepositoryImpl(remoteDataSource: injector()));

  injector.registerLazySingleton(() => GetVideos(repository: injector()));

  injector.registerFactory(() => VideoBloc(getVideos: injector()));
}
