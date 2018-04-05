//
//  RegCheck.swift
//  PhotoMatchApp
//
//  Created by Masashi Kudo on 2018/03/27.
//  Copyright © 2018年 Masashi Kudo. All rights reserved.
//

import UIKit

class RegCheck: UIViewController {
    
    /* ストーリーボードの紐付け */
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var OKButton: UIButton!
    @IBOutlet weak var BackButton: UIButton!
    
    /* 変数、定数などの準備 */
    var Img: UIImage!   //選択画像
    var correct: Bool!  //選択画像の正誤情報
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 前画面で選択された画像を表示
        imageView.image = Img
        //アスペクト比を揃える
        imageView.contentMode = UIViewContentMode.scaleAspectFit
        //圧力ジェスチャー認識機構
        let forceTouchRecognizer = ForceTouchGestureRecognizer()
        //viewにジェスチャーを実装
        view.addGestureRecognizer(forceTouchRecognizer)
        
        // ボタンの動作を定義
        let tapOkGesture = UITapGestureRecognizer(target: self, action: #selector(tapOkHandler(_:)))
        let tapBackGesture = UITapGestureRecognizer(target: self, action: #selector(tapBackHandler(_:)))
        OKButton.addGestureRecognizer(tapOkGesture)
        BackButton.addGestureRecognizer(tapBackGesture)
    }
    
    /* 決定ボタンをタップした時の動作 */
    @objc func tapOkHandler(_ sender: UITapGestureRecognizer) {
        print("決定")
        performSegue(withIdentifier: "toRegAnsVC", sender: nil)   // 次の画面へ
    }
    
    /* 戻るボタンをタップした時の動作 */
    @objc func tapBackHandler(_ sender: UITapGestureRecognizer) {
        print("戻る")
        self.dismiss(animated: false, completion: nil)   // 前画面へ
    }
    
    /* Segue準備 */
    override func prepare(for segue: UIStoryboardSegue, sender: Any!) {
        if(segue.identifier == "toRegAnsVC"){
            let RegAnsVC: RegAns = (segue.destination as? RegAns)!
            RegAnsVC.correct = correct    // 正解不正解の情報を伝える
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

