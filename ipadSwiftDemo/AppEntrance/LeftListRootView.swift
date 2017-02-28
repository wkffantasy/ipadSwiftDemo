//
//  LeftListRootView.swift
//  ipadSwiftDemo
//
//  Created by fantasy on 17/2/28.
//  Copyright © 2017年 fantasy. All rights reserved.
//

import UIKit

class LeftListRootView: UIView {

  typealias ClickButtonBlock = (Int) -> ()
  let buttonH = 45
  
  let titleSelectColor = UIColor.colorWithRGB(red: 243, green: 243, blue: 243)
  let titleNormalColor = UIColor.colorWithRGB(red: 33, green: 33, blue: 33)
  let selectBackColor  = UIColor.colorWithRGB(red: 74, green: 153, blue: 255)
  let normalBackColor  = UIColor.colorWithRGB(red: 243, green: 246, blue: 251)
  
  var selectButton: UIButton!
  var titlesArray : Array<String>!
  var clickButtonBlock : ClickButtonBlock?
  
  init(titlesArray :Array<String>,frame :CGRect) {
    super.init(frame:frame)
    //this assert only in DEBUG
    assert(titlesArray.count > 0, "this array should not be empty")
    self.titlesArray = titlesArray
    setupViews()
    
  }
  func setupViews() {
    
    // all buttons
    var lastOne:UIView?
    var tag = 0
    for title in self.titlesArray {
      
      let button = UIButton(type: .custom)
      button.setTitleColor(titleNormalColor, for: UIControlState.normal)
      button.backgroundColor = normalBackColor
      button.setTitle(title, for: UIControlState.normal)
      button.addTarget(self, action: #selector(clickButton(button:)), for: UIControlEvents.touchUpInside)
      button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
      addSubview(button)
      button.tag = tag
      tag += 1
      if lastOne == nil {
        button.snp.makeConstraints({ (make) in
          
          make.top.equalTo(0)
          make.height.equalTo(buttonH)
          make.width.equalTo(self.snp.width)
          make.left.equalTo(0)
        })
        selectButton = button
        button.setTitleColor(titleSelectColor, for: UIControlState.normal)
        button.backgroundColor = selectBackColor
      } else {
        button.snp.makeConstraints({ (make) in
          
          make.top.equalTo((lastOne?.snp.bottom)!)
          make.height.equalTo(buttonH)
          make.width.equalTo(self.snp.width)
          make.left.equalTo(0)
        })
      }
      lastOne = button
    }
    
    //others
    let lineView = UIView()
    addSubview(lineView)
    lineView.backgroundColor = selectBackColor
    lineView.snp.makeConstraints { (make) in
      
      make.left.bottom.top.equalTo(0)
      make.width.equalTo(2)
      make.bottom.equalTo((lastOne?.snp.bottom)!)
      
    }
    
  }
  func clickButton(button: UIButton) {
    print("clickButton and its tag == \(button.tag)")
    if button != self.selectButton {
      self.selectButton.setTitleColor(titleNormalColor, for: UIControlState.normal)
      self.selectButton.backgroundColor = normalBackColor
      
      self.selectButton = button
      self.selectButton.backgroundColor = selectBackColor
      self.selectButton.setTitleColor(titleSelectColor, for: UIControlState.normal)
      if (self.clickButtonBlock != nil) {
        self.clickButtonBlock!(self.selectButton.tag)
      }
    }
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

}
