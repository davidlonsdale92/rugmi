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
  final String message;

  const ModalError(this.message);

  @override
  List<Object?> get props => [message];
}
