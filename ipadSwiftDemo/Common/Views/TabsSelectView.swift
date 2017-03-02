//
//  TabsSelectView.swift
//  ipadSwiftDemo
//
//  Created by fantasy on 17/3/2.
//  Copyright © 2017年 fantasy. All rights reserved.
//

import UIKit

class TabsSelectView: UIView {

  let buttonW = 100
  typealias ClickButtonBlock = (Int) -> ()
  
  var titleArray :Array<String>?
  var selectColor:UIColor?
  var normalColor:UIColor?
  
  var imageNormalArray:Array<UIImage>?
  var imageSelectArray:Array<UIImage>?
  
  var scrollView :UIScrollView!
  var selectButton: UIButton!
  var dividingLine: UIView!
  var buttonsArray: Array<UIButton>!
  var movingLine: UIView!
  var clickButtonBlock : ClickButtonBlock?
  
  init(titleArray:Array<String>,frame:CGRect,selectColor:UIColor,normalColor:UIColor){
    
    super.init(frame:frame)
    assert(titleArray.count > 0 ,"this array should not be empty")
    self.titleArray = titleArray
    self.selectColor = selectColor
    self.normalColor = normalColor
    buttonsArray = []
    setupViewsWithoutImages()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  func clickButtonWithoutImage(button:UIButton) {
    print("button.tag == \(button.tag)")
    
    self.changeButtonState(button: button)
    if (self.clickButtonBlock != nil) {
      self.clickButtonBlock!(self.selectButton.tag)
    }
  }
  func changeButtonState(button:UIButton) {
    if self.selectButton == button {
      return
    }
    self.selectButton.setTitleColor(self.normalColor, for: UIControlState.normal)
    self.selectButton = button
    self.selectButton.setTitleColor(self.selectColor, for: UIControlState.normal)
    self.addLineViews()
  }
 
  
  func setupViewsWithoutImages() {
    
    //all buttons
    var lastOne:UIButton?
    var tag = 0
    
    for title in self.titleArray! {
      
      let button = UIButton(type:.custom)
      button.setTitle(title, for: UIControlState.normal)
      button.setTitleColor(self.normalColor, for: UIControlState.normal)
      button.tag = tag
      button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
      button.addTarget(self, action: #selector(clickButtonWithoutImage(button:)), for: UIControlEvents.touchUpInside)
      self.addSubview(button)
      buttonsArray.append(button)
      button.snp.makeConstraints({ (make) in
        make.top.bottom.equalTo(0)
        make.width.equalTo(self.snp.width).multipliedBy(1.0/CGFloat((self.titleArray?.count)!))
        if (tag == 0) {
          make.left.equalTo(0)
        } else {
          make.left.equalTo((lastOne?.snp.right)!)
        }
        if tag == ((self.titleArray?.count)! - 1) {
          make.right.equalTo(self.snp.right)
        }
      })
      if tag == 0 {
        selectButton = button
        selectButton.setTitleColor(self.selectColor, for: UIControlState.normal)
      }
      tag += 1
      lastOne = button
      
    }
    //lines
    dividingLine = UIView.init()
    self.addSubview(dividingLine)
    dividingLine.backgroundColor = self.normalColor
    dividingLine.snp.makeConstraints { (make) in
      make.right.left.equalTo(0)
      make.height.equalTo(1)
      make.bottom.equalTo(self.snp.bottom)
    }
    
    addLineViews()
    
  }
  func makeMovingLine() {
    assert(self.selectButton != nil,"must have one select button")
    
  }
  func addLineViews() {
    
    if movingLine != nil {
      movingLine.removeFromSuperview()
    }
    movingLine = UIView.init()
    movingLine.backgroundColor = self.selectColor
    self.addSubview(movingLine)
    movingLine.snp.makeConstraints { (make) in
      make.width.equalTo(self.selectButton.snp.width)
      make.left.equalTo(self.selectButton.snp.left)
      make.right.equalTo(self.selectButton.snp.right)
      make.height.equalTo(2)
      make.bottom.equalTo(self.snp.bottom)
    }
    
    
  }
  
  // public
  func updateButtonState(tag:Int) {
    print("updateButtonState tag ==\(tag)")
    assert(self.buttonsArray.count - 1 >= tag , "")
    let tagButton = self.buttonsArray[tag]
    self.changeButtonState(button: tagButton)
    
  }

}
