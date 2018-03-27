//
//  ViewController.swift
//  PhotoMatchApp
//
//  Created by Masashi Kudo on 2018/03/26.
//  Copyright © 2018年 Masashi Kudo. All rights reserved.
//
// タイトル画面に関するプログラム
//
// todo
// ・タッチ情報の取得
// 0327 画面遷移の動作完了


import UIKit

class ViewController: UIViewController {

    /* ストーリーボードとの紐付け */
    @IBOutlet weak var authButton: UIButton!
    @IBOutlet weak var regButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let tapAuthGesture = UITapGestureRecognizer(target: self, action: #selector(tapAuthHandler(_:)))
        let tapRegGesture = UITapGestureRecognizer(target: self, action: #selector(tapRegHandler(_:)))
        
        authButton.addGestureRecognizer(tapAuthGesture)
        regButton.addGestureRecognizer(tapRegGesture)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /* ゲーム開始ボタンを押した時の動作 */
    @objc func tapAuthHandler(_ sender: UITapGestureRecognizer){
        print("ゲーム開始")
        performSegue(withIdentifier: "toAuthVC", sender: nil)
    }
    
    /* 本人登録ボタンを押したときの動作 */
    @objc func tapRegHandler(_ sender: UITapGestureRecognizer){
        print("本人登録")
        performSegue(withIdentifier: "toRegVC", sender: nil)
    }
    
    /* segue準備 */
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       
    }


}

