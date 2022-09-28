//
//  LoginViewModel.swift
//  rxSwiftPractice
//
//  Created by Howlfu on 2022/9/28.
//

import Foundation
class LoginViewModel {
    let coordinator: MainCoordinator!
    
    init(coor: MainCoordinator) {
        coordinator = coor
    }
    
    func toSecView() {
        coordinator.loginToSecView()
    }
    
    func keyChainSave(acc: String?, pw: String?) {
        guard let account = acc, let password = pw else {
            return
        }
        let keyChain: KeyChainService = KeyChainService()
        keyChain.save(password, for: account)
    }
}
