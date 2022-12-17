import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_template/features/reviews/model.dart';

class ReviewsBloc extends Bloc<ReviewEvent, ReviewsState> {
  ReviewsBloc() : super(ReviewsInitial()) {
    on<AddReview>(onReviewAdded);
    on<Authorized>(loadUserReviews);
  }

  void onReviewAdded(
    AddReview event,
    Emitter<ReviewsState> emit,
  ) {
    state.items.add(event.item);
    emit(ReviewsUpdated(items: state.items));
  }

  void loadUserReviews(
    Authorized event,
    Emitter<ReviewsState> emit,
  ) {
    List<Review> reviews = [];
    emit(ReviewsUpdated(items: reviews));
  }
}

/* ---  States   --- */
abstract class ReviewsState {
  final List<Review> items;

  ReviewsState({required this.items});
}

class ReviewsInitial extends ReviewsState {
  ReviewsInitial() : super(items: []);
}

class ReviewsUpdated extends ReviewsState {
  ReviewsUpdated({required super.items});
}

/* ---  Events   --- */

abstract class ReviewEvent {
  const ReviewEvent();
}

class AddReview extends ReviewEvent {
  Review item;
  AddReview({required this.item});
}

class Authorized extends ReviewEvent {
  Authorized();
}
