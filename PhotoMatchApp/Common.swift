//
//  Common.swift
//  PhotoMatchApp
//
//  Created by Masashi Kudo on 2018/03/27.
//  Copyright © 2018年 Masashi Kudo. All rights reserved.
//
// グローバルな変数、関数を定義するファイル

import UIKit

/* グローバルな変数群 */
var tapCount: Int = 0           //タップの回数
var strokeCount: Int = 0        //ストロークの回数
var gestureCount: Int = 0       //ジェスチャーの総数
var elapsed: Double = 0.0       //時間の差
var tapOrStroke: Int = 1        //タップ（０）かストローク（１）か



var flag: Bool = true
var titleFlag: Bool = true
var gameCount: Int = 0              //マッチングゲーム試行回数

// タッチデータ収集用
var strokeTouch: UITouch? = nil     //ストローク中のタッチ情報を格納
var maximumForce: CGFloat? = nil    //圧力値の最大値を格納
var moveCount: Int = 0              //ストローク中にデータを取得した回数
var strokeFlag: Bool = false        //タップとドラッグの切り替え
var dragFlag: Bool = false          //ドラッグ終了のフラグ

var strokePartDistance: CGFloat = 0 //ストローク距離
var strokeDistance: CGFloat = 0     //ストローク総距離
var lineDistance: CGFloat = 0       //ストローク直線距離
var strokeAverage: CGFloat = 0      //ストローク平均速度
var stroke20: CGFloat = 0           //ストローク20%地点の速度
var stroke50: CGFloat = 0           //ストローク50%地点の速度
var stroke80: CGFloat = 0           //ストローク80%地点の速度
var strokeAngle: CGFloat = 0        //ストロークの角度
var strokeTime: CGFloat = 0         //ストローク時間
var strokeRatio: CGFloat = 0        //ストローク軌道と直線距離の比率
var strokeDirection: CGFloat = 0    //ストロークの方向（0:tap, 1:stroke[↑], 2:stroke[↓]）
var maxForce: CGFloat = 0           //１ストロークでの圧力最大値
var sumForce:CGFloat = 0            //１ストロークでの圧力合計値
var aveForce: CGFloat = 0           //１ストロークでの圧力平均値

//スクロール間のインターバルに関する変数
//初期値は-10.0、タッチキャンセルなどの異常があった場合は-1.0
var interStrokeStart: Double = -10.0    //ストローク間のインターバル開始時間
var interStrokeEnd: Double = -10.0      //ストローク間のインターバル終了時間
var interStrokeTime: Double = -10.0     //ストローク間のインターバル時間

//タッチ情報を保持する構造体
struct touchValues {
    var data = [CGFloat]()  //データを格納する配列
    var start: CGFloat = 0  //開始地点データ
    var t20: CGFloat = 0    //20%地点データ
    var t50: CGFloat = 0    //50%地点データ
    var t80: CGFloat = 0    //80%地点データ
    var end: CGFloat = 0    //終了地点データ
}

//タッチ情報を格納
var touchF = touchValues()  //圧力の情報を保持
var touchX = touchValues()  //x座標の情報を保持
var touchY = touchValues()  //y座標の情報を保持
var touchTime = [Double]()  //時間情報を保持

//配列の位置を格納
var sCount: Int = 0     //1ストロークの要素数
var sCount0: Int = 0    //0%地点
var sCount20: Int = 0   //20%地点
var sCount50: Int = 0   //50%地点
var sCount80: Int = 0   //80%地点
var sCount100: Int = 0  //100%地点

// 100枚の画像の名前の配列
var imageNameArray: [String] = [
    "match1", "match2", "match3", "match4", "match5",
    "match6", "match7", "match8", "match9", "match10",
    "match11", "match12", "match13", "match14", "match15",
    "match16", "match17", "match18", "match19", "match20",
    "match21", "match22", "match23", "match24", "match25",
    "match26", "match27", "match28", "match29", "match30",
    "match31", "match32", "match33", "match34", "match35",
    "match36", "match37", "match38", "match39", "match40",
    "match41", "match42", "match43", "match44", "match45",
    "match46", "match47", "match48", "match49", "match50",
    "match51", "match52", "match53", "match54", "match55",
    "match56", "match57", "match58", "match59", "match60",
    "match61", "match62", "match63", "match64", "match65",
    "match66", "match67", "match68", "match69", "match70",
    "match71", "match72", "match73", "match74", "match75",
    "match76", "match77", "match78", "match79", "match80",
    "match81", "match82", "match83", "match84", "match85",
    "match86", "match87", "match88", "match89", "match90",
    "match91", "match92", "match93", "match94", "match95",
    "match96", "match97", "match98", "match99", "match100",
]


class Common: NSObject {
    
    /* 表示画像をシャッフルする関数 */
    class func shuffleImage(){
        var str: String? = nil
        var num1: Int
        var num2: Int
        
        num1 = Int(arc4random_uniform(100))
        num2 = Int(arc4random_uniform(100))
        
        str = imageNameArray[num1]
        
        imageNameArray[num1] = imageNameArray[num2]
        imageNameArray[num2] = str!
    }
    
    /* 2地点の距離を求める関数 */
    class func moveDistance (p1: CGPoint, p2: CGPoint) -> CGFloat {
        var distance: CGFloat = 0
        var distanceX: Double = 0
        var distanceY: Double = 0
        
        distanceX = fabs(Double(p1.x) - Double(p2.x))
        distanceY = fabs(Double(p1.y) - Double(p2.y))
        
        distance = CGFloat(sqrt((distanceX * distanceX)+(distanceY * distanceY)))
        
        return distance
    }
    
    /* 現在時間を返す関数 */
    class func nowTime() -> Double{
        return NSDate().timeIntervalSince1970
    }
    
    /* 時間の差を返す関数（t1:begin < t2:end） */
    class func differenceTime(t1: Double, t2: Double) -> Double {
        return (t2 - t1)
    }
    
    /* 2地点と時間から速度を返す関数 */
    class func strokeSpeed (p1: CGPoint, p2: CGPoint, t1: Double, t2: Double) -> CGFloat {
        var speed: CGFloat = 0
        
        let dis = moveDistance(p1: p1, p2: p2)
        let ela = differenceTime(t1: t1, t2: t2)
        
        speed = dis / CGFloat(ela)
        
        return speed
    }
    
    /* 2地点から角度を求める関数 */
    class func angle(p1:CGPoint, p2:CGPoint) -> CGFloat {
        var r = atan2(p2.x-p1.x, p2.y-p1.y) - (CGFloat.pi / 2)
        if (r<0) {
            r = r + 2 * CGFloat.pi
        }
        return floor(r * 360 / (2 * CGFloat.pi))
    }
    
    /* タッチ情報の処理を行う関数 */
    class func touchDataProcessing(){
        var point1 = CGPoint(x: 0, y: 0)
        var point2 = CGPoint(x: 0, y: 0)
        
        //ジェスチャー回数を1増やす
        gestureCount = gestureCount + 1
        
        /* データを格納 */
        sCount0 = 0
        sCount20 = Int(Double(touchX.data.count) * 0.2)
        sCount50 = Int(Double(touchX.data.count) * 0.5)
        sCount80 = Int(Double(touchX.data.count) * 0.8)
        sCount100 = touchX.data.count - 1
        
        touchF.start = touchF.data[sCount0]
        touchF.t20 = touchF.data[sCount20]
        touchF.t50 = touchF.data[sCount50]
        touchF.t80 = touchF.data[sCount80]
        touchF.end = touchF.data[sCount100]
        
//        touchF.start = touchF.data[sCount0 + 1]       //0だと反応できていない場合がある
//        touchF.t20 = touchF.data[sCount20]
//        touchF.t50 = touchF.data[sCount50]
//        touchF.t80 = touchF.data[sCount80]
//        touchF.end = touchF.data[sCount100]
        
        touchX.start = touchX.data[sCount0]
        touchX.t20 = touchX.data[sCount20]
        touchX.t50 = touchX.data[sCount50]
        touchX.t80 = touchX.data[sCount80]
        touchX.end = touchX.data[sCount100]
        
        touchY.start = touchY.data[sCount0]
        touchY.t20 = touchY.data[sCount20]
        touchY.t50 = touchY.data[sCount50]
        touchY.t80 = touchY.data[sCount80]
        touchY.end = touchY.data[sCount100]
        
        /* データを処理 */
        // ストローク時間
        strokeTime = CGFloat(Common.differenceTime(t1: touchTime[sCount0], t2: touchTime[sCount100]))
        
        /* 速度 */
        // 平均
        point1.x = touchX.start
        point1.y = touchY.start
        point2.x = touchX.end
        point2.y = touchY.end
        strokeAverage = Common.strokeSpeed(p1: point1, p2: point2, t1: touchTime[sCount0], t2: touchTime[sCount100])
        
        // 20%地点
        if(sCount20 > 0){
            point1.x = touchX.data[sCount20-1]
            point1.y = touchY.data[sCount20-1]
            point2.x = touchX.data[sCount20]
            point2.y = touchY.data[sCount20]
            stroke20 = Common.strokeSpeed(p1: point1, p2: point2, t1: touchTime[sCount20-1], t2: touchTime[sCount20])
        }
        
        // 50%地点
        if(sCount50 > 0){
            point1.x = touchX.data[sCount50-1]
            point1.y = touchY.data[sCount50-1]
            point2.x = touchX.data[sCount50]
            point2.y = touchY.data[sCount50]
            stroke50 = Common.strokeSpeed(p1: point1, p2: point2, t1: touchTime[sCount50-1], t2: touchTime[sCount50])
        }
        
        // 80%地点
        if(sCount80 > 0){
            point1.x = touchX.data[sCount80-1]
            point1.y = touchY.data[sCount80-1]
            point2.x = touchX.data[sCount80]
            point2.y = touchY.data[sCount80]
            stroke80 = Common.strokeSpeed(p1: point1, p2: point2, t1: touchTime[sCount80-1], t2: touchTime[sCount80])
        }
        
        // 速度平均が0.1未満ならタップ
        if(0.1 > strokeAverage){
            tapOrStroke = 0
            tapCount += 1
            strokeDirection = 0
            print("\(gestureCount)(\(tapCount)) tap")
        } else {
            tapOrStroke = 1
            strokeCount += 1
            strokeDirection = 1
            print("\(gestureCount)(\(strokeCount)) stroke")
        }
        
        /* ストローク軌道 */
        // 直線距離と角度
        point1.x = touchX.start
        point1.y = touchY.start
        point2.x = touchX.end
        point2.y = touchY.end
        lineDistance = Common.moveDistance(p1: point1, p2: point2)
        strokeAngle = Common.angle(p1: point1, p2: point2)
        
        // ストロークの方向が下向きの場合
        if(strokeAngle > 180){
            strokeDirection = 2
        }
        
        // 総距離
        for i in 0 ..< sCount100 {
            point1.x = touchX.data[i]
            point1.y = touchY.data[i]
            point2.x = touchX.data[i+1]
            point2.y = touchY.data[i+1]
            strokePartDistance = Common.moveDistance(p1: point1, p2: point2)
            strokeDistance += strokePartDistance
        }
        
        // ストロークの比（stroke/line）
        if(strokeDistance > 0.1) {
            strokeRatio = strokeDistance / lineDistance
        } else {
            strokeRatio = -1
        }
        
        /* 圧力値の最大と平均 */
        for i in 0 ... sCount100 {
            sumForce += touchF.data[i]
            if(touchF.data[i] > maxForce){
                maxForce = touchF.data[i]
            }
            if(i == (sCount100)){
                aveForce = sumForce / CGFloat(sCount100)
            }
        }
    }
    
    /* 値をリセットする関数 */
    class func resetValue(){
        sCount = 0
        moveCount = 0
        tapOrStroke = 1
        strokePartDistance = 0
        strokeDistance = 0
        lineDistance = 0
        strokeAverage = 0
        stroke20 = 0
        stroke50 = 0
        stroke80 = 0
        strokeAngle = 0
        strokeTime = 0
        strokeRatio = 0
        interStrokeStart = 0.0
        interStrokeEnd = 0.0
        interStrokeTime = 0.0
        maxForce = 0
        sumForce = 0
        aveForce = 0
    }
    
    /* 配列をリセットする関数 */
    class func arrayRemove () {
        touchF.data.removeAll()
        touchX.data.removeAll()
        touchY.data.removeAll()
        touchTime.removeAll()
    }
    
    class func checkValue(){
        //breakpointを入れる
        return
    }
}
