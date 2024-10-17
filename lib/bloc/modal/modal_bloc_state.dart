import 'package:equatable/equatable.dart';

abstract class ModalState extends Equatable {
  const ModalState();

  @override
  List<Object?> get props => [];
}

class ModalHidden extends ModalState {}

class ModalLoading extends ModalState {}

class ModalVisible extends ModalState {}

class ModalError extends ModalState {
  const ModalError(this.message);
  final String message;

  @override
  List<Object?> get props => [message];
}
