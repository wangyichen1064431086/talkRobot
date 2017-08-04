//
//  OneTalkCell.swift
//  talkRobot
//
//  Created by wangyichen on 03/08/2017.
//  Copyright © 2017 Ftc. All rights reserved.
//
import UIKit
import Foundation

class OneTalkCell: UITableViewCell {
    var saysContentView = UILabel(frame:CGRect(x:0, y:0, width:200,height:50))
    var headImageView = UIImageView(image: UIImage(named: "you.jpeg"))
    var cellData:CellData
    
    // MARK: 重写Frame:费了好长好长时间才找到解决办法。。。
    override var frame: CGRect {
        didSet {
            var newFrame = frame
            newFrame.size.width = UIScreen.main.bounds.width
            super.frame = newFrame
        }
    }
    
    init(_ data:CellData, reuseId cellId:String) {
        self.cellData = data
        print(data)
        super.init(style: UITableViewCellStyle.default, reuseIdentifier:cellId)
        print("here")
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
            print(self.headImageView.frame.minX)
            print(self.headImageView.frame.maxX)
            self.addSubview(self.headImageView)
            print("Add headImage Success")
        }
        
        // 显示对话内容
        if(self.cellData.saysWhat != "") {
            
            let font = UIFont.systemFont(ofSize:12)
            let width = 250, height = 10000.0
            let atts = [NSFontAttributeName: font]
            
            let saysWhatNSString = self.cellData.saysWhat as NSString
            let size = saysWhatNSString.boundingRect(
                with: CGSize(width:CGFloat(width), height:CGFloat(height)),
                options: .truncatesLastVisibleLine,
                attributes: atts,
                context: nil)
            /*
            let size = self.cellData.saysWhat.boundingRect(
                with: CGSize(width:CGFloat(width), height:CGFloat(height)),
                options: .truncatesLastVisibleLine,
                attributes: atts,
                context: nil)
            */
            
            let finalWidth = size.size.width * 1.4 //修正计算错误
            let finalHeight = size.size.height * 1.4
            let finalX = (whoSays == .robot) ? 54: self.frame.width - 54 - finalWidth
            let finalY = self.frame.midY - 25
            saysContentView = UILabel(frame: CGRect(x: finalX, y: finalY, width: finalWidth, height: finalHeight))
            saysContentView.numberOfLines = 0
            saysContentView.lineBreakMode = NSLineBreakMode.byCharWrapping
            saysContentView.text = self.cellData.saysWhat

            /*
            let xForSaysContentView = (whoSays == .robot) ? 54 : self.frame.width - 54 - 200
            let yForSaysContentView = self.frame.midY - 25
            self.saysContentView.frame = CGRect(x: xForSaysContentView, y: yForSaysContentView, width: 200, height: 50)
            */
            self.addSubview(saysContentView)
        }
        

   
    }
}
