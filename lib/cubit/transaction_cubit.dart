import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tumbaspedia/models/models.dart';
import 'package:tumbaspedia/services/services.dart';

part '../state/transaction_state.dart';

class TransactionCubit extends Cubit<TransactionState> {
  TransactionCubit() : super(TransactionInitial());

  Future<void> getTransactions(int limit) async {
    ApiReturnValue<List<Transaction>> result =
        await TransactionServices.getTransactions(limit);

    print(result.value);
    if (result.value != null) {
      emit(TransactionLoaded(result.value));
    } else {
      emit(TransactionLoadingFailed(result.message));
    }
  }

  Future<Transaction> submitTransaction(Transaction transaction) async {
    ApiReturnValue<Transaction> result =
        await TransactionServices.submitTransaction(transaction);

    if (result.value != null) {
      emit(TransactionSubmitted(result.value));
      return result.value;
    } else {
      emit(TransactionSubmitFailed(result.message));
      return null;
    }
  }

  Future<Transaction> confirmDelivered(Transaction transaction) async {
    ApiReturnValue<Transaction> result =
        await TransactionServices.confirmDelivered(transaction);

    if (result.value != null) {
      emit(TransactionConfirmed(result.value));
      return result.value;
    } else {
      emit(TransactionConfirmFailed(result.message));
      return null;
    }
  }
}
