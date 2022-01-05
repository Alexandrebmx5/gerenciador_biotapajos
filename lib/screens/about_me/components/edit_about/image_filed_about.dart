import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:gerenciador_aquifero/screens/especie/components/image_dialog.dart';
import 'package:gerenciador_aquifero/stores/edit_about_me_store.dart';
import 'package:image_picker_web_redux/image_picker_web_redux.dart';

class ImagesFieldAbout extends StatelessWidget {

  ImagesFieldAbout(this.store);

  final EditAboutMeStore store;

  @override
  Widget build(BuildContext context) {
    void onImageSelected(MediaInfo image) {
      store.iaaLogo.add(image.data);
    }

    Future<void> getFromGallery() async {
      MediaInfo imageFile = await ImagePickerWeb.getImageInfo;
      if(imageFile == null) return;
      onImageSelected(imageFile);
    }

    return Column(
      children: [
        Container(
            height: 120,
            child: Observer(
              builder: (_) {
                return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: store.iaaLogo.length < 5 ?
                    store.iaaLogo.length + 1 : 5,
                    itemBuilder: (_, index) {
                      if (index == store.iaaLogo.length)
                        return Padding(
                          padding: const EdgeInsets.fromLTRB(8, 8, 0, 8),
                          child: GestureDetector(
                            onTap: getFromGallery,
                            child: Container(
                              width: 150,
                              decoration: BoxDecoration(
                                  color: Theme
                                      .of(context)
                                      .primaryColor,
                                  borderRadius: BorderRadius.circular(20)
                              ),
                              child: Icon(
                                Icons.camera_alt,
                                size: 40,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        );
                      else
                        return Padding(
                          padding: const EdgeInsets.fromLTRB(8, 8, 0, 8),
                          child: GestureDetector(
                            onTap: () {
                              showDialog(
                                  context: context,
                                  builder: (_) =>
                                      ImageDialog(
                                          image: store.iaaLogo[index],
                                          onDelete: () =>
                                              store.iaaLogo.removeAt(index)
                                      )
                              );
                            },
                            child: Container(
                                width: 150,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    image: DecorationImage(
                                      fit: BoxFit.contain,
                                      image: store.iaaLogo[index] is Uint8List
                                          ? MemoryImage(
                                        store.iaaLogo[index],
                                      ) : NetworkImage(store.iaaLogo[index]),
                                    )
                                )
                            ),
                          ),
                        );
                    }
                );
              },
            )
        ),
      ],
    );
  }
}

