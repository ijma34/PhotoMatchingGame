//
//  Auth.swift
//  PhotoMatchApp
//
//  Created by Masashi Kudo on 2018/03/27.
//  Copyright © 2018年 Masashi Kudo. All rights reserved.
//

import UIKit
import CoreMotion

class Auth: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    /* ストーリーボードとの紐付け */
    @IBOutlet weak var targetImage: UIImageView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    /* ローカル変数、定数などの準備 */
    var previewInteraction: UIPreviewInteraction!
    var targetImageNum: Int!        //ターゲット画像のインデックス番号
    var judge: Bool!                //選択画像の正誤判定
    var selectedImage: UIImage?     //タップで選択した画像
    var unwindFlag: Bool = false    //戻る遷移のフラグ、Checkから戻ってきた時にtrue
    
    /* 以下メインプログラム */
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        
        // 圧力ジェスチャー認識機構
        let forceTouchRecognizer = ForceTouchGestureRecognizer()
        
        // collectionviewとviewにジェスチャーを実装
        collectionView.addGestureRecognizer(forceTouchRecognizer)
        view.addGestureRecognizer(forceTouchRecognizer)
        
        // チェック画面から戻ってきた場合
        if(!unwindFlag){
            // 画像を100回シャッフル
            for _ in 1...100 {
                Common.shuffleImage()
            }
            gameCount += 1  // ゲームカウントを加算
        }
        setTarget()         // ターゲット画像を設定
        unwindFlag = false  // 戻る遷移のフラグを戻す
    }
    
    /* コレクションビュー上でドラッグ開始 */
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        dragFlag = true     //ドラッグ開始
        
        //カウントの引き継ぎ
        if(!strokeFlag){
            moveCount = touchX.data.count-1
            strokeFlag = true
        }
        moveCount += 1      // カウントの加算
        
        //タッチ情報と時間情報を追加
        let loc = (strokeTouch)!.location(in: view)
        let dragForce = (strokeTouch?.force)! / maximumForce!

        touchX.data.append(loc.x)
        touchY.data.append(loc.y)
        touchF.data.append(dragForce)
        touchTime.append(Common.nowTime())
        print("wbd: \(moveCount)")
    }
    
    
    /* コレクションビュー上でドラッグ中 */
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if(dragFlag){
            moveCount += 1
            
            //タッチ情報と時間情報を追加
            let loc = (strokeTouch)!.location(in: view)
            let dragForce = (strokeTouch?.force)! / maximumForce!

            touchX.data.append(loc.x)
            touchY.data.append(loc.y)
            touchF.data.append(dragForce)
            touchTime.append(Common.nowTime())
            print("ds: \(moveCount)")
        }
    }
    
    /* コレクションビュー上でドラッグ終了 */
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
        moveCount += 1
        print("de: \(moveCount)")
        dragFlag = false            //ドラッグ終了
        
        //タッチ情報と時間情報を追加
        let loc = strokeTouch!.location(in: view)
        let dragForce = (strokeTouch?.force)! / maximumForce!
        
        touchX.data.append(loc.x)
        touchY.data.append(loc.y)
        touchF.data.append(dragForce)
        touchTime.append(Common.nowTime())
//        Common.checkValue()
        
        Common.touchDataProcessing()    //タッチ情報の処理
//        LogWrite.touchWrite()           //ログの書き込み
        
        //カウントのリセット
        Common.arrayRemove()
        Common.resetValue()
        
        //ストロークインターバルの開始時間を記録
        interStrokeStart = Common.nowTime()
    }
    
    /* ターゲット画像を設定 */
    func setTarget(){
        if(!unwindFlag){
            targetImageNum = Int(arc4random_uniform(100))                       // 乱数生成
        }
        targetImage.image = UIImage(named: imageNameArray[targetImageNum])      // ターゲットの画像を表示
    }
    
    /* １つのセクションに含まれているセルの数を返すメソッド */
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageNameArray.count     // 写真データの個数を返す
    }

    /* 対象のインデックスに対応するUICollectionViewCellインスタンスを返す */
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // Identifierに対応するUICollectionViewCellインスタンスを取得（この場合は"AuthImageCell"）
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AuthImageCell", for: indexPath)

        let imageView = cell.viewWithTag(1) as! UIImageView
        imageView.image = UIImage(named: imageNameArray[indexPath.item])

        return cell
    }

    /* セルが選択された場合 */
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.collectionView.delaysContentTouches = false
        // タップで選択した画像をindexPath情報から探す
        selectedImage = UIImage(named: imageNameArray[indexPath.item])

        // 正解画像かをジャッジしておく
        if indexPath.item == targetImageNum {
            judge = true
        } else {
            judge = false
        }

        if selectedImage != nil {
            // toAuthCheckVCへ遷移するためにSegueを呼び出す
            performSegue(withIdentifier: "toAuthCheckVC", sender: nil)
        }
    }

    /* Segue準備 */
    override func prepare(for segue: UIStoryboardSegue, sender: Any!) {
        if(segue.identifier == "toAuthCheckVC"){
            let AuthCheckVC: AuthCheck = (segue.destination as? AuthCheck)!
            // 選択画像を遷移先の画面に表示
            AuthCheckVC.Img = selectedImage
            // 正解不正解の情報を伝える
            AuthCheckVC.correct = judge
            // 正解画像の番号を伝える
            AuthCheckVC.targetImageNum = targetImageNum
        }
    }

    /* 対象のインデックス番号に対応するセルの大きさを返す */
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // 横２列のタイルを表示（stroke）
        let width = collectionView.bounds.size.width / 2
        return CGSize(width: width, height: width)
    }

    /* 横のマージンの値を返す */
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }

    /* 縦のマージンの値を返す */
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
