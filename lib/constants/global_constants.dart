List<String> passwordStrength = [
  'Weak',
  'Medium',
  'Good',
  'Strong',
  'Password must be at  least 8 characters long.'
];
String userId = '0';
Map? userData;
List languages = [];
List channels = [];
int serverStatus = 0;
String currentLanguage ="en";

List freshnessList = [
  '0',
  '100',
  '1000',
  '10000'
];


class MyGlobalConstants{
  static const String kGoogleApiKey = 'AIzaSyABk-0Al27H9Ap_Rtti2t0ePxOLvl5QFzk';
  static const String termsAndConditionsLink = 'http://ox21nft.xyz/api/get_terms';
  static const String passwordSalt = 'qwertyuiopasdfghjklzxcvbnmqwerty';
  static const String ipfsLink = "https://ipfs.io/ipfs/";
}