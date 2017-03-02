//
//  TabsScrollView.swift
//  ipadSwiftDemo
//
//  Created by fantasy on 17/2/28.
//  Copyright © 2017年 fantasy. All rights reserved.
//

import UIKit

class TabsScrollView: UIView {
  
  let buttonW = 100
  let thisHeight = 40
  
  var titleArray :Array<String>?
  var selectColor:UIColor?
  var normalColor:UIColor?
  
  var imageNormalArray:Array<UIImage>?
  var imageSelectArray:Array<UIImage>?
  
  var scrollView :UIScrollView!
  var selectButton: UIButton!
  
  init(titleArray:Array<String>,frame:CGRect,selectColor:UIColor,normalColor:UIColor){
    super.init(frame:frame)
    assert(titleArray.count > 0 ,"this array should not be empty")
    self.titleArray = titleArray
    self.selectColor = selectColor
    self.normalColor = normalColor
    setupViewsWithoutImages()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  func clickButtonWithoutImage(button:UIButton) {
    print("button.tag == \(button.tag)")
  }
  
  func setupViewsWithoutImages() {
    
    scrollView = UIScrollView.init()
    scrollView.showsHorizontalScrollIndicator = true
    self.addSubview(scrollView)
    scrollView.snp.makeConstraints { (make) in
      make.top.left.right.equalTo(0)
      make.height.equalTo(thisHeight)
    }
    
    let container = UIView.init()
    scrollView.addSubview(container)
    container.snp.makeConstraints { (make) in
      make.edges.equalTo(self.scrollView)
    }
    scrollView.contentSize = CGSize(width:(self.titleArray?.count)!*buttonW,height:0)
    scrollView.backgroundColor = UIColor.red
    
    //all buttons
    var lastOne:UIView?
    var tag = 0
    
    for title in self.titleArray! {
      
      let button = UIButton(type:.custom)
      button.setTitle(title, for: UIControlState.normal)
      button.setTitleColor(self.normalColor, for: UIControlState.normal)
      button.tag = tag
      button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
      button.addTarget(self, action: #selector(clickButtonWithoutImage(button:)), for: UIControlEvents.touchUpInside)
      tag += 1
      button.backgroundColor = UIColor.randomColor()
      container.addSubview(button)
      if lastOne == nil {
        
        button.snp.makeConstraints({ (make) in
          make.top.left.equalTo(0)
          make.width.equalTo(buttonW).priority(.high)
          make.height.equalTo(thisHeight)
          
        })
        selectButton = button
        selectButton.setTitleColor(self.selectColor, for: UIControlState.normal)
      } else {
        button.snp.makeConstraints({ (make) in
          make.top.equalTo(0)
          make.height.equalTo(thisHeight)
          make.width.equalTo(buttonW).priority(.high)
          make.left.equalTo((lastOne?.snp.right)!)
          if(title == self.titleArray?[(self.titleArray?.count)!-1]){
            make.right.equalTo(container.snp.right)
          }
        })
      }
      lastOne = button
      
    }
    //lines
    
  }
  
  
}
