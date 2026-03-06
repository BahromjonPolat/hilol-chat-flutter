/*

  Created by: Bakhromjon Polat
  Created on: Nov 27 2025 09:21:57

*/

import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hilol_chat_flutter/src/blocs/chat/hilol_chat_bloc.dart';
import 'package:hilol_chat_flutter/src/models/image_meta.dart';
import 'package:hilol_chat_flutter/src/models/upload_task.dart';

class HilolChatImage extends StatelessWidget {
  final String imageUrl;
  final ImageMeta imageMeta;
  const HilolChatImage({
    super.key,
    required this.imageUrl,
    required this.imageMeta,
  });

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      key: ValueKey(imageMeta.filePath),
      aspectRatio: imageMeta.aspectRatio,
      child: ClipRRect(
        borderRadius: BorderRadiusGeometry.circular(8),
        child: BlocSelector<HilolChatBloc, HilolChatState, UploadTask?>(
          selector: (state) => state.uploadTasks[imageMeta.filePath],
          builder: (context, uploadTask) {
            final imageWidget = CachedNetworkImage(
              imageUrl: imageUrl,
              placeholder: (context, url) => imageMeta.filePath.isNotEmpty
                  ? HilolFileImage(
                      imageMeta: imageMeta,
                      key: ValueKey(imageMeta.filePath),
                    )
                  : const Icon(Icons.image),
              errorWidget: (context, url, error) =>
                  imageMeta.filePath.isNotEmpty
                      ? HilolFileImage(
                          imageMeta: imageMeta,
                          key: ValueKey(imageMeta.filePath),
                        )
                      : const Icon(Icons.error),
            );

            if (uploadTask == null) return imageWidget;

            return Stack(
              fit: StackFit.expand,
              children: [
                imageWidget,
                Container(
                  color: Colors.black.withValues(alpha: 0.4),
                  child: Center(
                    child: SizedBox(
                      width: 48,
                      height: 48,
                      child: uploadTask.status == UploadStatus.failed
                          ? const Icon(
                              Icons.error_outline,
                              color: Colors.white,
                              size: 36,
                            )
                          : CircularProgressIndicator(
                              value: uploadTask.status == UploadStatus.waiting
                                  ? null
                                  : uploadTask.progress,
                              color: Colors.white,
                              strokeWidth: 3,
                            ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class HilolFileImage extends StatelessWidget {
  final ImageMeta imageMeta;
  const HilolFileImage({super.key, required this.imageMeta});

  @override
  Widget build(BuildContext context) {
    return Image.file(
      File(imageMeta.filePath),
      width: imageMeta.width.toDouble(),
      height: imageMeta.height.toDouble(),
      // fit: BoxFit.cover,
    );
  }
}
