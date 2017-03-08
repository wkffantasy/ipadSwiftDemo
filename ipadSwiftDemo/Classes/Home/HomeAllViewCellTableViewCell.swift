//
//  HomeAllViewCellTableViewCell.swift
//  ipadSwiftDemo
//
//  Created by fantasy on 17/3/8.
//  Copyright © 2017年 fantasy. All rights reserved.
//

import UIKit

class HomeAllViewCellTableViewCell: UITableViewCell {
  
  
  var songNameLabel :UILabel!
  
  class func cellWithTableView(tableView:UITableView) -> AnyObject {
    
    let cellId = "HomeAllViewCellTableViewCell"
    var cell = tableView.dequeueReusableCell(withIdentifier: cellId)
    if cell == nil {
      cell = HomeAllViewCellTableViewCell.init(style: UITableViewCellStyle.default, reuseIdentifier: cellId)
    }
    return cell!
  }
  public func updateContent(songName:String) {
    self.songNameLabel.text = songName
  }
  
  private override init(style: UITableViewCellStyle, reuseIdentifier: String?){
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    
    self.backgroundColor = UIColor.white
    self.selectionStyle = UITableViewCellSelectionStyle.none
    self.setupViews()
    
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  
  private func setupViews() {
    
    songNameLabel = UILabel.init()
    songNameLabel.textColor = UIColor.colorWithHexString("333333")
    songNameLabel.font = UIFont.systemFont(ofSize: 15)
    self.addSubview(songNameLabel)
    songNameLabel.snp.makeConstraints { (make) in
      make.left.equalTo(20)
      make.top.equalTo(10)
      make.bottom.equalTo(-10)
    }
    
  }

}
