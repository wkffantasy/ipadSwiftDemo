//
//  HomeAllController.swift
//  ipadSwiftDemo
//
//  Created by fantasy on 17/3/2.
//  Copyright © 2017年 fantasy. All rights reserved.
//

import UIKit

class HomeAllController: UIViewController,UITableViewDataSource,UITableViewDelegate {
  
  var dataSourceArray:Array<String>!
  var tableView:UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.yellow

        // Do any additional setup after loading the view.
      initData()
      setupViews()
      
    }
  func initData() {
    dataSourceArray = [
      "发如雪",
      "东风破",
      "珊瑚海",
      "青花瓷",
      "七里香",
      "千里之外",
      "红尘客栈",
      "外婆",
      "听妈妈的话",
      "琴伤",
      "飘逸",
      "皮影戏",
      "白色风车",
      "晴天",
      "彩虹",
    ]
    
  }
  func setupViews() {
    tableView = UITableView.init()
    tableView.delegate = self
    tableView.estimatedRowHeight = 60
    tableView.rowHeight = UITableViewAutomaticDimension
    tableView.dataSource = self
    tableView.separatorStyle = .none
    self.view.addSubview(tableView)
    tableView.snp.makeConstraints { (make) in
      make.top.left.right.bottom.equalTo(0)
    }
    
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.dataSourceArray.count
  }
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let cell:HomeAllViewCellTableViewCell = HomeAllViewCellTableViewCell.cellWithTableView(tableView: tableView) as! HomeAllViewCellTableViewCell
    cell.updateContent(songName: self.dataSourceArray[indexPath.row])
    
    return cell
    
    
  }
  
  
  


  
}
