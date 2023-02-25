import 'dart:async';import 'package:bloc/bloc.dart';import 'package:equatable/equatable.dart';import 'package:ricky_morty/core/error/failure.dart';import '../../../domain/entities/person_entity.dart';import '../../../domain/usecases/search_person.dart';part 'search_event.dart';part 'search_state.dart';class SearchBloc extends Bloc<SearchEvent, SearchState> {  final SearchPerson searchPerson;  SearchBloc(this.searchPerson) : super(const SearchState()) {    on<SearchPersonsEvent>((event, emit) async {      emit(state.copyWith(status: SearchStatus.loading));      final failureOrPerson = await searchPerson(SearchPersonParams(query: event.personQuery));      emit(failureOrPerson.fold(          (failure) => state.copyWith(status: SearchStatus.failure, errorMessage: _mapFailure(failure)),          (person) => state.copyWith(status: SearchStatus.loaded, person: person)));    });  }  String _mapFailure(Failure failure) {    switch (failure.runtimeType) {      case ServerFailure:        return "ServerFailure";      case CacheFailure:        return "Cache Failure";      default:        return "UnExpected Failure";    }  }}