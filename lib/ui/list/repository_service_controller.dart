
import 'dart:collection';

import 'package:sitediary/data_cache/repository_service.dart';

class RepositoryServiceController{

  int pageSize = 15;

  RepositoryServiceController({pageSize : 10});

  final repositoryServiceMap = HashMap<int, RepositoryService>();

  void resetRepositoryService(){
    repositoryServiceMap.forEach((i,service){
      service.clearAll();
    });
  }

  RepositoryService createRepositoryService (Function getDataFunction, int section ){
    final repositoryService = RepositoryService(getDataFunction, pageSize: pageSize, logEnabled: section==41 || section==3);
    repositoryServiceMap[section] = repositoryService;
    //print('reportRepositoryService lenght: ${repositoryServiceMap.length}');

    return repositoryService;
  }
}