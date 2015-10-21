//
//  ViewController.swift
//  UpDownGame
//
//  Created by sdt5 on 2015. 10. 20..
//  Copyright © 2015년 all4web. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // 수정
    var 최대횟수 = 5
    var 시도횟수 = 0
    var 컴퓨터가선택한값 = 0
    var 성공 = false
    var 타이머 : NSTimer!
    var 타이머카운트 = 0
    
    @IBOutlet weak var label메시지: UILabel!
    @IBOutlet weak var segment게임선택: UISegmentedControl!
    @IBOutlet weak var progress도전횟수: UIProgressView!
    @IBOutlet weak var label도전횟수: UILabel!
    @IBOutlet weak var text사용자입력: UITextField!
    @IBOutlet weak var label타이머: UILabel!

    func 도전(사용자 : Int, 컴퓨터 : Int) {
        시도횟수++
        
        label도전횟수.text = String(시도횟수) + "/" + String(최대횟수)
        progress도전횟수.progress = Float(시도횟수) / Float(최대횟수)
        타이머카운트 = 0

        if 컴퓨터 == 사용자 {
            성공 = true
        } else if 컴퓨터 > 사용자 {
            label메시지.text = "컴퓨터 숫자보다 작은 값을 입력했습니다."
        } else {
            label메시지.text = "컴퓨터 숫자보다 큰 값을 입력했습니다."
        }
        
        text사용자입력.text = ""
    }
    
    func 초기화() {
        let 게임모드 : Int = segment게임선택.selectedSegmentIndex
        
        text사용자입력.resignFirstResponder()

        switch 게임모드 {
        case 0:
            최대횟수 = 5
            컴퓨터가선택한값 = (Int)(arc4random() % 10) + 1;
        case 1:
            최대횟수 = 10
            컴퓨터가선택한값 = (Int)(arc4random() % 50) + 1;
        default:
            최대횟수 = 15
            컴퓨터가선택한값 = (Int)(arc4random() % 100) + 1;
        }
        
        시도횟수 = 0
        label메시지.text = "게임 시작을 눌러주세요."
        label타이머.text = ""
        label도전횟수.text = String(시도횟수) + "/" + String(최대횟수)
        text사용자입력.text = ""
        progress도전횟수.progress = 0.0
        
        print("컴퓨터가선택한값 : \(컴퓨터가선택한값)")
        
        if 타이머 != nil {
            타이머.invalidate()
        }
    }
    
    func countUP() {
        label타이머.text = String(타이머카운트)
        
        if ++타이머카운트 >= 10 {
            도전(-1, 컴퓨터: 컴퓨터가선택한값)
        }
    }
    
    func 게임시작() {
        let 게임모드 : Int = segment게임선택.selectedSegmentIndex
        
        switch 게임모드 {
        case 0:
            컴퓨터가선택한값 = (Int)(arc4random() % 5) + 1;
            label메시지.text = "1부터 10사이의 값을 입력해주세요."
        case 1:
            컴퓨터가선택한값 = (Int)(arc4random() % 50) + 1;
            label메시지.text = "1부터 50사이의 값을 입력해주세요."
        default:
            컴퓨터가선택한값 = (Int)(arc4random() % 100) + 1;
            label메시지.text = "1부터 100사이의 값을 입력해주세요."
        }
        
        let 주기 : NSTimeInterval = 1
        타이머 = NSTimer.scheduledTimerWithTimeInterval(주기, target: self, selector: "countUP", userInfo: nil, repeats: true)
    }

    @IBAction func button확인(sender: UIButton) {
        var 사용자입력 : String = text사용자입력.text!
        var 제목 : String = ""
        var 메시지 : String = ""
        
        text사용자입력.resignFirstResponder()
        
        사용자입력 = 사용자입력.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())

        if 사용자입력 == "" {
            label메시지.text = "값을 입력하지 않았습니다."
            return
        }
        
        let 사용자입력숫자 = Int(사용자입력)
        
        도전(사용자입력숫자!, 컴퓨터: 컴퓨터가선택한값)

        if 성공 {
            제목 = "확인"
            메시지 = "축하합니다. 정답입니다."

            let dialog = UIAlertController(title: 제목, message: 메시지, preferredStyle: UIAlertControllerStyle.Alert)
            let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default) { (acion) -> Void in print("OK 선택") }
            dialog.addAction(okAction)
            
            self.presentViewController(dialog, animated: true, completion: nil)
            
            초기화()
        } else if 시도횟수 >= 최대횟수 {
            제목 = "실패"
            메시지 = "정답 : " + String(컴퓨터가선택한값);

            let dialog = UIAlertController(title: 제목, message: 메시지, preferredStyle: UIAlertControllerStyle.Alert)

            let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default) { (acion) -> Void in print("OK 선택") }
            dialog.addAction(okAction)

            self.presentViewController(dialog, animated: true, completion: nil)
            
            초기화()
        }
    }
    
    @IBAction func button게임시작(sender: UIButton) {
        게임시작()
    }
    
    @IBAction func segment게임모드변경(sender: UISegmentedControl) {
        초기화()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        초기화()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

