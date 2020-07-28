//
//  Presenter.swift
//  WeiBo
//
//  Created by 聂康 on 2020/7/29.
//  Copyright © 2020 com.nk. All rights reserved.
//

import Foundation

protocol ViewType: NSObjectProtocol {
    func loginStateChange(enable: Bool)
}

protocol UserLoginProtocol: NSObjectProtocol {
    func textDidChange(usename: String, password: String)
    func login(username: String, password: String)
}

class Presenter: NSObject {
    
    weak var view: ViewType?
    
    init(_ view: ViewType) {
        self.view = view
    }
}

extension Presenter: UserLoginProtocol {
    
    func textDidChange(usename: String, password: String) {
        let can = usename.count >= 6 && password.count >= 6
        print(can)
        self.view?.loginStateChange(enable: can)
    }
    
    func login(username: String, password: String) {
        print("登录")
    }
}
