import 'package:notes_test/presentation/screen/main/bloc/main_bloc.dart';
import 'package:flutter_easylogger/flutter_logger.dart';
import 'package:get/get.dart';
import 'package:notes_test/domain/repository/main_repository.dart';
import 'package:package_info_plus/package_info_plus.dart';

/// внедряем зависимости
Future initMain() async {
  try {
    await Get.putAsync(() async {
      PackageInfo packageInfo = await PackageInfo.fromPlatform();
      return packageInfo;
    });
  } catch (e) {
    Logger.e('PackageInfo error = $e');
    return 'PackageInfo error = $e';
  }

  try {
    await Get.putAsync(() async {
      final mainRepository = MainRepository();
      await mainRepository.init();
      return mainRepository;
    });
  } catch (e) {
    Logger.e('MainRepository error = $e');
    return 'MainRepository error = $e';
  }

  try {
    Get.put<MainBloc>(MainBloc());
  } catch (e) {
    Logger.e('MainBloc error = $e');
    return 'MainBloc error = $e';
  }
  await Future.delayed(const Duration(seconds: 3));
  return '';
}
