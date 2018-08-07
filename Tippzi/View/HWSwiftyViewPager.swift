//
//  HWSwiftyViewPager.swift
//  HWSwiftViewPager

import UIKit

open class HWSwiftyViewPager: UICollectionView, UICollectionViewDelegate {
    
    
    
    enum PagerControlState : Int {
        case stayCurrent = 0
        case toLeft = 1
        case toRight = 2
    }
    
    fileprivate let VELOCITY_STANDARD : CGFloat = 0.6
    
    fileprivate var flowLayout: UICollectionViewFlowLayout!
    fileprivate var beforeFrame: CGRect! = nil
    fileprivate var itemsTotalCount = 0
    fileprivate var selectedPageNum = 0
    fileprivate var itemWidthWithMargin :CGFloat = 0
    fileprivate var scrollBeginOffset :CGFloat = 0
    fileprivate var pagerControlState = PagerControlState.stayCurrent
    
    var pageSelectedDelegate : HWSwiftyViewPagerDelegate?
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.isScrollEnabled = true
        self.isPagingEnabled = false
        self.delegate = self
        self.decelerationRate = UIScrollViewDecelerationRateFast
        
        self.flowLayout = self.collectionViewLayout as! UICollectionViewFlowLayout
        self.flowLayout.scrollDirection = .horizontal
        self.showsHorizontalScrollIndicator = false
        self.showsVerticalScrollIndicator = false
        self.beforeFrame = self.frame
    }
    
    override open func layoutSubviews() {
        super.layoutSubviews()
        
        // if present view size is not equal with before view size, size of item is change, too.
        if !self.frame.equalTo(self.beforeFrame) {
            let widthNew = self.frame.size.width - (self.flowLayout.sectionInset.left * 2) - self.flowLayout.minimumLineSpacing
            let heightNew = self.frame.size.height - self.flowLayout.sectionInset.top - self.flowLayout.sectionInset.bottom
            self.flowLayout.itemSize = CGSize(width: widthNew, height: heightNew)
            
            self.beforeFrame = self.frame
            
            self.itemWidthWithMargin = widthNew + self.flowLayout.minimumLineSpacing
            
            //move to offset of selected page
            let targetX = self.getOffSetFromPage(self.selectedPageNum, scrollView: self)
            self.contentOffset = CGPoint(x: targetX, y: 0)
            self.layoutIfNeeded()
        }
        
    }
    
    override open func reloadData() {
        super.reloadData()
        
        self.itemsTotalCount = 0
        
        let sectionCount = self.numberOfSections
        for section in 0..<sectionCount {
            self.itemsTotalCount = self.itemsTotalCount + self.dataSource!.collectionView(self, numberOfItemsInSection: section)
        }
        
        // When call new, pagenum = 0, offset = 0
        self.selectedPageNum = 0
        self.contentOffset = CGPoint(x: 0, y: 0)
        self.layoutIfNeeded()
    }
    
    //MARK: ScrollViewDelegate
    open func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        self.scrollBeginOffset = scrollView.contentOffset.x
        self.pagerControlState = .stayCurrent
    }
    
    open func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        //save target point.
        var point = targetContentOffset.pointee
        
        //decide move state by velocity
        if velocity.x > VELOCITY_STANDARD {
            self.pagerControlState = .toRight
        }
        else if velocity.x < -VELOCITY_STANDARD {
            self.pagerControlState = .toLeft
        }
        
        //get all scrolling distance
        let scrollDistance = self.scrollBeginOffset - scrollView.contentOffset.x
        let standardDistance = self.itemWidthWithMargin / 2
        
        //move scroll as same as half of contents size,
        if scrollDistance < -standardDistance {
            self.pagerControlState = .toRight
        }
        else if scrollDistance > standardDistance {
            self.pagerControlState = .toLeft
        }
        
        // decide will select page
        if self.pagerControlState == .toLeft && self.selectedPageNum > 0 {
            self.selectedPageNum -= 1
        }
        else if self.pagerControlState == .toRight && selectedPageNum < (itemsTotalCount - 1) {
            self.selectedPageNum += 1
        }
        
        //if page set, delegate set, call delegate
        self.pageSelectedDelegate?.pagerDidSelecedPage(selectedPageNum)
        
        point.x = self.getOffSetFromPage(self.selectedPageNum, scrollView: scrollView)
        targetContentOffset.pointee = point
        
    }
    
    open func setPage(_ pageNum:Int, isAnimation:Bool){
        if pageNum == self.selectedPageNum || pageNum >= itemsTotalCount {
            return
        }
        
        let offset = getOffSetFromPage(pageNum, scrollView: self)
        self.setContentOffset(CGPoint(x: offset, y: 0), animated: isAnimation)
        self.selectedPageNum = pageNum
        self.pageSelectedDelegate?.pagerDidSelecedPage(pageNum)
    }
    
    // get offset by pagenum
    fileprivate func getOffSetFromPage(_ pageNum: Int, scrollView:UIScrollView) -> CGFloat {
        if pageNum == 0 {
            return 0
        }
        
        else if pageNum >= self.itemsTotalCount - 1 {
            return scrollView.contentSize.width - self.frame.size.width
        }
        
        return (self.itemWidthWithMargin * CGFloat(pageNum)) - (self.flowLayout.minimumLineSpacing / 2)
    }
}

public protocol HWSwiftyViewPagerDelegate {
    func pagerDidSelecedPage(_ selectedPage: Int)
}
