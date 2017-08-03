//
//  OneTalkCell.swift
//  talkRobot
//
//  Created by wangyichen on 03/08/2017.
//  Copyright © 2017 Ftc. All rights reserved.
//
import UIKit
import Foundation

class OneTalkCell: UITableViewCell,UITextFieldDelegate {
    var saysContentView: UITextField!
    
    // 设置该内容UITextField不可编辑
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        return false
    }
    var headImageView: UIImageView!
    var cellData:CellData
    
    init(_ data:CellData, reuseId cellId:String) {
        self.cellData = data
        super.init(style: UITableViewCellStyle.default, reuseIdentifier:cellId)
        buildTheCell()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func buildTheCell() {
        self.selectionStyle = UITableViewCellSelectionStyle.none
    
        let whoSays = self.cellData.whoSays
        
        
        // 显示头像
        if(self.cellData.headImage != "") {
            let headImageName = self.cellData.headImage //The name of the image in tha app's maini bundler, which including the extension except for PNG
            let headImage = UIImage(named: headImageName)
            self.headImageView = UIImageView(image: headImage)
            
            // 头像高、宽都为50CGFloat
            // 头像的位置x: robot头像在左，you头像在右
            let xForHeadImageView = (whoSays == .robot) ? 2 : self.frame.width - 52
            // 头像的位置y: 在cell的垂直居中处
            let yForHeadImageView = self.frame.midY - 25
            
            // 绘制头像view
            self.headImageView.frame = CGRect(x:xForHeadImageView,y:yForHeadImageView,width:50,height:50)
            
            self.addSubview(self.headImageView)
        }
        
        // 显示对话内容
        self.saysContentView.text = self.cellData.saysWhat
        let xForSaysContentView = (whoSays == .robot) ? 54 : self.frame.width - 54 - self.saysContentView.bounds.width
        let yForSaysContentView = self.frame.midY - 25
        self.saysContentView.frame = CGRect(x: xForSaysContentView, y: yForSaysContentView, width: self.saysContentView.bounds.width, height: 50)
        self.addSubview(saysContentView)
        
        
    }
}
