import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import './config/palette.dart';

import './providers/FieldOperationsProvider.dart';
import './providers/CurrentSeasonVarietyProvider.dart';
import './providers/FertilizationProvider.dart';
import './providers/FieldProfileProvider.dart';
import './providers/PostPlantingProvider.dart';
import './providers/FloweringProvider.dart';
import './providers/PostFloweringProvider.dart';
import './providers/PreHarvestProvider.dart';
import './providers/HarvestProvider.dart';
import './providers/PostHarvestProvider.dart';
import './providers/AuthProvider.dart';
import './providers/SynchronizeTraitsProvider.dart';
import './providers/RegisterSezilFarmerProvider.dart';

import './screens/HomePageScreen.dart';
import 'screens/PlotsScreen.dart';
import 'screens/TraitsScreen.dart';
import './screens/FieldOperationsScreen.dart';
import './screens/EditValueScreen.dart';
import './screens/FieldProfileScreen.dart';
import './screens/CurrentSeasonVarietyScreen.dart';
import './screens/FertilizationScreen.dart';
import './screens/DetailedFertilizationScreen.dart';
import './screens/PostPlantingScreen.dart';
import './screens/FloweringScreen.dart';
import './screens/PreHarvestScreen.dart';
import './screens/HarvestScreen.dart';
import './screens/PostHarvestScreen.dart';
import './screens/EditCheckBoxesScreen.dart';
import './screens/QRViewScreen.dart';
import './screens/FertDressingScreen.dart';
import './screens/SynchronizeScreen.dart';
import './screens/LoginScreen.dart';
import './screens/LoadingScreen.dart';
import './screens/PostFloweringScreen.dart';
import './screens/RegisterSezilFarmerScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthProvider>(
          create: (ctx) => AuthProvider(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => FieldOperationsProvider(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => CurrentSeasonVarietyProvider(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => FertilizationProvider(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => FieldProfileProvider(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => PostPlantingProvider(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => FloweringProvider(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => PostFloweringProvider(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => PreHarvestProvider(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => HarvestProvider(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => PostHarvestProvider(),
        ),
        ChangeNotifierProxyProvider<AuthProvider, RegisterSezilFarmerProvider>(
          create: (_) => RegisterSezilFarmerProvider(),
          update: (ctx, authProvider, registerFarmerProvider) {
            return registerFarmerProvider!..auth = authProvider.accessToken!;
          },
        ),
        ChangeNotifierProxyProvider6<
            AuthProvider,
            PostPlantingProvider,
            FloweringProvider,
            PostFloweringProvider,
            PreHarvestProvider,
            HarvestProvider,
            SynchronizeTraitsProvider>(
          create: (_) => SynchronizeTraitsProvider(),
          update: (ctx,
              authProvider,
              postPlantingProvider,
              floweringProvider,
              postFloweringProvider,
              preHarvestProvider,
              harvestProvider,
              syncTraitsProvider) {
            syncTraitsProvider!.accessToken = authProvider.accessToken;
            syncTraitsProvider.crop = authProvider.crop;
            syncTraitsProvider.farmerId = authProvider.farmerId;
            syncTraitsProvider.floweringObjectsToBeSynced =
                floweringProvider.floweringObjectsToBeSynced;
            syncTraitsProvider.harvestObjectsToBeSynced =
                harvestProvider.harvestObjectsToBeSynced;
            syncTraitsProvider.postFloweringObjectsToBeSynced =
                postFloweringProvider.postFloweringObjectsToBeSynced;
            syncTraitsProvider.postPlantingObjectsToBeSynced =
                postPlantingProvider.postPlantingObjectsToBeSynced;
            syncTraitsProvider.preHarvestObjectsToBeSynced =
                preHarvestProvider.preHarvestObjectsToBeSynced;
            return syncTraitsProvider;
          },
        )
      ],
      child: Consumer<AuthProvider>(
        builder: (ctx, authProvider, _) => MaterialApp(
          title: 'SeZIL App',
          theme: ThemeData(
            primarySwatch: Palette.gnaColorSwatch,
          ),
          home: authProvider.isAuth
              ? HomePageScreen()
              : FutureBuilder(
                  future: authProvider.tryAutoLogin(),
                  builder: (
                    ctx,
                    authResultsSnapshot,
                  ) =>
                      authResultsSnapshot.connectionState ==
                              ConnectionState.waiting
                          ? LoadingScreen()
                          : LoginScreen(),
                ),
          routes: {
            TraitsScreen.routeName: (ctx) => TraitsScreen(),
            FieldProfileScreen.routeName: (ctx) => FieldProfileScreen(),
            FieldOperationsScreen.routeName: (ctx) => FieldOperationsScreen(),
            CurrentSeasonVarietyScreen.routeName: (ctx) =>
                CurrentSeasonVarietyScreen(),
            FertilizationScreen.routeName: (ctx) => FertilizationScreen(),
            PlotsScreen.routeName: (ctx) => PlotsScreen(),
            EditValueScreen.routeName: (ctx) => EditValueScreen(),
            DetailedFertilizationScreen.routeName: (ctx) =>
                DetailedFertilizationScreen(),
            PostPlantingScreen.routeName: (ctx) => PostPlantingScreen(),
            FloweringScreen.routeName: (ctx) => FloweringScreen(),
            PreHarvestScreen.routeName: (ctx) => PreHarvestScreen(),
            HarvestScreen.routeName: (ctx) => HarvestScreen(),
            PostHarvestScreen.routeName: (ctx) => PostHarvestScreen(),
            EditCheckBoxesScreen.routeName: (ctx) => EditCheckBoxesScreen(),
            QRViewScreen.routeName: (ctx) => QRViewScreen(),
            FertDressingScreen.routeName: (ctx) => FertDressingScreen(),
            SynchronizeScreen.routeName: (ctx) => SynchronizeScreen(),
            PostFloweringScreen.routeName: (ctx) => PostFloweringScreen(),
            RegisterSezilFarmerScreen.routeName: (ctx) =>
                RegisterSezilFarmerScreen(),
          },
        ),
      ),
    );
  }
}
