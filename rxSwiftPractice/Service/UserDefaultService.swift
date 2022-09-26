//
//  UserDefaultService.swift
//  rxSwiftPractice
//
//  Created by Howlfu on 2022/9/26.
//

import Foundation

class UserService {
  
  static var shared = UserService()
  let logInToken = "logInToken"
  // 是否登入
  var isSuccessLogin: Bool{
    get{
      if let _ = accessToken{
        return true
      }
      return false
    }
  }
  
  var accessToken: String?{
    set{
      let userDefaults = UserDefaults.standard
      userDefaults.setValue(newValue, forKey: logInToken)
      userDefaults.synchronize()
    }
    get{
      return UserDefaults.standard.string(forKey: logInToken)
    }
  }
  
  func clear() {
    resetDefaults()
  }
  
  private func resetDefaults() {
    let defaults = UserDefaults.standard
    let dictionary = defaults.dictionaryRepresentation()
    dictionary.keys.forEach { key in
      defaults.removeObject(forKey: key)
    }
  }
}

