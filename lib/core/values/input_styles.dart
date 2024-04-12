part of values;

class AppInputStyles {
  static final InputDecoration defaultInputStyle = InputDecoration(
    hintText: '검색',
    prefixIcon: Icon(Icons.search),
    contentPadding: EdgeInsets.symmetric(vertical: AppSpaceSize.mediumSize),
    // 패딩 조정
    border: OutlineInputBorder(
      // 기본 테두리
      borderSide: BorderSide(color: Pallete.primaryColor),
      borderRadius: BorderRadius.all(Radius.circular(AppSpaceSize.mediumSize)),
    ),
    enabledBorder: OutlineInputBorder(
      // 활성화되지 않았을 때의 테두리
      borderSide: BorderSide(color: Pallete.primaryColor),
      borderRadius: BorderRadius.all(Radius.circular(AppSpaceSize.mediumSize)),
    ),
    focusedBorder: OutlineInputBorder(
      // 포커스 받았을 때의 테두리
      borderSide: BorderSide(color: Pallete.primaryColor),
      borderRadius: BorderRadius.all(
        Radius.circular(AppSpaceSize.mediumSize),
      ),
    ),
  );
  static final InputDecoration defaultFormFieldStyle = InputDecoration(
    contentPadding: EdgeInsets.all(AppSpaceSize.mediumSize),
    // 패딩 조정F
    border: OutlineInputBorder(
      // 기본 테두리
      borderSide: BorderSide(color: Pallete.primaryColor),
      borderRadius: BorderRadius.all(Radius.circular(AppSpaceSize.mediumSize)),
    ),
    enabledBorder: OutlineInputBorder(
      // 활성화되지 않았을 때의 테두리
      borderSide: BorderSide(color: Pallete.primaryColor),
      borderRadius: BorderRadius.all(Radius.circular(AppSpaceSize.mediumSize)),
    ),
    focusedBorder: OutlineInputBorder(
      // 포커스 받았을 때의 테두리
      borderSide: BorderSide(color: Pallete.primaryColor),
      borderRadius: BorderRadius.all(
        Radius.circular(AppSpaceSize.mediumSize),
      ),
    ),
  );
}
