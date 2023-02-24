import 'package:get_it/get_it.dart';import 'package:http/http.dart';import 'package:internet_connection_checker/internet_connection_checker.dart';import 'package:ricky_morty/core/platform/network_info.dart';import 'package:ricky_morty/features/data/datasources/person_remote_data_source.dart';import 'package:ricky_morty/features/data/repositores/person_repository_impl.dart';import 'package:ricky_morty/features/domain/repository/person_repository.dart';import 'package:ricky_morty/features/domain/usecases/get_all_persons.dart';import 'package:ricky_morty/features/presentation/bloc/person_list_cubit/person_list_cubit.dart';import 'package:ricky_morty/features/presentation/bloc/seearch_bloc/search_bloc.dart';import 'package:shared_preferences/shared_preferences.dart';import 'features/domain/usecases/search_person.dart';final sl = GetIt.instance;Future<void> init() async{  //Bloc  sl.registerFactory(() => PersonListCubit(getAllPersons: sl()));  sl.registerFactory(() => SearchPersonsEvent(sl()));  //Usecase  sl.registerLazySingleton(() => GetAllPersons(personRepository: sl()));  sl.registerLazySingleton(() => SearchPerson(personRepository: sl()));  //Repository  sl.registerLazySingleton<PersonRepository>(      () => PersonRepositoryImpl(remoteDataSource: sl(), localDataSource: sl(), networkInfo: sl()));  sl.registerLazySingleton<PersonRemoteDataSource>(() => PersonRemoteDataSourceImpl(client: Client()));  //Core  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));  //External  final sharedPreferences = await SharedPreferences.getInstance();  sl.registerLazySingleton(()=>sharedPreferences);  sl.registerLazySingleton(() => Client());  sl.registerLazySingleton(() => InternetConnectionChecker());}