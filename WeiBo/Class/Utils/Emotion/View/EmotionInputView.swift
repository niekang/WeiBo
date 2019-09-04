
//
//  EmotionInputView.swift
//  WeiBo
//
//  Created by 聂康  on 2017/6/28.
//  Copyright © 2017年 com.nk. All rights reserved.
//

import UIKit


private let cellId = "EmotionCell"

class EmotionInputView: UIView {

    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var toolView: EmotionToolView!
    
    @IBOutlet weak var pageControl: UIPageControl!

    
    var selectEmotion:((Emotion?)->())?
    /// 加载并且返回输入视图
    class func inputView(selectEmotion:((Emotion?)->())?) -> EmotionInputView {
        
        let nib = UINib(nibName: "EmotionInputView", bundle: nil)
        
        let v = nib.instantiate(withOwner: nil, options: nil)[0] as! EmotionInputView
        
        v.selectEmotion = selectEmotion
        
        return v
    }
    
    override func awakeFromNib() {
        
        toolView.delegate = self
        
        frame = CGRect(x: 0, y: 0, width: kWidth, height: 253)
        
        collectionView.register(EmotionCollectionViewCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.delegate = self;
        collectionView.dataSource = self;
        
        // 设置分页控件的图片
        let bundle = EmotionManager.shared.bundle
        
        guard let normalImage = UIImage(named: "compose_keyboard_dot_normal", in: bundle, compatibleWith: nil),
            let selectedImage = UIImage(named: "compose_keyboard_dot_selected", in: bundle, compatibleWith: nil) else {
                return
        }
        
        // 使用填充图片设置颜色
        //        pageControl.pageIndicatorTintColor = UIColor(patternImage: normalImage)
        //        pageControl.currentPageIndicatorTintColor = UIColor(patternImage: selectedImage)
        
        // 使用 KVC 设置私有成员属性
        pageControl.setValue(normalImage, forKey: "_pageImage")
        pageControl.setValue(selectedImage, forKey: "_currentPageImage")
        
    }
}


// MARK: - UICollectionViewDelegate, UICollectionViewDataSource
extension EmotionInputView: UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return EmotionManager.shared.packages.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return EmotionManager.shared.packages[section].page
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! EmotionCollectionViewCell
        cell.emotions = EmotionManager.shared.packages[indexPath.section].emotions(page: indexPath.row)
        cell.delegate = self
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        // 1. 获取中心点
        var center = scrollView.center
        center.x += scrollView.contentOffset.x
        
        // 2. 获取当前显示的 cell 的 indexPath
        let paths = collectionView.indexPathsForVisibleItems
        
        // 3. 判断中心点在哪一个 indexPath 上，在哪一个页面上
        var targetIndexPath: IndexPath?
        
        for indexPath in paths {
            
            // 1> 根据 indexPath 获得 cell
            let cell = collectionView.cellForItem(at: indexPath)
            
            // 2> 判断中心点位置
            if cell?.frame.contains(center) == true {
                targetIndexPath = indexPath
                
                break
            }
        }
        
        guard let target = targetIndexPath else {
            return
        }
        
        // 4. 判断是否找到 目标的 indexPath
        // indexPath.section => 对应的就是分组
        toolView.selectedIndex = target.section
        
        // 5. 设置分页控件
        // 总页数，不同的分组，页数不一样
        pageControl.numberOfPages = collectionView.numberOfItems(inSection: target.section)
        pageControl.currentPage = target.item
    }
}


extension EmotionInputView:EmotionCollectionViewCellDelegate {
    
    func emoticonCellDidSelectedEmoticon(cell: EmotionCollectionViewCell, em: Emotion?) {
        selectEmotion?(em)
        WBLog(em)
        // 添加最近使用的表情
        guard let em = em else {
            return
        }
        
        // 如果当前 collectionView 就是最近的分组，不添加最近使用的表情
        let indexPath = collectionView.indexPathsForVisibleItems[0]
        if indexPath.section == 0 {
            return
        }
        
        // 添加最近使用的表情
        EmotionManager.shared.recentEmoticon(em: em)
        
        // 刷新数据 - 第 0 组
        var indexSet = IndexSet()
        indexSet.insert(0)
        
        collectionView.reloadSections(indexSet)

    }
    
}


extension EmotionInputView:EmotionToolViewDelegate {
    
    func emotionToolViewDidSelectedItemIndex(toolView: EmotionToolView, index: Int) {
        // 让 collectionView 发生滚动 -> 每一个分组的第0页
        let indexPath = IndexPath(item: 0, section: index)
        
        collectionView.scrollToItem(at: indexPath, at: .left, animated: true)
        
        // 设置分组按钮的选中状态
        toolView.selectedIndex = index

    }
}
