import '../../../utils/urls.dart';
import 'tizer.dart';

class TizerRepository {
  Future<List<TizerInfo>> loadTizersData() async {
    final response = await pb.collection('tizers').getFullList();
    var promotions =
        response.map((recordModel) => TizerInfo.fromJson(recordModel.id, recordModel.data)).toList();
    return promotions;
  }
}
