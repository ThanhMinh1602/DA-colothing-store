import 'package:googleapis_auth/auth_io.dart';

class GetServerKey {
  Future<String> getServerKey() async {
    final scopes = [
      'https://www.googleapis.com/auth/userinfo.email',
      'https://www.googleapis.com/auth/firebase.database',
      'https://www.googleapis.com/auth/firebase.messaging',
    ];
    final client = await clientViaServiceAccount(
      ServiceAccountCredentials.fromJson({
        "type": "service_account",
        "project_id": "male-store-ab1d1",
        "private_key_id": "2660b649622eee3baf7e83a943a99bfdfcaa7174",
        "private_key":
            "-----BEGIN PRIVATE KEY-----\nMIIEvAIBADANBgkqhkiG9w0BAQEFAASCBKYwggSiAgEAAoIBAQClMjsaDJhJ/F3Z\njB3oiqRa6EgKRlTIZ7wcZglYQEo4sxoeK7Ce7KdzzxA23vlbu/f6ATzshMF+JNAY\nkdbiLAzdBEBnJ2o/IlErWCmtbtdYaoGh5/AKD52Cj++p4iMY7KaTub75GYgyU22D\nIAsIx2MQdQkdZO2fu+BxavI3643Rg8NazutqnvK1r+Nx9R2NmEE6WOo5m3PAkzGX\n6/osx8h874fSErjxiGrd+rvcbeu3bKL8HBpK5XlfFL3f9WvkyGaVUFSVWEevGcvI\n6TzPXSvba/w7XSP5jfgb2IH5X/OmhbP+oZ/QBDNpEnjmqXMRnIdkxdexrugNXs43\nhGHA4Tg5AgMBAAECggEAAob3MoA402dVKp8JiH7+e3y/a8prQTmdCufHHGuEKl1+\nRWUW6aEZmrYmbsB257ldCZ0VPB6rAYc5cin6mjEt7TLdQJBXM5B1CQjrPxtjMTFH\n7gMo8yGnOWuCsU89VdDhARq/wJQ5NvpIKM/64aKAC60B4hcJYsuYzmnIoaRf4gs8\nsknWJsj2GLgwcrDTzIWtlchViQ8dWGOCmMKEMIHIY8iU6HmOyGXT7JM9I8rvo/Bw\nHd5tcn+40EfqWTwAwSTmbyhVyZyLXpVGqRqUSdvJ1nJJ2HZPpzWq2JW5iw5p6hPs\nyImAGFBCTJ/Rlr7ES3R4sBh2oVYZOXtYNGWwjBHnZQKBgQDWU9jII1oSO+jhqQ5c\n1/vvSo2++/lniegEf4lFaES01y13LXt6NM7L/a6tQpKRISWh6K2L6EqBQvbS2vgf\najfijV2j+lfp7M0Fw/JwVP+/tXO2vCePEe7cSRXUdcBgmbpuJx1qGvQeR/KjkpO6\n8WtXhht8wOshD+QlHrMapHn7wwKBgQDFUN90KdNVZiVJDd+70eHYovVE7ed/fziV\nw+Q5vaAB1Wk8V5CKYQ6DqBTgBQcPFyaqFMYbWXjg7LGLvakxoYPON4ztSXbl7Dbn\n1L8WG3ZeqF0A7R31i0/wtY61sJLQqixWA6sQUpDe7QFx6Ofz63/YWVdj04V8O5W0\nPpVJuceIUwKBgHuBA4mIvY2GUlM+/NTJbRbeCkJEptpgIH//EhYZ2IWw/TUQ03d/\nWK859t9GXnkc9beQAfl+GPjVoq+smJBZv+xf89bbGq/k0dwBpwHOKTXKlOx3DgCm\nn9L2lorAc+P2kfSJu6x57bRJV2ukulZeabGcyNghvxxlMN2nDCRNJTHLAoGABFXi\nkwrYOegkqZZEdDwIWlo6SWlwzLxe4euL+DjSazflOA40ftXjG8F1s/ZoUUyQ7OvH\n7pHotgh9XjSsowqJet59mjkjA6pNCosCJ9oyn6HTaVHMdri46PEUUamvkCYtEzbB\na3pk9IEApyAW+KUUCgzsfqUHKdOlVnCJlzUdzUECgYAa2UyVVHMTpmBpminlRe9a\nI4i0Lx9k1j5t905YyiR/s6cH9VTZdsiRlHMbpfB/gL2YEZvfiSXtVl5wE4ISbhY9\np0KLn6RRHRiwMcC4NOb0+7ZoXZxWtz5E/zPKb4FwutBMtljDthVZOAlLKs2+ABO+\niDJi4gFX4U/kX9DMFWgSag==\n-----END PRIVATE KEY-----\n",
        "client_email":
            "firebase-adminsdk-fbsvc@male-store-ab1d1.iam.gserviceaccount.com",
        "client_id": "105197350158067465429",
        "auth_uri": "https://accounts.google.com/o/oauth2/auth",
        "token_uri": "https://oauth2.googleapis.com/token",
        "auth_provider_x509_cert_url":
            "https://www.googleapis.com/oauth2/v1/certs",
        "client_x509_cert_url":
            "https://www.googleapis.com/robot/v1/metadata/x509/firebase-adminsdk-fbsvc%40male-store-ab1d1.iam.gserviceaccount.com",
        "universe_domain": "googleapis.com",
      }),
      scopes,
    );

    final serverKey = client.credentials.accessToken.data;
    return serverKey;
  }
}
