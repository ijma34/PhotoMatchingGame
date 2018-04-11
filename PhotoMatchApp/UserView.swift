//
//  UserView.swift
//  PhotoMatchApp
//
//  Created by Masashi Kudo on 2018/04/10.
//  Copyright © 2018年 Masashi Kudo. All rights reserved.
//
// ameblo.jp/highcommunicate/entry-12059919502.html

import UIKit

/* ユーザー情報に関する構造体 */
struct UserInfo {
    var name: String
    var fileName: String
}

class UserView: UIViewController, UITableViewDataSource, UITableViewDelegate {

    /* 変数、定数などの準備 */
    var myItems: [String] = ["user_1", "user_2", "user_3","addCell"]
    var editFlag: Bool = false
    
    /* ストーリーボードの紐付け */
    @IBOutlet weak var tableView: UITableView!
    // セルに新しいデータを追加
//    @IBAction func addUser(_ sender: Any) {
//        // myItemsに追加.
//        myItems.add("タイトルNEW")
//        // TableViewを再読み込み.
//        tableView.reloadData()
//    }
    
    @IBAction func addAction(_ sender: Any) {
        let insertNum: Int = myItems.count
        // myItemsに追加.
        myItems.insert("user_new", at: insertNum - 1)
        // TableViewを再読み込み.
        tableView.reloadData()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    // セルの編集状態を変更
    @IBAction func editUser(_ sender: Any) {
        if isEditing {
            super.setEditing(false, animated: true)
            tableView.setEditing(false, animated: true)
        } else {
            super.setEditing(true, animated: true)
            tableView.setEditing(true, animated: true)
        }
        
        // セルを編集前に"addCell"を退避、編集後に再表示
        if(!editFlag){
            editFlag = true
            myItems.removeLast()
        } else {
            myItems.append("addCell")
            editFlag = false
        }
        tableView.reloadData()
    }
    
    // セルの行数
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myItems.count
    }
    
    // セルの設定
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if(myItems[indexPath.row] == "addCell"){
            // セルを取得する
            let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "AddCell", for: indexPath)
            // セルに表示する値を設定する
            return cell
        } else {
            // セルを取得する
            let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "NameCell", for: indexPath)
            // セルに表示する値を設定する
            cell.textLabel!.text = myItems[indexPath.row]
            return cell
            
        }
    }
    
    // セルを追加or削除しようとした場合
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        // 削除のとき.
        if editingStyle == UITableViewCellEditingStyle.delete {
            // 指定されたセルのオブジェクトをmyItemsから削除する.
            myItems.remove(at: indexPath.row)
            // TableViewを再読み込み.
            tableView.reloadData()
        }
    }
    
    // セルの並び替えを有効にする
    private func tableView(tableView: UITableView, moveRowAtIndexPath sourceIndexPath: IndexPath, toIndexPath destinationIndexPath: IndexPath) {
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
