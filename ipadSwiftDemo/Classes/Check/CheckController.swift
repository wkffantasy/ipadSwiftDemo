//
//  CheckController.swift
//  ipadSwiftDemo
//
//  Created by fantasy on 17/2/28.
//  Copyright © 2017年 fantasy. All rights reserved.
//

import UIKit
import MBProgressHUD

class CheckController: UIViewController {
  
    var hudText  :MBProgressHUD?
    var hudImage :MBProgressHUD?
  
    override func viewDidLoad() {
        super.viewDidLoad()

      self.view.backgroundColor = UIColor.randomColor()
        // Do any additional setup after loading the view.
      self.view.backgroundColor = UIColor.randomColor()
      // Do any additional setup after loading the view.
      
      let showTextButton = UIButton(type: .custom)
      showTextButton.backgroundColor = UIColor.randomColor()
      showTextButton.setTitle("展示文字HUD", for: UIControlState.normal)
      showTextButton.setTitleColor(UIColor.colorWithRGB(red: 33, green: 33, blue: 33), for: UIControlState.normal)
      showTextButton.addTarget(self, action: #selector(clickToShowText), for: UIControlEvents.touchUpInside)
      self.view.addSubview(showTextButton)
      showTextButton.snp.makeConstraints { (make) in
        make.left.top.equalTo(20)
        make.width.equalTo(200)
        make.height.equalTo(40)
      }
      
//      let hideTextButton = UIButton(type: .custom)
//      hideTextButton.backgroundColor = UIColor.randomColor()
//      hideTextButton.setTitle("隐藏文字HUD", for: UIControlState.normal)
//      hideTextButton.setTitleColor(UIColor.colorWithRGB(red: 33, green: 33, blue: 33), for: UIControlState.normal)
//      hideTextButton.addTarget(self, action: #selector(clickToHideText), for: UIControlEvents.touchUpInside)
//      self.view.addSubview(hideTextButton)
//      hideTextButton.snp.makeConstraints { (make) in
//        make.left.equalTo(showTextButton.snp.right).offset(20)
//        make.top.equalTo(20)
//        make.width.equalTo(200)
//        make.height.equalTo(40)
//      }
      
//      let showImageButton = UIButton(type: .custom)
//      showImageButton.backgroundColor = UIColor.randomColor()
//      showImageButton.setTitle("展示图片HUD", for: UIControlState.normal)
//      showImageButton.setTitleColor(UIColor.colorWithRGB(red: 33, green: 33, blue: 33), for: UIControlState.normal)
//      showImageButton.addTarget(self, action: #selector(clickToShowImage), for: UIControlEvents.touchUpInside)
//      self.view.addSubview(showImageButton)
//      showImageButton.snp.makeConstraints { (make) in
//        make.left.equalTo(20)
//        make.top.equalTo(showTextButton.snp.bottom).offset(20)
//        make.width.equalTo(200)
//        make.height.equalTo(40)
//      }
      
//      let hideImageButton = UIButton(type: .custom)
//      hideImageButton.backgroundColor = UIColor.randomColor()
//      hideImageButton.setTitle("隐藏图片HUD", for: UIControlState.normal)
//      hideImageButton.setTitleColor(UIColor.colorWithRGB(red: 33, green: 33, blue: 33), for: UIControlState.normal)
//      hideImageButton.addTarget(self, action: #selector(clickToHideImage), for: UIControlEvents.touchUpInside)
//      self.view.addSubview(hideImageButton)
//      hideImageButton.snp.makeConstraints { (make) in
//        make.top.equalTo(hideTextButton.snp.bottom).offset(20)
//        make.left.equalTo(showImageButton.snp.right).offset(20)
//        make.width.equalTo(200)
//        make.height.equalTo(40)
//      }
      
      let showSomeTimeTextButton = UIButton(type: .custom)
      showSomeTimeTextButton.backgroundColor = UIColor.randomColor()
      showSomeTimeTextButton.setTitle("展示文字2秒", for: UIControlState.normal)
      showSomeTimeTextButton.setTitleColor(UIColor.colorWithRGB(red: 33, green: 33, blue: 33), for: UIControlState.normal)
      showSomeTimeTextButton.addTarget(self, action: #selector(clickToShowSomeTimeText), for: UIControlEvents.touchUpInside)
      self.view.addSubview(showSomeTimeTextButton)
      showSomeTimeTextButton.snp.makeConstraints { (make) in
        make.top.equalTo(showTextButton.snp.bottom).offset(20)
        make.left.equalTo(20)
        make.width.equalTo(200)
        make.height.equalTo(40)
      }
      
//      let showSomeTimeImageButton = UIButton(type: .custom)
//      showSomeTimeImageButton.backgroundColor = UIColor.randomColor()
//      showSomeTimeImageButton.setTitle("展示图片2秒", for: UIControlState.normal)
//      showSomeTimeImageButton.setTitleColor(UIColor.colorWithRGB(red: 33, green: 33, blue: 33), for: UIControlState.normal)
//      showSomeTimeImageButton.addTarget(self, action: #selector(clickToShowSomeTimeImage), for: UIControlEvents.touchUpInside)
//      self.view.addSubview(showSomeTimeImageButton)
//      showSomeTimeImageButton.snp.makeConstraints { (make) in
//        make.top.equalTo(hideImageButton.snp.bottom).offset(20)
//        make.left.equalTo(showSomeTimeTextButton.snp.right).offset(20)
//        make.width.equalTo(200)
//        make.height.equalTo(40)
//      }
      
      NotificationCenter.default.addObserver(self, selector: #selector(recieveNotification(param:)), name: NSNotification.Name(rawValue: kNonificationNameChangeLeftRootVCName), object: nil)
      
    }
  
      func recieveNotification(param:Notification) {
        
        let currentTag = param.userInfo?["currentTag"]
        print("currentTag == \(currentTag)")
        
        self.clickToHideImage()
        self.clickToHideText()
        
      }
      func clickToShowText(){
        print("clickToShowText")
        print("hud1 ==",self.hudText)
        hudText = HUDTool.tool.showTextHUD(text: "加载中...", view: self.view)
      }
      func clickToHideText(){
        print("clickToHideText")
        print("hud1 ==",self.hudText)
        hudText?.hide(animated: true)
        hudText?.removeFromSuperview()
      }
      func clickToShowImage(){
        print("clickToShowImage")
        
      }
      func clickToHideImage(){
        print("clickToHideImage")
      }
      func clickToShowSomeTimeText(){
        print("clickToShowSomeTimeText")
        HUDTool.tool.showTextHud(text: "请求中...", view: self.view, afterDelay: 2.0)
        
      }
      func clickToShowSomeTimeImage(){
        print("clickToShowSomeTimeImage")
      }
    
}
