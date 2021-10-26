import 'package:flutter/material.dart';

import 'package:recase/recase.dart';

import 'package:provider/provider.dart';
import 'package:location/location.dart';

import '../providers/FieldProfileProvider.dart';

import '../models/FieldProfileModel.dart';

import '../components/UI/ListWidgetComponent.dart';

import '../constants/Seasons.dart';

class FieldProfileScreen extends StatefulWidget {
  const FieldProfileScreen({Key? key}) : super(key: key);

  static const routeName = '/field-profile';

  @override
  State<FieldProfileScreen> createState() => _FieldProfileScreenState();
}

class _FieldProfileScreenState extends State<FieldProfileScreen> {
  var updatedFieldProfileObject;
  Set finalOptionsPrevSeasonSet = <String>{};
  var finalStringPrevSeason;
  var maizeValuePrevSeason;
  var sorghumValuePrevSeason;
  var beansValuePrevSeason;
  var soybeansValuePrevSeason;
  var groundnutsValuePrevSeason;
  var cowpeasValuePrevSeason;
  var sunflowerValuePrevSeason;
  var fallowValuePrevSeason;
  var otherValuePrevSeason;

  Set finalOptionsSeasonBeforeLastSet = <String>{};
  var finalStringSeasonBeforeLast;
  var maizeValueSeasonBeforeLast;
  var sorghumValueSeasonBeforeLast;
  var beansValueSeasonBeforeLast;
  var soybeansValueSeasonBeforeLast;
  var groundnutsValueSeasonBeforeLast;
  var cowpeasValueSeasonBeforeLast;
  var sunflowerValueSeasonBeforeLast;
  var fallowValueSeasonBeforeLast;
  var otherValueSeasonBeforeLast;

  @override
  void initState() {
    super.initState();

    updatedFieldProfileObject = Provider.of<FieldProfileProvider>(
      context,
      listen: false,
    ).getFieldProfileObject;

    finalOptionsPrevSeasonSet =
        updatedFieldProfileObject.cropGrownPrevSeason.split(',').toSet();

    maizeValuePrevSeason = finalOptionsPrevSeasonSet.contains('Maize');
    sorghumValuePrevSeason = finalOptionsPrevSeasonSet.contains('Sorghum');
    beansValuePrevSeason = finalOptionsPrevSeasonSet.contains('Beans');
    soybeansValuePrevSeason = finalOptionsPrevSeasonSet.contains('Soybeans');

    groundnutsValuePrevSeason =
        finalOptionsPrevSeasonSet.contains('Groundnuts');
    cowpeasValuePrevSeason = finalOptionsPrevSeasonSet.contains('Cowpeas');
    sunflowerValuePrevSeason = finalOptionsPrevSeasonSet.contains('Sunflower');
    fallowValuePrevSeason = finalOptionsPrevSeasonSet.contains('Fallow');

    otherValuePrevSeason = finalOptionsPrevSeasonSet.contains('Other');

    finalStringPrevSeason = finalOptionsPrevSeasonSet.join(',');

    finalOptionsSeasonBeforeLastSet =
        updatedFieldProfileObject.cropGrownTwoSeasonsAgo.split(',').toSet();

    maizeValueSeasonBeforeLast =
        finalOptionsSeasonBeforeLastSet.contains('Maize');
    sorghumValueSeasonBeforeLast =
        finalOptionsSeasonBeforeLastSet.contains('Sorghum');
    beansValueSeasonBeforeLast =
        finalOptionsSeasonBeforeLastSet.contains('Beans');
    soybeansValueSeasonBeforeLast =
        finalOptionsSeasonBeforeLastSet.contains('Soybeans');

    groundnutsValueSeasonBeforeLast =
        finalOptionsSeasonBeforeLastSet.contains('Groundnuts');
    cowpeasValueSeasonBeforeLast =
        finalOptionsSeasonBeforeLastSet.contains('Cowpeas');
    sunflowerValueSeasonBeforeLast =
        finalOptionsSeasonBeforeLastSet.contains('Sunflower');
    fallowValueSeasonBeforeLast =
        finalOptionsSeasonBeforeLastSet.contains('Fallow');

    otherValueSeasonBeforeLast =
        finalOptionsSeasonBeforeLastSet.contains('Other');

    finalStringSeasonBeforeLast = finalOptionsSeasonBeforeLastSet.join(',');
  }

  void onChangedMaizePrevSeasonValue(
    bool newValue,
    String pickedValue,
  ) {
    setState(() {
      maizeValuePrevSeason = newValue;
      prevSeasonCropHandler(
        newValue,
        pickedValue,
      );
    });
  }

  void onChangedSorghumPrevSeasonValue(
    bool newValue,
    String pickedValue,
  ) {
    setState(() {
      sorghumValuePrevSeason = newValue;
      prevSeasonCropHandler(
        newValue,
        pickedValue,
      );
    });
  }

  void onChangedBeansPrevSeasonValue(
    bool newValue,
    String pickedValue,
  ) {
    setState(() {
      beansValuePrevSeason = newValue;
      prevSeasonCropHandler(
        newValue,
        pickedValue,
      );
    });
  }

  void onChangedSoybeansPrevSeasonValue(
    bool newValue,
    String pickedValue,
  ) {
    setState(() {
      soybeansValuePrevSeason = newValue;
      prevSeasonCropHandler(
        newValue,
        pickedValue,
      );
    });
  }

  void onChangedGroundnutsPrevSeasonValue(
    bool newValue,
    String pickedValue,
  ) {
    setState(() {
      groundnutsValuePrevSeason = newValue;
      prevSeasonCropHandler(
        newValue,
        pickedValue,
      );
    });
  }

  void onChangedCowpeasPrevSeasonValue(
    bool newValue,
    String pickedValue,
  ) {
    setState(() {
      cowpeasValuePrevSeason = newValue;
      prevSeasonCropHandler(
        newValue,
        pickedValue,
      );
    });
  }

  void onChangedSunflowerPrevSeasonValue(
    bool newValue,
    String pickedValue,
  ) {
    setState(() {
      sunflowerValuePrevSeason = newValue;
      prevSeasonCropHandler(
        newValue,
        pickedValue,
      );
    });
  }

  void onChangedFallowPrevSeasonValue(
    bool newValue,
    String pickedValue,
  ) {
    setState(() {
      fallowValuePrevSeason = newValue;
      prevSeasonCropHandler(
        newValue,
        pickedValue,
      );
    });
  }

  void onChangedOtherPrevSeasonValue(
    bool newValue,
    String pickedValue,
  ) {
    setState(() {
      otherValuePrevSeason = newValue;
      prevSeasonCropHandler(
        newValue,
        pickedValue,
      );
    });
  }

  void onChangedMaizeSeasonBeforeLastValue(
    bool newValue,
    String pickedValue,
  ) {
    setState(() {
      maizeValueSeasonBeforeLast = newValue;
      seasonBeforeLastCropHandler(
        newValue,
        pickedValue,
      );
    });
  }

  void onChangedSorghumSeasonBeforeLastValue(
    bool newValue,
    String pickedValue,
  ) {
    setState(() {
      sorghumValueSeasonBeforeLast = newValue;
      seasonBeforeLastCropHandler(
        newValue,
        pickedValue,
      );
    });
  }

  void onChangedBeansSeasonBeforeLastValue(
    bool newValue,
    String pickedValue,
  ) {
    setState(() {
      beansValueSeasonBeforeLast = newValue;
      seasonBeforeLastCropHandler(
        newValue,
        pickedValue,
      );
    });
  }

  void onChangedSoybeansSeasonBeforeLastValue(
    bool newValue,
    String pickedValue,
  ) {
    setState(() {
      soybeansValueSeasonBeforeLast = newValue;
      seasonBeforeLastCropHandler(
        newValue,
        pickedValue,
      );
    });
  }

  void onChangedGroundnutsSeasonBeforeLastValue(
    bool newValue,
    String pickedValue,
  ) {
    setState(() {
      groundnutsValueSeasonBeforeLast = newValue;
      seasonBeforeLastCropHandler(
        newValue,
        pickedValue,
      );
    });
  }

  void onChangedCowpeasSeasonBeforeLastValue(
    bool newValue,
    String pickedValue,
  ) {
    setState(() {
      cowpeasValueSeasonBeforeLast = newValue;
      seasonBeforeLastCropHandler(
        newValue,
        pickedValue,
      );
    });
  }

  void onChangedSunflowerSeasonBeforeLastValue(
    bool newValue,
    String pickedValue,
  ) {
    setState(() {
      sunflowerValueSeasonBeforeLast = newValue;
      seasonBeforeLastCropHandler(
        newValue,
        pickedValue,
      );
    });
  }

  void onChangedFallowSeasonBeforeLastValue(
    bool newValue,
    String pickedValue,
  ) {
    setState(() {
      fallowValueSeasonBeforeLast = newValue;
      seasonBeforeLastCropHandler(
        newValue,
        pickedValue,
      );
    });
  }

  void onChangedOtherSeasonBeforeLastValue(
    bool newValue,
    String pickedValue,
  ) {
    setState(() {
      otherValueSeasonBeforeLast = newValue;
      seasonBeforeLastCropHandler(
        newValue,
        pickedValue,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    FieldProfileModel fieldProfileObject = Provider.of<FieldProfileProvider>(
      context,
      listen: true,
    ).getFieldProfileObject;

    List cropOptionsPrevSeason = [
      {
        'label': 'Maize',
        'value': maizeValuePrevSeason as bool,
        'onChanged': onChangedMaizePrevSeasonValue,
      },
      {
        'label': 'Sorghum',
        'value': sorghumValuePrevSeason as bool,
        'onChanged': onChangedSorghumPrevSeasonValue,
      },
      {
        'label': 'Beans',
        'value': beansValuePrevSeason as bool,
        'onChanged': onChangedBeansPrevSeasonValue,
      },
      {
        'label': 'Soybeans',
        'value': soybeansValuePrevSeason as bool,
        'onChanged': onChangedSoybeansPrevSeasonValue,
      },
      {
        'label': 'Groundnuts',
        'value': groundnutsValuePrevSeason as bool,
        'onChanged': onChangedGroundnutsPrevSeasonValue,
      },
      {
        'label': 'Cowpeas',
        'value': cowpeasValuePrevSeason as bool,
        'onChanged': onChangedCowpeasPrevSeasonValue,
      },
      {
        'label': 'Sunflower',
        'value': sunflowerValuePrevSeason as bool,
        'onChanged': onChangedSunflowerPrevSeasonValue,
      },
      {
        'label': 'Fallow',
        'value': fallowValuePrevSeason as bool,
        'onChanged': onChangedFallowPrevSeasonValue,
      },
      {
        'label': 'Other',
        'value': otherValuePrevSeason as bool,
        'onChanged': onChangedOtherPrevSeasonValue,
      },
    ];

    List cropOptionsSeasonBeforeLast = [
      {
        'label': 'Maize',
        'value': maizeValueSeasonBeforeLast as bool,
        'onChanged': onChangedMaizeSeasonBeforeLastValue,
      },
      {
        'label': 'Sorghum',
        'value': sorghumValueSeasonBeforeLast as bool,
        'onChanged': onChangedSorghumSeasonBeforeLastValue,
      },
      {
        'label': 'Beans',
        'value': beansValueSeasonBeforeLast as bool,
        'onChanged': onChangedBeansSeasonBeforeLastValue,
      },
      {
        'label': 'Soybeans',
        'value': soybeansValueSeasonBeforeLast as bool,
        'onChanged': onChangedSoybeansSeasonBeforeLastValue,
      },
      {
        'label': 'Groundnuts',
        'value': groundnutsValueSeasonBeforeLast as bool,
        'onChanged': onChangedGroundnutsSeasonBeforeLastValue,
      },
      {
        'label': 'Cowpeas',
        'value': cowpeasValueSeasonBeforeLast as bool,
        'onChanged': onChangedCowpeasSeasonBeforeLastValue,
      },
      {
        'label': 'Sunflower',
        'value': sunflowerValueSeasonBeforeLast as bool,
        'onChanged': onChangedSunflowerSeasonBeforeLastValue,
      },
      {
        'label': 'Fallow',
        'value': fallowValueSeasonBeforeLast as bool,
        'onChanged': onChangedFallowSeasonBeforeLastValue,
      },
      {
        'label': 'Other',
        'value': otherValueSeasonBeforeLast as bool,
        'onChanged': onChangedOtherSeasonBeforeLastValue,
      },
    ];

    void fieldSizeHandler(value) {
      updatedFieldProfileObject.fieldSize = value;
    }

    void soilTypeHandler(value) {
      updatedFieldProfileObject.soilType = value;
    }

    void prevSeasonWeedingManualHandler(value) {
      updatedFieldProfileObject.prevSeasonWeedingManual = value;
    }

    void prevSeasonWeedingChemicalNameHandler(String value) {
      updatedFieldProfileObject.prevSeasonWeedingChemicalName = value.titleCase;
    }

    void fieldCoordinatesHandler() async {
      final locData = await Location().getLocation();

      updatedFieldProfileObject.latitude = locData.latitude;
      updatedFieldProfileObject.longitude = locData.longitude;

      updatedFieldProfileObject.lastUpdated = DateTime.now();
      updatedFieldProfileObject.isUpToDateInServer = 'No';

      Provider.of<FieldProfileProvider>(
        context,
        listen: false,
      ).updateFieldProfileObject(updatedFieldProfileObject);

      Navigator.of(context).pop();
    }

    void onSubmitHandler() {
      updatedFieldProfileObject.lastUpdated = DateTime.now();
      updatedFieldProfileObject.isUpToDateInServer = 'No';

      Provider.of<FieldProfileProvider>(
        context,
        listen: false,
      ).updateFieldProfileObject(updatedFieldProfileObject);

      Navigator.of(context).pop();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Field Profile"),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          ListWidgetComponent(
            title: 'Field Size',
            subtitle: fieldProfileObject.fieldSize,
            value: fieldProfileObject.fieldSize,
            onChangeDateValueHandler: () {},
            onChangeTextValueHandler: fieldSizeHandler,
            onSubmitHandler: onSubmitHandler,
            isTextField: true,
            onChangeGenComValueHandler: () {},
          ),
          ListWidgetComponent(
            title: 'Soil Type',
            subtitle: fieldProfileObject.soilType,
            value: fieldProfileObject.soilType,
            onChangeDateValueHandler: () {},
            onChangeTextValueHandler: soilTypeHandler,
            onSubmitHandler: onSubmitHandler,
            isDropDownField: true,
            isTextField: false,
            listOfValues: <String>[
              'Light',
              'Heavy',
              'Other',
            ],
            onChangeGenComValueHandler: () {},
          ),
          ListWidgetComponent(
            title: 'Field Coordinates',
            subtitle: fieldProfileObject.latitude == null
                ? 'Blank'
                : '${fieldProfileObject.latitude}, ${fieldProfileObject.longitude}',
            value: fieldProfileObject.latitude == null
                ? 'Blank'
                : '${fieldProfileObject.latitude}, ${fieldProfileObject.longitude}',
            onChangeDateValueHandler: () {},
            onChangeTextValueHandler: () {},
            onSubmitHandler: fieldCoordinatesHandler,
            isTextField: false,
            onChangeGenComValueHandler: () {},
          ),
          ListWidgetComponent(
            title: 'Crop(s) Grown ${Seasons.previousSeason} Season',
            subtitle: fieldProfileObject.cropGrownPrevSeason == ''
                ? 'Blank'
                : fieldProfileObject.cropGrownPrevSeason,
            value: fieldProfileObject.cropGrownPrevSeason,
            onChangeDateValueHandler: () {},
            onChangeTextValueHandler: () {},
            onSubmitHandler: () {},
            isDropDownField: true,
            listOfValues: cropOptionsPrevSeason,
            isTextField: false,
            onChangeGenComValueHandler: () {},
            isLeadingToCheckBoxScreen: true,
          ),
          ListWidgetComponent(
            title: 'Crop(s) Grown ${Seasons.seasonBeforeLast} Season',
            subtitle: fieldProfileObject.cropGrownTwoSeasonsAgo == ''
                ? 'Blank'
                : fieldProfileObject.cropGrownTwoSeasonsAgo,
            value: fieldProfileObject.cropGrownTwoSeasonsAgo,
            onChangeDateValueHandler: () {},
            onChangeTextValueHandler: () {},
            onSubmitHandler: () {},
            isDropDownField: true,
            listOfValues: cropOptionsSeasonBeforeLast,
            isTextField: false,
            onChangeGenComValueHandler: () {},
            isLeadingToCheckBoxScreen: true,
          ),
          ListWidgetComponent(
            title: 'Manual Weeding ${Seasons.previousSeason} Season?',
            subtitle: fieldProfileObject.prevSeasonWeedingManual,
            value: fieldProfileObject.prevSeasonWeedingManual,
            onChangeDateValueHandler: () {},
            onChangeTextValueHandler: prevSeasonWeedingManualHandler,
            onSubmitHandler: onSubmitHandler,
            isDropDownField: true,
            isTextField: false,
            listOfValues: <String>[
              'Yes',
              'No',
            ],
            onChangeGenComValueHandler: () {},
          ),
          ListWidgetComponent(
            title: 'Herbicide Used ${Seasons.previousSeason} Season',
            subtitle: fieldProfileObject.prevSeasonWeedingChemicalName,
            value: fieldProfileObject.prevSeasonWeedingChemicalName,
            onChangeDateValueHandler: () {},
            onChangeTextValueHandler: prevSeasonWeedingChemicalNameHandler,
            onSubmitHandler: onSubmitHandler,
            isTextField: true,
            onChangeGenComValueHandler: () {},
          ),
        ],
      ),
    );
  }

  void prevSeasonCropHandler(newValue, pickedValue) {
    if (newValue) {
      finalOptionsPrevSeasonSet.add(pickedValue);
    } else {
      finalOptionsPrevSeasonSet.remove(pickedValue);
    }
    finalOptionsPrevSeasonSet.remove('Blank');

    finalStringPrevSeason = finalOptionsPrevSeasonSet.join(',');

    updatedFieldProfileObject.cropGrownPrevSeason = finalStringPrevSeason;

    updatedFieldProfileObject.lastUpdated = DateTime.now();
    updatedFieldProfileObject.isUpToDateInServer = 'No';

    Provider.of<FieldProfileProvider>(
      context,
      listen: false,
    ).updateFieldProfileObject(updatedFieldProfileObject);
  }

  void seasonBeforeLastCropHandler(newValue, pickedValue) {
    if (newValue) {
      finalOptionsSeasonBeforeLastSet.add(pickedValue);
    } else {
      finalOptionsSeasonBeforeLastSet.remove(pickedValue);
    }
    finalOptionsSeasonBeforeLastSet.remove('Blank');

    finalStringSeasonBeforeLast = finalOptionsSeasonBeforeLastSet.join(',');
    updatedFieldProfileObject.cropGrownTwoSeasonsAgo =
        finalStringSeasonBeforeLast;
    updatedFieldProfileObject.lastUpdated = DateTime.now();
    updatedFieldProfileObject.isUpToDateInServer = 'No';
    Provider.of<FieldProfileProvider>(
      context,
      listen: false,
    ).updateFieldProfileObject(updatedFieldProfileObject);
  }
}
