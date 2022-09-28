//
//  ViewController.swift
//  rxSwiftPractice
//
//  Created by Howlfu on 2022/9/12.
//

import UIKit
import RxSwift
import RxCocoa

class LoginViewController: UIViewController {

    @IBOutlet weak var usernameOutlet: UITextField!
    @IBOutlet weak var usernameValidOutlet: UILabel!
    
    @IBOutlet weak var passwordOutlet: UITextField!
    @IBOutlet weak var passwordValidOutlet: UILabel!
    @IBOutlet weak var loginBtnOutlet: UIButton!
    var viewModel: LoginViewModel!
    
    static func instantiate() -> LoginViewController {
        let storyBoard = UIStoryboard(name: "Main", bundle: .main)
        let viewController = storyBoard.instantiateInitialViewController() as! LoginViewController
         return viewController
    }
    
    let disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        usernameOutlet.text = ""
        passwordOutlet.text = ""
        if UserService.shared.accessToken == "token123" {
           toNextView()
        }
//        initView()
    }
    
    private func initView() {
        let accountWarn = NSLocalizedString("Login.Warn.Account", comment: "Login Warning Message Account")
        let passwordWarn = NSLocalizedString("Login.Warn.Password", comment: "Login Warning Message Password")  
//        let path = Bundle.main.path(forResource: "zh-Hans", ofType: "lproj")
//        let bundle = Bundle(path: path!)
//        let str = NSLocalizedString("Login.Warn.Account" , tableName: nil, bundle: bundle!, value: "", comment: "")

        usernameValidOutlet.text = accountWarn
        passwordValidOutlet.text = passwordWarn
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
        
//        loginBtnOutlet.addTarget(self, action: #selector(loginBtnPress), for: .touchUpInside)
        loginBtnOutlet.rx.tap
            .observe(on: MainScheduler.instance)
            .subscribe( onNext: { [weak self] in
            self?.loginBtnPress()
        }).disposed(by: disposeBag)
        
    }
    @objc private func loginBtnPress() {
        let account = self.usernameOutlet.text
        let password = self.passwordOutlet.text
        self.viewModel.keyChainSave(acc: account, pw: password)
        UserService.shared.accessToken = "token123"
        self.toNextView()
    }
    
    private func toNextView() {
        viewModel.toSecView()
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

