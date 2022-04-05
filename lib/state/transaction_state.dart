part of '../cubit/transaction_cubit.dart';

abstract class TransactionState extends Equatable {
  const TransactionState();

  @override
  List<Object> get props => [];
}

class TransactionInitial extends TransactionState {}

class TransactionLoaded extends TransactionState {
  final List<Transaction> transactions;

  TransactionLoaded(this.transactions);

  @override
  List<Object> get props => [transactions];
}

class TransactionLoadingFailed extends TransactionState {
  final String message;

  TransactionLoadingFailed(this.message);

  @override
  List<Object> get props => [message];
}

class TransactionSubmitted extends TransactionState {
  final Transaction transaction;

  TransactionSubmitted(this.transaction);

  @override
  List<Object> get props => [transaction];
}

class TransactionSubmitFailed extends TransactionState {
  final String message;

  TransactionSubmitFailed(this.message);

  @override
  List<Object> get props => [message];
}
class TransactionConfirmed extends TransactionState {
  final Transaction transaction;

  TransactionConfirmed(this.transaction);

  @override
  List<Object> get props => [transaction];
}

class TransactionConfirmFailed extends TransactionState {
  final String message;

  TransactionConfirmFailed(this.message);

  @override
  List<Object> get props => [message];
}
