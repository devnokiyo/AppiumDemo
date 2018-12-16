require "rubygems"
require "appium_lib"

# iOSシミュレーター(iOS 12.1)の設定
ios_caps = {
  caps: {
    "platformName": "iOS",
    "platformVersion": "12.1",
    "deviceName": "iPhone Simulator",
    "automationName": "XCUITest",
    "app": "./SampleApp/AppiumDemo.app"
  },
  appium_lib: {
    wait: 10
  }
}

# Androidエミュレーター(Android 9.0)の設定
# 【補足】"platformVersion": "x.x"で指定するサンプルを多く見かけましたが、
# エミュレーターで実行するなら「"avd": "xxx"」が良いと思いました。
# この指定方法だとエミュレーターも自動で起動します。
android_caps = {
  caps: {
    "platformName": "Android",
#    "platformVersion": "8.1",
    "deviceName": "Android Emulator",
    "automationName": "Appium",
    "appPackage": "com.example.devnokiyo.appiumdemo",
    "app": "./SampleApp/app-debug.apk",
    "appActivity": "com.example.devnokiyo.appiumdemo.MainActivity",
    "avd": "Pixel_2_API_28"
  },
  appium_lib: {
    wait: 10
  }
}

RSpec.configure { |c|
  c.before(:each) {
    caps = ios? ? ios_caps : android_caps
    @driver = Appium::Driver.new(caps)
    @driver.start_driver
    Appium.promote_appium_methods Object
  }

  c.after(:each) {
    @driver.driver_quit
  }
}

# テスト対象がiOS/Androidか判定
#
# @return [true,false] iOSならtrue、Androidならfalse
def ios?
  return ENV["PLATFORM"] == "iOS"
end
