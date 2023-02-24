import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ricky_morty/common/app_colors.dart';
import 'package:ricky_morty/features/presentation/bloc/person_list_cubit/person_list_cubit.dart';
import 'package:ricky_morty/features/presentation/bloc/seearch_bloc/search_bloc.dart';
import 'package:ricky_morty/locator_service.dart' as di;

import 'features/presentation/pages/home_page.dart';
import 'locator_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widges is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider<PersonListCubit>(create: (_)=> sl<PersonListCubit>()..loadPerson()),
      BlocProvider<SearchBloc>(create: (_)=>sl<SearchBloc>()),

    ], child: MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        scaffoldBackgroundColor : AppColors.mainBackGround,
      backgroundColor : AppColors.callBackGround,
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    ));
  }
}
