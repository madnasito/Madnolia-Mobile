import 'package:flutter/material.dart';
import 'package:drift_db_viewer/drift_db_viewer.dart';

import '../../database/repository_manager.dart';

class PageDatabase extends StatelessWidget {
  const PageDatabase({super.key});

  @override
  Widget build(BuildContext context) {
    final databaseRepository = RepositoryManager();
    return DriftDbViewer(databaseRepository.database);
  }
}
