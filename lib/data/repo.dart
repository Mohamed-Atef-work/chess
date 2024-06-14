import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:chess/data/model.dart';
import 'package:chess/utils/constants/strings.dart';

abstract class ChessRepo {
  Future<void> uploadMove(MoveModel model, String onMe);
  Stream<MoveModel> movesStream(String opponent);
}

class ChessRepoImpl implements ChessRepo {
  final FirebaseFirestore _store = FirebaseFirestore.instance;

  @override
  Stream<MoveModel> movesStream(String opponent) {
    final response = _store.collection(Strings.chess).doc(opponent).snapshots();
    final modelSteam =
        response.map((event) => MoveModel.fromJson(event.data()!));
    return modelSteam;
  }

  @override
  Future<void> uploadMove(MoveModel model, String onMe) async {
    await _store.collection(Strings.chess).doc(onMe).set(model.toMap());
  }
}
