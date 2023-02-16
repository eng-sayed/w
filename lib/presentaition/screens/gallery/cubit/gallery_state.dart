part of 'gallery_cubit.dart';

@immutable
abstract class GalleryState {}

class GalleryInitial extends GalleryState {}

class BrandsSuccessState extends GalleryState {}

class BrandsErrorState extends GalleryState {}

class BrandsLoadingState extends GalleryState {}

class ModelSuccessState extends GalleryState {}

class ModelErrorState extends GalleryState {}

class ModelLoadingState extends GalleryState {}

class ChangeImageState extends GalleryState {}
