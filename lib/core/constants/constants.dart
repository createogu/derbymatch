import 'dart:io';

//secure Repository에 저장하는 것이므로, 킷값을 임의로 설정해도 무방.
const accessTokenKey = 'ACCESS_TOKEN';
const refreshTokenKey = 'REFRESH_TOKEN';
const String nativeAppKey = 'fd1ac79544475836f83a774bb1cecacf';
//에뮬레이터의 로컬 IP
final emulatorIp = 'http://10.0.0.2:3000';

//시뮬레이터의 로컬 IP
final simulatorIp = 'http://localhost:8080';

class Constants {
  static const serviceNameKor = "더비매치";
  static const serviceNameEng = "DerbyMatch";

  static const logoPath = 'asset/img/logo/logo.png';
  static const maleDefaultProfileImagePath =
      'asset/img/profile/male_default_profile_image.png';
  static const femaleDefaultProfileImagePath =
      'asset/img/profile/female_default_profile_image.png';

  static final ip = Platform.isIOS ? simulatorIp : emulatorIp;
}
