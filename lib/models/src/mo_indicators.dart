import 'dart:convert';

class MoIndicators {
  final Messages? messages;
  final Data? data;
  final String? status;

  MoIndicators({
    this.messages,
    this.data,
    this.status,
  });

  MoIndicators copyWith({
    Messages? messages,
    Data? data,
    String? status,
  }) =>
      MoIndicators(
        messages: messages ?? this.messages,
        data: data ?? this.data,
        status: status ?? this.status,
      );

  factory MoIndicators.fromJson(String str) =>
      MoIndicators.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory MoIndicators.fromMap(Map<String, dynamic> json) => MoIndicators(
        messages: json["MESSAGES"] == null
            ? null
            : Messages.fromMap(json["MESSAGES"]),
        data: json["DATA"] == null ? null : Data.fromMap(json["DATA"]),
        status: json["STATUS"],
      );

  Map<String, dynamic> toMap() => {
        "MESSAGES": messages?.toMap(),
        "DATA": data?.toMap(),
        "STATUS": status,
      };
}

class Data {
  final int? page;
  final int? pagesCount;
  final int? rowsCount;
  final List<Row>? rows;

  Data({
    this.page,
    this.pagesCount,
    this.rowsCount,
    this.rows,
  });

  Data copyWith({
    int? page,
    int? pagesCount,
    int? rowsCount,
    List<Row>? rows,
  }) =>
      Data(
        page: page ?? this.page,
        pagesCount: pagesCount ?? this.pagesCount,
        rowsCount: rowsCount ?? this.rowsCount,
        rows: rows ?? this.rows,
      );

  factory Data.fromJson(String str) => Data.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Data.fromMap(Map<String, dynamic> json) => Data(
        page: json["page"],
        pagesCount: json["pages_count"],
        rowsCount: json["rows_count"],
        rows: json["rows"] == null
            ? []
            : List<Row>.from(json["rows"]!.map((x) => Row.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "page": page,
        "pages_count": pagesCount,
        "rows_count": rowsCount,
        "rows":
            rows == null ? [] : List<dynamic>.from(rows!.map((x) => x.toMap())),
      };
}

class Row {
  final String? name;
  final int? indicatorToMoId;
  final int? parentId;
  final int? order;
  final String? parentName;
  final String? description;

  Row({
    this.name,
    this.indicatorToMoId,
    this.parentId,
    this.order,
    this.parentName,
    this.description,
  });

  Row copyWith({
    String? name,
    int? indicatorToMoId,
    int? parentId,
    int? order,
    String? parentName,
    String? description,
  }) =>
      Row(
        name: name ?? this.name,
        indicatorToMoId: indicatorToMoId ?? this.indicatorToMoId,
        parentId: parentId ?? this.parentId,
        order: order ?? this.order,
        parentName: parentName ?? this.parentName,
        description: description ?? this.description,
      );

  factory Row.fromJson(String str) => Row.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Row.fromMap(Map<String, dynamic> json) => Row(
        name: json["name"],
        indicatorToMoId: json["indicator_to_mo_id"],
        parentId: json["parent_id"],
        order: json["order"],
        parentName: json["parent_name"],
        description: json["description"],
      );

  Map<String, dynamic> toMap() => {
        "name": name,
        "indicator_to_mo_id": indicatorToMoId,
        "parent_id": parentId,
        "order": order,
        "parent_name": parentName,
        "description": description,
      };
}

class Messages {
  final List<String>? error;
  final dynamic warning;
  final dynamic info;

  Messages({
    this.error,
    this.warning,
    this.info,
  });

  Messages copyWith({
    List<String>? error,
    dynamic warning,
    dynamic info,
  }) =>
      Messages(
        error: error ?? this.error,
        warning: warning ?? this.warning,
        info: info ?? this.info,
      );

  factory Messages.fromJson(String str) => Messages.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Messages.fromMap(Map<String, dynamic> json) => Messages(
        error: json["error"] == null
            ? []
            : List<String>.from(json["error"]!.map((x) => x)),
        warning: json["warning"],
        info: json["info"],
      );

  Map<String, dynamic> toMap() => {
        "error": error == null ? [] : List<dynamic>.from(error!.map((x) => x)),
        "warning": warning,
        "info": info,
      };
}
