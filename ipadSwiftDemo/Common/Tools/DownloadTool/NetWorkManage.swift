//
//  NetWorkManage.swift
//  ipadSwiftDemo
//
//  Created by fantasy on 17/3/6.
//  Copyright © 2017年 fantasy. All rights reserved.
//

import UIKit
import SwiftHTTP

//成功的回调
public typealias HttpSuccess = (_ responseObject: [String: AnyObject]) -> Void

//失败的回调
public typealias HttpFailure = (_ error: String) -> Void

//正在上传的回调
//public typealias HttpProgress = (_ progress: String) -> Void


class NetWorkManage: NSObject {
  
  static let manger = NetWorkManage()
  
  func getMethodUrl(url:String,second:Double?=nil,parameters:[String: Any]?=nil,successBlock: HttpSuccess?=nil,failurlBlock: HttpFailure?=nil) -> HTTP?{
    
    assert(url.length > 0 , "")
    //设置超时时间
    var newSecond = second;
    if newSecond == nil {
      newSecond = kNetTimeOut
    }
    do {
      HTTP.globalRequest { req in
        req.timeoutInterval = newSecond!   //设置超时时间
      }
      let net = try HTTP.GET(url, parameters: parameters)
      net.start { response in
        if let err = response.error {
          self.doCallBack(successBlock: nil, failedBlock: failurlBlock, message: err)
        } else {
          self.doCallBack(successBlock: successBlock, failedBlock: nil, message: response.data)
        }
      }
      return net
    } catch let error {
      print("got an error creating the request: \(error)")
      self.doCallBack(successBlock: nil, failedBlock: failurlBlock, message: error)
      return nil
    }
  }
  func postMethodUrl(url:String,second:Double?=nil,parameters:[String: Any]?=nil,successBlock: HttpSuccess?=nil,failurlBlock: HttpFailure?=nil) -> HTTP?{
    assert(url.length > 0 , "")
    //设置超时时间
    var newSecond = second;
    if newSecond == nil {
      newSecond = kNetTimeOut
    }
    do {
      HTTP.globalRequest { req in
        req.timeoutInterval = newSecond!   //设置超时时间
      }
      
      let net = try HTTP.POST(url, parameters: parameters, headers: nil)
      net.start { response in
        if let err = response.error {
          self.doCallBack(successBlock: nil, failedBlock: failurlBlock, message: err)
        } else {
          self.doCallBack(successBlock: successBlock, failedBlock: nil, message: response.data)
        }
      }
      return net
    } catch let error {
      print("got an error creating the request: \(error)")
      self.doCallBack(successBlock: nil, failedBlock: failurlBlock, message: error)
      return nil
    }
  }
  func uploadFileMethodUrl(url:String,filePathDict:[String:String]?=nil,second:Double?=nil,parameters:[String: Any]?=nil,successBlock: HttpSuccess?=nil,failurlBlock: HttpFailure?=nil) -> HTTP?{
    
    assert(url.length > 0 , "")
    assert(filePathDict != nil , "")
    
    var newParameters = [String: Any]()
    if parameters != nil {
      newParameters = parameters!
    }
    if filePathDict != nil {
      for item in filePathDict! {
        let fileUrl = URL.init(fileURLWithPath: item.value)
        newParameters[item.key] = Upload(fileUrl:fileUrl)
      }
    }
    return self.postMethodUrl(url: url, second: second, parameters: newParameters, successBlock: successBlock, failurlBlock: failurlBlock)
   
  }
  
  //执行回调
  private func doCallBack(successBlock:HttpSuccess?=nil,failedBlock:HttpFailure?=nil,message:Any) {
    
    if successBlock != nil {
      
      var retDic:[String: Any]!
      do {
        let object: Any = try JSONSerialization.jsonObject(with: message as! Data, options: .allowFragments)
        if let value = object as? [String: AnyObject] {
          retDic = value
        }else{
          retDic = ["code":-1,"msg":"网络超时，请刷新重试！"]
        }
      } catch{
        //出错
        print("occur error",message)
        retDic = ["code":-1,"msg":"网络超时，请刷新重试！"]
      }
      
      //刷新主线程UI
      DispatchQueue.main.async {
        successBlock?(retDic as [String : AnyObject])
      }
    }else if(failedBlock != nil){
      DispatchQueue.main.async {
        let msg = "网络不给力，请刷新重试！"
        failedBlock!(msg)
      }
    }
  }

  
  
  

}
