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
    @IBOutlet weak var logoutBtn: UIButton!
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
        initView()
        bindingAll()
    }
    
    private func initView() {
        self.county.placeholder = "新北市"
        self.dist.placeholder = "樹林區"
    }
    
    private func bindingAll() {
        // subscribe
        let countyObser = self.county.rx.text.orEmpty.map{
            $0.count > 0 } .share(replay: 1)
        let cityObser = self.dist.rx.text.orEmpty.map{
            $0.count > 0 } .share(replay: 1)
        let getBtnType = Observable.combineLatest(countyObser, cityObser){$0 && $1}.share(replay: 1)
        getBtnType.bind(to: self.getBtn.rx.isEnabled).disposed(by: disposeBag)
        
        viewModel.temperate
            .observe(on: MainScheduler.instance)
            .subscribe(
            onNext: { [weak self] (data) in
                self?.tmpLabel.text = String(data) + "°C"
        }, onError: { [weak self] error in
            self?.showAlert(title: "錯誤", msg:  "網路異常")
        }).disposed(by: disposeBag)
        //binder for bind in MainScheduler
        let rainObserver: Binder<Int> = Binder(viewModel.rainRate) { [weak self] (control, data) in
            self?.rainRate.text = String(data)
        }
        viewModel.rainRate
            .bind(to: rainObserver)
            .disposed(by: disposeBag)
        
        //bind to observerable directly
        viewModel.humiRate
            .observe(on: MainScheduler.instance)
            .bind { [weak self] (data) in
                self?.humiRate.text = String(data) + "%"
        }.disposed(by: disposeBag)
        
        viewModel.desc
            .observe(on: MainScheduler.instance)
            .bind { [weak self] (data) in
                self?.descLabel.text = data
        }.disposed(by: disposeBag)
        
        viewModel.logout.bind(onNext: {[weak self] (isLogout) in
            if isLogout {
                self?.navigationController?.popViewController(animated: false)
            }
        }).disposed(by: disposeBag)
        //operator
        getBtn.rx.tap.subscribe(onNext:  { [weak self] in
            var county = self?.county.text ?? "新北市"
            var town = self?.dist.text ?? "樹林區"
            self?.viewModel.getWeather(county: county, town: town)
        }).disposed(by: disposeBag)
        
        let logoutBtnObs = logoutBtn.rx.tap.subscribe(onNext:  { [weak self] in
            self?.viewModel.logoutAct()
        })
    }
    
    
    
    private func showAlert(title: String, msg: String) {
        let controller = UIAlertController(title: title, message: msg , preferredStyle: .alert)
           let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
           controller.addAction(okAction)
           present(controller, animated: true, completion: nil)
    }
}
