// To parse this JSON data, do
//
//     final podCastModel = podCastModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

// PodCastModel podCastModelFromJson(String str) => PodCastModel.fromJson(json.decode(str));

// String podCastModelToJson(PodCastModel data) => json.encode(data.toJson());

class PodCastModel {
  static var obs;

  PodCastModel({
    required this.data,
    required this.meta,
  });

  List<Datum> data;
  Meta meta;

  factory PodCastModel.fromJson(Map<String, dynamic> json) => PodCastModel(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        meta: Meta.fromJson(json["meta"]),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "meta": meta.toJson(),
      };
}

class Datum {
  Datum({
    required this.id,
    required this.attributes,
  });

  int id;
  DatumAttributes attributes;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        attributes: DatumAttributes.fromJson(json["attributes"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "attributes": attributes.toJson(),
      };
}

class DatumAttributes {
  DatumAttributes({
    required this.seriesName,
    required this.createdAt,
    required this.updatedAt,
    required this.name,
    required this.description,
    required this.episodeNo,
    required this.publishedAt,
    required this.banner,
    required this.file,
  });

  String seriesName;
  DateTime createdAt;
  DateTime updatedAt;
  String name;
  String description;
  String episodeNo;
  DateTime publishedAt;
  Banner banner;
  Banner file;

  factory DatumAttributes.fromJson(Map<String, dynamic> json) =>
      DatumAttributes(
        seriesName: json["SeriesName"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        name: json["Name"],
        description: json["Description"],
        episodeNo: json["EpisodeNo"],
        publishedAt: DateTime.parse(json["publishedAt"]),
        banner: Banner.fromJson(json["Banner"]),
        file: Banner.fromJson(json["file"]),
      );

  Map<String, dynamic> toJson() => {
        "SeriesName": seriesName,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "Name": name,
        "Description": description,
        "EpisodeNo": episodeNo,
        "publishedAt": publishedAt.toIso8601String(),
        "Banner": banner.toJson(),
        "file": file.toJson(),
      };
}

class Banner {
  Banner({
    required this.data,
  });

  Data data;

  factory Banner.fromJson(Map<String, dynamic> json) => Banner(
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
      };
}

class Data {
  Data({
    required this.id,
    required this.attributes,
  });

  int id;
  DataAttributes attributes;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        attributes: DataAttributes.fromJson(json["attributes"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "attributes": attributes.toJson(),
      };
}

class DataAttributes {
  DataAttributes({
    required this.name,
    required this.alternativeText,
    required this.caption,
    required this.width,
    required this.height,
    required this.formats,
    required this.hash,
    required this.ext,
    required this.mime,
    required this.size,
    required this.url,
    required this.previewUrl,
    required this.provider,
    required this.providerMetadata,
    required this.createdAt,
    required this.updatedAt,
  });

  String name;
  String alternativeText;
  String caption;
  int? width;
  int? height;
  Formats? formats;
  String hash;
  String ext;
  String mime;
  double size;
  String url;
  dynamic previewUrl;
  String provider;
  dynamic providerMetadata;
  DateTime createdAt;
  DateTime updatedAt;

  factory DataAttributes.fromJson(Map<String, dynamic> json) => DataAttributes(
        name: json["name"],
        alternativeText: json["alternativeText"],
        caption: json["caption"],
        width: json["width"] == null ? null : json["width"],
        height: json["height"] == null ? null : json["height"],
        formats:
            json["formats"] == null ? null : Formats.fromJson(json["formats"]),
        hash: json["hash"],
        ext: json["ext"],
        mime: json["mime"],
        size: json["size"].toDouble(),
        url: json["url"],
        previewUrl: json["previewUrl"],
        provider: json["provider"],
        providerMetadata: json["provider_metadata"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "alternativeText": alternativeText,
        "caption": caption,
        "width": width == null ? null : width,
        "height": height == null ? null : height,
        "formats": formats == null ? null : formats!.toJson(),
        "hash": hash,
        "ext": ext,
        "mime": mime,
        "size": size,
        "url": url,
        "previewUrl": previewUrl,
        "provider": provider,
        "provider_metadata": providerMetadata,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
      };
}

class Formats {
  Formats({
    required this.thumbnail,
    required this.large,
    required this.small,
    required this.medium,
  });

  Thumbnail thumbnail;
  Thumbnail? large;
  Thumbnail? small;
  Thumbnail? medium;

  factory Formats.fromJson(Map<String, dynamic> json) => Formats(
        thumbnail: Thumbnail.fromJson(json["thumbnail"]),
        large: json["large"] == null ? null : Thumbnail.fromJson(json["large"]),
        small: json["small"] == null ? null : Thumbnail.fromJson(json["small"]),
        medium:
            json["medium"] == null ? null : Thumbnail.fromJson(json["medium"]),
      );

  Map<String, dynamic> toJson() => {
        "thumbnail": thumbnail.toJson(),
        "large": large == null ? null : large!.toJson(),
        "small": small == null ? null : small!.toJson(),
        "medium": medium == null ? null : medium!.toJson(),
      };
}

class Thumbnail {
  Thumbnail({
    required this.ext,
    required this.url,
    required this.hash,
    required this.mime,
    required this.name,
    required this.path,
    required this.size,
    required this.width,
    required this.height,
  });

  String ext;
  String url;
  String hash;
  String mime;
  String name;
  dynamic path;
  double size;
  int width;
  int height;

  factory Thumbnail.fromJson(Map<String, dynamic> json) => Thumbnail(
        ext: json["ext"],
        url: json["url"],
        hash: json["hash"],
        mime: json["mime"],
        name: json["name"],
        path: json["path"],
        size: json["size"].toDouble(),
        width: json["width"],
        height: json["height"],
      );

  Map<String, dynamic> toJson() => {
        "ext": ext,
        "url": url,
        "hash": hash,
        "mime": mime,
        "name": name,
        "path": path,
        "size": size,
        "width": width,
        "height": height,
      };
}

class Meta {
  Meta({
    required this.pagination,
  });

  Pagination pagination;

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
        pagination: Pagination.fromJson(json["pagination"]),
      );

  Map<String, dynamic> toJson() => {
        "pagination": pagination.toJson(),
      };
}

class Pagination {
  Pagination({
    required this.page,
    required this.pageSize,
    required this.pageCount,
    required this.total,
  });

  int page;
  int pageSize;
  int pageCount;
  int total;

  factory Pagination.fromJson(Map<String, dynamic> json) => Pagination(
        page: json["page"],
        pageSize: json["pageSize"],
        pageCount: json["pageCount"],
        total: json["total"],
      );

  Map<String, dynamic> toJson() => {
        "page": page,
        "pageSize": pageSize,
        "pageCount": pageCount,
        "total": total,
      };
}
