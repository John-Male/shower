import 'package:drift/drift.dart';
import 'package:drift/web.dart';

QueryExecutor createQueryExecutor() {
  return WebDatabase('shower_master_web', logStatements: true);
}
