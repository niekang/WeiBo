//
//  BaseTableViewController.swift
//  WeiBo
//
//  Created by 聂康 on 2019/9/11.
//  Copyright © 2019 com.nk. All rights reserved.
//

import UIKit

class BaseTableViewController: BaseViewController {

    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: self.view.frame)
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        tableView.backgroundColor = UIColor.white
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(tableView)
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
