//
//  ImageMainViewController.swift
//  rxSwiftPractice
//
//  Created by Howlfu on 2022/9/28.
//

import UIKit
import RxSwift
import RxCocoa
class ImageMainViewController: UIViewController {
    let disposeBag = DisposeBag()
    @IBOutlet weak var horizontalBtn: UIButton!
    @IBOutlet weak var verticalBtn: UIButton!
    @IBOutlet weak var backBtn: UIButton!
    var viewModel: ImageMainViewModel!
    
    static func instantiate() -> ImageMainViewController {
        let storyBoard = UIStoryboard(name: "ImagePicker", bundle: .main)
        let viewController = storyBoard.instantiateInitialViewController() as! ImageMainViewController
         return viewController
    }
    
    override func viewDidLoad() {
        bindAll()
    }
    
    private func bindAll() {
        horizontalBtn.rx.tap
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] in
                self?.viewModel.toHorizontalView()
            })
            .disposed(by: disposeBag)
        
        verticalBtn.rx.tap
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] in
                self?.viewModel.toVerticalView()
            })
            .disposed(by: disposeBag)
        
        backBtn.rx.tap
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] in
                self?.viewModel.backToMain()
            })
            .disposed(by: disposeBag)
        
    }
}
