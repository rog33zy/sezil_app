import 'package:flutter/material.dart';

import 'package:recase/recase.dart';

import 'package:provider/provider.dart';
import 'package:location/location.dart';

import '../providers/FieldProfileProvider.dart';
import '../providers/AuthProvider.dart';

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

    maizeValuePrevSeason = finalOptionsPrevSeasonSet.contains('Maize') ||
        finalOptionsPrevSeasonSet.contains('Chimanga');
    sorghumValuePrevSeason = finalOptionsPrevSeasonSet.contains('Sorghum') ||
        finalOptionsPrevSeasonSet.contains('Mapila');
    beansValuePrevSeason = finalOptionsPrevSeasonSet.contains('Beans') ||
        finalOptionsPrevSeasonSet.contains('Kayela');
    soybeansValuePrevSeason = finalOptionsPrevSeasonSet.contains('Soybeans') ||
        finalOptionsPrevSeasonSet.contains('Soya');

    groundnutsValuePrevSeason =
        finalOptionsPrevSeasonSet.contains('Groundnuts') ||
            finalOptionsPrevSeasonSet.contains('Nshawa');
    cowpeasValuePrevSeason = finalOptionsPrevSeasonSet.contains('Cowpeas') ||
        finalOptionsPrevSeasonSet.contains('Nyemba');
    sunflowerValuePrevSeason =
        finalOptionsPrevSeasonSet.contains('Sunflower') ||
            finalOptionsPrevSeasonSet.contains('Sunifulawa');
    fallowValuePrevSeason = finalOptionsPrevSeasonSet.contains('Fallow') ||
        finalOptionsPrevSeasonSet.contains('Kugoneka-Munda');

    otherValuePrevSeason = finalOptionsPrevSeasonSet.contains('Other') ||
        finalOptionsPrevSeasonSet.contains('Zina');

    finalStringPrevSeason = finalOptionsPrevSeasonSet.join(',');

    finalOptionsSeasonBeforeLastSet =
        updatedFieldProfileObject.cropGrownTwoSeasonsAgo.split(',').toSet();

    maizeValueSeasonBeforeLast =
        finalOptionsSeasonBeforeLastSet.contains('Maize') ||
            finalOptionsSeasonBeforeLastSet.contains('Chimanga');
    sorghumValueSeasonBeforeLast =
        finalOptionsSeasonBeforeLastSet.contains('Sorghum') ||
            finalOptionsSeasonBeforeLastSet.contains('Mapila');
    beansValueSeasonBeforeLast =
        finalOptionsSeasonBeforeLastSet.contains('Beans') ||
            finalOptionsSeasonBeforeLastSet.contains('Kayela');
    soybeansValueSeasonBeforeLast =
        finalOptionsSeasonBeforeLastSet.contains('Soybeans') ||
            finalOptionsSeasonBeforeLastSet.contains('Soya');

    groundnutsValueSeasonBeforeLast =
        finalOptionsSeasonBeforeLastSet.contains('Groundnuts') ||
            finalOptionsSeasonBeforeLastSet.contains('Nshawa');
    cowpeasValueSeasonBeforeLast =
        finalOptionsSeasonBeforeLastSet.contains('Cowpeas') ||
            finalOptionsSeasonBeforeLastSet.contains('Nyemba');
    sunflowerValueSeasonBeforeLast =
        finalOptionsSeasonBeforeLastSet.contains('Sunflower') ||
            finalOptionsSeasonBeforeLastSet.contains('Sunifulawa');
    fallowValueSeasonBeforeLast =
        finalOptionsSeasonBeforeLastSet.contains('Fallow') ||
            finalOptionsSeasonBeforeLastSet.contains('Kugoneka-Munda');

    otherValueSeasonBeforeLast =
        finalOptionsSeasonBeforeLastSet.contains('Other') ||
            finalOptionsSeasonBeforeLastSet.contains('Zina');

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
    final authProvider = Provider.of<AuthProvider>(
      context,
      listen: false,
    );

    final bool? isFarmer = authProvider.isSezilMotherTrialFarmer;

    FieldProfileModel fieldProfileObject = Provider.of<FieldProfileProvider>(
      context,
      listen: true,
    ).getFieldProfileObject;

    List cropOptionsPrevSeason = [
      {
        'label': isFarmer! ? 'Chimanga' : 'Maize',
        'value': maizeValuePrevSeason as bool,
        'onChanged': onChangedMaizePrevSeasonValue,
      },
      {
        'label': isFarmer ? 'Mapila' : 'Sorghum',
        'value': sorghumValuePrevSeason as bool,
        'onChanged': onChangedSorghumPrevSeasonValue,
      },
      {
        'label': isFarmer ? 'Kayela' : 'Beans',
        'value': beansValuePrevSeason as bool,
        'onChanged': onChangedBeansPrevSeasonValue,
      },
      {
        'label': isFarmer ? 'Soya' : 'Soybeans',
        'value': soybeansValuePrevSeason as bool,
        'onChanged': onChangedSoybeansPrevSeasonValue,
      },
      {
        'label': isFarmer ? 'Nshawa' : 'Groundnuts',
        'value': groundnutsValuePrevSeason as bool,
        'onChanged': onChangedGroundnutsPrevSeasonValue,
      },
      {
        'label': isFarmer ? 'Nyemba' : 'Cowpeas',
        'value': cowpeasValuePrevSeason as bool,
        'onChanged': onChangedCowpeasPrevSeasonValue,
      },
      {
        'label': isFarmer ? 'Sunifulawa' : 'Sunflower',
        'value': sunflowerValuePrevSeason as bool,
        'onChanged': onChangedSunflowerPrevSeasonValue,
      },
      {
        'label': isFarmer ? 'Kugoneka-Munda' : 'Fallow',
        'value': fallowValuePrevSeason as bool,
        'onChanged': onChangedFallowPrevSeasonValue,
      },
      {
        'label': isFarmer ? 'Zina' : 'Other',
        'value': otherValuePrevSeason as bool,
        'onChanged': onChangedOtherPrevSeasonValue,
      },
    ];

    List cropOptionsSeasonBeforeLast = [
      {
        'label': isFarmer ? 'Chimanga' : 'Maize',
        'value': maizeValueSeasonBeforeLast as bool,
        'onChanged': onChangedMaizeSeasonBeforeLastValue,
      },
      {
        'label': isFarmer ? 'Mapila' : 'Sorghum',
        'value': sorghumValueSeasonBeforeLast as bool,
        'onChanged': onChangedSorghumSeasonBeforeLastValue,
      },
      {
        'label': isFarmer ? 'Kayela' : 'Beans',
        'value': beansValueSeasonBeforeLast as bool,
        'onChanged': onChangedBeansSeasonBeforeLastValue,
      },
      {
        'label': isFarmer ? 'Soya' : 'Soybeans',
        'value': soybeansValueSeasonBeforeLast as bool,
        'onChanged': onChangedSoybeansSeasonBeforeLastValue,
      },
      {
        'label': isFarmer ? 'Nshawa' : 'Groundnuts',
        'value': groundnutsValueSeasonBeforeLast as bool,
        'onChanged': onChangedGroundnutsSeasonBeforeLastValue,
      },
      {
        'label': isFarmer ? 'Nyemba' : 'Cowpeas',
        'value': cowpeasValueSeasonBeforeLast as bool,
        'onChanged': onChangedCowpeasSeasonBeforeLastValue,
      },
      {
        'label': isFarmer ? 'Sunifulawa' : 'Sunflower',
        'value': sunflowerValueSeasonBeforeLast as bool,
        'onChanged': onChangedSunflowerSeasonBeforeLastValue,
      },
      {
        'label': isFarmer ? 'Kugoneka-Munda' : 'Fallow',
        'value': fallowValueSeasonBeforeLast as bool,
        'onChanged': onChangedFallowSeasonBeforeLastValue,
      },
      {
        'label': isFarmer ? 'Zina' : 'Other',
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

    void prevSeasonWeedingChemicalHandler(value) {
      updatedFieldProfileObject.prevSeasonWeedingChemical = value;
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
        title: isFarmer ? Text('Mbiri Ya Munda') : Text("Field Profile"),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          ListWidgetComponent(
            title: isFarmer ? 'Kukula Kwa Munda' : 'Field Size',
            subtitle: fieldProfileObject.fieldSize,
            value: fieldProfileObject.fieldSize,
            onChangeDateValueHandler: () {},
            onChangeTextValueHandler: fieldSizeHandler,
            onSubmitHandler: onSubmitHandler,
            isTextField: true,
            onChangeGenComValueHandler: () {},
          ),
          ListWidgetComponent(
            title: isFarmer ? 'Gulu La Doti' : 'Soil Type',
            subtitle: fieldProfileObject.soilType,
            value: fieldProfileObject.soilType,
            onChangeDateValueHandler: () {},
            onChangeTextValueHandler: soilTypeHandler,
            onSubmitHandler: onSubmitHandler,
            isDropDownField: true,
            isTextField: false,
            listOfValues: isFarmer
                ? <String>[
                    'Dothi Lopepuka',
                    'Dothi Lolema',
                    'Zina',
                  ]
                : <String>[
                    'Light',
                    'Heavy',
                    'Other',
                  ],
            onChangeGenComValueHandler: () {},
          ),
          ListWidgetComponent(
            title: isFarmer ? 'Malo a Munda' : 'Field Coordinates',
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
            title: isFarmer
                ? 'Mbeu Zinlimidwa Nyengo ${Seasons.previousSeason}'
                : 'Crop(s) Grown ${Seasons.previousSeason} Season',
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
            title: isFarmer
                ? 'Mbeu Zinlimidwa Nyengo ${Seasons.seasonBeforeLast}'
                : 'Crop(s) Grown ${Seasons.seasonBeforeLast} Season',
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
            title: isFarmer
                ? 'Kodi Munaswenzesa Munkhwala Ophera Udzu Nyehngo Ya ${Seasons.previousSeason}'
                : 'Chemical Weeding ${Seasons.previousSeason} Season?',
            subtitle: fieldProfileObject.prevSeasonWeedingChemical,
            value: fieldProfileObject.prevSeasonWeedingChemical,
            onChangeDateValueHandler: () {},
            onChangeTextValueHandler: prevSeasonWeedingChemicalHandler,
            onSubmitHandler: onSubmitHandler,
            isDropDownField: true,
            isTextField: false,
            listOfValues: isFarmer
                ? <String>[
                    'Inde',
                    'Ai',
                  ]
                : <String>[
                    'Yes',
                    'No',
                  ],
            onChangeGenComValueHandler: () {},
          ),
          ListWidgetComponent(
            title: isFarmer
                ? 'Munkwala Munaswenzesa Nyengo Ya ${Seasons.previousSeason}'
                : 'Herbicide Used ${Seasons.previousSeason} Season',
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
