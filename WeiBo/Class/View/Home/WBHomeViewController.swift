
//
//  HomeViewController.swift
//  WeiBo
//
//  Created by 聂康  on 2017/6/19.
//  Copyright © 2017年 com.nk. All rights reserved.
//

import UIKit

class WBHomeViewController: WBBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
}

extension WBHomeViewController {
    
    func setupUI() {
        setupBarButtonItems()
    }
    
    func setupBarButtonItems() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(imageName: "navigationbar_friendattention", target: self, action: #selector(leftButtonClick))

        navigationItem.rightBarButtonItem = UIBarButtonItem(imageName: "navigationbar_pop", target: self, action: #selector(rightButtonClick))
    }
    
    func leftButtonClick() {
        
    }
    
    func rightButtonClick() {
        let QRCodeVC = WBQRCodeViewController()
        navigationController?.pushViewController(QRCodeVC, animated: true)
    }

}
