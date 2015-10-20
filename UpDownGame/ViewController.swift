//
//  ViewController.swift
//  UpDownGame
//
//  Created by sdt5 on 2015. 10. 20..
//  Copyright © 2015년 all4web. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let 최대횟수 = 5
    var 시도횟수 = 0
    var 컴퓨터가선택한값 = 0
    var 성공 = false
    
    @IBOutlet weak var label메시지: UILabel!
    @IBOutlet weak var segment게임선택: UISegmentedControl!
    @IBOutlet weak var progress도전횟수: UIProgressView!
    @IBOutlet weak var label도전횟수: UILabel!
    @IBOutlet weak var text사용자입력: UITextField!

    func 초기화() {
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
        
        시도횟수 = 0
        label도전횟수.text = String(시도횟수) + "/" + String(최대횟수)
        text사용자입력.text = ""
        progress도전횟수.progress = 0.0
        
        print("컴퓨터가선택한값 : \(컴퓨터가선택한값)")
    }

    @IBAction func button확인(sender: UIButton) {
        var 사용자입력 : String = text사용자입력.text!
        var 제목 : String = ""
        var 메시지 : String = ""
        
        사용자입력 = 사용자입력.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())

        if 사용자입력 == "" {
            label메시지.text = "값을 입력하지 않았습니다."
            return
        }
        
        let 사용자입력숫자 = Int(사용자입력)
        
        if 컴퓨터가선택한값 == 사용자입력숫자 {
            성공 = true
        } else if 컴퓨터가선택한값 > 사용자입력숫자 {
            메시지 = "컴퓨터 숫자보다 작은 값을 입력했습니다."
            label메시지.text = 메시지
            text사용자입력.text = ""
        } else {
            메시지 = "컴퓨터 숫자보다 큰 값을 입력했습니다."
            label메시지.text = 메시지
            text사용자입력.text = ""
        }
        
        시도횟수++;
        label도전횟수.text = String(시도횟수) + "/" + String(최대횟수)
        progress도전횟수.progress = Float(시도횟수) / Float(최대횟수)

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
//            let cancelAction = UIAlertAction(title: "취소", style: UIAlertActionStyle.Cancel) { (acion) -> Void in print("취소 선택") }
//            dialog.addAction(cancelAction)

            let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default) { (acion) -> Void in print("OK 선택") }
            dialog.addAction(okAction)

            self.presentViewController(dialog, animated: true, completion: nil)
            
            초기화()
        }
    }
    
    @IBAction func segment게임모드변경(sender: UISegmentedControl) {
        초기화()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
//        label메시지.text = "1부터 10사이의 값을 입력해주세요."
//        
//        컴퓨터가선택한값 = (Int)(arc4random() % 5) + 1;
//        label도전횟수.text = String(시도횟수) + "/" + String(최대횟수)
//        progress도전횟수.progress = 0.0
//
//        print("컴퓨터가선택한값 : \(컴퓨터가선택한값)")
        초기화()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

