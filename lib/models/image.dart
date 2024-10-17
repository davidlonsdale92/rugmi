// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Image {
  Image({
    required this.id,
    required this.datetime,
    required this.cover,
    required this.coverWidth,
    required this.coverHeight,
    required this.accountUrl,
    required this.accountId,
    required this.privacy,
    required this.layout,
    required this.views,
    required this.link,
    required this.ups,
    required this.downs,
    required this.points,
    required this.score,
    required this.isAlbum,
    required this.favorite,
    required this.nsfw,
    required this.section,
    required this.commentCount,
    required this.favoriteCount,
    required this.imagesCount,
    required this.inGallery,
    required this.isAd,
    required this.images,
    this.title,
    this.description,
    this.vote,
    this.topic,
    this.topicId,
  });
  final String id;
  final String? title;
  final String? description;
  final int datetime;
  final String cover;
  final int coverWidth;
  final int coverHeight;
  final String accountUrl;
  final int accountId;
  final String privacy;
  final String layout;
  final int views;
  final String link;
  final int ups;
  final int downs;
  final int points;
  final int score;
  final bool isAlbum;
  final bool? vote;
  final bool favorite;
  final bool nsfw;
  final String section;
  final int commentCount;
  final int favoriteCount;
  final String? topic;
  final int? topicId;
  final int imagesCount;
  final bool inGallery;
  final bool isAd;
  final List<ImageDetail> images;
}

class ImageDetail {
  ImageDetail({
    required this.id,
    required this.datetime,
    required this.type,
    required this.animated,
    required this.width,
    required this.height,
    required this.size,
    required this.views,
    required this.bandwidth,
    required this.favorite,
    required this.isAd,
    required this.inMostViral,
    required this.hasSound,
    required this.link,
    this.title,
    this.description,
    this.vote,
    this.nsfw,
    this.section,
    this.accountUrl,
    this.accountId,
    this.mp4,
    this.gifv,
    this.hls,
  });
  final String id;
  final String? title;
  final String? description;
  final int datetime;
  final String type;
  final bool animated;
  final int width;
  final int height;
  final int size;
  final int views;
  final int bandwidth;
  final bool? vote;
  final bool favorite;
  final bool? nsfw;
  final String? section;
  final String? accountUrl;
  final int? accountId;
  final bool isAd;
  final bool inMostViral;
  final bool hasSound;
  final String link;
  final String? mp4;
  final String? gifv;
  final String? hls;

  ImageDetail copyWith({
    String? id,
    String? title,
    String? description,
    int? datetime,
    String? type,
    bool? animated,
    int? width,
    int? height,
    int? size,
    int? views,
    int? bandwidth,
    bool? vote,
    bool? favorite,
    bool? nsfw,
    String? section,
    String? accountUrl,
    int? accountId,
    bool? isAd,
    bool? inMostViral,
    bool? hasSound,
    String? link,
    String? mp4,
    String? gifv,
    String? hls,
  }) {
    return ImageDetail(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      datetime: datetime ?? this.datetime,
      type: type ?? this.type,
      animated: animated ?? this.animated,
      width: width ?? this.width,
      height: height ?? this.height,
      size: size ?? this.size,
      views: views ?? this.views,
      bandwidth: bandwidth ?? this.bandwidth,
      vote: vote ?? this.vote,
      favorite: favorite ?? this.favorite,
      nsfw: nsfw ?? this.nsfw,
      section: section ?? this.section,
      accountUrl: accountUrl ?? this.accountUrl,
      accountId: accountId ?? this.accountId,
      isAd: isAd ?? this.isAd,
      inMostViral: inMostViral ?? this.inMostViral,
      hasSound: hasSound ?? this.hasSound,
      link: link ?? this.link,
      mp4: mp4 ?? this.mp4,
      gifv: gifv ?? this.gifv,
      hls: hls ?? this.hls,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'description': description,
      'datetime': datetime,
      'type': type,
      'animated': animated,
      'width': width,
      'height': height,
      'size': size,
      'views': views,
      'bandwidth': bandwidth,
      'vote': vote,
      'favorite': favorite,
      'nsfw': nsfw,
      'section': section,
      'accountUrl': accountUrl,
      'accountId': accountId,
      'isAd': isAd,
      'inMostViral': inMostViral,
      'hasSound': hasSound,
      'link': link,
      'mp4': mp4,
      'gifv': gifv,
      'hls': hls,
    };
  }

  factory ImageDetail.fromMap(Map<String, dynamic> map) {
    return ImageDetail(
      id: map['id'] as String,
      title: map['title'] != null ? map['title'] as String : null,
      description:
          map['description'] != null ? map['description'] as String : null,
      datetime: map['datetime'] as int,
      type: map['type'] as String,
      animated: map['animated'] as bool,
      width: map['width'] as int,
      height: map['height'] as int,
      size: map['size'] as int,
      views: map['views'] as int,
      bandwidth: map['bandwidth'] as int,
      vote: map['vote'] != null ? map['vote'] as bool : null,
      favorite: map['favorite'] as bool,
      nsfw: map['nsfw'] != null ? map['nsfw'] as bool : null,
      section: map['section'] != null ? map['section'] as String : null,
      accountUrl:
          map['accountUrl'] != null ? map['accountUrl'] as String : null,
      accountId: map['accountId'] != null ? map['accountId'] as int : null,
      isAd: map['isAd'] as bool,
      inMostViral: map['inMostViral'] as bool,
      hasSound: map['hasSound'] as bool,
      link: map['link'] as String,
      mp4: map['mp4'] != null ? map['mp4'] as String : null,
      gifv: map['gifv'] != null ? map['gifv'] as String : null,
      hls: map['hls'] != null ? map['hls'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ImageDetail.fromJson(String source) =>
      ImageDetail.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ImageDetail(id: $id, title: $title, description: $description, datetime: $datetime, type: $type, animated: $animated, width: $width, height: $height, size: $size, views: $views, bandwidth: $bandwidth, vote: $vote, favorite: $favorite, nsfw: $nsfw, section: $section, accountUrl: $accountUrl, accountId: $accountId, isAd: $isAd, inMostViral: $inMostViral, hasSound: $hasSound, link: $link, mp4: $mp4, gifv: $gifv, hls: $hls)';
  }

  @override
  bool operator ==(covariant ImageDetail other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.title == title &&
        other.description == description &&
        other.datetime == datetime &&
        other.type == type &&
        other.animated == animated &&
        other.width == width &&
        other.height == height &&
        other.size == size &&
        other.views == views &&
        other.bandwidth == bandwidth &&
        other.vote == vote &&
        other.favorite == favorite &&
        other.nsfw == nsfw &&
        other.section == section &&
        other.accountUrl == accountUrl &&
        other.accountId == accountId &&
        other.isAd == isAd &&
        other.inMostViral == inMostViral &&
        other.hasSound == hasSound &&
        other.link == link &&
        other.mp4 == mp4 &&
        other.gifv == gifv &&
        other.hls == hls;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        description.hashCode ^
        datetime.hashCode ^
        type.hashCode ^
        animated.hashCode ^
        width.hashCode ^
        height.hashCode ^
        size.hashCode ^
        views.hashCode ^
        bandwidth.hashCode ^
        vote.hashCode ^
        favorite.hashCode ^
        nsfw.hashCode ^
        section.hashCode ^
        accountUrl.hashCode ^
        accountId.hashCode ^
        isAd.hashCode ^
        inMostViral.hashCode ^
        hasSound.hashCode ^
        link.hashCode ^
        mp4.hashCode ^
        gifv.hashCode ^
        hls.hashCode;
  }
}
