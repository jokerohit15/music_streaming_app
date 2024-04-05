import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:music_streaming_app/core/app_constants/app_colors.dart';
import 'package:music_streaming_app/core/app_constants/app_images.dart';
import 'package:music_streaming_app/core/app_constants/string_constants.dart';
import 'package:music_streaming_app/core/extensions/extension.dart';
import 'package:music_streaming_app/core/service_locator.dart';
import 'package:music_streaming_app/core/theme/theme_provider.dart';
import 'package:music_streaming_app/data/models/song_model.dart';
import 'package:music_streaming_app/presentation/bloc/auth/auth_cubit.dart';
import 'package:music_streaming_app/presentation/bloc/home/home_cubit.dart';
import 'package:music_streaming_app/presentation/bloc/search/search_cubit.dart';
import 'package:music_streaming_app/presentation/bloc/search/search_state.dart';
import 'package:music_streaming_app/presentation/routes/app_routes.dart';
import 'package:music_streaming_app/presentation/routes/route_parameters.dart';
import 'package:music_streaming_app/presentation/widgets/circular_indicator_sliver.dart';
import 'package:music_streaming_app/presentation/widgets/like_button_widget.dart';
import 'package:music_streaming_app/presentation/widgets/sliver_error_widget.dart';
import 'package:music_streaming_app/presentation/widgets/top_bar_widget.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    return CustomScrollView(
        controller: context.read<SearchCubit>().scrollController,
        slivers: <Widget>[
          SliverAppBar(
            automaticallyImplyLeading: false,
            pinned: true,
            expandedHeight: 0.2.heightSize(context),
            collapsedHeight: 0.1.heightSize(context),
            surfaceTintColor: Colors.transparent,
            flexibleSpace: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                var top = constraints.biggest.height;
                return Stack(
                  children: [
                    Positioned(
                      top: 0,
                      left: 0,
                      right: 0,
                      bottom: 0,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (top > 100)
                            const TopBarWidget(),
                          searchBar(context),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          listOfSongs(),
        ],
      ).paddingSymmetric(horizontal: 0.02.sw);
  }

  Widget searchBar(BuildContext context) {
    return Container(
      width: 1.sw,
      height: 0.07.sh,
      margin: EdgeInsets.symmetric(vertical: 0.01.sh,horizontal: 0.01.sw),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: Theme.of(context).primaryColorLight,
      ),
      child: TextField(
        style: Theme.of(context)
            .textTheme
            .bodyLarge!
            .copyWith(color: Theme.of(context).primaryColorDark),
        onChanged: (value) => context.read<SearchCubit>().searchSongs(value),
        decoration: InputDecoration(
          contentPadding:
              EdgeInsets.symmetric(horizontal: 0.1.sw, vertical: 0.025.sh),
          hintText: StringConstants.search,
          hintStyle:
              Theme.of(context).textTheme.titleMedium!.copyWith(fontSize: 14),
          suffixIcon: const Icon(Icons.search),
          suffixIconColor: Theme.of(context).primaryColorDark,
          border: InputBorder.none,
        ),
      ),
    );
  }


  Widget listOfSongs() {
    return BlocBuilder<SearchCubit, SearchState>(
      builder: (context, state) {
        if (state is SearchLoaded) {
          return SliverList(
              delegate: SliverChildBuilderDelegate(
                childCount: state.songs.length,
                    (BuildContext context, int index) {
                  final SongModel song = state.songs[index];
                  return ListTile(
                    onTap: () =>
                        context.navigateTo(
                            AppRoutes.details,
                            DetailsScreenParameters(
                                song: song, title: index.toString())),
                    title: Text(song.name),
                    subtitle: Text(song.artist.first),
                    leading: Hero(
                        tag: song.name + index.toString(),
                        child: Image.network(
                            song.albumArt, width: 50, height: 50)),
                    trailing: LikeButtonWidget(
                      icon: song.isLiked ? Icons.favorite : Icons
                          .favorite_border,
                      reference: song.reference,
                      song: song,
                    ),
                  ).paddingSymmetric(vertical: 0.02.sh);
                },
              ));
        } else if (state is SearchError) {
          return SliverErrorWidget(message: state.message);
        } else {
          return const CircularIndicatorSliver();
        }
      },
    );
  }
}
