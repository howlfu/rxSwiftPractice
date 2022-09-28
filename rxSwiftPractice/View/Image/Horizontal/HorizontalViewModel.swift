//
//  HorizontalViewModel.swift
//  rxSwiftPractice
//
//  Created by Howlfu on 2022/9/28.
//

import Foundation
import Foundation
class HorizontalViewModel {
    let coordinator: ImageCoordinator!
    
    init(coor: ImageCoordinator) {
        coordinator = coor
    }
    func backToMain() {
        coordinator.backToList()
    }
}
