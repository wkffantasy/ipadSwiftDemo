//
//  TimeTool.swift
//  ipadSwiftDemo
//
//  Created by fantasy on 17/3/7.
//  Copyright © 2017年 fantasy. All rights reserved.
//

import UIKit

class TimeTool: NSObject {
  
  static let tool = TimeTool()

  /*
   + (NSString *)timeStringWithTimeInterval:(int64_t)timeInterval {
   NSString *ret = nil;
   
   NSInteger hour = (NSInteger)timeInterval / 3600;
   NSInteger hourRemain = (NSInteger)timeInterval % 3600;
   NSInteger totalMin = (NSInteger)hourRemain / 60;
   NSInteger totalSec = (NSInteger)hourRemain % 60;
   
   if (hour == 0) {
   ret = [NSString stringWithFormat:@"%.2ld:%.2ld",(long)totalMin, (long)totalSec];
   } else {
   ret = [NSString stringWithFormat:@"%.2ld:%.2ld:%.2ld", (long)hour, (long)totalMin, (long)totalSec];
   }
   
   return ret;
   
   50 -> 50
   61 -> 01:01
   
   }*/
  func convertTimeIntToTimeString(time:Int64) -> String {
    
    let hour = time / 3600
    let hourRemain = time % 3600
    let totalMin = hourRemain / 60
    let totalSec = hourRemain % 60
    
    var timeString :String
    if hour == 0 {
      timeString = String(format: "%.2d:%.2d",totalMin,totalSec)
    } else {
      timeString = String(format: "%.2d:%.2d:%.2d",hour,totalMin,totalSec)
    }
    return timeString
  }

}
