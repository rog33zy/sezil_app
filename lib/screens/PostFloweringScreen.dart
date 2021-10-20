import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../helpers/id_generator_helper.dart';

import '../providers/PostFloweringProvider.dart';

import '../models/PostFloweringModel.dart';

import '../components/UI/ListWidgetComponent.dart';
import '../components/UI/FloatingActionButtonComp.dart';

class PostFloweringScreen extends StatelessWidget {
  PostFloweringScreen({Key? key}) : super(key: key);

  static const routeName = '/post-flowering';


  @override
  Widget build(BuildContext context) {
    

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

    final PostFloweringModel postFloweringObject = Provider.of<PostFloweringProvider>(
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
        title: Text('PostFlowering - Plot $plotId'),
        centerTitle: true,
      ),
      body: ListView(
        children: [
      
            ListWidgetComponent(
              title: 'Pest Resistance',
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
              title: 'Disease Resistance',
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
      floatingActionButton: FloatingActionButtonComp(),
    );
  }
}
