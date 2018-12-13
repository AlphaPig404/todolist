//
//  ViewController.swift
//  todolist
//
//  Created by Chris on 2018/12/9.
//  Copyright © 2018年 Chris. All rights reserved.
//

import UIKit

var todos: [TodoModel] = []

func dateFromString(dateString: String) -> NSDate?{
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-mm-dd"
    let date = dateFormatter.date(from: dateString)
    return date as NSDate?
}

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        todos = [
            TodoModel(id:"1", image:"child-selected",title: "去游乐场", date: dateFromString(dateString: "2018-05-06")!),
            TodoModel(id:"2", image:"phone-selected",title: "打电话", date: dateFromString(dateString: "2018-05-07")!),
            TodoModel(id:"3", image:"shopping-cart-selected",title: "购物", date: dateFromString(dateString: "2018-05-08")!),
            TodoModel(id:"4", image:"travel-selected",title: "旅游", date: dateFromString(dateString: "2018-05-09")!)
        ]
        
        navigationItem.leftBarButtonItem = editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return todos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let ceil = self.tableView.dequeueReusableCell(withIdentifier: "todoCeil")
        
        let todo = todos[indexPath.row] as TodoModel
        
        let image = ceil?.viewWithTag(1) as! UIImageView
        let title = ceil?.viewWithTag(2) as! UILabel
        let date = ceil?.viewWithTag(3) as! UILabel
        
        image.image = UIImage(named: todo.image)
        title.text = todo.title
        
        let locale = NSLocale.current
        let dateFormat = DateFormatter.dateFormat(fromTemplate: "yyyy-mm-dd", options: 0, locale: locale)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat
        
        date.text = dateFormatter.string(from: todo.date as Date)
        
        return ceil!
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath){
        if(editingStyle == UITableViewCell.EditingStyle.delete){
            todos.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
        }
    }
    
    // Edit Mode
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        self.tableView.setEditing(editing, animated: animated)
    }
    
    @IBAction func close(segue: UIStoryboardSegue){
        tableView.reloadData()
    }
    
    // navigate
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        if(segue.identifier == "EditTodo"){
            let vc = segue.destination as! DetailViewController
            let indexPath = tableView.indexPathForSelectedRow
            if let index = indexPath{
                vc.todo = todos[index.row]
            }
        }
    }

    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool{
        return tableView.isEditing
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath){
        let todo = todos[sourceIndexPath.row]
        todos.remove(at: sourceIndexPath.row)
        todos.insert(todo, at: destinationIndexPath.row)
    }

}

