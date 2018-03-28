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
    
    /*表示画像をシャッフルする関数*/
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
    
    
}
