import 'dart:typed_data';

import 'package:supernodeapp/common/repositories/shared/clients/shared_client.dart';
import 'package:supernodeapp/common/repositories/shared/dao/jira_dao.dart';

class JiraRepository {
  final JiraDao _dao = JiraDao(SharedHttpClient());

  Future<String> createIssue(FeedbackParams params) {
    return _dao.createIssue(params);
  }

  Future<void> addImage(String issueId, Uint8List image) async {
    return _dao.addImage(issueId, image);
  }
}
