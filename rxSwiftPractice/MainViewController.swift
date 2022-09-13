//
//  ViewController.swift
//  rxSwiftPractice
//
//  Created by Howlfu on 2022/9/12.
//

import UIKit
import RxSwift
import RxCocoa

class MainViewController: UIViewController {

    @IBOutlet weak var usernameOutlet: UITextField!
    @IBOutlet weak var usernameValidOutlet: UILabel!
    
    @IBOutlet weak var passwordOutlet: UITextField!
    @IBOutlet weak var passwordValidOutlet: UILabel!
    @IBOutlet weak var loginBtnOutlet: UIButton!
    var disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        usernameValidOutlet.text = "Username at least 5 characters"
        passwordValidOutlet.text = "Password at least 5 characters"
        bindingAll()
    }
    
    private func bindingAll() {
        let userNameOver5 = getObservableBool(target: usernameOutlet)
        let userNameEmpty = usernameOutlet.rx.text.orEmpty.map{
                    $0.count == 0 } .share(replay: 1)
        let userNameValid = Observable.combineLatest(userNameEmpty, userNameOver5) {$0 || $1}.share(replay: 1)
        self.bindingElement(obser: userNameValid, binder: self.usernameValidOutlet.rx.isHidden)
        self.bindingElement(obser: userNameOver5, binder: self.passwordOutlet.rx.isEnabled)
        
        let passwordOver5 = getObservableBool(target: passwordOutlet)
        let passwordEmpty = passwordOutlet.rx.text.orEmpty.map{
                    $0.count == 0 } .share(replay: 1)
        let passwordValid = Observable.combineLatest(passwordEmpty, passwordOver5) {$0 || $1}.share(replay: 1)
        self.bindingElement(obser: passwordValid, binder: self.passwordValidOutlet.rx.isHidden)
        
        let everyThingValid = Observable.combineLatest(userNameOver5, passwordOver5) {$0 && $1}.share(replay: 1)
        self.bindingElement(obser: everyThingValid, binder: self.loginBtnOutlet.rx.isEnabled)
        
    }
    
    private func getObservableBool(target: UITextField) -> Observable<Bool> {
        return target.rx.text.orEmpty.map{
            $0.count >= 5
        } .share(replay: 1)
    }

    private func bindingElement(obser: Observable<Bool>, binder: Binder<Bool>) {
        obser.bind(to:binder).disposed(by: disposeBag)
    }
    

}

