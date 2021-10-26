import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:provider/provider.dart';

import '../providers/AuthProvider.dart';

import '../helpers/id_generator_helper.dart';

import '../providers/HarvestProvider.dart';

import '../models/HarvestModel.dart';

import '../components/UI/ListWidgetComponent.dart';
import '../components/UI/PlotsFloatingButtons.dart';

class HarvestScreen extends StatelessWidget {
  HarvestScreen({Key? key}) : super(key: key);

  static const routeName = '/harvest';

  @override
  Widget build(BuildContext context) {
    final String crop = Provider.of<AuthProvider>(
      context,
      listen: false,
    ).crop;
    final argumentsMap = ModalRoute.of(context)?.settings.arguments as Map;
    final plotId = argumentsMap['argument'];

    final bool isObjectExisiting = Provider.of<HarvestProvider>(
      context,
      listen: false,
    ).isExisting(plotId);
    if (!isObjectExisiting) {
      HarvestModel newHarvestObject = HarvestModel(
        id: IDGeneratorHelper.generateId(),
        lastUpdated: DateTime.now(),
        plotId: plotId,
      );
      Provider.of<HarvestProvider>(
        context,
        listen: false,
      ).updateHarvestObject(
        newHarvestObject,
        false,
      );
    }

    final HarvestModel harvestObject = Provider.of<HarvestProvider>(
      context,
      listen: true,
    ).findByPlot(plotId);

    final HarvestModel updatedHarvestObject = Provider.of<HarvestProvider>(
      context,
      listen: false,
    ).findByPlot(plotId);

    void harvestDateHandler(value) {
      updatedHarvestObject.harvestDate = value;
    }

    void numberOfPlantsHandler(String value) {
      updatedHarvestObject.numberOfPlants = int.parse(value);
    }

    void numberOfPlantsCommentsHandler(String value) {
      updatedHarvestObject.numberOfPlantsComments = value;
    }

    void numberOfHarvestedCobsHandler(String value) {
      updatedHarvestObject.numberOfHarvestedCobs = int.parse(value);
    }

    void numberOfHarvestedCobsCommentsHandler(String value) {
      updatedHarvestObject.numberOfHarvestedCobsComments = value;
    }

    void yieldOfHarvestedCobsHandler(String value) {
      updatedHarvestObject.yieldOfHarvestedCobs = double.parse(value);
    }

    void yieldOfHarvestedCobsCommentsHandler(String value) {
      updatedHarvestObject.yieldOfHarvestedCobsComments = value;
    }

    void numberOfHarvestedPaniclesHandler(String value) {
      updatedHarvestObject.numberOfHarvestedPanicles = int.parse(value);
    }

    void numberOfHarvestedPaniclesCommentsHandler(String value) {
      updatedHarvestObject.numberOfHarvestedPaniclesComments = value;
    }

    void yieldOfHarvestedPaniclesHandler(String value) {
      updatedHarvestObject.yieldOfHarvestedPanicles = double.parse(value);
    }

    void yieldOfHarvestedPaniclesCommentsHandler(String value) {
      updatedHarvestObject.yieldOfHarvestedPaniclesComments = value;
    }

    void numberOfHarvestedHeadsHandler(String value) {
      updatedHarvestObject.numberOfHarvestedHeads = int.parse(value);
    }

    void numberOfHarvestedHeadsCommentsHandler(String value) {
      updatedHarvestObject.numberOfHarvestedHeadsComments = value;
    }

    void yieldOfHarvestedHeadsHandler(String value) {
      updatedHarvestObject.yieldOfHarvestedHeads = double.parse(value);
    }

    void yieldOfHarvestedHeadsCommentsHandler(String value) {
      updatedHarvestObject.yieldOfHarvestedHeadsComments = value;
    }

    void numberOfHarvestedPodsHandler(String value) {
      updatedHarvestObject.numberOfHarvestedPods = int.parse(value);
    }

    void numberOfHarvestedPodsCommentsHandler(String value) {
      updatedHarvestObject.numberOfHarvestedPodsComments = value;
    }

    void yieldOfHarvestedPodsHandler(String value) {
      updatedHarvestObject.yieldOfHarvestedPods = double.parse(value);
    }

    void yieldOfHarvestedPodsCommentsHandler(String value) {
      updatedHarvestObject.yieldOfHarvestedPodsComments = value;
    }

    void onSubmitHandler() {
      updatedHarvestObject.lastUpdated = DateTime.now();
      updatedHarvestObject.isUpToDateInServer = 'No';

      Provider.of<HarvestProvider>(
        context,
        listen: false,
      ).updateHarvestObject(
        updatedHarvestObject,
        true,
      );

      Navigator.of(context).pop();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Harvest - Plot $plotId'),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          ListWidgetComponent(
            title: 'Date of Harvest',
            subtitle: harvestObject.harvestDate == null
                ? 'Blank'
                : _formatDate(harvestObject.harvestDate),
            value: harvestObject.harvestDate == null
                ? 'Blank'
                : harvestObject.harvestDate!.toIso8601String(),
            onChangeDateValueHandler: harvestDateHandler,
            onChangeTextValueHandler: () {},
            onSubmitHandler: onSubmitHandler,
            isDateField: true,
            onChangeGenComValueHandler: () {},
          ),
          ListWidgetComponent(
            title: 'Number of Plants',
            subtitle: harvestObject.numberOfPlants == null
                ? 'Blank'
                : harvestObject.numberOfPlants.toString(),
            value: harvestObject.numberOfPlants == null
                ? 'Blank'
                : harvestObject.numberOfPlants.toString(),
            onChangeDateValueHandler: () {},
            onChangeTextValueHandler: numberOfPlantsHandler,
            onSubmitHandler: onSubmitHandler,
            isNumberField: true,
            onChangeGenComValueHandler: numberOfPlantsCommentsHandler,
            isTrait: true,
            genComSubtitle: harvestObject.numberOfPlantsComments,
          ),
          if (crop == 'Maize')
            ListWidgetComponent(
              title: 'Number of Harvested Cobs',
              subtitle: harvestObject.numberOfHarvestedCobs == null
                  ? 'Blank'
                  : harvestObject.numberOfHarvestedCobs.toString(),
              value: harvestObject.numberOfHarvestedCobs == null
                  ? 'Blank'
                  : harvestObject.numberOfHarvestedCobs.toString(),
              onChangeDateValueHandler: () {},
              onChangeTextValueHandler: numberOfHarvestedCobsHandler,
              onSubmitHandler: onSubmitHandler,
              isNumberField: true,
              onChangeGenComValueHandler: numberOfHarvestedCobsCommentsHandler,
              isTrait: true,
              genComSubtitle: harvestObject.numberOfHarvestedCobsComments,
            ),
          if (crop == 'Maize')
            ListWidgetComponent(
              title: 'Yield of Harvested Cobs (Kg)',
              subtitle: harvestObject.yieldOfHarvestedCobs == null
                  ? 'Blank'
                  : harvestObject.yieldOfHarvestedCobs.toString(),
              value: harvestObject.yieldOfHarvestedCobs == null
                  ? 'Blank'
                  : harvestObject.yieldOfHarvestedCobs.toString(),
              onChangeDateValueHandler: () {},
              onChangeTextValueHandler: yieldOfHarvestedCobsHandler,
              onSubmitHandler: onSubmitHandler,
              isNumberField: true,
              onChangeGenComValueHandler: yieldOfHarvestedCobsCommentsHandler,
              isTrait: true,
              genComSubtitle: harvestObject.yieldOfHarvestedCobsComments,
            ),
          if (crop == 'Sorghum')
            ListWidgetComponent(
              title: 'Number of Harvested Panicles',
              subtitle: harvestObject.numberOfHarvestedPanicles == null
                  ? 'Blank'
                  : harvestObject.numberOfHarvestedPanicles.toString(),
              value: harvestObject.numberOfHarvestedPanicles == null
                  ? 'Blank'
                  : harvestObject.numberOfHarvestedPanicles.toString(),
              onChangeDateValueHandler: () {},
              onChangeTextValueHandler: numberOfHarvestedPaniclesHandler,
              onSubmitHandler: onSubmitHandler,
              isNumberField: true,
              onChangeGenComValueHandler:
                  numberOfHarvestedPaniclesCommentsHandler,
              isTrait: true,
              genComSubtitle: harvestObject.numberOfHarvestedPaniclesComments,
            ),
          if (crop == 'Sorghum')
            ListWidgetComponent(
              title: 'Yield of Harvested Panicles (Kg)',
              subtitle: harvestObject.yieldOfHarvestedPanicles == null
                  ? 'Blank'
                  : harvestObject.yieldOfHarvestedPanicles.toString(),
              value: harvestObject.yieldOfHarvestedPanicles == null
                  ? 'Blank'
                  : harvestObject.yieldOfHarvestedPanicles.toString(),
              onChangeDateValueHandler: () {},
              onChangeTextValueHandler: yieldOfHarvestedPaniclesHandler,
              onSubmitHandler: onSubmitHandler,
              isNumberField: true,
              onChangeGenComValueHandler:
                  yieldOfHarvestedPaniclesCommentsHandler,
              isTrait: true,
              genComSubtitle: harvestObject.yieldOfHarvestedPaniclesComments,
            ),
          if (crop == 'Sunflower')
            ListWidgetComponent(
              title: 'Number of Harvested Heads',
              subtitle: harvestObject.numberOfHarvestedHeads == null
                  ? 'Blank'
                  : harvestObject.numberOfHarvestedHeads.toString(),
              value: harvestObject.numberOfHarvestedHeads == null
                  ? 'Blank'
                  : harvestObject.numberOfHarvestedHeads.toString(),
              onChangeDateValueHandler: () {},
              onChangeTextValueHandler: numberOfHarvestedHeadsHandler,
              onSubmitHandler: onSubmitHandler,
              isNumberField: true,
              onChangeGenComValueHandler: numberOfHarvestedHeadsCommentsHandler,
              isTrait: true,
              genComSubtitle: harvestObject.numberOfHarvestedHeadsComments,
            ),
          if (crop == 'Sunflower')
            ListWidgetComponent(
              title: 'Yield of Harvested Heads (Kg)',
              subtitle: harvestObject.yieldOfHarvestedHeads == null
                  ? 'Blank'
                  : harvestObject.yieldOfHarvestedHeads.toString(),
              value: harvestObject.yieldOfHarvestedHeads == null
                  ? 'Blank'
                  : harvestObject.yieldOfHarvestedHeads.toString(),
              onChangeDateValueHandler: () {},
              onChangeTextValueHandler: yieldOfHarvestedHeadsHandler,
              onSubmitHandler: onSubmitHandler,
              isNumberField: true,
              onChangeGenComValueHandler: yieldOfHarvestedHeadsCommentsHandler,
              isTrait: true,
              genComSubtitle: harvestObject.yieldOfHarvestedHeadsComments,
            ),
          if (crop == 'Beans')
            ListWidgetComponent(
              title: 'Number of Harvested Pods',
              subtitle: harvestObject.numberOfHarvestedPods == null
                  ? 'Blank'
                  : harvestObject.numberOfHarvestedPods.toString(),
              value: harvestObject.numberOfHarvestedPods == null
                  ? 'Blank'
                  : harvestObject.numberOfHarvestedPods.toString(),
              onChangeDateValueHandler: () {},
              onChangeTextValueHandler: numberOfHarvestedPodsHandler,
              onSubmitHandler: onSubmitHandler,
              isNumberField: true,
              onChangeGenComValueHandler: numberOfHarvestedPodsCommentsHandler,
              isTrait: true,
              genComSubtitle: harvestObject.numberOfHarvestedPodsComments,
            ),
          if (crop == 'Beans')
            ListWidgetComponent(
              title: 'Yield of Harvested Pods (Kg)',
              subtitle: harvestObject.yieldOfHarvestedPods == null
                  ? 'Blank'
                  : harvestObject.yieldOfHarvestedPods.toString(),
              value: harvestObject.yieldOfHarvestedPods == null
                  ? 'Blank'
                  : harvestObject.yieldOfHarvestedPods.toString(),
              onChangeDateValueHandler: () {},
              onChangeTextValueHandler: yieldOfHarvestedPodsHandler,
              onSubmitHandler: onSubmitHandler,
              isNumberField: true,
              onChangeGenComValueHandler: yieldOfHarvestedPodsCommentsHandler,
              isTrait: true,
              genComSubtitle: harvestObject.yieldOfHarvestedPodsComments,
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

  String _formatDate(dateTimeObject) {
    return DateFormat.yMMMd().format(dateTimeObject);
  }
}
