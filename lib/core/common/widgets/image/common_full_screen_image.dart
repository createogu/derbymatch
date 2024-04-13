import 'package:cached_network_image/cached_network_image.dart';
import 'package:derbymatch/core/values/values.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../features/auth/models/secure_storage_model.dart';
import '../../../constants/constants.dart';
import '../../controllers/FileController.dart';

class CommonFullScreenImage extends ConsumerStatefulWidget {
  final List<String> imagePaths;
  final int initialIndex;

  CommonFullScreenImage(
      {Key? key, required this.initialIndex, required this.imagePaths})
      : super(key: key);

  @override
  _CommonFullScreenImageState createState() => _CommonFullScreenImageState();
}

class _CommonFullScreenImageState extends ConsumerState<CommonFullScreenImage> {
  late List<String> imageUrls;
  String? token;
  bool isLoading = true;
  late PageController pageController;
  late int currentPage;

  @override
  void initState() {
    super.initState();
    currentPage = widget.initialIndex;
    pageController = PageController(initialPage: widget.initialIndex);
    loadImages();
  }

  Future<void> loadImages() async {
    try {
      final storage = ref.read(secureStorageProvider);
      token = await storage.read(key: accessTokenKey);
      final fileController = ref.read(fileControllerProvider.notifier);
      imageUrls = await Future.wait(
          widget.imagePaths.map((path) => fileController.getImageUrl(path)));
    } catch (e) {
      // Handle errors or set default images
      print("Error loading images: $e");
    } finally {
      if (mounted) {
        setState(() => isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "${currentPage + 1}/${imageUrls.length}",
          style: AppTextStyles.headlineTextStyle,
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: pageController,
              itemCount: imageUrls.length,
              onPageChanged: (int index) {
                setState(() {
                  currentPage = index;
                });
              },
              itemBuilder: (context, index) {
                return Image.network(
                  imageUrls[index],
                  headers:
                      token != null ? {'Authorization': 'Bearer $token'} : {},
                  fit: BoxFit.contain,
                );
              },
            ),
          ),
          Container(
            height: 80,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: imageUrls.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () => pageController.animateToPage(index,
                      duration: Duration(milliseconds: 300),
                      curve: Curves.easeInOut),
                  child: Container(
                    width: 80,
                    height: 80,
                    margin: EdgeInsets.symmetric(horizontal: 4),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white, width: 2),
                      image: DecorationImage(
                        image: CachedNetworkImageProvider(imageUrls[index]),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          AppSpacesBox.verticalSpaceLarge
        ],
      ),
    );
  }
}
