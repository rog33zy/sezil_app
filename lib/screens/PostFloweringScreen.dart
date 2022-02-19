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

    void pestAndDiseasesResistanceHandler(value) {
      updatedPostFloweringObject.pestAndDiseasesResistance = value;
    }

    void pestAndDiseasesResistanceCommentsHandler(value) {
      updatedPostFloweringObject.pestAndDiseasesResistanceComments = value;
    }

    void droughtToleranceHandler(value) {
      updatedPostFloweringObject.droughtTolerance = value;
    }

    void droughtToleranceCommentsHandler(value) {
      updatedPostFloweringObject.droughtToleranceComments = value;
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
            title: isFarmer
                ? 'Kukakaniza Kwa Tudoyo Ndi Matenda'
                : 'Pest and Diseases Resistance',
            subtitle: postFloweringObject.pestAndDiseasesResistance,
            value: postFloweringObject.pestAndDiseasesResistance,
            onChangeDateValueHandler: () {},
            onChangeTextValueHandler: pestAndDiseasesResistanceHandler,
            onSubmitHandler: onSubmitHandler,
            isDropDownField: true,
            listOfValues: isFarmer
                ? const <String>[
                    '1-Kukanikiza Kwambili',
                    '2-Kukanikiza',
                    '3-Kukanikiza Mwapakati',
                    '4-Kukanikiza Pangono',
                    '5-Kusakanikiza',
                  ]
                : const <String>[
                    '1-Very High',
                    '2-High',
                    '3-Moderate',
                    '4-Low',
                    '5-Very Low',
                  ],
            isTrait: true,
            isTextField: false,
            onChangeGenComValueHandler:
                pestAndDiseasesResistanceCommentsHandler,
            genComSubtitle:
                postFloweringObject.pestAndDiseasesResistanceComments,
          ),
          ListWidgetComponent(
            title: isFarmer ? 'Kulimba Ku Cilala' : 'Drought Tolerance',
            subtitle: postFloweringObject.droughtTolerance,
            value: postFloweringObject.droughtTolerance,
            onChangeDateValueHandler: () {},
            onChangeTextValueHandler: droughtToleranceHandler,
            onSubmitHandler: onSubmitHandler,
            isDropDownField: true,
            listOfValues: isFarmer
                ? const <String>[
                    '1-Kulimba Kwambili',
                    '2-Kulimba',
                    '3-Kulimba Mwapakati',
                    '4-Kulimba Pangono',
                    '5-Kusalimba',
                  ]
                : const <String>[
                    '1-Very High',
                    '2-High',
                    '3-Moderate',
                    '4-Low',
                    '5-Very Low',
                  ],
            isTrait: true,
            isTextField: false,
            onChangeGenComValueHandler: droughtToleranceCommentsHandler,
            genComSubtitle: postFloweringObject.droughtToleranceComments,
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
