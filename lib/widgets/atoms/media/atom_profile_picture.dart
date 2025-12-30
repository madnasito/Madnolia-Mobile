import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:madnolia/i18n/strings.g.dart';
import 'package:http/http.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:madnolia/blocs/user/user_bloc.dart';

import '../../../blocs/edit_user_provider.dart';
import '../../alert_widget.dart';

class AtomProfilePicture extends StatelessWidget {
  const AtomProfilePicture({super.key});

  @override
  Widget build(BuildContext context) {
    final userBloc = context.read<UserBloc>();
    final userStream = EditUserProvider.of(context);
    bool uploadingImage = false;
    userStream.changeImg(userBloc.state.image);
    return GestureDetector(
      onTap: () async {
        if (uploadingImage) {
          return;
        }
        // uploadingImage = true;
        final picker =
            await ImagePicker().pickImage(source: ImageSource.gallery);

        if (picker != null) {
          CroppedFile? croppedFile = await ImageCropper().cropImage(
            sourcePath: picker.path,
            aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
            compressFormat: ImageCompressFormat.jpg,
            uiSettings: [
              AndroidUiSettings(
                toolbarColor: Colors.black,
                toolbarWidgetColor: Colors.white,
                initAspectRatio: CropAspectRatioPreset.original,
                cropStyle: CropStyle.circle,
                showCropGrid: false,
                hideBottomControls: true,
              ),
              IOSUiSettings(
                title: t.PROFILE.USER_PAGE.CROP_IMAGE,
                aspectRatioLockEnabled: true,
              ),
            ],
          );
          if (croppedFile?.path != null) {
            try {
              final resp = await userStream.uploadImage(croppedFile!.path);
              userBloc.updateImages(resp.thumb, resp.image);
            } catch (e) {
              if (!context.mounted) return;
              showErrorServerAlert(context, {"message": "NETWORK_ERROR"});
              rethrow;
            }
          }
        }
        uploadingImage = false;
      },
      child: BlocBuilder<UserBloc, UserState>(
        builder: (context, state) {
          return Stack(
            children: [
              AspectRatio(
                aspectRatio: 1,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: StreamBuilder(
                    stream: userStream.imgStream,
                    builder:
                        (BuildContext context, AsyncSnapshot<String> snapshot) {
                      if (snapshot.hasData) {
                        return CachedNetworkImage(
                            imageUrl: userBloc.state.image,
                            fit: BoxFit.cover,
                            placeholder: (context, url) => Container(
                                  color: Colors.grey[300],
                                  child: const Icon(
                                    Icons.person,
                                    size: 60,
                                    color: Colors.grey,
                                  ),
                                ),
                            errorWidget: (context, url, error) => Container(
                                  color: Colors.grey[300],
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.error_outline,
                                        size: 60,
                                        color: Colors.red,
                                      ),
                                      error is ClientException
                                          ? SizedBox()
                                          : Text(
                                              translate(
                                                  'ERRORS.SERVER.IMAGE_DATA'),
                                              style:
                                                  TextStyle(color: Colors.red),
                                            )
                                    ],
                                  ),
                                ));
                      } else {
                        return Container(
                          color: Colors.grey[300],
                          child: const Icon(
                            Icons.person,
                            size: 60,
                            color: Colors.grey,
                          ),
                        );
                      }
                    },
                  ),
                ),
              ),
              StreamBuilder(
                stream: userStream.loadingStream,
                builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
                  if (snapshot.hasData && snapshot.data == true) {
                    return Positioned.fill(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.black87,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: StreamBuilder<int>(
                            stream: userStream.loadingPercentage,
                            builder: (context, AsyncSnapshot<int> percentageSnapshot) {
                              final percentage = percentageSnapshot.data ?? 0;
                              return Stack(
                                alignment: Alignment.center,
                                children: [
                                  SizedBox(
                                    width: 80,
                                    height: 80,
                                    child: CircularProgressIndicator(
                                      value: percentage / 100,
                                      strokeWidth: 6,
                                      backgroundColor: Colors.white30,
                                      valueColor: const AlwaysStoppedAnimation<Color>(Colors.lightBlueAccent),
                                    ),
                                  ),
                                  Text(
                                    '$percentage%',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                      ),
                    );
                  } else {
                    return const SizedBox.shrink();
                  }
                },
              )
            ],
          );
        },
      ),
    );
  }
}
