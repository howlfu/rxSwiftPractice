//
//  SecondViewController.swift
//  rxSwiftPractice
//
//  Created by Howlfu on 2022/9/13.
//

import Foundation
import UIKit

class SecondViewController: UIViewController {
    
    @IBOutlet weak var keyName: UITextField!
    @IBOutlet weak var tryGetBtn: UIButton!
    @IBOutlet weak var value: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    @IBAction func tryGetAct(_ sender: Any) {
        let keyChain: KeyChainService = KeyChainService()
        if let name = keyName.text {
            let retValue: String? = keyChain.retrive(KeyName: name, typeOfKey: .password) ?? ""
            value.text = retValue
        }
    }
}
