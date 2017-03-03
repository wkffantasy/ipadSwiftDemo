//
//  LiveController.swift
//  ipadSwiftDemo
//
//  Created by fantasy on 17/2/28.
//  Copyright © 2017年 fantasy. All rights reserved.
//

import UIKit

class LiveController: UIViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()

    self.view.backgroundColor = UIColor.randomColor()
      // Do any additional setup after loading the view.
    
    let downloadTool = DownloadTool()
    let homeDirectory = NSHomeDirectory()
    print("homeDirectory == \(homeDirectory)")
    downloadTool.startNewTask(url: "http://hangge.com/blog/images/logo.png", destinationPath:homeDirectory)
    
  }

  override func didReceiveMemoryWarning() {
      super.didReceiveMemoryWarning()
      // Dispose of any resources that can be recreated.
  }
    

  

}
