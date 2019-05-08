
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

    lazy var statusListViewModel = WBStatusListViewModel() // ViewModel 处理微博数据
    
    let refreshControl = NKRefreshControl() /// 下拉刷新控件
    
    override func viewDidLoad() {
        setupUI() //在判断登录状态之前 注册table 接收到登录通知之后 显示数据
        super.viewDidLoad()
    }
    
    override func loginSuccess() {
        super.loginSuccess()
        setupUI() /// 注册table
        loadData() // 加载数据
    }
    
    @objc override func loadData() {
        /// 如果是下拉，显示下拉动画
        if isHeader {
            refreshControl.beginRefresh()
        }
        
        statusListViewModel.loadWBStatusListData(isHeader: isHeader) { (isSuccess) in
            self.isHeader = true
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
        
        NotificationCenter.default.addObserver(self, selector: #selector(loadData), name: NSNotification.Name.init(rawValue: WBHomeVCShouldRefresh), object: nil)
    }
    
    func setupBarButtonItems() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(imageName: "navigationbar_friendattention", target: self, action: #selector(leftButtonClick))

        navigationItem.rightBarButtonItem = UIBarButtonItem(imageName: "navigationbar_pop", target: self, action: #selector(rightButtonClick))
        
        let name = WBUserAccont.shared.screen_name
        let btn = WBTitleButton(title: name)
        navigationItem.titleView = btn
        btn.addTarget(self, action: #selector(titleButtonClick(btn:)), for: .touchUpInside)
    }
    
    @objc func leftButtonClick() {
        
    }
    
    @objc func rightButtonClick() {
        let QRCodeVC = WBQRCodeViewController()
        navigationController?.pushViewController(QRCodeVC, animated: true)
    }
    
    @objc func titleButtonClick(btn:UIButton) {
        btn.isSelected = !btn.isSelected
    }

}
