
import 'package:dart_application/application/config/database_connection_configuration.dart';
import 'package:dart_application/application/config/service_locator_config.dart';
import 'package:dart_application/application/logger/i_logger.dart';
import 'package:dart_application/application/logger/logger.dart';
import 'package:dart_application/application/routers/router_configure.dart';
import 'package:dotenv/dotenv.dart' show load, env;
import 'package:get_it/get_it.dart';
import 'package:shelf_router/shelf_router.dart';

class ApplicationConfig {
  
  //static final env = DotEnv(includePlatformEnvironment: true)..load();

  Future<void> loadConfigApplication(Router router) async {
    await _loadEnv();
    _loadDatabaseConfig();
    _configLogger();
    _loadDependencies();
    _loadRoutersconfigure(router);
  }

  Future<void> _loadEnv() async => load();

  void _loadDatabaseConfig(){
    final databaseConfig = DatabaseConnectionConfiguration(
      host: env['DATABASE_HOST'] ?? env['databaseHost']!, 
      user: env['DATABASE_USER'] ?? env['databaseUser']!, 
      port: int.tryParse(env['DATABASE_PORT'] ?? env['databasePort']!) ?? 0, 
      password: env['DATABASE_PASSWORD'] ?? env['databasePassword']!, 
      databaseName: env['DATABASE_NAME'] ?? env['databaseName']!,
    );
    GetIt.I.registerSingleton(databaseConfig);
  }

  void _configLogger() => GetIt.I.registerLazySingleton<ILogger>(() => Logger());
  
  void _loadDependencies() => configureDependencies();
  
  void _loadRoutersconfigure(Router router) => RouterConfigure(router).configure();

}


// import 'package:dart_application/application/config/database_connection_configuration.dart';
// import 'package:dart_application/application/config/service_locator_config.dart';
// import 'package:dart_application/application/logger/i_logger.dart';
// import 'package:dart_application/application/logger/logger.dart';
// import 'package:dart_application/application/routers/router_configure.dart';
// import 'package:dotenv/dotenv.dart';
// import 'package:get_it/get_it.dart';
// import 'package:shelf_router/shelf_router.dart';

// class ApplicationConfig {

//    late final DotEnv _env;

//   Future<void> loadConfigApplication(Router router) async {
//     _env = await _loadEnv();
//     _loadDatabaseConfig();
//     _configLogger();
//     _loadDependencies();
//     _loadRoutersconfigure(router);
//   }

//   Future<DotEnv> _loadEnv() async => DotEnv(includePlatformEnvironment: true)..load();

//   void _loadDatabaseConfig(){
//     final databaseConfig = DatabaseConnectionConfiguration(
//       host: _env['DATABASE_HOST'] ?? _env['databaseHost']!, 
//       user: _env['DATABASE_USER'] ?? _env['databaseUser']!, 
//       port: int.tryParse(_env['DATABASE_PORT'] ?? _env['databasePort']!) ?? 0, 
//       password: _env['DATABASE_PASSWORD'] ?? _env['databasePassword']!, 
//       databaseName: _env['DATABASE_NAME'] ?? _env['databaseName']!,
//     );
//     GetIt.I.registerSingleton(databaseConfig);
//   }

//   void _configLogger() => GetIt.I.registerLazySingleton<ILogger>(() => Logger());
  
//   void _loadDependencies() => configureDependencies();
  
//   void _loadRoutersconfigure(Router router) => RouterConfigure(router).configure();

//   DotEnv get env => _env;

// }