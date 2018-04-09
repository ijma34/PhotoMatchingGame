//
//  AuthAns.swift
//  PhotoMatchApp
//
//  Created by Masashi Kudo on 2018/03/27.
//  Copyright © 2018年 Masashi Kudo. All rights reserved.
//


import UIKit

class AuthAns: UIViewController {
    
    /* ストーリーボードの紐付け */
    @IBOutlet weak var ans: UILabel!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var finishButton: UIButton!
    
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
        //圧力ジェスチャー認識機構
        let forceTouchRecognizer = ForceTouchGestureRecognizer()
        //viewにジェスチャーを実装
        view.addGestureRecognizer(forceTouchRecognizer)
        // ボタンの動作を定義
        let tapNextGesture = UITapGestureRecognizer(target: self, action: #selector(tapNextHandler(_:)))
        let tapFinishGesture = UITapGestureRecognizer(target: self, action: #selector(tapFinishHandler(_:)))
        nextButton.addGestureRecognizer(tapNextGesture)
        finishButton.addGestureRecognizer(tapFinishGesture)
    }
    
    /* 次へボタンをタップした時の動作 */
    @objc func tapNextHandler (_ sender: UITapGestureRecognizer) {
        print("次へ")
        flag = false
        performSegue(withIdentifier: "toAuthVC", sender: nil)
    }
    
    /* 終了ボタンをタップした時の動作 */
    @objc func tapFinishHandler (_ sender: UITapGestureRecognizer) {
        print("タイトルへ")
        flag = false
        performSegue(withIdentifier: "toTitleVC", sender: nil)
    }
    
    /*Segue準備*/
    override func prepare(for segue: UIStoryboardSegue, sender: Any!) {
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
