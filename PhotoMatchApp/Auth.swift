//
//  Auth.swift
//  PhotoMatchApp
//
//  Created by Masashi Kudo on 2018/03/27.
//  Copyright © 2018年 Masashi Kudo. All rights reserved.
//

import UIKit
import CoreMotion

class Auth: UIViewController {
    /* ストーリーボードとの紐付け */
    @IBOutlet weak var targetImage: UIImageView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    /* 変数、定数などの準備 */
    var previewInteraction: UIPreviewInteraction!
    var targetImageNum: Int!        //ターゲット画像のインデックス番号
    var judge: Bool!                //選択画像の正誤判定
    var selectedImage: UIImage?     //タップで選択した画像
    
    
    /* 以下メインプログラム */
    override func viewDidLoad() {
        super.viewDidLoad()
//        collectionView.delegate = self
//        collectionView.dataSource = self
//
//        self.collectionView.isUserInteractionEnabled = true
//        self.view.isUserInteractionEnabled = true

        // 画像を100回シャッフル
        for _ in 1...100 {
            Common.shuffleImage()
        }
        // ターゲット画像を設定
        setTarget()
    }
    
    /* ターゲット画像を設定 */
    func setTarget(){
        targetImageNum = Int(arc4random_uniform(100))                           // 乱数生成
        targetImage.image = UIImage(named: imageNameArray[targetImageNum])      // ターゲットの画像を表示
    }
//
//    /* タップジェスチャー */
//    @IBAction func tapHandler(_ sender: UITapGestureRecognizer) {
//        //collectionviewでの座標
//        let collectionLocation = sender.location(in: collectionView)
//
//        //collectionview座標からインデックスパスを入手し、インデックスパスに対応するセルを選択
//        if let indexPath = collectionView.indexPathForItem(at: collectionLocation) {
//            //画面のタッチ操作を一時停止
//            self.collectionView.isUserInteractionEnabled = false
//            self.view.isUserInteractionEnabled = false
//
//            //選択されたセル
//            collectionView(collectionView, didSelectItemAt: indexPath)
//
//            //画面のタッチ操作を再開
//            self.collectionView.isUserInteractionEnabled = true
//            self.view.isUserInteractionEnabled = true
//        }
//    }
//
//    /* １つのセクションに含まれているセルの数を返すメソッド */
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return imageNameArray.count     // 写真データの個数を返す
//    }
//
//    /* 対象のインデックスに対応するUICollectionViewCellインスタンスを返す */
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        //Identifierに対応するUICollectionViewCellインスタンスを取得（この場合は"ImageCell"）
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCell", for: indexPath)
//
//        let imageView = cell.viewWithTag(1) as! UIImageView
//        imageView.image = UIImage(named: imageNameArray[indexPath.item])
//
//        return cell
//    }
//
//    /* セルが選択された場合 */
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        self.collectionView.delaysContentTouches = false
//        // タップで選択した画像をindexPath情報から探す
//        selectedImage = UIImage(named: imageNameArray[indexPath.item])
//
//        // 正解画像かをジャッジしておく
//        if indexPath.item == targetImageNum {
//            judge = true
//        } else {
//            judge = false
//        }
//
//        if selectedImage != nil {
//            // toAuthCheckVCへ遷移するためにSegueを呼び出す
//            performSegue(withIdentifier: "toAuthCheckVC", sender: nil)
//        }
//    }
//
//    /* Segue準備 */
//    override func prepare(for segue: UIStoryboardSegue, sender: Any!) {
//        if(segue.identifier == "toAuthCheckVC"){
//            let AuthCheckVC: AuthCheck = (segue.destination as? AuthCheck)!
//            // 選択画像を遷移先の画面に表示
//            AuthCheckVC.Img = selectedImage
//            // 正解不正解の情報を伝える
//            AuthCheckVC.correct = judge
//        }
//    }
//
//    /* 対象のインデックス番号に対応するセルの大きさを返す */
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        // 横２列のタイルを表示（stroke）
//        let width = collectionView.bounds.size.width / 2
//        return CGSize(width: width, height: width)
//    }
//
//    /* 横のマージンの値を返す */
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//        return 0.0
//    }
//
//    /* 縦のマージンの値を返す */
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        return 0.0
//    }
//

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
