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
    var talkData: [String] = ["","","","","","","","","","","","","",""] {
        didSet{
            self.talkListBlock.reloadData()
            let currentIndexPath = IndexPath(row: talkData.count-1, section: 0)
            self.talkListBlock?.scrollToRow(at: currentIndexPath, at: .bottom, animated: false)
        }
    }
    
 
    @IBOutlet weak var talkListBlock: UITableView!
    
    @IBOutlet weak var inputBlock: UITextField!

    
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {//NOTE:该UITapGestureRecognizer在storyboard上拖动的时候必须拖到UIView里面，不能直接放在顶部，否则无效
        self.inputBlock.resignFirstResponder()
    }
   
   
    @IBAction func sendYourTalk(_ sender: UIButton) {
        if let currentYourTalk = inputBlock.text {
            talkData.append(currentYourTalk)
            self.inputBlock.text = ""
            
            switch currentYourTalk {
                case "How are you":
                talkData.append("Fine")
                case "Hi":
                talkData.append("Hello")
                case "I love you":
                talkData.append("I love you, too")
            default:
                talkData.append("What do you say?")
            }
           
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
        return self.talkData.count
    }
 
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Talk", for: indexPath)
        print(cell)
        cell.textLabel?.text = talkData[indexPath.row]
        return cell
 
        /*
        let cellData = self.talkData[indexPath.row]
        let cell = OneTalkCell(data: cellData, reuseId:"Talk")
        return cell
        */
    }
    
  
    private func decideTableViewLocation (_ tableHeight: Float, tableRealHeight realHeight: Float, keyBoardIsShow show: Bool) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow(_:)), name:NSNotification.Name.UIKeyboardWillShow, object: nil)
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide(_:)), name:NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        self.talkListBlock.delegate = self
        self.talkListBlock.dataSource = self // MARK:两个协议代理，一个也不能少
        
        
    }

    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }

}

