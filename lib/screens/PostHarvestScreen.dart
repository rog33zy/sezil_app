import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../helpers/id_generator_helper.dart';

import '../providers/PostHarvestProvider.dart';

import '../models/PostHarvestModel.dart';

import '../components/UI/ListWidgetComponent.dart';
import '../components/UI/FloatingActionButtonComp.dart';

class PostHarvestScreen extends StatelessWidget {
  const PostHarvestScreen({Key? key}) : super(key: key);

  static const routeName = '/post-harvest';

  @override
  Widget build(BuildContext context) {
    final argumentsMap = ModalRoute.of(context)?.settings.arguments as Map;
    final plotId = argumentsMap['argument'];

    final bool isObjectExisiting = Provider.of<PostHarvestProvider>(
      context,
      listen: false,
    ).isExisting(plotId);
    if (!isObjectExisiting) {
      PostHarvestModel newPostHarvestObject = PostHarvestModel(
        id: IDGeneratorHelper.generateId(),
        lastUpdated: DateTime.now(),
        plotId: plotId,
      );
      Provider.of<PostHarvestProvider>(
        context,
        listen: false,
      ).updatePostHarvestObject(
        newPostHarvestObject,
        false,
      );
    }

    final PostHarvestModel postHarvestObject = Provider.of<PostHarvestProvider>(
      context,
      listen: true,
    ).findByPlot(
      plotId,
    );

    final PostHarvestModel updatedPostHarvestObject =
        Provider.of<PostHarvestProvider>(
      context,
      listen: false,
    ).findByPlot(
      plotId,
    );

    void driedCobsYieldHandler(value) {
      updatedPostHarvestObject.yieldOfDriedCobs = double.parse(value);
    }

    void driedCobsYieldCommentsHandler(value) {
      updatedPostHarvestObject.yieldOfDriedCobsComments = value;
    }

    void grainHardnessHandler(value) {
      updatedPostHarvestObject.grainHardness = value;
    }

    void grainHardnessCommentsHandler(value) {
      updatedPostHarvestObject.grainHardnessComments = value;
    }

    void driedPaniclesYieldHandler(value) {
      updatedPostHarvestObject.yieldOfDriedPanicles = double.parse(value);
    }

    void driedPaniclesYieldCommentsHandler(value) {
      updatedPostHarvestObject.yieldOfDriedPaniclesComments = value;
    }

    void driedHeadsYieldHandler(value) {
      updatedPostHarvestObject.yieldOfDriedHeads = double.parse(value);
    }

    void driedHeadsYieldCommentsHandler(value) {
      updatedPostHarvestObject.yieldOfDriedHeadsComments = value;
    }

    void driedPodsYieldHandler(value) {
      updatedPostHarvestObject.yieldOfDriedPods = double.parse(value);
    }

    void driedPodsYieldCommentsHandler(value) {
      updatedPostHarvestObject.yieldOfDriedPodsComments = value;
    }

    void grainsYieldHandler(value) {
      updatedPostHarvestObject.grainsYield = double.parse(value);
    }

    void grainsYieldCommentsHandler(value) {
      updatedPostHarvestObject.grainsYieldComments = value;
    }

    void grainSizeHandler(value) {
      updatedPostHarvestObject.grainSize = value;
    }

    void grainSizeCommentsHandler(value) {
      updatedPostHarvestObject.grainSizeComments = value;
    }

    void grainColourHandler(value) {
      updatedPostHarvestObject.grainColour = value;
    }

    void grainColourCommentsHandler(value) {
      updatedPostHarvestObject.grainColourComments = value;
    }

    void onSubmitHandler() {
      updatedPostHarvestObject.lastUpdated = DateTime.now();
      updatedPostHarvestObject.isUpToDateInServer = 'No';

      Provider.of<PostHarvestProvider>(
        context,
        listen: false,
      ).updatePostHarvestObject(
        updatedPostHarvestObject,
        true,
      );

      Navigator.of(context).pop();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Post Harvest - Plot $plotId'),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          ListWidgetComponent(
            title: 'Yield of Dried Cobs (Kg)',
            subtitle: postHarvestObject.yieldOfDriedCobs == null
                ? 'Blank'
                : postHarvestObject.yieldOfDriedCobs.toString(),
            value: postHarvestObject.yieldOfDriedCobs == null
                ? 'Blank'
                : postHarvestObject.yieldOfDriedCobs.toString(),
            onChangeDateValueHandler: () {},
            onChangeTextValueHandler: driedCobsYieldHandler,
            onSubmitHandler: onSubmitHandler,
            isNumberField: true,
            onChangeGenComValueHandler: driedCobsYieldCommentsHandler,
            isTrait: true,
            genComSubtitle: postHarvestObject.yieldOfDriedCobsComments,
          ),
          ListWidgetComponent(
            title: 'Grain Hardness',
            subtitle: postHarvestObject.grainHardness,
            value: postHarvestObject.grainHardness,
            onChangeDateValueHandler: () {},
            onChangeTextValueHandler: grainHardnessHandler,
            onSubmitHandler: onSubmitHandler,
            isDropDownField: true,
            listOfValues: <String>[
              '1-Very Soft',
              '2-Soft',
              '3-Medium',
              '4-Hard',
              '5-Very Hard',
            ],
            isTrait: true,
            isTextField: false,
            onChangeGenComValueHandler: grainHardnessCommentsHandler,
            genComSubtitle: postHarvestObject.grainHardnessComments,
          ),
          ListWidgetComponent(
            title: 'Yield of Dried Panicles per Plot (Kg)',
            subtitle: postHarvestObject.yieldOfDriedPanicles == null
                ? 'Blank'
                : postHarvestObject.yieldOfDriedPanicles.toString(),
            value: postHarvestObject.yieldOfDriedPanicles == null
                ? 'Blank'
                : postHarvestObject.yieldOfDriedPanicles.toString(),
            onChangeDateValueHandler: () {},
            onChangeTextValueHandler: driedPaniclesYieldHandler,
            onSubmitHandler: onSubmitHandler,
            isNumberField: true,
            onChangeGenComValueHandler: driedPaniclesYieldCommentsHandler,
            isTrait: true,
            genComSubtitle: postHarvestObject.yieldOfDriedPaniclesComments,
          ),
          ListWidgetComponent(
            title: 'Yield of Dried Heads (Kg)',
            subtitle: postHarvestObject.yieldOfDriedHeads == null
                ? 'Blank'
                : postHarvestObject.yieldOfDriedHeads.toString(),
            value: postHarvestObject.yieldOfDriedHeads == null
                ? 'Blank'
                : postHarvestObject.yieldOfDriedHeads.toString(),
            onChangeDateValueHandler: () {},
            onChangeTextValueHandler: driedHeadsYieldHandler,
            onSubmitHandler: onSubmitHandler,
            isNumberField: true,
            onChangeGenComValueHandler: driedHeadsYieldCommentsHandler,
            isTrait: true,
            genComSubtitle: postHarvestObject.yieldOfDriedHeadsComments,
          ),
          ListWidgetComponent(
            title: 'Yield of Dried Pods (Kg)',
            subtitle: postHarvestObject.yieldOfDriedPods == null
                ? 'Blank'
                : postHarvestObject.yieldOfDriedPods.toString(),
            value: postHarvestObject.yieldOfDriedPods == null
                ? 'Blank'
                : postHarvestObject.yieldOfDriedPods.toString(),
            onChangeDateValueHandler: () {},
            onChangeTextValueHandler: driedPodsYieldHandler,
            onSubmitHandler: onSubmitHandler,
            isNumberField: true,
            onChangeGenComValueHandler: driedPodsYieldCommentsHandler,
            isTrait: true,
            genComSubtitle: postHarvestObject.yieldOfDriedPodsComments,
          ),
          ListWidgetComponent(
            title: 'Grain Yield (Kg)',
            subtitle: postHarvestObject.grainsYield == null
                ? 'Blank'
                : postHarvestObject.grainsYield.toString(),
            value: postHarvestObject.grainsYield == null
                ? 'Blank'
                : postHarvestObject.grainsYield.toString(),
            onChangeDateValueHandler: () {},
            onChangeTextValueHandler: grainsYieldHandler,
            onSubmitHandler: onSubmitHandler,
            isNumberField: true,
            onChangeGenComValueHandler: grainsYieldCommentsHandler,
            isTrait: true,
            genComSubtitle: postHarvestObject.grainsYieldComments,
          ),
          ListWidgetComponent(
            title: 'Grain Size',
            subtitle: postHarvestObject.grainSize,
            value: postHarvestObject.grainSize,
            onChangeDateValueHandler: () {},
            onChangeTextValueHandler: grainSizeHandler,
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
            onChangeGenComValueHandler: grainSizeCommentsHandler,
            genComSubtitle: postHarvestObject.grainSizeComments,
          ),
          ListWidgetComponent(
            title: 'Grain Colour',
            subtitle: postHarvestObject.grainColour,
            value: postHarvestObject.grainColour,
            onChangeDateValueHandler: () {},
            onChangeTextValueHandler: grainColourHandler,
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
            onChangeGenComValueHandler: grainColourCommentsHandler,
            genComSubtitle: postHarvestObject.grainColourComments,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButtonComp(),
    );
  }
}
