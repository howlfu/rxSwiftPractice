//
//  KeyChainService.swift
//  rxSwiftPractice
//
//  Created by Howlfu on 2022/9/13.
//

import Foundation
enum keyChainType {
    case password
}
class KeyChainService {
    func save(_ value: String, for key: String) {
        if isExist(key: key) {
            self.updateValue(value, for: key)
        } else {
            self.createKey(value, for: key)
        }
    }
    
    func retrive<T>(KeyName: String, typeOfKey: keyChainType) -> T?{
        switch typeOfKey {
        case .password:
            return retrivePassword(for: KeyName) as? T
        }
    }
    
    
    private func isExist(key: String) -> Bool {
        if let _ = retrivePassword(for: key) {
            return true
        }
        return false
    }
    
    private func updateValue(_ value: String, for key: String) {
        let valueData = value.data(using: String.Encoding.utf8)!
        let query = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key
        ] as CFDictionary
        let updateField = [
            kSecValueData: valueData
        ] as CFDictionary
        
        let status = SecItemUpdate(query, updateField)
        guard status == errSecSuccess else {
            return print("update error")
        }
    }
    
    private func createKey(_ value: String, for key: String){
        let valueData = value.data(using: String.Encoding.utf8)!
        let query: [String: Any] = [kSecClass as String: kSecClassGenericPassword,
                                    kSecAttrAccount as String: key,
                                    kSecValueData as String: valueData]
        let status = SecItemAdd(query as CFDictionary, nil)
        guard status == errSecSuccess else { return print("create error")
        }
    }
    
    private func retrivePassword(for account: String) -> String? {
        let query: [String: Any] = [kSecClass as String: kSecClassGenericPassword,
                                    kSecAttrAccount as String: account,
                                    kSecMatchLimit as String: kSecMatchLimitOne,
                                    kSecReturnData as String: kCFBooleanTrue as Any]
        
        
        var retrivedData: AnyObject? = nil
        let _ = SecItemCopyMatching(query as CFDictionary, &retrivedData)
        
        
        guard let data = retrivedData as? Data else {return nil}
        return String(data: data, encoding: String.Encoding.utf8)
    }
}
