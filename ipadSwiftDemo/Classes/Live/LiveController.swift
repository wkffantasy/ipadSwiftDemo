//
//  LiveController.swift
//  ipadSwiftDemo
//
//  Created by fantasy on 17/2/28.
//  Copyright © 2017年 fantasy. All rights reserved.
//

import UIKit

class LiveController: UIViewController {

    let url1 = "http://imgurl.com/apicture.jpg"
    let url2 = "http://download.thinkbroadband.com/10MB.zip"
    let url3 = "http://download.thinkbroadband.com/20MB.zip"
    let url4 = "http://download.thinkbroadband.com/30MB.zip"

    var url5 = "http://media7.smartstudy.com/pd/videos/2015/af/c7/16040/mp4/dest.m3u8"
    let url6 = "http://media7.smartstudy.com/pd/videos/2015/3e/5a/16041/mp4/dest.m3u8"
    let url7 = "http://v.smartstudy.com/pd/videos/2015/67/df/10422/mp4/dest.m3u8"
  let url8 = "http://dldir1.qq.com/qqfile/QQforMac/QQ_V4.2.4.dmg"

    var downloadTool: DownloadToolManage!
  var labelProgress : UILabel!
  var labelSpeed :UILabel!
  var labelRemainTime:UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.white
        // Do any additional setup after loading the view.

        setupViews()
    }

    func setupViews() {

        let downloadButton = UIButton(type: .custom)
        downloadButton.backgroundColor = UIColor.randomColor()
        downloadButton.setTitle("重新下载", for: UIControlState.normal)
        downloadButton.setTitleColor(UIColor.colorWithRGB(red: 33, green: 33, blue: 33), for: UIControlState.normal)
        downloadButton.addTarget(self, action: #selector(clickToDownload(button:)), for: UIControlEvents.touchUpInside)
        self.view.addSubview(downloadButton)
        downloadButton.snp.makeConstraints { make in
            make.left.top.equalTo(20)
            make.width.equalTo(100)
            make.height.equalTo(40)
        }

        let goonButton = UIButton(type: .custom)
        goonButton.backgroundColor = UIColor.randomColor()
        goonButton.setTitle("继续下载", for: UIControlState.normal)
        goonButton.setTitleColor(UIColor.colorWithRGB(red: 33, green: 33, blue: 33), for: UIControlState.normal)
        goonButton.addTarget(self, action: #selector(clickToGoon(button:)), for: UIControlEvents.touchUpInside)
        self.view.addSubview(goonButton)
        goonButton.snp.makeConstraints { make in
            make.left.equalTo(downloadButton.snp.right).offset(20)
            make.top.equalTo(20)
            make.width.equalTo(100)
            make.height.equalTo(40)
        }
      
      let pauseButton = UIButton(type: .custom)
      pauseButton.backgroundColor = UIColor.randomColor()
      pauseButton.setTitle("暂停", for: UIControlState.normal)
      pauseButton.setTitleColor(UIColor.colorWithRGB(red: 33, green: 33, blue: 33), for: UIControlState.normal)
      pauseButton.addTarget(self, action: #selector(clickToPause(button:)), for: UIControlEvents.touchUpInside)
      self.view.addSubview(pauseButton)
      pauseButton.snp.makeConstraints { make in
        make.left.equalTo(20)
        make.top.equalTo(downloadButton.snp.bottom).offset(20)
        make.width.equalTo(100)
        make.height.equalTo(40)
      }
      
      let cancelButton = UIButton(type: .custom)
      cancelButton.backgroundColor = UIColor.randomColor()
      cancelButton.setTitle("取消下载", for: UIControlState.normal)
      cancelButton.setTitleColor(UIColor.colorWithRGB(red: 33, green: 33, blue: 33), for: UIControlState.normal)
      cancelButton.addTarget(self, action: #selector(clickToCancel(button:)), for: UIControlEvents.touchUpInside)
      self.view.addSubview(cancelButton)
      cancelButton.snp.makeConstraints { make in
        make.left.equalTo(pauseButton.snp.right).offset(20)
        make.top.equalTo(goonButton.snp.bottom).offset(20)
        make.width.equalTo(100)
        make.height.equalTo(40)
      }
      
      labelSpeed = self.setupLabel()
      labelSpeed.snp.makeConstraints { (make) in
        make.left.equalTo(20)
        make.top.equalTo(pauseButton.snp.bottom).offset(20)
      }
      
      labelProgress = self.setupLabel()
      labelProgress.snp.makeConstraints { (make) in
        make.left.equalTo(20)
        make.top.equalTo(labelSpeed.snp.bottom).offset(20)
      }
      labelRemainTime = self.setupLabel()
      labelRemainTime.snp.makeConstraints { (make) in
        make.left.equalTo(20)
        make.top.equalTo(labelProgress.snp.bottom).offset(20)
      }
      
    }
  func clickToCancel(button _:UIButton) {
    print("clickToCancel")
    self.downloadTool.cancelDownload()
  }
  func clickToGoon(button _: UIButton) {
    print("clickToGoon")
    self.downloadTool.goonDownload()
  }
  func clickToPause(button _: UIButton) {

    print("clickToPause")
    self.downloadTool.pauseDownload()
  }

    func clickToDownload(button _: UIButton) {
        print("clickToDownlod")

        let progressBlock = { (progress: String, remainTime: String, speed: String) in
            print("progressBlock")
          self.labelRemainTime.text = "剩余时间:" + remainTime
          self.labelSpeed.text = "速度:" + speed
          self.labelProgress.text = "进度:" + progress
        }
        let completeBlock = { (path: String) in
            print("completeBlock path ==\(path)")
        }
        let failedBlock = { (error: Error) in
            print("failedBlock error==", error)
        }
        downloadTool = DownloadToolManage()
        downloadTool.downloadVideoFiles(downloadUrl: url8, toSavePath: "asd", progressBlock: progressBlock, completeBlock: completeBlock, failedBlock: failedBlock)
    }
  func setupLabel() -> UILabel {
    let label = UILabel.init()
    label.textColor = UIColor.colorWithHexString("333333")
    label.font = UIFont.systemFont(ofSize: 15)
    label.backgroundColor = UIColor.brown
    self.view.addSubview(label)
    return label
  }
  
  func changeUrlStringToName(urlString: String) -> String {
    
    var name = urlString.subStringTo(to: (urlString.length - 14))
    if name.hasPrefix("http://") {
      name = name.SubStringFrom(from: 7)
    }
    
    let newName = name.replacingOccurrences(of: "/", with: "~") + ".mp4"
    
    print("name == \(name)")
    print("newName ==\(newName)")
    return newName
  }
}
