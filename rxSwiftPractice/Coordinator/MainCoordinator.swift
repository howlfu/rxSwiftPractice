//
//  AppCoordinator.swift
//  rxSwiftPractice
//
//  Created by Howlfu on 2022/9/27.
//

import UIKit
//protocol Coordinator : class {
//    var childCoordinators : [Coordinator] { get set }
//    func start()
//}

class MainCoordinator: Coordinator {
    var parentCoordinator: Coordinator?
    var children: [Coordinator] = []
    var navigationController: UINavigationController?
    private let window: UIWindow
    private let storyboard = UIStoryboard.init(name: "Main", bundle: .main)
    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        //start to Login view
        let startView = LoginViewController.instantiate()
        startView.viewModel = LoginViewModel.init(coor: self)
        navigationController = UINavigationController(rootViewController: startView)
        navigationController?.isNavigationBarHidden = true
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
    
    func childDidFinished(child: Coordinator) {
//        if children.contains(where: child) {
//            
//        }
    }
    
    func toSecView() {
        let secViewVC = storyboard.instantiateViewController(withIdentifier: "secondView") as! SecondViewController
        let viewModel = SecondViewModel(coor: self)
        secViewVC.viewModel = viewModel
        self.navigationController?.pushViewController(secViewVC, animated: false)
    }
    
    func backToLogin() {
        self.navigationController?.popViewController(animated: false)
    }
    
    func secToImageFlow() {
        guard let navMain = self.navigationController else {
            print("Main nav is gone")
            return
        }
        let imageCoordinator = ImageCoordinator(nav: navMain)
        children.append(imageCoordinator)
        imageCoordinator.parentCoordinator = self
        imageCoordinator.start()
    }
    
}
