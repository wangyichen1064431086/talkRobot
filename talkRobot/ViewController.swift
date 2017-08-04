//
//  ViewController.swift
//  talkRobot
//
//  Created by wangyichen on 01/08/2017.
//  Copyright © 2017 Ftc. All rights reserved.
//

import UIKit
import Foundation

class ChatViewController: UIViewController, UITextFieldDelegate, UITableViewDataSource, UITableViewDelegate {
   
    var keyboardNeedLayout:Bool = true
  
    var talkData = Array(repeating:CellData(), count:10){
        didSet{
            self.talkListBlock.reloadData()
            //let num = talkData.count
            let currentIndexPath = IndexPath(row: talkData.count-1, section: 0)
            //let firstIndexPath = IndexPath(row: 0, section: 0)
            
                self.talkListBlock?.scrollToRow(at: currentIndexPath, at: .bottom, animated: true)
            
        }
    }
    
    
    //CellData(headImage: "you.jpeg", whoSays: .you, saysWhat: "Hahaha"), CellData(headImage: "robot.jpeg", whoSays: .robot, saysWhat: "Welcome")
    @IBOutlet weak var talkListBlock: UITableView!
    
    @IBOutlet weak var inputBlock: UITextField!

    
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {//NOTE:该UITapGestureRecognizer在storyboard上拖动的时候必须拖到UIView里面，不能直接放在顶部，否则无效
        self.inputBlock.resignFirstResponder()
    }
   
   
    @IBAction func sendYourTalk(_ sender: UIButton) {
        if let currentYourTalk = inputBlock.text {
            let currentYourCellData = CellData(headImage: "you.jpeg", whoSays: .you, saysWhat: currentYourTalk)
            talkData.append(currentYourCellData)
            
            self.inputBlock.text = ""
            
            var currentRobotTalk = ""
            switch currentYourTalk {
                case "How are you":
                currentRobotTalk = "Fine"
                case "Hi":
                currentRobotTalk = "Hello"
                case "I love you":
                currentRobotTalk = "I love you, too"
            default:
                currentRobotTalk = "What do you say?"
            }
            let currentRobotCellData = CellData(headImage: "robot.jpeg", whoSays: .robot, saysWhat: currentRobotTalk)
            talkData.append(currentRobotCellData)
           
        }
        

    }
  
    
    
    func keyboardWillShow(_ notification: NSNotification) {
        print("show")
        
        if let userInfo = notification.userInfo, let value = userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue, let duration = userInfo[UIKeyboardAnimationDurationUserInfoKey] as? Double, let curve = userInfo[UIKeyboardAnimationCurveUserInfoKey] as? UInt{
            let keyboardFrame = value.cgRectValue
            
            if let currentWindow = self.view.window {
                currentWindow.convert(keyboardFrame, from: nil)
            }
            
            print(keyboardFrame.height)
            let intersection = self.view.frame.intersection(keyboardFrame) // 求当前view的frame与keyboardFrame的交集
            let deltaY = intersection.height
            print(deltaY)
            
            if keyboardNeedLayout {
                UIView.animate(
                    withDuration: duration,
                    delay: 0.0,
                    options: UIViewAnimationOptions(rawValue: curve),
                    animations: { _ in
                        
                        self.view.frame = CGRect(x: 0, y: -deltaY, width: self.view.bounds.width, height: self.view.bounds.height)
                        self.keyboardNeedLayout = false
                        self.view.layoutIfNeeded()
                        
                },
                    completion: nil
                )
            }
            
            
            
        }
        
    }
    func keyboardWillHide(_ notification: NSNotification) {
        print("hide")
        if let userInfo = notification.userInfo, let value = userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue, let duration = userInfo[UIKeyboardAnimationDurationUserInfoKey] as? Double, let curve = userInfo[UIKeyboardAnimationCurveUserInfoKey] as? UInt{
            let keyboardFrame = value.cgRectValue
            let intersection = self.view.frame.intersection(keyboardFrame) // 求当前view的frame与keyboardFrame的交集
            let deltaY = intersection.height
            print(deltaY)
            UIView.animate(
                withDuration: duration,
                delay: 0.0,
                options: UIViewAnimationOptions(rawValue: curve),
                animations: { _ in
                    
                    self.view.frame = CGRect(x: 0, y: deltaY, width: self.view.bounds.width, height: self.view.bounds.height)
                    self.keyboardNeedLayout = true
                    self.view.layoutIfNeeded()
                    
            },
                completion: nil
            )
            
        }

    }
    
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(self.talkData.count)
        return self.talkData.count
    }
 
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        print(100)
        return 60.0
    }
    
   
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        /*
        let cell = tableView.dequeueReusableCell(withIdentifier: "Talk", for: indexPath)
        print(cell)
        cell.textLabel?.text = talkData[indexPath.row]
         */
 
        print("one cell")
        let cellData = self.talkData[indexPath.row]
        print(cellData)
        let cell = OneTalkCell(cellData, reuseId:"Talk")
        print("One cell success")
        return cell
        
    }
    
  

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow(_:)), name:NSNotification.Name.UIKeyboardWillShow, object: nil)
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide(_:)), name:NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        self.talkListBlock.delegate = self
        self.talkListBlock.dataSource = self // MARK:两个协议代理，一个也不能少
        
        self.talkListBlock.separatorStyle = .none //MARK:删除cell之间的分割线
        
        self.talkData.append(CellData(headImage: "you.jpeg", whoSays: .you, saysWhat: "Hahaha"))
        self.talkData.append(CellData(headImage: "robot.jpeg", whoSays: .robot, saysWhat: "Welcome"))
      
        
    }

    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }

}

