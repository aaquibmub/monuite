import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_de.dart';
import 'app_localizations_en.dart';
import 'app_localizations_fr.dart';
import 'app_localizations_it.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('de'),
    Locale('en'),
    Locale('fr'),
    Locale('it')
  ];

  /// The conventional newborn programmer greeting
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// Label for guest user
  ///
  /// In en, this message translates to:
  /// **'Guest'**
  String get guest;

  /// Label for orders section
  ///
  /// In en, this message translates to:
  /// **'Orders'**
  String get orders;

  /// Label for My Orders item in profile screen
  ///
  /// In en, this message translates to:
  /// **'My Orders'**
  String get myOrders;

  /// Label for settings section
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// Label for language selection
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// Label for theme selection
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get theme;

  /// Label for sign out button
  ///
  /// In en, this message translates to:
  /// **'Sign Out'**
  String get signOut;

  /// Label for app version
  ///
  /// In en, this message translates to:
  /// **'Version'**
  String get version;

  /// Label for about section
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get about;

  /// Label for privacy policy section
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get privacyPolicy;

  /// Label for push notifications section
  ///
  /// In en, this message translates to:
  /// **'Push Notifications'**
  String get pushNotifications;

  /// Label for cards section
  ///
  /// In en, this message translates to:
  /// **'Cards'**
  String get cards;

  /// Label for address book section
  ///
  /// In en, this message translates to:
  /// **'Address Book'**
  String get addressBook;

  /// Label for profile section
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile;

  /// Title for the wishlist screen
  ///
  /// In en, this message translates to:
  /// **'Wishlist'**
  String get wishlistScreenTitle;

  /// Title for the cart screen
  ///
  /// In en, this message translates to:
  /// **'Cart'**
  String get cartScreenTitle;

  /// Label for address with a colon
  ///
  /// In en, this message translates to:
  /// **'Address:'**
  String get addressWithColon;

  /// Label for add address button
  ///
  /// In en, this message translates to:
  /// **'Add Address'**
  String get addAddress;

  /// Message displayed when the cart is empty
  ///
  /// In en, this message translates to:
  /// **'Your cart is empty'**
  String get cartEmptyMessage;

  /// Title for the categories screen
  ///
  /// In en, this message translates to:
  /// **'Categories'**
  String get categoriesScreenTitle;

  /// Message displayed when no categories are found
  ///
  /// In en, this message translates to:
  /// **'No categories found'**
  String get noCategoriesFound;

  /// Title for the checkout screen
  ///
  /// In en, this message translates to:
  /// **'Checkout'**
  String get checkoutScreenTitle;

  /// Label for shipping address section
  ///
  /// In en, this message translates to:
  /// **'Shipping Address'**
  String get shippingAddress;

  /// Label for total with a colon
  ///
  /// In en, this message translates to:
  /// **'Total:'**
  String get totalWithColon;

  /// Hint text for entering a coupon code
  ///
  /// In en, this message translates to:
  /// **'have a coupon?'**
  String get enterCouponCode;

  /// Label for apply button
  ///
  /// In en, this message translates to:
  /// **'Apply'**
  String get apply;

  /// Title for order summary section
  ///
  /// In en, this message translates to:
  /// **'Order Summary'**
  String get orderSummary;

  /// Label for subtotal amount
  ///
  /// In en, this message translates to:
  /// **'Subtotal'**
  String get subtotal;

  /// Label for number of items
  ///
  /// In en, this message translates to:
  /// **'items'**
  String get items;

  /// Label for shipping fee amount
  ///
  /// In en, this message translates to:
  /// **'Shipping Fee'**
  String get shippingFee;

  /// Label for coupon amount
  ///
  /// In en, this message translates to:
  /// **'Coupon'**
  String get coupon;

  /// Label for total amount
  ///
  /// In en, this message translates to:
  /// **'Total'**
  String get total;

  /// Message displayed when user tries to checkout without an address
  ///
  /// In en, this message translates to:
  /// **'Please add address before checkout'**
  String get addAddressBeforeCheckout;

  /// Label for confirm and pay button
  ///
  /// In en, this message translates to:
  /// **'Confirm & Pay'**
  String get confirmAndPay;

  /// Label for country/region field
  ///
  /// In en, this message translates to:
  /// **'Country/Region'**
  String get countryRegion;

  /// Label for first name field
  ///
  /// In en, this message translates to:
  /// **'First Name'**
  String get firstName;

  /// Hint text for first name field
  ///
  /// In en, this message translates to:
  /// **'Type first name'**
  String get firstNameHint;

  /// Validation message when first name is not provided
  ///
  /// In en, this message translates to:
  /// **'First name is required'**
  String get firstNameRequired;

  /// Label for last name field
  ///
  /// In en, this message translates to:
  /// **'Last Name'**
  String get lastName;

  /// Hint text for last name field
  ///
  /// In en, this message translates to:
  /// **'Type last name'**
  String get lastNameHint;

  /// Validation message when last name is not provided
  ///
  /// In en, this message translates to:
  /// **'Last name is required'**
  String get lastNameRequired;

  /// Label for company name field
  ///
  /// In en, this message translates to:
  /// **'Company Name'**
  String get companyName;

  /// Hint text for company name field
  ///
  /// In en, this message translates to:
  /// **'Type company name'**
  String get companyNameHint;

  /// Validation message when company name is not provided
  ///
  /// In en, this message translates to:
  /// **'Company name is required'**
  String get companyNameRequired;

  /// Label for phone number field
  ///
  /// In en, this message translates to:
  /// **'Phone'**
  String get phone;

  /// Hint text for phone number field
  ///
  /// In en, this message translates to:
  /// **'Type phone number'**
  String get phoneHint;

  /// Validation message when phone number is not provided
  ///
  /// In en, this message translates to:
  /// **'Phone number is required'**
  String get phoneRequired;

  /// Label for address line 1 field
  ///
  /// In en, this message translates to:
  /// **'Address 1'**
  String get address1;

  /// Hint text for address line 1 field
  ///
  /// In en, this message translates to:
  /// **'Type address 1'**
  String get address1Hint;

  /// Validation message when address line 1 is not provided
  ///
  /// In en, this message translates to:
  /// **'Address 1 is required'**
  String get address1Required;

  /// Label for address line 2 field
  ///
  /// In en, this message translates to:
  /// **'Address 2'**
  String get address2;

  /// Hint text for address line 2 field
  ///
  /// In en, this message translates to:
  /// **'Type address 2'**
  String get address2Hint;

  /// Validation message when address line 2 is not provided
  ///
  /// In en, this message translates to:
  /// **'Address 2 is required'**
  String get address2Required;

  /// Label for city field
  ///
  /// In en, this message translates to:
  /// **'City'**
  String get city;

  /// Hint text for city field
  ///
  /// In en, this message translates to:
  /// **'Type city'**
  String get cityHint;

  /// Validation message when city is not provided
  ///
  /// In en, this message translates to:
  /// **'City is required'**
  String get cityRequired;

  /// Label for state field
  ///
  /// In en, this message translates to:
  /// **'State'**
  String get state;

  /// Hint text for state field
  ///
  /// In en, this message translates to:
  /// **'Type state'**
  String get stateHint;

  /// Validation message when state is not provided
  ///
  /// In en, this message translates to:
  /// **'State is required'**
  String get stateRequired;

  /// Label for zip code field
  ///
  /// In en, this message translates to:
  /// **'Zip Code'**
  String get zipCode;

  /// Hint text for zip code field
  ///
  /// In en, this message translates to:
  /// **'Type zip code'**
  String get zipCodeHint;

  /// Validation message when zip code is not provided
  ///
  /// In en, this message translates to:
  /// **'Zip code is required'**
  String get zipCodeRequired;

  /// Label for email field
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// Hint text for email field
  ///
  /// In en, this message translates to:
  /// **'Type email'**
  String get emailHint;

  /// Validation message when email is not provided
  ///
  /// In en, this message translates to:
  /// **'Email is required'**
  String get emailRequired;

  /// Title for error dialog
  ///
  /// In en, this message translates to:
  /// **'An error occurred'**
  String get anErrorOccurred;

  /// Label for okay button in dialogs
  ///
  /// In en, this message translates to:
  /// **'Okay'**
  String get okay;

  /// Error message displayed when adding an address fails
  ///
  /// In en, this message translates to:
  /// **'Could not add address. Please try again.'**
  String get couldNotAddAddress;

  /// Label for add address button in capital letters
  ///
  /// In en, this message translates to:
  /// **'ADD ADDRESS'**
  String get addAddressInCapital;

  /// Hint text for global search button
  ///
  /// In en, this message translates to:
  /// **'Search the entire shop'**
  String get searchTheEntireShop;

  /// Label for categories section
  ///
  /// In en, this message translates to:
  /// **'Categories'**
  String get categories;

  /// Label for see all button
  ///
  /// In en, this message translates to:
  /// **'See All'**
  String get seeAll;

  /// Label for popular products section
  ///
  /// In en, this message translates to:
  /// **'Popular Products'**
  String get popularProducts;

  /// Message displayed when no products are found
  ///
  /// In en, this message translates to:
  /// **'No products found'**
  String get noProductsFound;

  /// Message displayed for an unknown error
  ///
  /// In en, this message translates to:
  /// **'Unknown error'**
  String get unknownError;

  /// Title for selecting payment method section
  ///
  /// In en, this message translates to:
  /// **'Select Payment Method'**
  String get selectPaymentMethod;

  /// Label for pay button
  ///
  /// In en, this message translates to:
  /// **'Pay'**
  String get pay;

  /// Label for products section
  ///
  /// In en, this message translates to:
  /// **'Products'**
  String get products;

  /// Title for order confirmed screen
  ///
  /// In en, this message translates to:
  /// **'Order Confirmed'**
  String get orderConfirmed;

  /// Label indicating the order is confirmed
  ///
  /// In en, this message translates to:
  /// **'Confirmed'**
  String get confirmed;

  /// Message displayed to thank the user for their order
  ///
  /// In en, this message translates to:
  /// **'Thank you for your order. You will receive an email confirmation shortly.'**
  String get thankYouForOrdering;

  /// Message displayed when the order is not found
  ///
  /// In en, this message translates to:
  /// **'Order not found'**
  String get orderNotFound;

  /// Label for back to home button
  ///
  /// In en, this message translates to:
  /// **'Back to Home'**
  String get backToHome;

  /// Hint text for searching orders
  ///
  /// In en, this message translates to:
  /// **'Search orders...'**
  String get searchOrders;

  /// Message displayed when no orders are found
  ///
  /// In en, this message translates to:
  /// **'No orders found'**
  String get noOrdersFound;

  /// Message displayed when no product is found
  ///
  /// In en, this message translates to:
  /// **'No product found'**
  String get noProductFound;

  /// Label for add to cart button
  ///
  /// In en, this message translates to:
  /// **'Add to Cart'**
  String get addToCart;

  /// Hint text for searching products
  ///
  /// In en, this message translates to:
  /// **'Search products...'**
  String get searchProducts;

  /// Label indicating the default option
  ///
  /// In en, this message translates to:
  /// **'Default'**
  String get defaultLabel;

  /// Message displayed when no address is found
  ///
  /// In en, this message translates to:
  /// **'No address found'**
  String get noAddressFound;

  /// Label for setting an address as the default
  ///
  /// In en, this message translates to:
  /// **'Set as default address'**
  String get setAsDefaultAddress;

  /// Error message displayed when updating an address fails
  ///
  /// In en, this message translates to:
  /// **'Could not update address. Please try again.'**
  String get couldNotUpdateAddress;

  /// Label for update address button in capital letters
  ///
  /// In en, this message translates to:
  /// **'UPDATE ADDRESS'**
  String get updateAddressInCapitalLetters;

  /// Title for update address screen
  ///
  /// In en, this message translates to:
  /// **'Update Address'**
  String get updateAddress;

  /// Title for user profile screen
  ///
  /// In en, this message translates to:
  /// **'User Profile'**
  String get userProfile;

  /// Label for name field
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get name;

  /// Label for country field
  ///
  /// In en, this message translates to:
  /// **'Country'**
  String get country;

  /// Label for logout button
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logout;

  /// Label for cart section
  ///
  /// In en, this message translates to:
  /// **'Cart'**
  String get cart;

  /// Label for wishlist section
  ///
  /// In en, this message translates to:
  /// **'Wishlist'**
  String get wishlist;

  /// Message displayed when an item is added to the cart
  ///
  /// In en, this message translates to:
  /// **'Item added to cart'**
  String get itemAddedToCart;

  /// Label for login button
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login;

  /// Label for notifications section
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notifications;

  /// Title for the product detail screen
  ///
  /// In en, this message translates to:
  /// **'Product Detail'**
  String get productDetailScreenTitle;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['de', 'en', 'fr', 'it'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'de':
      return AppLocalizationsDe();
    case 'en':
      return AppLocalizationsEn();
    case 'fr':
      return AppLocalizationsFr();
    case 'it':
      return AppLocalizationsIt();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
