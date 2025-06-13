import 'package:animate_do/animate_do.dart';
import 'package:cinamapedia/domain/entities/movie.dart';
import 'package:cinamapedia/presentation/widget/widgets.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MovieHorizontalListview extends StatefulWidget {
  final List<Movie> movies;
  final String? title;
  final String? subTitle;
  final VoidCallback? loadNextPage;

  const MovieHorizontalListview({
    super.key,
    required this.movies,
    this.title,
    this.subTitle,
    this.loadNextPage,
  });

  @override
  State<MovieHorizontalListview> createState() =>
      _MovieHorizontalListviewState();
}

class _MovieHorizontalListviewState extends State<MovieHorizontalListview> {
  final scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      if (widget.loadNextPage == null) return;

      if ((scrollController.position.pixels + 200) >=
          scrollController.position.maxScrollExtent) {
        widget.loadNextPage!();
      }
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 350,
      child: Column(
        children: [
          if (widget.title != null || widget.subTitle != null)
            _Title(widget.title, widget.subTitle),

          Expanded(
            child: ListView.builder(
              controller: scrollController,
              physics: BouncingScrollPhysics(),
              itemCount: widget.movies.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return FadeInRight(child: _Slide(movie: widget.movies[index]));
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _Slide extends StatelessWidget {
  final Movie movie;
  const _Slide({required this.movie});

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //* Imagen
          SizedBox(
            width: 150,

            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: GestureDetector(
                onTap: () => context.push('/home/0/movie/${movie.id}'),
                child: FadeInImage(
                  height: 225,
                  fit: BoxFit.cover,
                  placeholder: AssetImage('assets/loaders/bottle-loader.gif'),
                  image: NetworkImage(movie.posterPath),
                ),
              ),
            ),
          ),

          SizedBox(height: 5),

          //* Titulo
          SizedBox(
            width: 150,
            child: Text(
              movie.title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: textStyle.titleSmall,
            ),
          ),

          //* Rating
          MovieRating(voteAverage: movie.voteAverage),
        ],
      ),
    );
  }
}

class _Title extends StatelessWidget {
  final String? title;
  final String? subTitle;
  const _Title(this.title, this.subTitle);

  @override
  Widget build(BuildContext context) {
    final titleStyle = Theme.of(context).textTheme.titleLarge;

    return Container(
      padding: const EdgeInsets.only(top: 10),
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
      child: Row(
        children: [
          if (title != null) Text(title!, style: titleStyle),

          Spacer(),

          if (subTitle != null)
            FilledButton.tonal(
              style: ButtonStyle(visualDensity: VisualDensity.compact),
              onPressed: () {},
              child: Text(subTitle!),
            ),
        ],
      ),
    );
  }
}
