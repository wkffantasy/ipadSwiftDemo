//
//  LeftListRootView.swift
//  ipadSwiftDemo
//
//  Created by fantasy on 17/2/28.
//  Copyright © 2017年 fantasy. All rights reserved.
//

import UIKit




class LeftListRootView: UIView {

  let buttonH = 50
  
  var selectButton: UIButton!
  var titlesArray : Array<String>!
  
  init(titlesArray :Array<String>,frame :CGRect) {
    super.init(frame:frame)
    //this assert only in DEBUG
    assert(titlesArray.count > 0, "this array should not be empty")
    self.titlesArray = titlesArray
    setupViews()
    
  }
  func setupViews() {
    
    var lastOne:UIView?;
    for index in 0  ..< self.titlesArray.count {
      
      let title = self.titlesArray[index]
      print("title == \(title)")
      print("index == \(index)")
      let button = UIButton(type: .custom)
    
      button.setTitleColor(UIColor.colorWithRGB(red: 243, green: 243, blue: 243), for: UIControlState.selected)
      button.setTitleColor(UIColor.colorWithRGB(red: 33, green: 33, blue: 33), for: UIControlState.selected)
      button.backgroundColor = UIColor.colorWithRGB(red: 243, green: 246, blue: 251)
      button.setTitle(title, for: UIControlState.normal)
      button.setTitle(title, for: UIControlState.selected)
      button.addTarget(self, action: #selector(clickButton(button:)), for: UIControlEvents.touchUpInside)
      addSubview(button)
      
      if index == 0 {
        button.snp.makeConstraints({ (make) in
          
          make.top.equalTo(0)
          make.height.equalTo(buttonH)
          make.width.equalTo(self.snp.width)
          make.left.equalTo(0)
        })
        
        selectButton = button
       
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
    
    
  }
  func clickButton(button: UIButton) {
    print("clickButton")
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

}
