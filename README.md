# flutter_application_1

A new Flutter project.


# 第一次使用流程  
## 清除套件設定  
```
flutter clean  
flutter pub get  
```    

## 啟用與連入本地模擬環境  
```
docker-compose up -d  
docker exec -it firebase-emulator.cxcxc.xingming /bin/bash  
```  

## 登入firebase
```
firebase login --reauth
```  

## 透過flutterfire命令列，註冊專案  
```
dart pub global activate flutterfire_cli

PATH="$PATH":"$HOME/.pub-cache/bin"  

flutterfire configure  
```  

## 啟用模擬器，並匯入firestore 測試資料集  
```
firebase init
<!-- 若要調整專案, 使用 firebase use <project_id> -->
firebase emulators:start
<!-- 若無法啟動, 檢查 firebase.json -->
```  

## 更新 firebase.json  
```  
{
  "firestore": {
    "rules": "firestore.rules",
    "indexes": "firestore.indexes.json"
  },
  "storage": {
    "rules": "storage.rules"
  },
  "emulators": {
    "auth": {
      "host": "0.0.0.0",
      "port": 9099
    },
    "firestore": {
      "host": "0.0.0.0",
      "port": 8080
    },
    "storage": {
      "host": "0.0.0.0",
      "port": 9199
    },
    "ui": {
      "host": "0.0.0.0",
      "enabled": true,
      "port": 4000
    },
    "singleProjectMode": true
  }
}

```  

## 添加開發時網路相關權限
android\app\src\debug\AndroidManifest.xml   
```   
<manifest xmlns:android="http://schemas.android.com/apk/res/android">
    <!-- The INTERNET permission is required for development. Specifically,
         the Flutter tool needs it to communicate with the running application
         to allow setting breakpoints, to provide hot reload, etc.
    -->
    
    <!-- 若使用 Android 需在此添加 -->
    <application
    android:usesCleartextTraffic="true">
    </application>
    <!-- 若使用 Android 需在此添加 -->


    <uses-permission android:name="android.permission.INTERNET"/>

</manifest>
```   

## 設置最低SDK版本、啟用 multidex
android\app\build.gradle
```
android {
  defaultConfig {
    // minSdkVersion flutter.minSdkVersion
    minSdkVersion 19 
    multiDexEnabled true
  }
}
...
dependencies {
    ...
    implementation 'com.android.support:multidex:1.0.3'
    ...
}
```
## 至 Firebase Console 啟用 Email/password 與 Google 驗證
https://firebase.google.com


## 在 Android 做 Google 驗證
https://developers.google.com/android/guides/client-auth?hl=zh-tw
需取得憑證的 SHA-1 指紋
```
cd android
<!-- 以下命令須安裝JAVA，並設定JAVA_HOME環境變數 -->
.\gradlew signingReport
// 取得 Task :app:signingReport 的 sha1
// 至 firebase 填寫 sha1值
// 注意：在firebase emulator 無法使用 google Auth功能, 若要看見效果, 可至 lib\utils\config.dart 設定 const bool USE_EMULATOR = false;  並在google 登入試試
```

## 設定 
lib/utils/config.dart
* 未來若要生產用需要全改為環境變數較為安全，避免反向工程
* 因開發用, 若要在開發時啟動環境變數, 需額外設定 IDE 環境變數的設定  
  
```
// 判定是否啟用模擬器，開發時需啟用；生產時須關閉
const bool USE_EMULATOR = true;
// 設定 ip, 若是使用實體手機進行測試, 需更換 ip 為電腦 ip
const String IP = "localhost";
// 判定是否為開發階段
// 定義, 生產階段時, info 以上的 log 才打印出來; 開發階段時, 所有 log 都打印出來
const bool IS_DEVELOPMENT_STAGE = true;
// 桶子名稱
const String BUCKET_NAME = "test_bucket";
// Google Provider Client ID
const String GOOGLE_PROVIDER_CLIENT_ID = "<Firebase Google Provider ID>";
```