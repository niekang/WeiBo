//
//  BaseTableViewController.swift
//  WeiBo
//
//  Created by 聂康 on 2019/9/3.
//  Copyright © 2019 com.nk. All rights reserved.
//

import UIKit

class BaseTableViewController<T>: BaseViewController, UITableViewDataSource, UITableViewDelegate {
    
    typealias ConfigCellClosure = (IndexPath, T) -> UITableViewCell
    typealias ConfigCellHeightClosure = (IndexPath, T) -> CGFloat
    typealias CommonConfigClosure = (IndexPath, T) -> Void
    typealias ScrollClosure = (UIScrollView) -> Void

    //MARK: dataSource, delegate closure
    public var configCell: ConfigCellClosure!
    public var configCellHeight: ConfigCellHeightClosure?
    public var willDisplayCell: CommonConfigClosure?
    public var didSelectedCell: CommonConfigClosure?
    public var endDecelerating: ScrollClosure?
    public var didScroll: ScrollClosure?

    public var dataSource = [T]()
    
    private(set) lazy var tableView: UITableView = {
        let tableView = UITableView(frame: self.view.frame)
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        tableView.backgroundColor = UIColor.white
        tableView.dataSource = self
        tableView.delegate = self
        return tableView
    }()

    override func viewDidLoad() {
        self.view.addSubview(tableView)
        super.viewDidLoad()
    }
    
    //MARK: Override
    public func loadData() {
        
    }
    
    public func loadMoreData() {
        
    }
    
    //MARK:  UITableViewDataSource, UITableViewDelegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataSource.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let configCellHeight = self.configCellHeight else {
            return tableView.rowHeight
        }
        return configCellHeight(indexPath, self.dataSource[indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return self.configCell(indexPath, self.dataSource[indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.didSelectedCell?(indexPath, self.dataSource[indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        self.willDisplayCell?(indexPath, self.dataSource[indexPath.row])
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.didScroll?(scrollView)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        self.endDecelerating?(scrollView)
    }
}
