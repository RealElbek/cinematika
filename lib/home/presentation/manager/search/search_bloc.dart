import 'package:cinematika/home/presentation/manager/search/search_event.dart';
import 'package:cinematika/home/presentation/manager/search/search_state.dart';
import '../../../domain/use_cases/search_movies_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final SearchMoviesUseCase _searchMoviesUseCase;

  SearchBloc(this._searchMoviesUseCase) : super(SearchInitial()) {
    on<SearchQueryChanged>((event, emit) async {
      if (event.query.length > 1) {
        emit(SearchLoading());
        try {
          final movies = await _searchMoviesUseCase.execute(event.query);
          emit(SearchSuccess(movies));
        } catch (e) {
          emit(SearchError('Failed to load search results'));
        }
      } else {
        emit(SearchInitial());
      }
    });
  }
}