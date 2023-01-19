import 'package:flutter_bloc_template/utils/urls.dart';
import 'package:pocketbase/pocketbase.dart';

import 'model.dart';

class ReviewsRepository {
  RecordService get reviews => pb.collection('reviews');
  Future<List<Review>> getMyReviews({required String token, required String myUserId}) async {
    final resultList = await pb.collection('reviews').getFullList(
          filter: 'author.id >= "$myUserId',
        );
    var list = resultList.map((e) => Review.fromJson(e.id, e.data)).toList();
    return list;
  }
}
