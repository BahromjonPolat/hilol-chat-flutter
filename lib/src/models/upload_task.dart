/*

  Created by: Claude
  Created on: Mar 06 2026

*/

import 'package:equatable/equatable.dart';

enum UploadStatus { waiting, uploading, done, failed }

class UploadTask extends Equatable {
  final String filePath;
  final UploadStatus status;
  final double progress;

  const UploadTask({
    required this.filePath,
    this.status = UploadStatus.waiting,
    this.progress = 0.0,
  });

  UploadTask copyWith({
    UploadStatus? status,
    double? progress,
  }) {
    return UploadTask(
      filePath: filePath,
      status: status ?? this.status,
      progress: progress ?? this.progress,
    );
  }

  @override
  List<Object?> get props => [filePath, status, progress];
}
