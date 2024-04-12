part of values;

class ButtonStyles {
  static final ButtonStyle primaryButton = ButtonStyle(
    backgroundColor: MaterialStateProperty.resolveWith<Color>(
      (Set<MaterialState> states) {
        if (states.contains(MaterialState.disabled)) {
          return Pallete.greyColor; // 비활성화 상태일 때의 배경 색상
        }
        return Pallete.primaryColor; // 기본 배경 색상
      },
    ),
    minimumSize: MaterialStatePropertyAll<Size>(
      Size(double.infinity, 50),
    ),
    shape: MaterialStateProperty.resolveWith<RoundedRectangleBorder>(
      (Set<MaterialState> states) {
        return RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
          side: BorderSide(
            color: states.contains(MaterialState.disabled)
                ? Pallete.greyColor // 비활성화 상태일 때의 테두리 색상
                : Pallete.primaryColor, // 기본 테두리 색상
          ),
        );
      },
    ),
  );
  static final ButtonStyle seconderyButton = ButtonStyle(
    backgroundColor: MaterialStateProperty.all<Color>(Pallete.whiteColor),
    minimumSize: MaterialStatePropertyAll<Size>(
      Size(double.infinity, 50),
    ),
    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
        side: BorderSide(color: Pallete.primaryColor),
      ),
    ),
  );
  static final ButtonStyle textButton = ButtonStyle(
    backgroundColor: MaterialStateProperty.all<Color>(Pallete.whiteColor),
    minimumSize: MaterialStatePropertyAll<Size>(
      Size(double.infinity, 50),
    ),
  );

  static final ButtonStyle kakaoLoginButton = ButtonStyle(
    backgroundColor: MaterialStateProperty.all<Color>(Color(0xFFFEE500)),
    minimumSize: MaterialStatePropertyAll<Size>(
      Size(double.infinity, 50),
    ),
    maximumSize: MaterialStatePropertyAll<Size>(
      Size(double.infinity, 50),
    ),
    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
        side: BorderSide(color: Color(0xFFFEE500)),
      ),
    ),
  );
  static final ButtonStyle googleLoginButton = ButtonStyle(
    backgroundColor: MaterialStateProperty.all<Color>(Pallete.whiteColor),
    minimumSize: MaterialStatePropertyAll<Size>(
      Size(double.infinity, 50),
    ),
    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
        side: BorderSide(color: Pallete.blackColor),
      ),
    ),
  );

  static final ButtonStyle imageRounded = ButtonStyle(
      backgroundColor: MaterialStateProperty.all(HexColor.fromHex("181A1F")),
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50.0),
              side: BorderSide(color: HexColor.fromHex("666A7A"), width: 1))));
}
