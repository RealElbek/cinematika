// import 'package:bloc_test/bloc_test.dart';
// import 'package:cinematika/home/presentation/manager/search_bloc.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:mocktail/mocktail.dart';
// import 'package:network_image_mock/network_image_mock.dart';
// import 'package:cinematika/home/domain/entities/movie_entity.dart';
// import 'package:cinematika/home/presentation/manager/home_bloc.dart';
// import 'package:cinematika/home/presentation/pages/home_screen.dart';
// import 'package:cinematika/home/presentation/pages/search_screen.dart';
// import 'package:cinematika/home/presentation/widgets/movie_card.dart';
// import 'package:cinematika/home/presentation/widgets/unwatched_movie_card.dart';
// import 'package:get_it/get_it.dart';
//
// class MockHomeBloc extends Mock implements HomeBloc {}
// class MockSearchBloc extends Mock implements SearchBloc {}
// class MockNavigatorObserver extends Mock implements NavigatorObserver {}
// class FakeRoute extends Fake implements Route<dynamic> {}
//
// final GetIt getIt = GetIt.instance;
//
// void main() {
//   late MockHomeBloc mockHomeBloc;
//   late MockSearchBloc mockSearchBloc;
//   late MockNavigatorObserver mockObserver;
//
//   setUpAll(() {
//     registerFallbackValue(FakeRoute());
//   });
//
//   setUp(() {
//     mockHomeBloc = MockHomeBloc();
//     mockSearchBloc = MockSearchBloc();
//     mockObserver = MockNavigatorObserver();
//
//     // Register MockHomeBloc with GetIt
//     getIt.registerFactory<HomeBloc>(() => mockHomeBloc);
//
//     // Mock HomeBloc close method
//     when(() => mockHomeBloc.close()).thenAnswer((_) async => Future.value());
//
//     // Mock SearchBloc close method
//     when(() => mockSearchBloc.close()).thenAnswer((_) async => Future.value());
//
//     // Mock HomeBloc state
//     when(() => mockHomeBloc.state).thenReturn(
//       HomeSuccess(
//         [
//           MovieEntity(
//             id: 1,
//             title: 'Movie 1',
//             posterPath: '/poster1.jpg',
//             genreIds: [28],
//             overview: 'Overview of Movie 1',
//             voteAverage: 5.5,
//           ),
//           MovieEntity(
//             id: 2,
//             title: 'Movie 2',
//             posterPath: '/poster2.jpg',
//             genreIds: [12],
//             overview: 'Overview of Movie 2',
//             voteAverage: 5.5,
//           ),
//         ],
//         [
//           MovieEntity(
//             id: 3,
//             title: 'Movie 3',
//             posterPath: '/poster3.jpg',
//             genreIds: [28],
//             overview: 'Overview of Movie 3',
//             voteAverage: 5.5,
//           ),
//           MovieEntity(
//             id: 4,
//             title: 'Movie 4',
//             posterPath: '/poster4.jpg',
//             genreIds: [14],
//             overview: 'Overview of Movie 4',
//             voteAverage: 5.5,
//           ),
//         ],
//       ),
//     );
//     whenListen(
//       mockHomeBloc,
//       Stream.fromIterable([
//         HomeSuccess(
//           [
//             MovieEntity(
//               id: 1,
//               title: 'Movie 1',
//               posterPath: '/poster1.jpg',
//               genreIds: [28],
//               overview: 'Overview of Movie 1',
//               voteAverage: 5.5,
//             ),
//             MovieEntity(
//               id: 2,
//               title: 'Movie 2',
//               posterPath: '/poster2.jpg',
//               genreIds: [12],
//               overview: 'Overview of Movie 2',
//               voteAverage: 5.5,
//             ),
//           ],
//           [
//             MovieEntity(
//               id: 3,
//               title: 'Movie 3',
//               posterPath: '/poster3.jpg',
//               genreIds: [28],
//               overview: 'Overview of Movie 3',
//               voteAverage: 5.5,
//             ),
//             MovieEntity(
//               id: 4,
//               title: 'Movie 4',
//               posterPath: '/poster4.jpg',
//               genreIds: [14],
//               overview: 'Overview of Movie 4',
//               voteAverage: 5.5,
//             ),
//           ],
//         ),
//       ]),
//     );
//
//     // Mock SearchBloc state
//     when(() => mockSearchBloc.state).thenReturn(SearchInitial());
//     whenListen(mockSearchBloc, Stream.fromIterable([SearchInitial()]));
//   });
//
//   tearDown(() {
//     getIt.reset();
//   });
//
//   group('HomeScreen Widget Tests', () {
//     testWidgets('Key widgets are rendered on HomeScreen', (WidgetTester tester) async {
//       await mockNetworkImagesFor(() async {
//         await tester.pumpWidget(
//           MediaQuery(
//             data: const MediaQueryData(
//
//             ),
//             child: MaterialApp(
//               home: HomeScreen(), // GetIt provides MockHomeBloc
//             ),
//           ),
//         );
//
//         await tester.pumpAndSettle();
//
//         expect(find.byType(AppBar), findsOneWidget);
//         expect(find.byIcon(Icons.search), findsOneWidget);
//         expect(find.text('Movies'), findsOneWidget);
//         expect(find.text('Unwatched'), findsOneWidget);
//         expect(find.byType(UnwatchedMovieCard), findsNWidgets(2));
//         expect(find.text('New movies'), findsOneWidget);
//         expect(find.text('Movie 1'), findsOneWidget);
//         expect(find.text('Movie 2'), findsOneWidget);
//         expect(find.byType(MovieCard), findsNWidgets(2));
//         expect(find.text('Popular movies'), findsOneWidget);
//         expect(find.text('Movie 3'), findsOneWidget);
//         expect(find.text('Movie 4'), findsOneWidget);
//         expect(find.byType(MovieCard), findsNWidgets(4));
//       });
//     });
//
//     testWidgets('Search button navigates to SearchScreen', (WidgetTester tester) async {
//       await mockNetworkImagesFor(() async {
//         await tester.pumpWidget(
//           MediaQuery(
//             data: const MediaQueryData(
//               // Disable animations to prevent pumpAndSettle timeout
//             ),
//             child: MaterialApp(
//               initialRoute: '/',
//               routes: {
//                 '/': (context) => HomeScreen(), // GetIt provides MockHomeBloc
//                 '/search': (context) => BlocProvider.value(
//                   value: mockSearchBloc,
//                   child: SearchScreen(),
//                 ),
//               },
//               navigatorObservers: [mockObserver],
//             ),
//           ),
//         );
//
//         await tester.pumpAndSettle();
//
//         // Reset mock observer to ignore initial route push
//         reset(mockObserver);
//
//         await tester.tap(find.byIcon(Icons.search));
//         await tester.pumpAndSettle();
//
//         expect(find.byType(SearchScreen), findsOneWidget);
//         verify(() => mockObserver.didPush(any(), any())).called(1);
//       });
//     });
//   });
// }