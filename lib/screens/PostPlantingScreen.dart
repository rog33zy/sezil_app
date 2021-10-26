import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../helpers/id_generator_helper.dart';

import '../providers/PostPlantingProvider.dart';
import '../providers/AuthProvider.dart';

import '../models/PostPlantingModel.dart';

import '../components/UI/ListWidgetComponent.dart';
import '../components/UI/PlotsFloatingButtons.dart';

class PostPlantingScreen extends StatelessWidget {
  const PostPlantingScreen({Key? key}) : super(key: key);

  static const routeName = '/post-planting';

  @override
  Widget build(BuildContext context) {
    final argumentsMap = ModalRoute.of(context)?.settings.arguments as Map;
    final plotId = argumentsMap['argument'];

    final bool isObjectExisiting = Provider.of<PostPlantingProvider>(
      context,
      listen: false,
    ).isExisting(plotId);

    if (!isObjectExisiting) {
      PostPlantingModel newPostPlantingObject = PostPlantingModel(
        id: IDGeneratorHelper.generateId(),
        lastUpdated: DateTime.now(),
        plotId: plotId,
      );
      Provider.of<PostPlantingProvider>(
        context,
        listen: false,
      ).updatePostPlantingObject(
        newPostPlantingObject,
        false,
      );
    }

    final PostPlantingModel postPlantingObject =
        Provider.of<PostPlantingProvider>(
      context,
      listen: true,
    ).findByPlot(plotId);

    final PostPlantingModel updatedPostPlantingObject =
        Provider.of<PostPlantingProvider>(
      context,
      listen: false,
    ).findByPlot(plotId);

    void seedlingVigourHandler(value) {
      updatedPostPlantingObject.seedlingVigour = value;
    }

    void seedlingVigourCommentsHandler(value) {
      updatedPostPlantingObject.seedlingVigourComments = value;
    }

    void plantStandHandler(value) {
      updatedPostPlantingObject.plantStand = int.parse(value);
    }

    void plantStandCommentsHandler(value) {
      updatedPostPlantingObject.plantStandComments = value;
    }

    void onSubmitHandler() {
      updatedPostPlantingObject.lastUpdated = DateTime.now();
      updatedPostPlantingObject.isUpToDateInServer = 'No';

      Provider.of<PostPlantingProvider>(
        context,
        listen: false,
      ).updatePostPlantingObject(
        updatedPostPlantingObject,
        true,
      );

      Navigator.of(context).pop();
    }

    final String crop = Provider.of<AuthProvider>(
      context,
      listen: false,
    ).crop;

    return Scaffold(
      appBar: AppBar(
        title: Text('Post Planting - Plot $plotId'),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          ListWidgetComponent(
            title: 'Seedling Vigour',
            subtitle: postPlantingObject.seedlingVigour,
            value: postPlantingObject.seedlingVigour,
            onChangeDateValueHandler: () {},
            onChangeTextValueHandler: seedlingVigourHandler,
            onSubmitHandler: onSubmitHandler,
            isDropDownField: true,
            listOfValues: <String>[
              '1-Very Good',
              '2-Good',
              '3-Fair',
              '4-Bad',
              '5-Very Bad',
            ],
            isTrait: true,
            isTextField: false,
            onChangeGenComValueHandler: seedlingVigourCommentsHandler,
            genComSubtitle: postPlantingObject.seedlingVigourComments,
          ),
          ListWidgetComponent(
            title: 'Plant Stand',
            subtitle: postPlantingObject.plantStand == null
                ? 'Blank'
                : postPlantingObject.plantStand.toString(),
            value: postPlantingObject.plantStand == null
                ? 'Blank'
                : postPlantingObject.plantStand.toString(),
            onChangeDateValueHandler: () {},
            onChangeTextValueHandler: plantStandHandler,
            onSubmitHandler: onSubmitHandler,
            isNumberField: true,
            isTrait: true,
            onChangeGenComValueHandler: plantStandCommentsHandler,
            genComSubtitle: postPlantingObject.plantStandComments,
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: PlotsFloatingButtons(
          routeName: routeName, crop: crop, plotId: plotId),
    );
  }
}
