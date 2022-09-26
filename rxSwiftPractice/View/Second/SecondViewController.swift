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
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var pmLabel: UILabel!
    let disposeBag = DisposeBag()
    let viewModel = SecondViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        bindingAll()
    }
    
    private func bindingAll() {
        // subscribe
        viewModel.temperate.subscribe(
            onNext: { [weak self] (data) in
                DispatchQueue.main.async {
                    self?.tmpLabel.text = String(data) + "°C"
                }
        }, onError: { [weak self] error in
            DispatchQueue.main.async {
                self?.showAlert()
            }
        }).disposed(by: disposeBag)
        //binder for bind in MainScheduler
        let rainObserver: Binder<Int> = Binder(viewModel.rainRate) { [weak self] (control, data) in
            self?.rainRate.text = String(data)
        }
        viewModel.rainRate
            .bind(to: rainObserver)
            .disposed(by: disposeBag)
        
        //bind to observerable directly
        viewModel.humiRate.bind { [weak self] (data) in
            DispatchQueue.main.async {
                self?.humiRate.text = String(data) + "%"
            }
        }.disposed(by: disposeBag)
        
        viewModel.desc.bind { [weak self] (data) in
            DispatchQueue.main.async {
                self?.descLabel.text = data
            }
        }.disposed(by: disposeBag)
        
        //operator
        getBtn.rx.tap.subscribe(onNext:  { [weak self] in
            DispatchQueue.main.async {
                self?.viewModel.getWeather()
            }
        }).disposed(by: disposeBag)
        
    }
    
    private func showAlert() {
        let controller = UIAlertController(title: "錯誤", message: "網路異常", preferredStyle: .alert)
           let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
           controller.addAction(okAction)
           present(controller, animated: true, completion: nil)
    }
}
