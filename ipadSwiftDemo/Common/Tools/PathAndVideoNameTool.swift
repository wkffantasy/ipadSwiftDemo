//
//  PathAndVideoNameTool.swift
//  ipadSwiftDemo
//
//  Created by fantasy on 17/3/8.
//  Copyright © 2017年 fantasy. All rights reserved.
//

import UIKit

class PathAndVideoNameTool: NSObject {

  static let tool = PathAndVideoNameTool()
  
  //后缀为m3u8
  func videoConverUrlToName(urlString:String) -> String {
    assert(urlString.length > 0, "")
    
    var name = urlString
    if name.hasPrefix("http://") {
      name = name.SubStringFrom(from: 7)
    }
    
    name = name.replacingOccurrences(of: "/", with: "")
    name = name.replacingOccurrences(of: ":", with: "")
    name = name.replacingOccurrences(of: ".", with: "")
    name = name + ".mp4"
  
    print("name == \(name)")
    
    return name
  }
  //后缀为m3u8
  func videoConverUrlToPath(urlString:String) -> String {
    
    assert(urlString.length > 0, "")
    
    var  filePath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.cachesDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).last! as NSString
    filePath = filePath.appendingPathComponent(self.videoConverUrlToName(urlString: urlString)) as NSString
  
    return filePath as String

  }
  
  
  func audioConverUrlToName(urlString:String) -> String {
    assert(urlString.length > 0, "")
    return "22"
  }
  func audioConverUrlToPath(urlString:String) -> String {
    assert(urlString.length > 0, "")
    return "11"
  }
  
  
  
  
}
