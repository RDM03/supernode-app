import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:supernodeapp/common/repositories/shared/clients/client.dart';
import 'package:supernodeapp/configs/config.dart';
import 'package:http_parser/http_parser.dart';

import 'dao.dart';

class JiraApi {
  static final String createIssue =
      'https://mxc.atlassian.net/rest/api/2/issue/';
  static String attachment(String issueId) =>
      'https://mxc.atlassian.net/rest/api/2/issue/$issueId/attachments';
}

enum FeedbackType { bug, idea }

class FeedbackParams {
  final String description;
  final String title;
  final FeedbackType type;
  final bool critical;
  FeedbackParams({
    this.description,
    this.title,
    this.type,
    this.critical,
  });

  FeedbackParams copyWith({
    String description,
    String title,
    FeedbackType type,
    bool critical,
  }) {
    return FeedbackParams(
      description: description ?? this.description,
      title: title ?? this.title,
      type: type ?? this.type,
      critical: critical ?? this.critical,
    );
  }

  Map<String, dynamic> toMap() {
    String type;
    switch (this.type) {
      case FeedbackType.bug:
        type = 'Bug';
        break;
      case FeedbackType.idea:
        type = 'Idea';
        break;
    }
    List<String> labels = [];
    if (critical && this.type == FeedbackType.bug) labels.add('critical');
    return {
      'description': description,
      'summary': title,
      'issuetype': {
        'name': type,
      },
      'labels': labels,
    };
  }

  @override
  String toString() {
    return 'FeedbackParams(description: $description, title: $title, type: $type, important: $critical)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is FeedbackParams &&
        o.description == description &&
        o.title == title &&
        o.type == type &&
        o.critical == critical;
  }

  @override
  int get hashCode {
    return description.hashCode ^
        title.hashCode ^
        type.hashCode ^
        critical.hashCode;
  }
}

class JiraDao extends HttpDao {
  JiraDao(HttpClient client) : super(client);

  Future<String> createIssue(FeedbackParams params) async {
    final data = await post(
      url: JiraApi.createIssue,
      data: {
        "fields": {
          ...params.toMap(),
          'project': {'key': Config.JIRA_PROJECT_KEY},
        },
      },
      headers: {
        'Authorization': 'Basic ${Config.JIRA_AUTH}',
        'X-Atlassian-Token': 'no-check',
      },
    );
    if (data['id'] != null) return data['id'];
    throw Exception('Unknown response $data');
  }

  Future<void> addImage(String issueId, Uint8List image) async {
    final data = FormData.fromMap({
      'file': MultipartFile.fromBytes(
        image,
        filename: 'photo_$issueId.png',
        contentType: MediaType.parse('image/png'),
      ),
    });
    await post(
      url: JiraApi.attachment(issueId),
      data: data,
      headers: {
        'Authorization': 'Basic ${Config.JIRA_AUTH}',
        'X-Atlassian-Token': 'no-check',
      },
      encodeJson: false,
    );
  }
}
