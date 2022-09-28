//
//  ImageMainViewModel.swift
//  rxSwiftPractice
//
//  Created by Howlfu on 2022/9/28.
//

import Foundation
class ImageMainViewModel {
    let coordinator: ImageCoordinator!
    
    init(coor: ImageCoordinator) {
        coordinator = coor
    }
    
    func toHorizontalView() {
        self.coordinator.toHorizontal()
    }
    
    func toVerticalView() {
        self.coordinator.toVertical()
    }
    
    func backToMain() {
        self.coordinator.backToMain()
    }
}
