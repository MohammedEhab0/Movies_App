import 'package:carousel_slider/carousel_slider.dart';
import 'package:copy_movie/Data/models/MovieRespone.dart';
import 'package:copy_movie/ui/Widgets/movie_item.dart';
import 'package:copy_movie/utils/app_colors.dart';
import 'package:flutter/material.dart';


class MovieSlider extends StatelessWidget {
   MovieSlider({
    super.key,
    required this.height,
    required this.slider,
    required this.onPageChanged
  });

  final double height;
  final List<Movies> slider;
  dynamic Function(int, CarouselPageChangedReason)? onPageChanged;
  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
      options: CarouselOptions(onPageChanged:onPageChanged ,
        height: height * 0.42,
        enlargeCenterPage: true,
        viewportFraction: 0.65,
        enableInfiniteScroll: true,
        enlargeFactor: .3
      ),
      itemCount: slider.length,
      itemBuilder: (context, index, pageIndex) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 1),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            boxShadow: const [
              BoxShadow(
                color: AppColors.blackColor,
                blurRadius: 8,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: ItemBuilder(slider: slider, index: index),
        );
      },
    );
  }
}
