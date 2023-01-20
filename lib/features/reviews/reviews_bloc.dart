import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_template/features/reviews/model.dart';
import 'package:flutter_bloc_template/features/user/model.dart';

import 'repository.dart';

class MyReviewsBloc extends Bloc<ReviewEvent, ReviewsState> {
  ReviewsRepository repository = ReviewsRepository();
  MyReviewsBloc({
    required UserData userData,
    required String token,
  }) : super(ReviewsInitial()) {
    on<Authorized>(loadUserReviews);
    on<AddReview>(onSendReview);
    add(Authorized(userData: userData, token: token));
  }

  Future<void> loadUserReviews(
    Authorized event,
    Emitter<ReviewsState> emit,
  ) async {
    emit(ReviewsLoading(items: state.items));
    var reviews = await repository.getMyReviews(token: event.token, myUserId: event.userData.id);
    emit(ReviewsUpdated(items: reviews));
  }

  void onSendReview(
    AddReview event,
    Emitter<ReviewsState> emit,
  ) {
    state.items.add(event.item);
    emit(ReviewsUpdated(items: state.items));
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

class ReviewsLoading extends ReviewsState {
  ReviewsLoading({required super.items});
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
  final UserData userData;
  final String token;
  Authorized({
    required this.userData,
    required this.token,
  });
}
