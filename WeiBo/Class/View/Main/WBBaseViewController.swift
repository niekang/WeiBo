//
//  WBBaseViewController.swift
//  WeiBo
//
//  Created by 聂康  on 2017/6/19.
//  Copyright © 2017年 com.nk. All rights reserved.
//

import UIKit

class WBBaseViewController: UIViewController {
    
    var visitorInfoDictionary:[String:String]?
        
    lazy var visitorView = VisitorView(frame: CGRect(x: 0, y: kNavHeight, width: kWidth, height: kHeight - kNavHeight - kTabBarHeight))

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
}

extension WBBaseViewController {
    
    func setup() {
        view.backgroundColor = UIColor.white
        view.addSubview(visitorView)
        visitorView.visitorInfoDictionary = visitorInfoDictionary
    }
}
