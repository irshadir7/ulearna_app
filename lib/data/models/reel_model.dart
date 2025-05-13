import 'package:equatable/equatable.dart';

class ReelEntity extends Equatable {
  final int id;
  final String title;
  final String url;
  final String cdnUrl;
  final String thumbCdnUrl;
  final int userId;
  final String status;
  final String slug;
  final int categoryId;
  final int totalViews;
  final int totalLikes;
  final int totalComments;
  final int totalShare;
  final int totalWishlist;
  final int duration;
  final DateTime byteAddedOn;
  final DateTime byteUpdatedOn;
  final String language;
  final String orientation;
  final int videoHeight;
  final int videoWidth;
  final String videoAspectRatio;
  final ReelUserEntity user;
  final ReelCategoryEntity category;
  final bool is_liked;

  const ReelEntity({
    required this.id,
    required this.title,
    required this.url,
    required this.cdnUrl,
    required this.thumbCdnUrl,
    required this.userId,
    required this.status,
    required this.slug,
    required this.categoryId,
    required this.totalViews,
    required this.totalLikes,
    required this.totalComments,
    required this.totalShare,
    required this.totalWishlist,
    required this.duration,
    required this.byteAddedOn,
    required this.byteUpdatedOn,
    required this.language,
    required this.orientation,
    required this.videoHeight,
    required this.videoWidth,
    required this.videoAspectRatio,
    required this.user,
    required this.category,
    required this.is_liked,
  });

  @override
  List<Object?> get props => [
    id, title, url, cdnUrl, thumbCdnUrl, userId,
    status, slug, categoryId, totalViews, totalLikes,
    totalComments, totalShare, totalWishlist, duration,
    byteAddedOn, byteUpdatedOn, language, orientation,
    videoHeight, videoWidth, videoAspectRatio, user, category,is_liked
  ];
}

class ReelUserEntity extends Equatable {
  final int userId;
  final String fullname;
  final String username;
  final String? profilePicture;
  final String? profilePictureCdn;
  final String? designation;
  final bool isSubscriptionActive;
  final bool isFollow;

  const ReelUserEntity({
    required this.userId,
    required this.fullname,
    required this.username,
    this.profilePicture,
    this.profilePictureCdn,
    this.designation,
    required this.isSubscriptionActive,
    required this.isFollow,
  });

  @override
  List<Object?> get props => [
    userId, fullname, username, profilePicture,
    profilePictureCdn, designation,
    isSubscriptionActive, isFollow
  ];
}

class ReelCategoryEntity extends Equatable {
  final String title;

  const ReelCategoryEntity({required this.title});

  @override
  List<Object?> get props => [title];
}

class ReelModel extends ReelEntity {
  const ReelModel({
    required super.id,
    required super.title,
    required super.url,
    required super.cdnUrl,
    required super.thumbCdnUrl,
    required super.userId,
    required super.status,
    required super.slug,
    required super.categoryId,
    required super.totalViews,
    required super.totalLikes,
    required super.totalComments,
    required super.totalShare,
    required super.totalWishlist,
    required super.duration,
    required super.byteAddedOn,
    required super.byteUpdatedOn,
    required super.language,
    required super.orientation,
    required super.videoHeight,
    required super.videoWidth,
    required super.videoAspectRatio,
    required super.user,
    required super.category,
    required super.is_liked,
  });

  factory ReelModel.fromJson(Map<String, dynamic> json) {
    return ReelModel(
      id: json['id'] as int? ?? 0,
      title: json['title'] as String? ?? '',
      url: json['url'] as String? ?? '',
      cdnUrl: json['cdn_url'] as String? ?? '',
      thumbCdnUrl: json['thumb_cdn_url'] as String? ?? '',
      userId: json['user_id'] as int? ?? 0,
      status: json['status'] as String? ?? '',
      slug: json['slug'] as String? ?? '',
      categoryId: json['category_id'] as int? ?? 0,
      totalViews: json['total_views'] as int? ?? 0,
      totalLikes: json['total_likes'] as int? ?? 0,
      totalComments: json['total_comments'] as int? ?? 0,
      totalShare: json['total_share'] as int? ?? 0,
      totalWishlist: json['total_wishlist'] as int? ?? 0,
      duration: json['duration'] as int? ?? 0,
      byteAddedOn: json['byte_added_on'] != null
          ? DateTime.parse(json['byte_added_on'] as String)
          : DateTime.now(),
      byteUpdatedOn: json['byte_updated_on'] != null
          ? DateTime.parse(json['byte_updated_on'] as String)
          : DateTime.now(),
      language: json['language'] as String? ?? '',
      orientation: json['orientation'] as String? ?? '',
      videoHeight: json['video_height'] as int? ?? 0,
      videoWidth: json['video_width'] as int? ?? 0,
      videoAspectRatio: json['video_aspect_ratio'] as String? ?? '',
      user: ReelUserModel.fromJson(json['user'] ?? {}),
      category: ReelCategoryModel.fromJson(json['category'] ?? {}),
      is_liked: json['is_liked'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'url': url,
      'cdn_url': cdnUrl,
      'thumb_cdn_url': thumbCdnUrl,
      'user_id': userId,
      'status': status,
      'slug': slug,
      'category_id': categoryId,
      'total_views': totalViews,
      'total_likes': totalLikes,
      'total_comments': totalComments,
      'total_share': totalShare,
      'total_wishlist': totalWishlist,
      'duration': duration,
      'byte_added_on': byteAddedOn.toIso8601String(),
      'byte_updated_on': byteUpdatedOn.toIso8601String(),
      'language': language,
      'orientation': orientation,
      'video_height': videoHeight,
      'video_width': videoWidth,
      'video_aspect_ratio': videoAspectRatio,
      'user': (user as ReelUserModel).toJson(),
      'category': (category as ReelCategoryModel).toJson(),
    };
  }

  ReelEntity toEntity() => this;
}

class ReelUserModel extends ReelUserEntity {
  const ReelUserModel({
    required super.userId,
    required super.fullname,
    required super.username,
    super.profilePicture,
    super.profilePictureCdn,
    super.designation,
    required super.isSubscriptionActive,
    required super.isFollow,
  });

  factory ReelUserModel.fromJson(Map<String, dynamic> json) {
    return ReelUserModel(
      userId: json['user_id'] as int? ?? 0,
      fullname: json['fullname'] as String? ?? '',
      username: json['username'] as String? ?? '',
      profilePicture: json['profile_picture'] as String?,
      profilePictureCdn: json['profile_picture_cdn'] as String?,
      designation: json['designation'] as String?,
      isSubscriptionActive: json['is_subscription_active'] as bool? ?? false,
      isFollow: json['is_follow'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'fullname': fullname,
      'username': username,
      'profile_picture': profilePicture,
      'profile_picture_cdn': profilePictureCdn,
      'designation': designation,
      'is_subscription_active': isSubscriptionActive,
      'is_follow': isFollow,
    };
  }
}

class ReelCategoryModel extends ReelCategoryEntity {
  const ReelCategoryModel({required super.title});

  factory ReelCategoryModel.fromJson(Map<String, dynamic> json) {
    return ReelCategoryModel(
      title: json['title'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
    };
  }
}

class MetaData {
  final int total;
  final int page;
  final int limit;

  MetaData({required this.total, required this.page, required this.limit});

  factory MetaData.fromJson(Map<String, dynamic> json) {
    return MetaData(
      total: json['total'],
      page: json['page'],
      limit: json['limit'],
    );
  }
}

