//
//  HomeController.swift
//  ipadSwiftDemo
//
//  Created by fantasy on 17/2/28.
//  Copyright © 2017年 fantasy. All rights reserved.
//

import UIKit

class HomeController: UIViewController {
  
  var tabsScrollView:TabsScrollView!
  var titleArray:Array<String>!
  
  override func viewDidLoad() {
      super.viewDidLoad()
      self.view.backgroundColor = UIColor.white
      setupViews()
    
      // Do any additional setup after loading the view.
  }

  override func didReceiveMemoryWarning() {
      super.didReceiveMemoryWarning()
      // Dispose of any resources that can be recreated.
  }
  func setupViews() {
    
    titleArray = [
                  "发如雪",
                  "东风破",
                  "兰亭序",
                  "七里香",
                  "青花瓷",
                  "珊瑚海",
                  ]
    tabsScrollView = TabsScrollView.init(titleArray: titleArray, frame: CGRect.zero, selectColor: UIColor.colorWithRGB(red: 74, green: 153, blue: 255), normalColor: UIColor.colorWithRGB(red: 134, green: 134, blue: 134))
    self.view.addSubview(tabsScrollView)
    tabsScrollView.snp.makeConstraints { (make) in
      make.top.left.right.equalTo(0)
    }
    
    
  }

}
