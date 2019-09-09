//
//  BaseSectionTableViewController.swift
//  WeiBo
//
//  Created by 聂康 on 2019/9/7.
//  Copyright © 2019 com.nk. All rights reserved.
//

import UIKit

protocol SectionModelType {
    
    associatedtype Section
    associatedtype Item
    
    var section: Section {get}
    var items: [Item] {get}
    
    init(section: Section, items: [Item])
}

public struct SectionModel<SectionType, ItemType>: SectionModelType {
    
    typealias Section = SectionType
    
    typealias Item = ItemType
    
    public var section: SectionType
    public var items: [ItemType]
    
    public init(section: SectionType, items: [ItemType]) {
        self.section = section
        self.items = items
    }
}


class BaseSectionTableViewController<T: SectionModelType>: BaseViewController, UITableViewDataSource, UITableViewDelegate {
 
    typealias ConfigCellClosure = (IndexPath, T.Item, [T], UITableView) -> UITableViewCell
    typealias ConfigCellHeightClosure = (IndexPath, T.Item, [T], UITableView) -> CGFloat
    typealias CommonConfigClosure = (IndexPath, T.Item, [T], UITableView) -> Void
    typealias ScrollClosure = (UIScrollView) -> Void
    typealias ConfigViewClosure = (Int, [T], UITableView) -> UIView?
    typealias ConfigViewHeightClosure = (Int, [T], UITableView) -> CGFloat
    
    //MARK: dataSource, delegate closure
    public var configCell: ConfigCellClosure!
    public var configCellHeight: ConfigCellHeightClosure?
    public var willDisplayCell: CommonConfigClosure?
    public var didSelectedCell: CommonConfigClosure?
    public var endDecelerating: ScrollClosure?
    public var didScroll: ScrollClosure?
    public var viewForHeader: ConfigViewClosure?
    public var viewForFooter: ConfigViewClosure?
    public var heightForHeader: ConfigViewHeightClosure?
    public var heightForFooter: ConfigViewHeightClosure?


    
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
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.dataSource.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataSource[section].items.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let configCellHeight = self.configCellHeight else {
            return tableView.rowHeight
        }
        return configCellHeight(indexPath, self.dataSource[indexPath.section].items[indexPath.row], self.dataSource, tableView)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return self.configCell(indexPath, self.dataSource[indexPath.section].items[indexPath.row], self.dataSource, tableView)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return self.viewForHeader?(section, self.dataSource, tableView)
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return self.viewForFooter?(section, self.dataSource, tableView)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return self.heightForHeader?(section, self.dataSource, tableView) ?? 0.0001
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return self.heightForFooter?(section, self.dataSource, tableView) ?? 0.0001
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.didSelectedCell?(indexPath, self.dataSource[indexPath.section].items[indexPath.row], self.dataSource, tableView)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        self.willDisplayCell?(indexPath, self.dataSource[indexPath.section].items[indexPath.row], self.dataSource, tableView)

    }
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.didScroll?(scrollView)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        self.endDecelerating?(scrollView)
    }

}
