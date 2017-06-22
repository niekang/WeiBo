
//
//  HomeViewController.swift
//  WeiBo
//
//  Created by 聂康  on 2017/6/19.
//  Copyright © 2017年 com.nk. All rights reserved.
//

import UIKit

private let normalCellId = "WBStatusNormalCell"

private let retweetedCellId = "WBStatusRetweetedCell"

class WBHomeViewController: WBBaseViewController {

    lazy var statusListViewModel = WBStatusListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func loginSuccess() {
        super.loginSuccess()
        statusListViewModel.loadWBStatusListData() { (isSuccess) in
            self.tableView.reloadData()
        }
    }
}

extension WBHomeViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return statusListViewModel.statusList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: retweetedCellId, for: indexPath) as! WBStatusCell
        cell.statusViewModel = statusListViewModel.statusList[indexPath.row]
        return cell
    }
}

extension WBHomeViewController {
    
    func setupUI() {
        
        tableView.register(UINib(nibName: normalCellId, bundle: nil), forCellReuseIdentifier: normalCellId)
        tableView.register(UINib(nibName: retweetedCellId, bundle: nil), forCellReuseIdentifier: retweetedCellId)
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 300
        
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
