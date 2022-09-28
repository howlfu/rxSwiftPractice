//
//  ImageCoordinator.swift
//  rxSwiftPractice
//
//  Created by Howlfu on 2022/9/28.
//

import UIKit
class ImageCoordinator: Coordinator {
    var parentCoordinator: Coordinator?
    var children: [Coordinator] = []
    var navigationController: UINavigationController?
    private let storyboard = UIStoryboard.init(name: "ImagePicker", bundle: .main)
    init(nav: UINavigationController) {
        self.navigationController = nav
    }
    
    
    func start() {
        let startView = ImageMainViewController.instantiate()
        startView.viewModel = ImageMainViewModel(coor: self)
        self.navigationController?.pushViewController(startView, animated: false)
    }
    
    func backToMain() {
        guard let parent = self.parentCoordinator as? MainCoordinator else {
            print("Image coordinator have no parent")
            return
        }
        parent.toSecView()
    }
    
    func toHorizontal() {
        let secViewVC = storyboard.instantiateViewController(withIdentifier: "horizon") as! HorizontalViewController
        let viewModel = HorizontalViewModel(coor: self)
        secViewVC.viewModel = viewModel
        self.navigationController?.pushViewController(secViewVC, animated: false)
    
    }
    
    func toVertical() {
        let secViewVC = storyboard.instantiateViewController(withIdentifier: "vertical") as! VerticalViewController
        let viewModel = VerticalViewModel(coor: self)
        secViewVC.viewModel = viewModel
        self.navigationController?.pushViewController(secViewVC, animated: false)
    }
    
    func backToList() {
        self.navigationController?.popViewController(animated: false)
    }
    
}
