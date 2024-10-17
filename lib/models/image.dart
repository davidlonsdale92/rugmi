class Image {
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
  final List<Tag> tags;
  final AdConfig adConfig;
  final List<ImageDetail> images;

  Image({
    required this.id,
    this.title,
    this.description,
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
    this.vote,
    required this.favorite,
    required this.nsfw,
    required this.section,
    required this.commentCount,
    required this.favoriteCount,
    this.topic,
    this.topicId,
    required this.imagesCount,
    required this.inGallery,
    required this.isAd,
    required this.tags,
    required this.adConfig,
    required this.images,
  });
}

class Tag {
  final String name;
  final String displayName;
  final int followers;
  final int totalItems;
  final bool following;
  final bool isWhitelisted;
  final String backgroundHash;
  final String thumbnailHash;
  final String accent;
  final bool backgroundIsAnimated;
  final bool thumbnailIsAnimated;
  final bool isPromoted;
  final String? description;
  final String? logoHash;
  final String? logoDestinationUrl;
  final Map<String, dynamic> descriptionAnnotations;

  Tag({
    required this.name,
    required this.displayName,
    required this.followers,
    required this.totalItems,
    required this.following,
    required this.isWhitelisted,
    required this.backgroundHash,
    required this.thumbnailHash,
    required this.accent,
    required this.backgroundIsAnimated,
    required this.thumbnailIsAnimated,
    required this.isPromoted,
    this.description,
    this.logoHash,
    this.logoDestinationUrl,
    required this.descriptionAnnotations,
  });
}

class ImageDetail {
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
  final List<Tag> tags;
  final String link;
  final String? mp4;
  final String? gifv;
  final String? hls;

  ImageDetail({
    required this.id,
    this.title,
    this.description,
    required this.datetime,
    required this.type,
    required this.animated,
    required this.width,
    required this.height,
    required this.size,
    required this.views,
    required this.bandwidth,
    this.vote,
    required this.favorite,
    this.nsfw,
    this.section,
    this.accountUrl,
    this.accountId,
    required this.isAd,
    required this.inMostViral,
    required this.hasSound,
    required this.tags,
    required this.link,
    this.mp4,
    this.gifv,
    this.hls,
  });
}

class AdConfig {
  final List<String> safeFlags;
  final List<String> highRiskFlags;
  final List<String> unsafeFlags;
  final List<String> wallUnsafeFlags;
  final bool showsAds;
  final int showAdLevel;
  final double nsfwScore;

  AdConfig({
    required this.safeFlags,
    required this.highRiskFlags,
    required this.unsafeFlags,
    required this.wallUnsafeFlags,
    required this.showsAds,
    required this.showAdLevel,
    required this.nsfwScore,
  });
}
