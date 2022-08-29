///development
// const String kUrl = 'izifin-engagement-wallet-staging.eba-xpi2ug7b.us-east-2.elasticbeanstalk.com';
const String kUrl = 'ew-staging.izifin.com';
///production
// const String kUrl = 'app.skillpaddy.com';


///headers
Map<String, String> _headers(dynamic token) {
  return {'Content-type': 'application/json', 'Authorization': 'Bearer $token'};
}

const kHeaders = _headers;


const String kTokenName = 'token';

