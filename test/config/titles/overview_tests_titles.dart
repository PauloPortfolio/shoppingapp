/* INSTRUCTIONS ABOUT 'REPO-REAL-DE-PRODUCAO'
  https://timm.preetz.name/articles/http-request-flutter-test
  By DEFAULT, HTTP request made in tests invoked BY flutter test
  result in an empty response (400).
  By DEFAULT, It is a good behavior to avoid external
  dependencies and hence reduce flakyness(FRAGILE) tests.
  THEREFORE:
  A) TESTS CAN NOT DO EXTERNAL-HTTP REQUESTS/CALLS;
  B) HENCE, THE TESTS CAN NOT USE 'REPO-REAL-DE-PRODUCAO'(no external calls)
  C) SO, THE TESTS ONLY WILL USE MockedRepoClass/MockedDatasource
   */
class OverviewTestsTitles {
  String REPO_NAME = 'OverviewMockedRepo';

  // @formatter:off
  //GROUP-TITLES ---------------------------------------------------------------
  static get GROUP_TITLE => 'OverView|Integration-Tests:';

  //MVC-TITLES -----------------------------------------------------------------
  get REPO_TITLE => '$REPO_NAME|Repo: Unit';
  get SERVICE_TITLE => '$REPO_NAME|Service: Unit';
  get CONTROLLER_TITLE => '$REPO_NAME|Controller: Integr';
  get VIEW_TITLE => '$REPO_NAME|View: Functional';

  //OVERVIEW-TEST-TITLES -------------------------------------------------------
  get check_overviewGridItems => 'Checking products';
  get toggle_productFavButton => 'Toggling FavoritesIconButton in a product';
  get add_sameProduct2x_Check_ShopCartIconTotal =>
      'Adding a product 2x|Check ShopCartIcon|Snackbar';
  get addProduct_click_undoSnackbar_check_shopCartIconTotal =>
      'Adding product|Clicking SnackbarUndo (rollback)';
  get add_sameProduct3x_check_shopCartIconTotal =>
      'Adding same product 3x|Check ShopCartIcon';
  get add_AllDbProducts_check_shopCartIconTotal =>
      'Adding All DB products|Check ShopCartIcon';
  get add_prods3And4_check_shopCartIcon => 'Adding products 3/4|Checking ShopCartIcon';
  get tap_favFilter_noFavoritesFound => 'Tapping FavoriteFilter|Not favorites found';
  get tap_favFilterPopup => 'Tapping FavoriteFilter';
  get close_favFilterPopup_tapOutside => 'Closing Favorite_Filter|tap OUTSIDE';

  //OVERVIEW-DETAILS-TEST-TITLES -----------------------------------------------
  get tap_product_details_check_texts => 'Tap Product|Check Product Details (texts)';
  get tap_product_details_check_image => 'Tap Product|Check Product Details (image)';
  get tap_product_details_click_back_button => 'Testing Product Details BackButton';
  // @formatter:on
}