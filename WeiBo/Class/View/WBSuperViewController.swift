//
//  WBSuperBaseViewController.swift
//  WeiBo
//
//  Created by 聂康  on 2017/6/21.
//  Copyright © 2017年 com.nk. All rights reserved.
//

import UIKit

class WBSuperViewController: UIViewController {
    
    deinit {
        WBLog("\(self.classForCoder)" + "释放了")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
    }
}