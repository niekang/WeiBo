
//
//  HomeViewController.swift
//  WeiBo
//
//  Created by 聂康  on 2017/6/19.
//  Copyright © 2017年 com.nk. All rights reserved.
//

import UIKit

let normalCellId = "WBStatusNormalCell"

class WBHomeViewController: WBBaseViewController {

    lazy var statusListViewModel = WBStatusListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func loginSuccess() {
        super.loginSuccess()
        statusListViewModel.loadWBStatusListData(since_id: 0, max_id: 0, count: 0) { (isSuccess) in
            self.tableView.reloadData()
        }
    }
}

extension WBHomeViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return statusListViewModel.statusList.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: normalCellId, for: indexPath) as! WBStatusCell
        cell.textLabel?.text = statusListViewModel.statusList[indexPath.row].status.text
        return cell
    }
}

extension WBHomeViewController {
    
    func setupUI() {
        
        tableView.register(UINib(nibName: "WBStatusNormalCell", bundle: nil), forCellReuseIdentifier: normalCellId)
        
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
