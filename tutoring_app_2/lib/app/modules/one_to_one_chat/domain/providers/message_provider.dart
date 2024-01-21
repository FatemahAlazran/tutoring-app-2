import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tutoring_app_2/app/modules/one_to_one_chat/domain/repo/message_repo.dart';

final messagingProvider = Provider<MessagingRepository>((ref) {
  return MessagingRepository();
});
