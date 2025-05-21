import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:notes_test/presentation/theme/theme.dart';
import 'package:notes_test/presentation/widgets/app_bar.dart';
import 'package:package_info_plus/package_info_plus.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    const String helpText =
        'Это простое приложение для создания и управления вашими заметками. '
        'Вы можете легко добавлять, редактировать, удалять и искать заметки, '
        'а также сортировать их для удобства.';

    final String version = Get.find<PackageInfo>().version;
    final String buildNumber = Get.find<PackageInfo>().buildNumber;

    return Theme(
      data: Theme.of(context).copyWith(
        bottomSheetTheme: const BottomSheetThemeData(
          backgroundColor: Colors.transparent,
        ),
      ),
      child: Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: AppColor.background,
        resizeToAvoidBottomInset: true,
        appBar: const AppBarBazi(title: 'Настройки'),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: ListView(
            children: [
              const Gap(20),
              Text(
                'О приложении:',
                style: AppText.t16rw.copyWith(
                    color: AppColor.black, fontWeight: FontWeight.bold),
              ),
              const Gap(10),
              Text(
                helpText,
                style: AppText.t14rb.copyWith(color: AppColor.greyText),
              ),
              const Gap(20),
              Text(
                'Версия приложения:',
                style: AppText.t16rw.copyWith(
                    color: AppColor.black, fontWeight: FontWeight.bold),
              ),
              const Gap(10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    version,
                    style: AppText.t14rb.copyWith(color: AppColor.greyText),
                  ),
                  if (buildNumber.isNotEmpty) ...[
                    const Gap(5),
                    Text(
                      'Сборка: $buildNumber',
                      style: AppText.t14rb
                          .copyWith(color: AppColor.greyText.withOpacity(0.7)),
                    ),
                  ],
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
