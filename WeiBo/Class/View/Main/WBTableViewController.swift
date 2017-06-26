//
//  WBTableViewController.swift
//  WeiBo
//
//  Created by 聂康  on 2017/6/21.
//  Copyright © 2017年 com.nk. All rights reserved.
//

import UIKit

class WBTableViewController: WBSuperViewController{
    
    lazy var tableView = UITableView()
    
    var isHeader = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    
    func setupTableView() {
        tableView.frame = view.bounds
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        view.addSubview(tableView)
        
    }
    
    func loadData() {
        
    }
}

extension WBTableViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        return UITableViewCell()
    }
    
    /// 当滑到底部的时候加载数据
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let row = indexPath.row
        let section = indexPath.section
        
        if row < 0 || section < 0 {
            return
        }
        
        let count = tableView.numberOfRows(inSection: section)
        
        if row == (count - 1) && isHeader{
            isHeader = false
            
            loadData()
        }
    }
}
