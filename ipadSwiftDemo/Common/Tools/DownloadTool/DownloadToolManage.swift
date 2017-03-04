//
//  DownloadToolManage.swift
//  ipadSwiftDemo
//
//  Created by fantasy on 17/3/4.
//  Copyright © 2017年 fantasy. All rights reserved.
//

import UIKit

class DownloadToolManage:NSObject,URLSessionDelegate,URLSessionDownloadDelegate {
  
  // 进度的String 22.0%  剩余时间的String 04:46 速度的String 300KB/s
  typealias DownloadingProgress = (String,String,String) -> ()
  // 返回的path
  typealias DownloadedComplete = (String) -> ()
  // 开始下载url 和文件的总大小
  typealias DownloadStart = (String,String) -> ()
  //下载失败
  typealias DownloadedFailed = (Error) -> ()
  
  public var startBlock:DownloadStart?
  public var progressBlock:DownloadingProgress?
  public var completeBlock:DownloadedComplete?
  public var failed:DownloadedFailed?
  
  var downloadUrl:String?
  var toSavePath:String?
  var session : URLSession?
  
  override init() {
    super.init()
    
    let configuration = URLSessionConfiguration.default
    self.session = URLSession(configuration: configuration, delegate: self, delegateQueue: nil)
    
  }
  
  public func downloadVideoFiles(
    downloadUrl:String,
    toSavePath:String,
    startBlock:@escaping DownloadStart,
    progressBlock:@escaping DownloadingProgress,
    completeBlock:@escaping DownloadedComplete,
    failedBlock:@escaping DownloadedFailed
    ){
    
    print("this func is downloadVideoFiles")
    assert(downloadUrl.length > 0 , "this url should not be nil")
    self.downloadUrl = downloadUrl
    self.toSavePath = toSavePath
    self.startBlock = startBlock
    self.progressBlock = progressBlock
    self.completeBlock = completeBlock
    self.failed = failedBlock
    
    startDownload()
    
  }
  func startDownload() {
    print("this func is startDownload")
    //检查：根据这个url去目录搜索是否已经下载好这个file了
    
    //开始下载
    let request = URLRequest(url: URL(string: self.downloadUrl!)!)
    let downloadTask = self.session?.downloadTask(with: request)
    downloadTask?.resume()
    if self.startBlock != nil {
      self.startBlock!(self.downloadUrl!,"10M")
    }
    
  }
  
  func urlSession(_ session: URLSession, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
    
    print("session ==\(session)")
    print("challenge ==\(challenge)")
//    print("AuthChallengeDisposition",URLSession.AuthChallengeDisposition())
    print("URLCredential",URLCredential())
    
    
  }
  func urlSessionDidFinishEvents(forBackgroundURLSession session: URLSession) {
    
    print("urlSessionDidFinishEvents")
    
    
  }
  func urlSession(_ session: URLSession, didBecomeInvalidWithError error: Error?) {
    
    print("session == ",session)
    print("error ==",error)
    
    
  }
  
  
  
  
  
 
  

}
