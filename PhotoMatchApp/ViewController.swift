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
// ・レイアウト問題 0328_ok
// ・コレクションビュー問題 0328_ok
// ・戻る遷移で情報の保持
// ・画面遷移の動作完了 0327_ok
// ・画像回転の調整
// ・ボタンにハンドラーを実装して画面遷移 0401_ok
// ・画像リストタップにハンドラーを実装
// ・スクロールで、指を離した瞬間の制御の移行先を特定する 0404_ok


import UIKit

class ViewController: UIViewController {

    /* ストーリーボードとの紐付け */
    @IBOutlet weak var authButton: UIButton!
    @IBOutlet weak var regButton: UIButton!
    @IBOutlet weak var titleImage1: UIImageView!
    @IBOutlet weak var titleImage2: UIImageView!
    @IBOutlet weak var titleImage3: UIImageView!
    
    /* 変数群 */
    var titleImageNum1: Int!
    var titleImageNum2: Int!
    var titleImageNum3: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        // ボタンの動作を定義
        let tapAuthGesture = UITapGestureRecognizer(target: self, action: #selector(tapAuthHandler(_:)))
        let tapRegGesture = UITapGestureRecognizer(target: self, action: #selector(tapRegHandler(_:)))
        authButton.addGestureRecognizer(tapAuthGesture)
        regButton.addGestureRecognizer(tapRegGesture)
        
        // タイトル画像を設定
        setTitleImage()
        
        // タイトル画像のアニメーション
        if(titleFlag){
            imageAnimation()
        }
        
        titleFlag = false
        gameCount = 0
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /* タイトル画像を設定 */
    func setTitleImage(){
        titleImageNum1 = Int(arc4random_uniform(100))
        titleImageNum2 = Int(arc4random_uniform(100))
        titleImageNum3 = Int(arc4random_uniform(100))
        
        //タイトル画像を表示
        titleImage1.image = UIImage(named: imageNameArray[titleImageNum1])
        titleImage2.image = UIImage(named: imageNameArray[titleImageNum2])
        titleImage3.image = UIImage(named: imageNameArray[titleImageNum3])
    }
    
    /* タイトル画像のアニメーション */
    func imageAnimation(){
        let layer1: CALayer = titleImage1.layer
        let layer2: CALayer = titleImage2.layer
        let layer3: CALayer = titleImage3.layer
        let animation = CABasicAnimation(keyPath:"transform.rotation")
        animation.toValue = Double.pi / 2.0
        animation.duration = 1.0            // 0.5秒で90度回転
        animation.repeatCount = MAXFLOAT    // 無限に回転
        animation.isCumulative = true;      // 効果を累積
        layer1.add(animation, forKey: "ImageViewRotation")
        layer2.add(animation, forKey: "ImageViewRotation")
        layer3.add(animation, forKey: "ImageViewRotation")
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

