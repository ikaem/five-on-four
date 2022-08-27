import 'package:five_on_four/services/database/constants.dart';

class QueryOptions {
  List<String>? columns;
  bool? distinct;
  String? groupBy;
  String? having;
  int? limit;
  int? offset;
  String? orderBy;
  String? where;
  List<Object?>? whereArgs;

  QueryOptions({
    this.columns,
    this.distinct,
    this.groupBy,
    this.having,
    this.limit,
    this.offset,
    this.orderBy,
    this.where,
    this.whereArgs,
  });
}

class QueryArgs {
  final String tableName;
  final QueryOptions? queryOptions;

  QueryArgs({
    required this.tableName,
    this.queryOptions,
  });
}
