//
//  DownloadToolManage.swift
//  ipadSwiftDemo
//
//  Created by fantasy on 17/3/4.
//  Copyright © 2017年 fantasy. All rights reserved.
//

import UIKit

public enum DownloadState: Int {

    case Downloading

    case Pause

    case NotBegan

    case Compeleted

    case Failed
}

class DownloadToolManage: NSObject, URLSessionDownloadDelegate {

    // 进度的String 22.0%  剩余时间的String 04:46 速度的String 300KB/s
    typealias DownloadingProgress = (String, String, String) -> Void
    // 返回的path
    typealias DownloadedComplete = (String) -> Void
    // 下载失败
    typealias DownloadedFailed = (Error) -> Void

    public var progressBlock: DownloadingProgress?
    public var completeBlock: DownloadedComplete?
    public var failed: DownloadedFailed?

    var downloadState = DownloadState.NotBegan
    var downloadUrl: String?
    var toSavePath: String?
    var session: URLSession?
    var downloadTask: URLSessionDownloadTask?
    var downloadDate: Date?
    // 断点续传
    var resumeData: NSData?

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
        let exist = FileManager.default.fileExists(atPath: self.toSavePath!)
        if exist == true {
            if self.completeBlock != nil {
                self.completeBlock!(self.toSavePath!)
            }
            return
        }
        // 检查：根据这个url去目录搜索是否有 resumeData存在
        // 开始下载
        let request = URLRequest(url: URL(string: self.downloadUrl!)!)
        downloadTask = self.session?.downloadTask(with: request)
        downloadTask?.resume()
        self.downloadState = DownloadState.Downloading
    }

    // 暂停
    func pauseDownload() {
        if self.downloadState == DownloadState.Downloading {
            self.downloadTask?.cancel(byProducingResumeData: { data in
                self.resumeData = data as NSData?
            })
            self.downloadState = DownloadState.Pause
        }
    }

    // 继续
    func goonDownload() {
        if self.downloadState == DownloadState.Pause {
            self.downloadTask = self.session?.downloadTask(withResumeData: self.resumeData as! Data)
            downloadTask?.resume()
            self.resumeData = nil
            self.downloadState = DownloadState.Downloading
        }
    }

    // 取消
    func cancelDownload() {
        self.downloadTask?.cancel()
    }

    // 下载出错
    func urlSession(_: URLSession, task _: URLSessionTask, didCompleteWithError error: Error?) {
        print("error ==", error)
    }

    // 下载完成
    func urlSession(_: URLSession, downloadTask _: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        print("location ==", location)
        print("location.path ==", location.path)
        let fileMan = FileManager.default
        do {
            try fileMan.copyItem(atPath: location.path, toPath: self.toSavePath! as String)
        } catch {
        }
        self.downloadState = DownloadState.Compeleted
        if self.completeBlock != nil {
            self.completeBlock!(self.toSavePath!)
        }
        self.session?.finishTasksAndInvalidate()
    }

    // 监听下载进度的方法
    func urlSession(_: URLSession, downloadTask _: URLSessionDownloadTask, didWriteData _: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {
        let progress = CGFloat(totalBytesWritten) / CGFloat(totalBytesExpectedToWrite)
        var progressString: String
        if progress == 1 {
            progressString = "100%"
        } else {
            progressString = String(format: "%.2f", progress * 100) + "%"
        }
        let timeInterval: TimeInterval = Date().timeIntervalSince(self.downloadDate!)
        let speed = CGFloat(totalBytesWritten) / CGFloat(timeInterval)
        print("speed ==", speed)
        let speedString = self.convertBytesToUnit(bytes: speed) + "/s"
        let remainingBytes = totalBytesExpectedToWrite - totalBytesWritten
        let remainingTimeFloat = CGFloat(remainingBytes) / CGFloat(speed)
        let remainingTime = TimeTool.tool.convertTimeIntToTimeString(time: Int64(remainingTimeFloat))
        DispatchQueue.main.async {
            if self.progressBlock != nil {
                self.progressBlock!(progressString, remainingTime, speedString)
            }
        }
    }

    func convertBytesToUnit(bytes: CGFloat) -> String {
        let remainM = bytes / (1024 * 1024)
        let remainKB = bytes / 1024
        var unitString: String
        if remainM > 1 {
            unitString = String(format: "%.1fM", remainM)
        } else {
            unitString = String(format: "%.1fKB", remainKB)
        }
        return unitString
    }
}
