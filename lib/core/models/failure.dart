import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;

  const Failure(this.message, [List props = const[]]) : super();
}

class CommonFailure extends Failure {
  const CommonFailure(String message) : super(message);

  @override
  List<Object?> get props => throw UnimplementedError();
}