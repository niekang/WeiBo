//
//  WBBaseTabViewController.swift
//  WeiBo
//
//  Created by 聂康 on 2019/9/6.
//  Copyright © 2019 com.nk. All rights reserved.
//

import UIKit

protocol VisitorViewProtocol {
    var visitorView: VisitorView {get set}
}


class WBBaseTabViewController<T>: BaseTableViewController<T>, VisitorViewProtocol{
    
    var visitorView = VisitorView(frame: CGRect(x: 0, y: kNavHeight, width: kWidth, height: kHeight - kNavHeight - kTabBarHeight))
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        visitorView.target = self
    }

}
