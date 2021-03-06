//
//  WBMessageViewController.swift
//  WeiBo
//
//  Created by 聂康  on 2017/6/19.
//  Copyright © 2017年 com.nk. All rights reserved.
//

import UIKit

class WBMessageViewController: WBBaseTabViewController {
    
    let data = [
        ["title": "@我的", "icon":"messagescenter_at"],
        ["title":"评论","icon":"messagescenter_comments"],
        ["title":"赞","icon":"messagescenter_good"]
    ]
    
    let adapter = TableViewDataSource<WBMessage>()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.configTable()

    }
    
}

extension WBMessageViewController {
    
    func configTable() {
        self.tableView.delegate = adapter
        self.tableView.dataSource = adapter
        
        self.tableView.rowHeight = 70
        adapter.dataSource = data.map({ (item) in
            return WBMessage(title: item["title"], detail: nil, icon: item["icon"])
        });

        let cellIden = "WBMessageCellTableViewCell"
        self.tableView.register(UINib(nibName: cellIden, bundle: nil), forCellReuseIdentifier: cellIden)
        
        adapter.configCell = {indexPath, model, tableView, _ in
            let cell = tableView.dequeueReusableCell(withIdentifier: cellIden) as! WBMessageCellTableViewCell
            cell.model = model
            return cell
        }
    }
}
