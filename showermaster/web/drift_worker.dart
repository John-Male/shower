import 'package:drift/drift.dart';
import 'package:drift/remote.dart';
import 'package:drift/web/workers.dart';

void main() {
  startRemoteWorker(() => DatabaseConnection.delayed(Future.sync(() {
    return DatabaseConnection.fromExecutor(
      WebWorkerDatabase.workerExecutor(),
    );
  })));
}