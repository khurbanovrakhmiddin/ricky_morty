part of 'search_bloc.dart';abstract class SearchEvent extends Equatable {  const SearchEvent();  @override  List<Object?> get props => [];}class SearchPersonsEvent extends SearchEvent{  final String personQuery; const SearchPersonsEvent(this.personQuery);}