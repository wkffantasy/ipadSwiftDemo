//
//  ViewController.swift
//  ipadSwiftDemo
//
//  Created by fantasy on 17/2/28.
//  Copyright © 2017年 fantasy. All rights reserved.
//

import UIKit

import SnapKit

class ViewController: UIViewController {

  var userView :UserAreaView!
  var leftListRootView :LeftListRootView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    makeUserAreaView()
    makeLeftListRootView()
    
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  func makeLeftListRootView() {
    
    let titleArray = [
      "我的首页",
      "我的学习计划",
      "我的练习",
      "我的模考",
      "我的批改",
      "我的逐题精讲",
    ]
    
    leftListRootView = LeftListRootView(titlesArray:titleArray,frame:CGRect.zero)
    self.view.addSubview(leftListRootView)
    leftListRootView.snp.makeConstraints { (make) in
      
      make.left.equalTo(10)
      make.top.equalTo(userView.snp.bottom).offset(20)
      make.width.equalTo(170)
      
    }
    
  }
  
  func makeUserAreaView() {
    
    userView = UserAreaView(frame:CGRect.zero)
    self.view.addSubview(userView)
    userView.signUpBlock = {
      print("in controller clickSignButton")
    }
    userView.vacateBlock = {
      print("in controller clickVacateButton")
    }
    
    userView.snp.makeConstraints{(make) in
      
      make.top.equalTo(0)
      make.left.equalTo(0)
      make.right.equalTo(0)
      make.height.equalTo(200)
      
    }
  
  }


}

