// import 'package:flutter_test/flutter_test.dart';
// import 'package:bloc_test/bloc_test.dart';
// import 'package:mockito/mockito.dart';
// import 'package:mocktail/mocktail.dart';
// import 'package:rugmi/bloc/favourites/favourites_bloc.dart';
// import 'package:rugmi/bloc/favourites/favourites_bloc_event.dart';
// import 'package:rugmi/bloc/favourites/favourites_bloc_state.dart';
// import 'package:rugmi/services/hive_init.dart';

// class MockHiveRepo extends Mock implements HiveRepo {}

// void main() {
//   group('FavouritesBloc', () {
//     late MockHiveRepo mockHiveRepo;

//     setUp(() {
//       mockHiveRepo = MockHiveRepo();
//     });

//     // Test initial state is FavouritesLoading
//     test('initial state is FavouritesLoading', () {
//       final favouritesBloc = FavouritesBloc();
//       expect(favouritesBloc.state, FavouritesLoading());
//     });

//     // Test when LoadFavourites is added and Hive has items
//     blocTest<FavouritesBloc, FavouritesState>(
//       'emits [FavouritesLoaded] when LoadFavourites is added and Hive has items',
//       build: () {
//         when(mockHiveRepo.getItems(HiveRepo.favouritesBox) as Function())
//             .thenReturn(['item1']);
//         return FavouritesBloc();
//       },
//       act: (bloc) => bloc.add(LoadFavourites()),
//       expect: () => [
//         FavouritesLoaded(['item1'])
//       ],
//     );

//     // Test when LoadFavourites is added and Hive is empty
//     blocTest<FavouritesBloc, FavouritesState>(
//       'emits [FavouritesEmpty] when LoadFavourites is added and Hive is empty',
//       build: () {
//         when(mockHiveRepo.getItems(HiveRepo.favouritesBox) as Function())
//             .thenReturn([]);
//         return FavouritesBloc();
//       },
//       act: (bloc) => bloc.add(LoadFavourites()),
//       expect: () => [FavouritesEmpty()],
//     );

//     // Test when ClearFavourites is added
//     blocTest<FavouritesBloc, FavouritesState>(
//       'emits [FavouritesEmpty] when ClearFavourites is added',
//       build: () {
//         when(mockHiveRepo.clearBox(HiveRepo.favouritesBox) as Function())
//             .thenAnswer((_) async => {});
//         return FavouritesBloc();
//       },
//       act: (bloc) => bloc.add(ClearFavourites()),
//       expect: () => [FavouritesEmpty()],
//     );

//     // Test when AddFavourite is added
//     blocTest<FavouritesBloc, FavouritesState>(
//       'emits [FavouritesLoaded] when AddFavourite is added',
//       build: () {
//         when(mockHiveRepo.addItem(HiveRepo.favouritesBox, any) as Function())
//             .thenAnswer((_) async => {});
//         when(mockHiveRepo.getItems(HiveRepo.favouritesBox) as Function())
//             .thenReturn(['item1', 'item2']);
//         return FavouritesBloc();
//       },
//       act: (bloc) => bloc.add(AddFavourite('imageId', {'imageUrl': 'item2'})),
//       expect: () => [
//         FavouritesLoaded(['item1', 'item2'])
//       ],
//     );

//     // Test when RemoveFavourite is added
//     blocTest<FavouritesBloc, FavouritesState>(
//       'emits [FavouritesLoaded] when RemoveFavourite is added',
//       build: () {
//         when(mockHiveRepo.getItems(HiveRepo.favouritesBox) as Function())
//             .thenReturn([
//           {'imageUrl': 'item1'},
//           {'imageUrl': 'item2'}
//         ]);
//         when(mockHiveRepo.removeItem(HiveRepo.favouritesBox, 1) as Function())
//             .thenAnswer((_) async => {});
//         return FavouritesBloc();
//       },
//       act: (bloc) => bloc.add(RemoveFavourite('item2')),
//       expect: () => [
//         FavouritesLoaded([
//           {'imageUrl': 'item1'}
//         ])
//       ],
//     );
//   });
// }
