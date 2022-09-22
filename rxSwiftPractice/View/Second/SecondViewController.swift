//
//  SecondViewController.swift
//  rxSwiftPractice
//
//  Created by Howlfu on 2022/9/13.
//

import Foundation
import UIKit
import RxSwift

class SecondViewController: UIViewController {
    @IBOutlet weak var county: UITextField!
    @IBOutlet weak var dist: UITextField!
    @IBOutlet weak var tmpLabel: UILabel!
    @IBOutlet weak var getBtn: UIButton!
    @IBOutlet weak var humiRate: UILabel!
    @IBOutlet weak var rainRate: UILabel!
    @IBOutlet weak var discLabel: UILabel!
    @IBOutlet weak var pmLabel: UILabel!
    let disposeBag = DisposeBag()
    let controller = SecondController()
    override func viewDidLoad() {
        super.viewDidLoad()
        bindingAll()
        
    }
    
    private func bindingAll() {
        getBtn.rx.tap.subscribe(onNext:  { [weak self] in
            self?.controller.getWeather()
        }).disposed(by: disposeBag)
    }
    
    @IBAction func tryGetAct(_ sender: Any) {

    }
}
