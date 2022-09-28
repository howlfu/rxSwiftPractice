//
//  HorizontalViewController.swift
//  rxSwiftPractice
//
//  Created by Howlfu on 2022/9/28.
//

import UIKit
import RxSwift
import RxCocoa
class HorizontalViewController: UIViewController {
    let disposeBag = DisposeBag()
    @IBOutlet weak var titleLabel: UILabel!
    var viewModel: HorizontalViewModel!
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        bindAll()
    }
    
    private func bindAll() {
        let tapGesture = UITapGestureRecognizer()
        tapGesture.numberOfTapsRequired = 1
        tapGesture.rx.event.bind(onNext: { recognizer in
            self.viewModel.backToMain()
        }).disposed(by: disposeBag)
        
        titleLabel.isUserInteractionEnabled = true
        titleLabel.addGestureRecognizer(tapGesture)
    }
}
