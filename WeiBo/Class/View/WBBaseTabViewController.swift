//
//  WBBaseTabViewController.swift
//  WeiBo
//
//  Created by 聂康 on 2019/9/6.
//  Copyright © 2019 com.nk. All rights reserved.
//

import UIKit

protocol VisitorViewProtocol {
    func getVisitorView() -> VisitorView
}

class WBBaseTabViewController<T>: BaseTableViewController<T> {
    
    lazy var visitorView = VisitorView(frame: self.view.bounds)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
    }

}

extension WBBaseTabViewController: VisitorViewProtocol {
    
    func getVisitorView() -> VisitorView {
        return self.visitorView
    }
}
