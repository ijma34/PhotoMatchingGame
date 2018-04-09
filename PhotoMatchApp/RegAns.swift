//
//  RegAns.swift
//  PhotoMatchApp
//
//  Created by Masashi Kudo on 2018/03/28.
//  Copyright © 2018年 Masashi Kudo. All rights reserved.
//

import UIKit

class RegAns: UIViewController {
    
    /* ストーリーボードの紐付け */
    @IBOutlet weak var ans: UILabel!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var retirementButton: UIButton!
    
    /* 変数、定数などの準備 */
    var correct: Bool!  // 選択画像の正誤情報
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 正誤の表示
        if correct {
            ans.text = "correct!"
            ans.textColor = UIColor.magenta
        } else {
            ans.text = "incorrect!"
            ans.textColor = UIColor.red
        }
        // 圧力ジェスチャー認識機構
        let forceTouchRecognizer = ForceTouchGestureRecognizer()
        // viewにジェスチャーを実装
        view.addGestureRecognizer(forceTouchRecognizer)
        // ボタンの動作を定義
        let tapNextGesture = UITapGestureRecognizer(target: self, action: #selector(tapNextHandler(_:)))
        let tapRetirementGesture = UITapGestureRecognizer(target: self, action: #selector(tapRetirementHandler(_:)))
        nextButton.addGestureRecognizer(tapNextGesture)
        retirementButton.addGestureRecognizer(tapRetirementGesture)
        
    }
    
    /* 次へボタンをタップした時の動作 */
    @objc func tapNextHandler (_ sender: UITapGestureRecognizer) {
        print("次へ")
        flag = false
        performSegue(withIdentifier: "toRegVC", sender: nil)
    }
    
    /* 中断ボタンをタップした時の動作 */
    @objc func tapRetirementHandler (_ sender: UITapGestureRecognizer) {
        print("タイトルへ")
        flag = false
        performSegue(withIdentifier: "toTitleRegVC", sender: nil)
    }
    
    /*Segue準備*/
    override func prepare(for segue: UIStoryboardSegue, sender: Any!) {
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
