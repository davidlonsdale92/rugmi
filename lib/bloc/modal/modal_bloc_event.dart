import 'package:equatable/equatable.dart';

abstract class ModalEvent extends Equatable {
  const ModalEvent();

  @override
  List<Object?> get props => [];
}

class ShowModal extends ModalEvent {}

class HideModal extends ModalEvent {}
