part of values;

class AppTextStyles {
  static final TextStyle defaultTextStyle = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    fontFamily: 'pretendard',
  );

  static final TextStyle bottomLinkTextStyle = defaultTextStyle.copyWith(
    fontSize: 25,
    fontWeight: FontWeight.w600,
  );

  static final TextStyle logoTextStyle = defaultTextStyle.copyWith(
    fontSize: 80,
    fontWeight: FontWeight.w400,
    fontFamily: 'samlip',
  );

  static final TextStyle headerTextStyle = defaultTextStyle.copyWith(
    fontSize: 28,
    fontWeight: FontWeight.w900,
  );

  static final TextStyle titleTextStyle = defaultTextStyle.copyWith(
    fontWeight: FontWeight.w700,
    fontSize: 24,
  );

  static final TextStyle headlineTextStyle = defaultTextStyle.copyWith(
    fontSize: 20,
    fontWeight: FontWeight.w500,
  );
  static final TextStyle bodyTextStyle = defaultTextStyle.copyWith(
    fontSize: 16,
    fontWeight: FontWeight.w500,
  );
  static final TextStyle infoTextStyle = defaultTextStyle.copyWith(
    fontSize: 14,
    fontWeight: FontWeight.w400,
  );
  static final TextStyle cautionTextStyle = defaultTextStyle.copyWith(
    fontSize: 12,
    fontWeight: FontWeight.w400,
  );
  static final TextStyle descriptionTextStyle = defaultTextStyle.copyWith(
    fontSize: 10,
    fontWeight: FontWeight.w400,
  );
}
