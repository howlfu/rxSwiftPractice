//
//  HorizontalViewModel.swift
//  rxSwiftPractice
//
//  Created by Howlfu on 2022/9/28.
//

import Foundation
import RxSwift
class HorizontalViewModel {
    let coordinator: ImageCoordinator!
    
    init(coor: ImageCoordinator) {
        coordinator = coor
    }
    
    func backToMain() {
        coordinator.backToList()
    }
    
    func getCellItems() -> Observable<[String]> {
        let itemComt = HorizonCellModel(imageArr: [
            "Image1",
            "Image2",
            "Image3"
        ])
        let items = Observable.just(itemComt.imageArr)
        return items
    }
    
    func getCollectionItems() -> Observable<[String]> {
        let itemComt = HorizonCollectionModel(imageArr: [
            "Image1",
            "Image2",
            "Image3",
            "Image1",
            "Image2",
            "Image3",
            "Image1",
            "Image2",
            "Image3",
            "Image1",
            "Image2",
            "Image3",
            "Image1",
            "Image2",
            "Image3",
            "Image1",
            "Image2",
            "Image3",
            "Image1",
            "Image2",
            "Image3",
            "Image1",
            "Image2",
            "Image3",
            "Image1",
            "Image2",
            "Image3",
            "Image1",
            "Image2",
            "Image3",
            "Image1",
            "Image2",
            "Image3",
            "Image1",
            "Image2",
            "Image3",
            "Image1",
            "Image2",
            "Image3",
            "Image1",
            "Image2",
            "Image3"
        ])
        let items = Observable.just(itemComt.imageArr)
        return items
    }
}
