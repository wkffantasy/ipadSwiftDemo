//
//  HUDTool.swift
//  ipadSwiftDemo
//
//  Created by fantasy on 17/3/6.
//  Copyright © 2017年 fantasy. All rights reserved.
//

import UIKit
import MBProgressHUD

class HUDTool: NSObject {

    static let tool = HUDTool()

    func showTextHUD(text: String?, view: UIView) -> MBProgressHUD {
        let hud = MBProgressHUD.showAdded(to: view, animated: true)
        hud.label.textColor = UIColor.colorWithHexString("7f7f7f")
        hud.mode = .text
        hud.bezelView.backgroundColor = UIColor.black
        hud.contentColor = UIColor.white
        hud.label.text = text
        hud.margin = 30.0
        hud.removeFromSuperViewOnHide = true
        return hud
    }

    func showTextHud(text: String?, view: UIView, afterDelay: TimeInterval) {
        let hud = self.showTextHUD(text: text, view: view)
        hud.hide(animated: true, afterDelay: afterDelay)
    }
}
