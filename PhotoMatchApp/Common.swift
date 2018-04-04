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

var flag: Bool = true
var titleFlag: Bool = true
var gameCount: Int = 0

// タッチデータ収集用
var strokeTouch: UITouch? = nil     //ストローク中のタッチ情報を格納
var maximumForce: CGFloat? = nil    //圧力値の最大値を格納
var moveCount: Int = 0
var strokeFlag: Bool = false        //タップとドラッグの切り替え
var dragFlag: Bool = false          //ドラッグ終了のフラグ

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
    
    /* 現在時間を返す関数 */
    class func nowTime() -> Double{
        return NSDate().timeIntervalSince1970
    }
    
    /* 時間の差を返す関数（t1:begin < t2:end） */
    class func differenceTime(t1: Double, t2: Double) -> Double {
        return (t2 - t1)
    }
    
    /* 値をリセットする関数 */
    class func resetValue(){
        sCount = 0
//        dragCount = 0
//        tapOrStroke = 1
//        strokePartDistance = 0
//        strokeDistance = 0
//        lineDistance = 0
//        strokeAverage = 0
//        stroke20 = 0
//        stroke50 = 0
//        stroke80 = 0
//        strokeAngle = 0
//        strokeTime = 0
//        strokeRatio = 0
        interStrokeStart = 0.0
        interStrokeEnd = 0.0
        interStrokeTime = 0.0
        //1019 add
//        maxForce = 0
//        sumForce = 0
//        aveForce = 0
    }
    
    /* 配列をリセットする関数 */
    class func arrayRemove () {
        touchF.data.removeAll()
        touchX.data.removeAll()
        touchY.data.removeAll()
        touchTime.removeAll()
    }
    
    
}
