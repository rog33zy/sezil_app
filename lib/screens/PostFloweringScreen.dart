import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../helpers/id_generator_helper.dart';

import '../providers/PostFloweringProvider.dart';
import '../providers/AuthProvider.dart';

import '../models/PostFloweringModel.dart';

import '../components/UI/ListWidgetComponent.dart';
import '../components/UI/PlotsFloatingButtons.dart';

class PostFloweringScreen extends StatelessWidget {
  PostFloweringScreen({Key? key}) : super(key: key);

  static const routeName = '/post-flowering';

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(
      context,
      listen: false,
    );

    final String crop = authProvider.crop;

    final bool? isFarmer = authProvider.isSezilMotherTrialFarmer;

    final argumentsMap = ModalRoute.of(context)?.settings.arguments as Map;
    final plotId = argumentsMap['argument'];

    final bool isObjectExisiting = Provider.of<PostFloweringProvider>(
      context,
      listen: false,
    ).isExisting(plotId);

    if (!isObjectExisiting) {
      PostFloweringModel newPostFloweringObject = PostFloweringModel(
        id: IDGeneratorHelper.generateId(),
        lastUpdated: DateTime.now(),
        plotId: plotId,
      );

      Provider.of<PostFloweringProvider>(
        context,
        listen: false,
      ).updatePostFloweringObject(
        newPostFloweringObject,
        false,
      );
    }

    final PostFloweringModel postFloweringObject =
        Provider.of<PostFloweringProvider>(
      context,
      listen: true,
    ).findByPlot(plotId);

    final PostFloweringModel updatedPostFloweringObject =
        Provider.of<PostFloweringProvider>(
      context,
      listen: false,
    ).findByPlot(plotId);

    void pestResistanceHandler(value) {
      updatedPostFloweringObject.pestResistance = value;
    }

    void pestResistanceCommentsHandler(value) {
      updatedPostFloweringObject.pestResistanceComments = value;
    }

    void diseasesResistanceHandler(value) {
      updatedPostFloweringObject.diseasesResistance = value;
    }

    void diseasesResistanceCommentsHandler(value) {
      updatedPostFloweringObject.diseasesResistanceComments = value;
    }

    void onSubmitHandler() {
      updatedPostFloweringObject.lastUpdated = DateTime.now();
      updatedPostFloweringObject.isUpToDateInServer = 'No';

      Provider.of<PostFloweringProvider>(
        context,
        listen: false,
      ).updatePostFloweringObject(
        updatedPostFloweringObject,
        true,
      );

      Navigator.of(context).pop();
    }

    return Scaffold(
      appBar: AppBar(
        title: isFarmer!
            ? Text(
                'Posatila Maluwa - Plot $plotId',
                style: TextStyle(fontSize: 17.5),
              )
            : Text('PostFlowering - Plot $plotId'),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          ListWidgetComponent(
            title: isFarmer ? 'Kukakaniza Kwa Tudoyo' : 'Pest Resistance',
            subtitle: postFloweringObject.pestResistance,
            value: postFloweringObject.pestResistance,
            onChangeDateValueHandler: () {},
            onChangeTextValueHandler: pestResistanceHandler,
            onSubmitHandler: onSubmitHandler,
            isDropDownField: true,
            listOfValues: <String>[
              '1-Very High',
              '2-High',
              '3-Moderate',
              '4-Low',
              '5-Very Low',
            ],
            isTrait: true,
            isTextField: false,
            onChangeGenComValueHandler: pestResistanceCommentsHandler,
            genComSubtitle: postFloweringObject.pestResistanceComments,
          ),
          ListWidgetComponent(
            title: isFarmer ? 'Kukakaniza Kwa Matenda' : 'Disease Resistance',
            subtitle: postFloweringObject.diseasesResistance,
            value: postFloweringObject.diseasesResistance,
            onChangeDateValueHandler: () {},
            onChangeTextValueHandler: diseasesResistanceHandler,
            onSubmitHandler: onSubmitHandler,
            isDropDownField: true,
            listOfValues: <String>[
              '1-Very High',
              '2-High',
              '3-Moderate',
              '4-Low',
              '5-Very Low',
            ],
            isTrait: true,
            isTextField: false,
            onChangeGenComValueHandler: diseasesResistanceCommentsHandler,
            genComSubtitle: postFloweringObject.diseasesResistanceComments,
          ),
        ],
      ),
      floatingActionButton: PlotsFloatingButtons(
        routeName: routeName,
        crop: crop,
        plotId: plotId,
      ),
    );
  }
}
