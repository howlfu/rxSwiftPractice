//
//  VerticalViewModel.swift
//  rxSwiftPractice
//
//  Created by Howlfu on 2022/9/28.
//

import Foundation
import RxSwift
import RxCocoa
class VerticalViewModel {
    let coordinator: ImageCoordinator!
    
    init(coor: ImageCoordinator) {
        coordinator = coor
    }
    
    func getItems() -> Observable<[String]> {
        let itemCont = VerticalCellModel(imageArr: [
            "Image1",
            "Image2",
            "Image3"
        ])
        let items = Observable.just(itemCont.imageArr)
        return items
    }
    
    func backToMain() {
        coordinator.backToList()
    }
    
}
