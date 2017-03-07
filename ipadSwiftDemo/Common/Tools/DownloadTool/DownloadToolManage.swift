//
//  DownloadToolManage.swift
//  ipadSwiftDemo
//
//  Created by fantasy on 17/3/4.
//  Copyright © 2017年 fantasy. All rights reserved.
//

import UIKit

class DownloadToolManage: NSObject,URLSessionDownloadDelegate {

    // 进度的String 22.0%  剩余时间的String 04:46 速度的String 300KB/s
    typealias DownloadingProgress = (String, String, String) -> Void
    // 返回的path
    typealias DownloadedComplete = (String) -> Void
    // 下载失败
    typealias DownloadedFailed = (Error) -> Void

    public var progressBlock: DownloadingProgress?
    public var completeBlock: DownloadedComplete?
    public var failed: DownloadedFailed?

    var downloadUrl: String?
    var toSavePath: String?
    var session: URLSession?
    var downloadTask :URLSessionDownloadTask?
    var downloadDate : Date?

    override init() {
        super.init()

        let configuration = URLSessionConfiguration.default
        self.session = URLSession(configuration: configuration, delegate: self, delegateQueue: nil)
    }

    public func downloadVideoFiles(
        downloadUrl: String,
        toSavePath: String,
        progressBlock: @escaping DownloadingProgress,
        completeBlock: @escaping DownloadedComplete,
        failedBlock: @escaping DownloadedFailed
    ) {

        print("this func is downloadVideoFiles")
        assert(downloadUrl.length > 0, "this url should not be nil")
        self.downloadUrl = downloadUrl
        self.toSavePath = toSavePath
        self.progressBlock = progressBlock
        self.completeBlock = completeBlock
        self.failed = failedBlock
        self.downloadDate = Date()

        startDownload()
    }
  

    func startDownload() {
        print("this func is startDownload")
        // 检查：根据这个url去目录搜索是否已经下载好这个file了

        // 开始下载
        let request = URLRequest(url: URL(string: self.downloadUrl!)!)
        downloadTask = self.session?.downloadTask(with: request)
        downloadTask?.resume()
  
    }
  //暂停
  func pauseDownload() {
    self.downloadTask?.suspend()
  }
  //继续
  func goonDownload() {
    self.downloadTask?.resume()
  }
  //取消
  func cancelDownload() {
    self.downloadTask?.cancel()
  }
  
  //下载出错
  func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
    print("error ==",error)
  }
  
  //下载完成
  func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
    print("location ==",location)
  }
  //监听下载进度的方法
  func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {
    
    let  progress = CGFloat(totalBytesWritten) / CGFloat(totalBytesExpectedToWrite)
    var progressString:String
    if progress == 1 {
      progressString = "100%"
    } else {
      progressString = String(format:"%.2f",progress*100) + "%"
    }
    
    let timeInterval : TimeInterval  = Date().timeIntervalSince(self.downloadDate!)
    let speed  = CGFloat.init(totalBytesWritten) / CGFloat(timeInterval)
    print("speed ==",speed)
    
    let remainingBytes = totalBytesExpectedToWrite - totalBytesWritten
    let remainingTime = CGFloat(remainingBytes) / CGFloat(speed)
    print("remainingTime ==",remainingTime)
    
    DispatchQueue.main.async {
      
      if self.progressBlock != nil {
        self.progressBlock!(progressString,"\(remainingTime)","\(speed)")
      }
      
    }

  }
 
}
