import 'package:supernodeapp/common/repositories/shared/dao/dao.dart';
import 'package:supernodeapp/common/repositories/supernode/clients/supernode_client.dart';

class SupernodeDao extends HttpDao {
  SupernodeDao(SupernodeHttpClient client) : super(client);
}
