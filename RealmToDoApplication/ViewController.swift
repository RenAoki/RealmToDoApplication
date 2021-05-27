//
//  ViewController.swift
//  RealmToDoApplication
//
//  Created by 青木蓮 on 2021/05/27.
//

import UIKit
import RealmSwift

class ViewController: UIViewController, UITextFieldDelegate {
    
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var table: UITableView!
    
    var itemList: Results<TodoModel>!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let RealmList = try! Realm()
        
        self.itemList = RealmList.objects(TodoModel.self)
    }

    
    @IBAction func add(_ sender: Any) {
        let AddTodoModel:TodoModel = TodoModel()
        
        AddTodoModel.koumoku = self.textField.text
        
        let RealmList2 = try! Realm()
        
        try! RealmList2.write{
            RealmList2.add(AddTodoModel)
        }
        
        self.table.reloadData()
        
    }
    

}


extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.itemList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "TestCell", for: indexPath)
        
        let item: TodoModel = self.itemList[(indexPath as NSIndexPath).row];
        
        cell.textLabel?.text = item.koumoku
        
        return cell
    }
    
}
