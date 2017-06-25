
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
    
    let refreshControl = NKRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func loginSuccess() {
        super.loginSuccess()
        setupUI()
        loadData()
    }
    
    func loadData() {
        refreshControl.beginRefresh()
        statusListViewModel.loadWBStatusListData() { (isSuccess) in
            self.tableView.reloadData()
            self.refreshControl.endRefresh()
        }
    }
}

extension WBHomeViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return statusListViewModel.statusList.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let statusViewModel = statusListViewModel.statusList[indexPath.row]
        let cellId = (statusViewModel.status.retweeted_status != nil) ? retweetedCellId : normalCellId
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! WBStatusCell
        cell.statusViewModel = statusViewModel
        return cell
    }
}

extension WBHomeViewController {
    
    func setupUI() {
        if navigationItem.titleView == nil{
            tableView.register(UINib(nibName: normalCellId, bundle: nil), forCellReuseIdentifier: normalCellId)
            tableView.register(UINib(nibName: retweetedCellId, bundle: nil), forCellReuseIdentifier: retweetedCellId)
            tableView.rowHeight = UITableViewAutomaticDimension
            tableView.estimatedRowHeight = 300
            
            tableView.addSubview(refreshControl)
            
            refreshControl.addTarget(self, action: #selector(loadData), for: .valueChanged)
            
            setupBarButtonItems()

        }
    }
    
    func setupBarButtonItems() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(imageName: "navigationbar_friendattention", target: self, action: #selector(leftButtonClick))

        navigationItem.rightBarButtonItem = UIBarButtonItem(imageName: "navigationbar_pop", target: self, action: #selector(rightButtonClick))
        
        let name = WBUserAccont.shared.screen_name
        let btn = WBTitleButton(title: name)
        navigationItem.titleView = btn
        btn.addTarget(self, action: #selector(titleButtonClick(btn:)), for: .touchUpInside)
    }
    
    func leftButtonClick() {
        
    }
    
    func rightButtonClick() {
        let QRCodeVC = WBQRCodeViewController()
        navigationController?.pushViewController(QRCodeVC, animated: true)
    }
    
    func titleButtonClick(btn:UIButton) {
        btn.isSelected = !btn.isSelected
    }

}
