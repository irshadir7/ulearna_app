import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:better_player_plus/better_player_plus.dart';
import '../bloc/video_bloc.dart';
import '../widgets/video_player_widget.dart';

class ReelsPage extends StatefulWidget {
  const ReelsPage({super.key});

  @override
  State<ReelsPage> createState() => _ReelsPageState();
}

class _ReelsPageState extends State<ReelsPage> {
  late final PageController _pageController;
  int? _lastPrefetchedIndex;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _pageController.addListener(_onScroll);
  }

  void _onScroll() {
    final bloc = context.read<VideoBloc>();
    final state = bloc.state;

    if (state is! VideoLoaded || bloc.isLoading) return;

    final currentPage = bloc.currentPage;
    final limit = bloc.limit;
    final totalItems = state.metaData.total;
    final loadedItems = state.videos.length;
    final currentIndex = _pageController.page?.round() ?? 0;

    final halfwayIndex = (loadedItems / 2).floor();
    final hasMore = loadedItems < totalItems;

    // Fetch next page when halfway through current items
    if (hasMore && currentIndex >= halfwayIndex) {
      bloc.add(FetchVideosEvent(page: currentPage + 1, limit: limit));
    }

    // Prefetch only if we haven't already prefetched this index
    if (_lastPrefetchedIndex != currentIndex && currentIndex + 1 < loadedItems) {
      final nextVideoUrl = state.videos[currentIndex + 1].cdnUrl;
      prefetchVideo(nextVideoUrl);
      _lastPrefetchedIndex = currentIndex;
    }
  }


  Future<void> prefetchVideo(String url) async {
    final dataSource = BetterPlayerDataSource(
      BetterPlayerDataSourceType.network,
      url,
      videoFormat: BetterPlayerVideoFormat.hls,
      cacheConfiguration: const BetterPlayerCacheConfiguration(
        useCache: true,
        preCacheSize: 10 * 1024 * 1024,
        maxCacheSize: 100 * 1024 * 1024,
        maxCacheFileSize: 20 * 1024 * 1024,
      ),
    );

    final tempController = BetterPlayerController(
      const BetterPlayerConfiguration(
        autoPlay: false, // Don't auto play during prefetch
        handleLifecycle: true,
      ),
    );

    await tempController.setupDataSource(dataSource);

    // Wait for a short while to give caching time to start
    await Future.delayed(const Duration(seconds: 4));

    // Dispose the temporary controller
    tempController.dispose();
  }




  @override
  void dispose() {
    _pageController.removeListener(_onScroll);
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      extendBodyBehindAppBar: true,
      extendBody: true,
      body: BlocBuilder<VideoBloc, VideoState>(
        builder: (context, state) {
          if (state is VideoInitial) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is VideoLoaded) {
            return PageView.builder(
              scrollDirection: Axis.vertical,
              controller: _pageController,
              itemCount: state.videos.length,
              itemBuilder: (_, index) {
                final video = state.videos[index];
                return Stack(
                  fit: StackFit.expand,
                  children: [
                    /// FULLSCREEN VIDEO PLAYER
                    const Positioned.fill(child: ColoredBox(color: Colors.black)), // fallback background
                    Positioned.fill(
                      child: VideoPlayerWidget(
                        url: video.cdnUrl,
                        onVideoComplete: index == 0
                            ? () {
                          // Prefetch only the second video when the first one completes
                          if (state.videos.length > 1) {
                            final secondVideoUrl = state.videos[1].cdnUrl;
                            prefetchVideo(secondVideoUrl);
                          }
                        }
                            : null,
                      ),
                    ),
                    /// GRADIENT OVERLAY
                    Positioned.fill(
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                            colors: [
                              Colors.black.withOpacity(0.6),
                              Colors.transparent
                            ],
                          ),
                        ),
                      ),
                    ),

                    /// LEFT BOTTOM INFO
                    Positioned(
                      left: 20,
                      bottom: 80,
                      right: 100,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                radius: 16,
                                backgroundImage: NetworkImage(
                                  (video.user.profilePictureCdn != null &&
                                      video.user.profilePictureCdn!.startsWith("http") &&
                                      video.user.profilePictureCdn!.isNotEmpty)
                                      ? video.user.profilePictureCdn!
                                      : "https://lh3.googleusercontent.com/ogw/AF2bZygZKfeXohPqK-Y-XGlQgAdGPSbGVj3-noB9hsnk-RmMIfnh=s64-c-mo",
                                ),
                              ),
                              const SizedBox(width: 10),
                              Text(
                                video.user.username,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text(
                            video.title,
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),

                    /// RIGHT SIDE ACTION ICONS
                    Positioned(
                      right: 20,
                      bottom: 100,
                      child: Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              context
                                  .read<VideoBloc>()
                                  .add(ToggleLikeEvent(videoId: video.id));
                            },
                            child: Column(
                              children: [
                                Icon(
                                  video.is_liked
                                      ? Icons.favorite
                                      : Icons.favorite_border,
                                  color: video.is_liked
                                      ? Colors.red
                                      : Colors.white,
                                  size: 32,
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  '${video.totalLikes}',
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 20),
                          GestureDetector(
                            onTap: () {
                            },
                            child: Column(
                              children: [
                                const Icon(FontAwesomeIcons.comment,
                                    color: Colors.white, size: 28),
                                const SizedBox(height: 4),
                                Text('${video.totalComments}',
                                    style: const TextStyle(color: Colors.white)),
                              ],
                            ),
                          ),
                          const SizedBox(height: 20),
                          GestureDetector(
                            onTap: () {
                            },
                            child: Column(
                              children: [
                                const Icon(FontAwesomeIcons.paperPlane,
                                    color: Colors.white, size: 28),
                                const SizedBox(height: 4),
                                Text('${video.totalShare}',
                                    style: const TextStyle(color: Colors.white)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            );
          } else if (state is VideoError) {
            return Center(
                child: Text(state.message,
                    style: const TextStyle(color: Colors.white)));
          }
          return const SizedBox();
        },
      ),
    );
  }
}

