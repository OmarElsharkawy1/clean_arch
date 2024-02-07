import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:quotes/core/error/failure.dart';
import 'package:quotes/core/usecases/usecase.dart';
import 'package:quotes/core/utils/app_strings.dart';
import 'package:quotes/features/random_quote/domain/entities/quote.dart';
import 'package:quotes/features/random_quote/domain/usecases/get_random_quote.dart';

part 'random_quote_state.dart';

class RandomQuoteCubit extends Cubit<RandomQuoteState> {
  final GetRandomQuote getRandomQuoteUseCase;

  RandomQuoteCubit({required this.getRandomQuoteUseCase}) : super(RandomQuoteInitial());

  Future<void> getRandomQuote() async {
    emit(RandomQuoteIsLoading());
    Either<Failure, Quote> response = await getRandomQuoteUseCase.call(NoParams());
    emit(response.fold((failure) => RandomQuoteError(errorMsg: _mapFailureToMsg(failure)),
            (quote) =>RandomQuoteLoaded(quote: quote)));
  }
  String _mapFailureToMsg(Failure failure){
    switch(failure.runtimeType){
      case ServerFailure:
        return AppStrings.serverFailure;
      case CacheFailure:
        return AppStrings.serverFailure;
    default:
      return  AppStrings.unexpectedError;
    }
  }
}
