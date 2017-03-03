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

  
  override func viewDidLoad() {
    super.viewDidLoad()

    self.view.backgroundColor = UIColor.white
    // Do any additional setup after loading the view.
    
    setupViews()
    
  }
  func setupViews() {
    
    let downloadButton = UIButton(type: .custom)
    downloadButton.backgroundColor = UIColor.randomColor()
    downloadButton.setTitle("下载", for: UIControlState.normal)
    downloadButton.setTitleColor(UIColor.colorWithRGB(red: 33, green: 33, blue: 33), for: UIControlState.normal)
    downloadButton.addTarget(self, action: #selector(clickToDownlod(button:)), for: UIControlEvents.touchUpInside)
    self.view.addSubview(downloadButton)
    downloadButton.snp.makeConstraints { (make) in
      make.left.top.equalTo(20)
      make.width.equalTo(100)
      make.height.equalTo(40)
    }
    
    let deletButton = UIButton(type: .custom)
    deletButton.backgroundColor = UIColor.randomColor()
    deletButton.setTitle("删除", for: UIControlState.normal)
    deletButton.setTitleColor(UIColor.colorWithRGB(red: 33, green: 33, blue: 33), for: UIControlState.normal)
    deletButton.addTarget(self, action: #selector(clickToDelet(button:)), for: UIControlEvents.touchUpInside)
    self.view.addSubview(deletButton)
    deletButton.snp.makeConstraints { (make) in
      make.left.equalTo(downloadButton.snp.right).offset(20)
      make.top.equalTo(20)
      make.width.equalTo(100)
      make.height.equalTo(40)
    }
    
  }
  func clickToDelet(button:UIButton) {
    print("clickToDelet")
    let url = URL(string: url5)
    if(VeloxCacheManagement.fileExistForURL(url: url!)){
      let result =  VeloxCacheManagement.deleteFileForURL(url: url!)
      print("deleteFileForURL : \(result)")
    } else {
      print("不存在这个url")
    }
  }
  func clickToDownlod(button:UIButton) {
    print("clickToDownlod")
    let url = URL(string: url5)
    
    //是否存在这个url
    if(VeloxCacheManagement.fileExistForURL(url: url!)){
      print("这个url 已经下载好了")
      return
    } else {
      print("不存在这个url")
    }
    
    let veloxDownloader = VeloxDownloadManager.sharedInstance
    let progressClosure : (CGFloat,VeloxDownloadInstance) -> (Void)
    let remainingTimeClosure : (CGFloat) -> Void
    let completionClosure : (Bool) -> Void
    
    progressClosure = {(progress,downloadInstace) in
      print("Progress of File : \(downloadInstace.filename) is \(Float(progress))")
    }
    
    remainingTimeClosure = {(timeRemaning) in
      print("Remaining Time is : \(timeRemaning)")
    }
    
    completionClosure = {(status) in
      print("is Download completed : \(status)")
    }
    
    let homeDirectory = NSHomeDirectory()
    let name = url5.subStringTo(to: (url5.length - 10))
    let charset=NSCharacterSet(charactersIn:"\\")
    
//    let name1 = name.
    print("homeDirectory == \(homeDirectory)")
    print("name == \(name)")
    
    veloxDownloader.downloadFile(
      withURL: url!,
      name: name,
      directoryName: nil,
      friendlyName: nil,
      progressClosure: progressClosure,
      remainigtTimeClosure: remainingTimeClosure,
      completionClosure: completionClosure,
      backgroundingMode: false
    )
    
  }
  override func didReceiveMemoryWarning() {
      super.didReceiveMemoryWarning()
      // Dispose of any resources that can be recreated.
  }
    

  

}
