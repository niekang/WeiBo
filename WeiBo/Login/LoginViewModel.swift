//
//  LoginViewModel.swift
//  WeiBo
//
//  Created by 聂康 on 2020/7/29.
//  Copyright © 2020 com.nk. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa


class LoginViewModel {
    
    var usernameValid: Observable<Bool>
    var passwordValid: Observable<Bool>
    var canLogin: Observable<Bool>
    
    init(_ username: Observable<String>, _ password: Observable<String>) {
        
        usernameValid = username.map({ (text) -> Bool in
            return text.count >= 6
        })
        passwordValid = password.map({ (text) -> Bool in
            return text.count >= 6
        })
        canLogin = Observable.combineLatest(usernameValid, passwordValid).map({ (valid1, valid2) -> Bool in
            return valid1 && valid2
        })
    }
}
