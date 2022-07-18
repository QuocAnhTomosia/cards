part of 'cards_searching_bloc.dart';

@immutable
abstract class CardsSearchingEvent extends Equatable {
  const CardsSearchingEvent();
  
}

class CardSearchingStarted extends CardsSearchingEvent
{
   @override
  List<Object> get props => [];
}
class CardSearchingSubmit extends CardsSearchingEvent {
  final String name;
  const CardSearchingSubmit({
    required this.name,
  });
   @override
  List<Object> get props => [];
}
