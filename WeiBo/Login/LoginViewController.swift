//
//  Login.swift
//  WeiBo
//
//  Created by 聂康 on 2020/7/28.
//  Copyright © 2020 com.nk. All rights reserved.
//

import Foundation
import UIKit
import RxCocoa
import RxSwift

class LoginViewController: UIViewController {
 
    @IBOutlet weak var acount: UITextField!
    
    @IBOutlet weak var password: UITextField!
    
    @IBOutlet weak var loginBtn: UIButton!
    
    var viewModel: LoginViewModel?
    
    var presenter: Presenter?
    
    lazy var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginBtn.isUserInteractionEnabled = false
//        mvvm()
        mvp()
    }
    
    func mvvm() {
       viewModel = LoginViewModel(acount.rx.text.orEmpty.asObservable(), password.rx.text.orEmpty.asObservable())
       
       viewModel?.usernameValid.bind(to: password.rx.isEnabled).disposed(by: disposeBag)
       
       viewModel?.canLogin.bind(to: loginBtn.rx.isEnabled).disposed(by: disposeBag)
       
       loginBtn.rx.tap.subscribe(onNext: {
           print("正在登录")
           }).disposed(by: disposeBag)
    }
    
    func mvp() {
        presenter = Presenter(self)
        
        Observable.combineLatest(acount.rx.text.orEmpty, password.rx.text.orEmpty).subscribe(onNext: { [weak self](name, pwd) in
            self?.presenter?.textDidChange(usename: name, password: pwd)
        }).disposed(by: disposeBag)
        
        loginBtn.rx.tap.subscribe(onNext: {[weak self] in
            self?.presenter?.login(username: self?.acount.text ?? "", password: self?.password.text ?? "")
        }).disposed(by: disposeBag)
    }
}

extension LoginViewController: ViewType {
    
    func loginStateChange(enable: Bool) {
        self.loginBtn.isUserInteractionEnabled = enable
    }
}
