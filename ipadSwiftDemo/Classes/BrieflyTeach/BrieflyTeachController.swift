//
//  BrieflyTeachController.swift
//  ipadSwiftDemo
//
//  Created by fantasy on 17/2/28.
//  Copyright © 2017年 fantasy. All rights reserved.
//

import UIKit
import MBProgressHUD

class BrieflyTeachController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.randomColor()
        let beganGetDataButton = UIButton(type: .custom)
        beganGetDataButton.backgroundColor = UIColor.randomColor()
        beganGetDataButton.setTitle("开始请求无参数的get", for: UIControlState.normal)
        beganGetDataButton.setTitleColor(UIColor.colorWithRGB(red: 33, green: 33, blue: 33), for: UIControlState.normal)
        beganGetDataButton.addTarget(self, action: #selector(clickToGetData(button:)), for: UIControlEvents.touchUpInside)
        self.view.addSubview(beganGetDataButton)
        beganGetDataButton.snp.makeConstraints { make in
            make.left.top.equalTo(20)
            make.width.equalTo(200)
            make.height.equalTo(40)
        }
        let getParamButton = UIButton(type: .custom)
        getParamButton.backgroundColor = UIColor.randomColor()
        getParamButton.setTitle("请求有参数的get", for: UIControlState.normal)
        getParamButton.setTitleColor(UIColor.colorWithRGB(red: 33, green: 33, blue: 33), for: UIControlState.normal)
        getParamButton.addTarget(self, action: #selector(clickToGetParamButton(button:)), for: UIControlEvents.touchUpInside)
        self.view.addSubview(getParamButton)
        getParamButton.snp.makeConstraints { make in
            make.left.equalTo(beganGetDataButton.snp.right).offset(20)
            make.top.equalTo(20)
            make.width.equalTo(200)
            make.height.equalTo(40)
        }
        let postButton = UIButton(type: .custom)
        postButton.backgroundColor = UIColor.randomColor()
        postButton.setTitle("请求有参数的post", for: UIControlState.normal)
        postButton.setTitleColor(UIColor.colorWithRGB(red: 33, green: 33, blue: 33), for: UIControlState.normal)
        postButton.addTarget(self, action: #selector(clickPostButton(button:)), for: UIControlEvents.touchUpInside)
        self.view.addSubview(postButton)
        postButton.snp.makeConstraints { make in
            make.left.equalTo(20)
            make.top.equalTo(beganGetDataButton.snp.bottom).offset(20)
            make.width.equalTo(200)
            make.height.equalTo(40)
        }
        let uploadButton = UIButton(type: .custom)
        uploadButton.backgroundColor = UIColor.randomColor()
        uploadButton.setTitle("上传一个图片", for: UIControlState.normal)
        uploadButton.setTitleColor(UIColor.colorWithRGB(red: 33, green: 33, blue: 33), for: UIControlState.normal)
        uploadButton.addTarget(self, action: #selector(clickToUploadFile(button:)), for: UIControlEvents.touchUpInside)
        self.view.addSubview(uploadButton)
        uploadButton.snp.makeConstraints { make in
            make.top.equalTo(getParamButton.snp.bottom).offset(20)
            make.left.equalTo(postButton.snp.right).offset(20)
            make.width.equalTo(200)
            make.height.equalTo(40)
        }
    }

    func clickToUploadFile(button _: UIButton) {
        print("clickToUploadFile")
        /*
         let data = UIImageJPEGRepresentation(portraitImg, 1)
         let headStr = data?.base64EncodedString()
         url = "http://api.test.smartstudy.com/user/avatar/upload?w=300&h=300"
         */

        //    let hud = MBProgressHUD.showAdded(to: self.view, animated: true)
        //    hud.label.textColor = UIColor.colorWithHexString("7f7f7f");
        //    hud.mode = .text
        //    hud.bezelView.backgroundColor = UIColor.black
        //    hud.contentColor = UIColor.white
        //    hud.label.text = "上传中"
        //    hud.margin = 30.0
        //    hud.removeFromSuperViewOnHide = true
        let hud = HUDTool.tool.showTextHUD(text: "上传中...", view: self.view)
        let param = [
            "image1": self.getFilePath(fileName: "WechatIMG3", ofType: "jpeg"),
        ]
        let urlString = "http://api.test.smartstudy.com/user/avatar/upload?w=300&h=300"
        //     let urlString = "http://api.test.smartstudy.com/user/avatar/upload?w=300&h=300"
        let net = NetWorkManage.manger.uploadFileMethodUrl(url: urlString, filePathDict: param, second: nil, parameters: nil, successBlock: { data in
            print("upload one image data ==", data)
            hud.hide(animated: true)
        }) { error in
            print("upload failed error == \(error)")
            hud.hide(animated: true)
        }
        print("net ==", net)
    }

    func clickToGetData(button _: UIButton) {
        // http://dev.smartstudy.com:3100/api/mobile/v3/product/1958

        //    let hud = MBProgressHUD.showAdded(to: self.view, animated: true)
        //    hud.label.textColor = UIColor.colorWithHexString("7f7f7f");
        //    hud.mode = .text
        //    hud.bezelView.backgroundColor = UIColor.black
        //    hud.contentColor = UIColor.white
        //    hud.label.text = "请求中"
        //    hud.margin = 30.0
        //    hud.removeFromSuperViewOnHide = true
        let hud = HUDTool.tool.showTextHUD(text: "请求中...", view: self.view)
        let productId = "1958"
        let urlString = kProductInfoApi + productId
        let net = NetWorkManage.manger.getMethodUrl(url: urlString, second: nil, parameters: nil, successBlock: { data in
            print("successBlock data ==", data)
            hud.hide(animated: true)
        }) { error in
            print("failedBlock error == \(error)")
            hud.hide(animated: true)
        }
        print("net ==", net)
        //    net?.cancel()
    }

    func clickToGetParamButton(button _: UIButton) {
        print("clickToGetParamButton")
        // http://dev.smartstudy.com:3100/api/mobile/v3/product/1016
        // token :u3JniMLnENWipLuyCcSre21K6n16wcmQ
        let param = ["token": "u3JniMLnENWipLuyCcSre21K6n16wcmQ"]
        //    let hud = MBProgressHUD.showAdded(to: self.view, animated: true)
        //    hud.label.textColor = UIColor.colorWithHexString("7f7f7f");
        //    hud.mode = .text
        //    hud.bezelView.backgroundColor = UIColor.black
        //    hud.contentColor = UIColor.white
        //    hud.label.text = "请求中"
        //    hud.margin = 30.0
        //    hud.removeFromSuperViewOnHide = true
        let hud = HUDTool.tool.showTextHUD(text: "请求中...", view: self.view)
        let productId = "1958"
        let urlString = kProductInfoApi + productId
        let net = NetWorkManage.manger.getMethodUrl(url: urlString, second: nil, parameters: param, successBlock: { data in
            print("successBlock data ==", data)
            hud.hide(animated: true)
        }) { error in
            print("failedBlock error == \(error)")
            hud.hide(animated: true)
        }
        print("net ==", net)
        //    net?.cancel()
    }

    func clickPostButton(button _: UIButton) {
        print("clickPostButton")
        /*
         url = http://test.smartstudy.com/api/slice/13974/progress
         {
         progress = 1;
         srvId = 150363;
         token = siOXWhYQu9EXbgSAYTgnAxSZTSMlFZM0;
         type = 1;
         }
         */
        let param = [
            "token": "siOXWhYQu9EXbgSAYTgnAxSZTSMlFZM0",
            "progress": "1",
            "srvId": "150363",
            "type": "1",
        ]
        //    let hud = MBProgressHUD.showAdded(to: self.view, animated: true)
        //    hud.label.textColor = UIColor.colorWithHexString("7f7f7f");
        //    hud.mode = .text
        //    hud.bezelView.backgroundColor = UIColor.black
        //    hud.contentColor = UIColor.white
        //    hud.label.text = "请求中"
        //    hud.margin = 30.0
        //    hud.removeFromSuperViewOnHide = true
        let hud = HUDTool.tool.showTextHUD(text: "请求中...", view: self.view)
        let urlString = "http://test.smartstudy.com/api/slice/13974/progress"
        let net = NetWorkManage.manger.postMethodUrl(url: urlString, second: nil, parameters: param, successBlock: { data in
            print("successBlock data ==", data)
            hud.hide(animated: true)
        }) { error in
            print("failedBlock error == \(error)")
            hud.hide(animated: true)
        }
        print("net ==", net)
    }

    func getFilePath(fileName: String, ofType: String) -> String {
        print("fileName ==\(fileName)")
        print("ofType ==\(ofType)")
        let path = Bundle.main.path(forResource: fileName, ofType: ofType)
        //    let path = Bundle.main.path(forResource: fileName, ofType: ofType)!
        print("path == \(path)")
        assert((path?.length)! > 0, "")
        return path!
    }
}
