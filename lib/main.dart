import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'di/injector.dart';
import 'presentation/bloc/video_bloc.dart';
import 'presentation/screens/reels_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupInjector();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      home: BlocProvider(
        create: (_) => injector<VideoBloc>()..add(const FetchVideosEvent(page: 1, limit: 10)),
        child: const ReelsPage(),
      ),
    );
  }
}
