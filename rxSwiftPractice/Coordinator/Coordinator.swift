//
//  Coordinator.swift
//  rxSwiftPractice
//
//  Created by Howlfu on 2022/9/28.
//

import UIKit
protocol Coordinator {
    var parentCoordinator: Coordinator? { get set }
    var children: [Coordinator] { get set }
    var navigationController : UINavigationController? { get set }
    
    func start()
}
