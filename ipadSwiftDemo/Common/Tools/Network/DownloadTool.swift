//
//  DownloadTool.swift
//  ipadSwiftDemo
//
//  Created by fantasy on 17/3/3.
//  Copyright © 2017年 fantasy. All rights reserved.
//

import UIKit

//开始下载
public typealias DownloadBegan = (_ totalSize:Int) -> Void
//正在下载
public typealias DownloadingProgress = (_ currentSize:Int,_ persent:String) -> Void
//下载完成
public typealias DownloadComplete = (_ destinationPath:String) -> Void
//下载失败
public typealias DownloadFailed = (_ error:String) -> Void

class DownloadTool: NSObject {
  
  var downloadBegan:DownloadBegan?
  var downloadingProgress:DownloadingProgress?
  var downloadComplete:DownloadComplete?
  var downloadFailed:DownloadFailed?
  var destinationPath:String?
  
  var urlString :String!
  
  override init() {
    super.init()
  }
  //public
  func startNewTask(url:String,destinationPath:String) {
    assert(url.length > 0 ,"this url should not be nil")
    self.urlString = url
    if destinationPath.length > 0 {
      self.destinationPath = destinationPath
    } else {
      self.destinationPath = ""
    }
    
    beganDownload()
    
  }
  
  // private
  // began download
  func beganDownload() {
    
    print("beganDownload \n path== \(self.destinationPath) \n url== \(self.urlString)")
    
    let url = URL(string:self.urlString)
    let request = URLRequest(url:url!)
    let session = URLSession.shared
    
    let downloadTask = session.downloadTask(with: request) { (location:URL?, response:URLResponse?, error:Error?) in
      
      print("location == \(location)")
      print("response == \(response)")
      print("error ==\(error)")
      
    }
    downloadTask.resume()
    
  }
  
  
  
  
}
