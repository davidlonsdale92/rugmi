import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rugmi/bloc/modal/modal_bloc.dart';
import 'package:rugmi/bloc/modal/modal_bloc_event.dart';
import 'package:rugmi/bloc/modal/modal_bloc_state.dart';

void main() {
  group('ModalBloc', () {
    test('initial state is ModalHidden', () {
      final modalBloc = ModalBloc();
      expect(modalBloc.state, ModalHidden());
    });

    blocTest<ModalBloc, ModalState>(
      'emits [ModalVisible] when ShowModal is added',
      build: ModalBloc.new,
      act: (bloc) => bloc.add(ShowModal()),
      expect: () => [ModalVisible()],
    );

    blocTest<ModalBloc, ModalState>(
      'emits [ModalHidden] when HideModal is added',
      build: ModalBloc.new,
      act: (bloc) => bloc.add(HideModal()),
      expect: () => [ModalHidden()],
    );
  });
}
