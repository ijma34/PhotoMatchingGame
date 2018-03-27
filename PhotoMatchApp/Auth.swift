//
//  Auth.swift
//  PhotoMatchApp
//
//  Created by Masashi Kudo on 2018/03/27.
//  Copyright © 2018年 Masashi Kudo. All rights reserved.
//

import UIKit

class Auth: UIViewController {
    /* ストーリーボードとの紐付け */
    @IBOutlet weak var targetImage: UIImageView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    /* 変数、定数などの準備 */
    var targetImageNum: Int!        //ターゲット画像のインデックス番号
    var judge: Bool!                //選択画像の正誤判定
    var selectedImage: UIImage?     //タップで選択した画像
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //画像を100回シャッフル
        for _ in 1...100 {
            Common.shuffleImage()
        }
        
        //ターゲット画像を設定
        setTarget()
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
