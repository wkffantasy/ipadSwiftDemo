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

  override func viewDidLoad() {
    super.viewDidLoad()
    
    makeUserAreaView()
    
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  func makeUserAreaView() {
    
    let userView:UserAreaView = UserAreaView(frame:CGRect.zero)
    self.view.addSubview(userView)
    
    userView.snp.makeConstraints{(make) in
      
      make.top.equalTo(0)
      make.left.equalTo(0)
      make.right.equalTo(0)
      make.height.equalTo(200)
      
    }
  
  }


}

