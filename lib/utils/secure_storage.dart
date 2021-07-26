import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage{

  final secureStore = new FlutterSecureStorage();

  void setSecureStore(String key, String data) async {
    await secureStore.write(key: key, value: data);
  }

  void getSecureStore(String key) async {
     await secureStore.read(key: key);
  }


  // void getAllSecureStore(String key, Function callback) async {
  //   await secureStore.read(key: key).then(callback);
  // }




// get all: Map<String, String> allValues = await secureStore.readAll();
  // delete: await secureStore.delete(key: key);
  // delete all: await secureStore.deleteAll();


}