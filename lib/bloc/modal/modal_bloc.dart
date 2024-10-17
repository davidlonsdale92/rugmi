import 'package:flutter_bloc/flutter_bloc.dart';
import 'modal_bloc_event.dart';
import 'modal_bloc_state.dart';

class ModalBloc extends Bloc<ModalEvent, ModalState> {
  ModalBloc() : super(ModalHidden()) {
    on<ShowModal>(_onShowModal);
    on<HideModal>(_onHideModal);
  }

  void _onShowModal(ShowModal event, Emitter<ModalState> emit) {
    emit(ModalVisible());
  }

  void _onHideModal(HideModal event, Emitter<ModalState> emit) {
    emit(ModalHidden());
  }
}
