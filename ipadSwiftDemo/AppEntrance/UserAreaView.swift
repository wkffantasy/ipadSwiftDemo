//
//  UserAreaView.swift
//  ipadSwiftDemo
//
//  Created by fantasy on 17/2/28.
//  Copyright © 2017年 fantasy. All rights reserved.
//

import UIKit



typealias VacateBlock = () -> Void
typealias SignUpBlock = () -> Void

class UserAreaView: UIView {
  
  let iconImageWH = 100
  let buttonW = 100
  let buttonH = 40
  
  var userIconView :UIImageView!
  var titleLabel :UILabel!
  var vacateButton: UIButton!
  var signButton : UIButton!
  
  var vacateBlock :VacateBlock?
  var signUpBlock :SignUpBlock?
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    self.backgroundColor = UIColor.colorWithRGB(red: 69, green: 81, blue: 138)
    
    setupViews()
    
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  //点击请假
  func clickVacateButton() {
    print("clickVacateButton")
    if vacateBlock != nil {
      vacateBlock!()
    }
    
  }
  //点击签到
  func clickSignButton() {
    print("clickSignButton")
    if signUpBlock != nil {
      signUpBlock!()
    }
  }
  
  func setupViews() {
    
    userIconView = UIImageView()
    addSubview(userIconView)
    userIconView.image = UIImage.init(named: "dog")
    userIconView.backgroundColor = UIColor.red
    userIconView.layer.masksToBounds = true
    userIconView.layer.cornerRadius = CGFloat ( iconImageWH / 2)
    userIconView.layer.borderWidth = 3.0
    userIconView.layer.borderColor = UIColor.white.cgColor
    userIconView.snp.makeConstraints { (make) in
      
      make.left.equalTo(80)
      make.width.equalTo(iconImageWH)
      make.height.equalTo(iconImageWH)
      make.centerY.equalTo(self.snp.centerY)
      
    }
    
    titleLabel = UILabel()
    addSubview(titleLabel)
    titleLabel.textColor = UIColor.white
    titleLabel.font = UIFont.systemFont(ofSize: 18)
    let userName = "姬如雪"
    titleLabel.text = "\(userName),下午好,\n今天的学习任务完成了吗"
    titleLabel.numberOfLines = 0
    titleLabel.snp.makeConstraints { (make) in
      
      make.left.equalTo(userIconView.snp.right).offset(20)
      make.centerY.equalTo(userIconView.snp.centerY)
      
    }
    
    //this two method is invalidaty
    //    vacateButton.titleLabel?.text = "请假"
    //    vacateButton.titleLabel?.textColor=UIColor.black
    signButton = UIButton(type:.custom)
    signButton.titleLabel?.font = UIFont.systemFont(ofSize: 14)
    signButton.setTitle("今日签到", for: UIControlState.normal)
    signButton.setTitleColor(UIColor.white, for: UIControlState.normal)
    signButton.backgroundColor = UIColor.colorWithRGB(red: 54, green: 153, blue: 255)
    signButton.layer.masksToBounds = true
    signButton.layer.cornerRadius = CGFloat(buttonH / 2)
    signButton.addTarget(self, action:#selector(clickSignButton), for: UIControlEvents.touchUpInside)
    addSubview(signButton)
    signButton.snp.makeConstraints { (make) in
      
      make.width.equalTo(buttonW)
      make.height.equalTo(buttonH)
      make.centerY.equalTo(userIconView.snp.centerY)
      make.right.equalTo(-80)
      
    }
    
    vacateButton = UIButton(type:.custom)
    vacateButton.titleLabel?.font = UIFont.systemFont(ofSize: 14)
    vacateButton.setTitle("请假", for: UIControlState.normal)
    vacateButton.setTitleColor(UIColor.white, for: UIControlState.normal)
    vacateButton.backgroundColor = UIColor.colorWithRGB(red: 52, green: 113, blue: 187)
    vacateButton.layer.masksToBounds = true
    vacateButton.layer.borderWidth = 1.0
    vacateButton.layer.cornerRadius = CGFloat(buttonH / 2)
    vacateButton.layer.borderColor = UIColor.colorWithRGB(red: 54, green: 153, blue: 255).cgColor
    vacateButton.addTarget(self, action:#selector(clickVacateButton), for: UIControlEvents.touchUpInside)
    addSubview(vacateButton)
    vacateButton.snp.makeConstraints { (make) in
      
      make.width.equalTo(buttonW)
      make.height.equalTo(buttonH)
      make.centerY.equalTo(self.snp.centerY)
      make.right.equalTo(signButton.snp.left).offset(-20)
      
    }
    
  }
  
  
}
