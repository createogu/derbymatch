import 'package:derbymatch/features/community/models/reply_model.dart';
import 'package:derbymatch/features/community/repositorys/reply_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final replyControllerProvider =
    StateNotifierProvider.family<ReplyController, ReplyDetailState, int>(
        (ref, reply_id) {
  final replyRepository = ref.watch(replyRepositoryProvider);
  return ReplyController(replyRepository: replyRepository, reply_id: reply_id);
});

class ReplyController extends StateNotifier<ReplyDetailState> {
  final ReplyRepository replyRepository;
  final int reply_id;

  ReplyController({required this.replyRepository, required this.reply_id})
      : super(ReplyDetailState());

  Future<void> fetchReplyDetail() async {
    try {
      final reply = await replyRepository.getReplyDetail(reply_id);
      state = ReplyDetailState(reply: reply);
    } catch (e) {
      state = ReplyDetailState(errorMessage: e.toString());
    }
  }

  Future<bool> updateReply(ReplyModel updatedReply) async {
    try {
      final result =
          await replyRepository.editReplyModel(replyModel: updatedReply);
      state = ReplyDetailState(reply: result);
      return true;
    } catch (e) {
      state = ReplyDetailState(errorMessage: e.toString());
      return false;
    }
  }

  Future<bool> toggleLike() async {
    try {
      await replyRepository.replyToggleLike(reply_id: reply_id);

      state = ReplyDetailState(
        reply: state.reply?.copyWith(
          is_like: !state.reply!.is_like,
          like_cnt: !state.reply!.is_like == true
              ? state.reply!.like_cnt + 1
              : state.reply!.like_cnt - 1,
        ),
      );
      return true;
    } catch (e) {
      state = ReplyDetailState(errorMessage: e.toString());
      return false;
    }
  }
}

class ReplyDetailState {
  final ReplyModel? reply;
  final String? errorMessage;

  ReplyDetailState({this.reply, this.errorMessage});
}
