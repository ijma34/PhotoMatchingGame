//
//  ForceGesture.swift
//  PhotoMatchApp
//
//  Created by Masashi Kudo on 2018/04/03.
//  Copyright © 2018年 Masashi Kudo. All rights reserved.
//
//  タッチジェスチャーを監視するジェスチャー認識機構のファイル

import UIKit
import UIKit.UIGestureRecognizerSubclass

class ForceTouchGestureRecognizer: UIGestureRecognizer {
    var force: CGFloat = 0
    var point: CGPoint?
    var point1 = CGPoint(x: 0, y: 0)
    var point2 = CGPoint(x: 0, y: 0)
    
    /*タッチ開始*/
    override public func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent) {
        super.touchesBegan(touches, with: event)
        
        //タッチ情報をグローバル変数に代入
        strokeTouch = touches.first
        maximumForce = strokeTouch?.maximumPossibleForce
        //        print(maximumForce)
        
        //タッチインターバルの終了時間を記録
        interStrokeEnd = Common.nowTime()

        //タッチインターバルを記録
        if(interStrokeStart > 0.0){
            //正常
            interStrokeTime = Common.differenceTime(t1: interStrokeStart, t2: interStrokeEnd)
        } else if(interStrokeStart > -1.5){
            //異常
            interStrokeTime = -1.0
        } else {
            //初回
            interStrokeTime = 0.0
        }
        //        print("interval: \(interStrokeTime)")

        //一応タッチ情報を初期化
        Common.arrayRemove()
        moveCount = 0
        
        if let touch = touches.first {
            let loc = touch.location(in: view)
            //            force = touch.force
            force = touch.force / maximumForce!
            point = loc
            touchF.data.append(force)
            touchX.data.append((point?.x)!)
            touchY.data.append((point?.y)!)
            touchTime.append(Common.nowTime())
            
            sCount = touchF.data.count
            
            strokeFlag = false
            print("begin")
        }
    }
    
    /*タッチ中*/
    override public func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent) {
        super.touchesMoved(touches, with: event)
        
        if let touch = touches.first {
            let loc = touch.location(in: view)
            //            force = touch.force
            force = touch.force / maximumForce!
            point = loc
            touchF.data.append(force)
            touchX.data.append((point?.x)!)
            touchY.data.append((point?.y)!)
            touchTime.append(Common.nowTime())
            
            sCount100 = touchF.data.count
            moveCount += 1
            print(moveCount)
        }
    }
    
    /*タッチ終了*/
    override public func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent) {
        super.touchesEnded(touches, with: event)
        
        if let touch = touches.first {
            //            Common.endTime()
            
            let loc = touch.location(in: view)
            //            force = touch.force
            force = touch.force / maximumForce!
            point = loc
            touchF.data.append(force)
            touchX.data.append((point?.x)!)
            touchY.data.append((point?.y)!)
            touchTime.append(Common.nowTime())
            
            sCount = touchF.data.count
            
            print("end")
        }
        
        if self.state == .possible {
            
//            //タッチ情報の処理
//            Common.touchDataProcessing()
//
//            //ログの書き込み
//            LogWrite.touchWrite()
//
//            //カウントのリセット
//            Common.arrayRemove()
//            Common.resetValue()
//
//            //ストロークインターバルの開始時間を記録
//            interStrokeStart = Common.nowTime()
        }
    }
    
    override public func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent) {
        super.touchesCancelled(touches, with: event)
        
        //カウントのリセット
        Common.arrayRemove()
        Common.resetValue()
        
        //タッチインターバルは記録しない
        interStrokeStart = -1.0
        
        //        print("cancel")
    }
    
}

