//
//  DetailViewController.swift
//  todolist
//
//  Created by Chris on 2018/12/9.
//  Copyright © 2018年 Chris. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var childButton: UIButton!
    @IBOutlet weak var phoneButton: UIButton!
    @IBOutlet weak var shoppingCarButton: UIButton!
    @IBOutlet weak var travelButton: UIButton!
    @IBOutlet weak var todoTitle: UITextField!
    @IBOutlet weak var date: UIDatePicker!
    
    var todo: TodoModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        todoTitle.delegate = self
        if todo == nil{
            childButton.isSelected = true
            self.title = "新增Todo"
//            navigationController?.title = "新增Todo"
        }else{
            self.title = "修改Todo"
            if todo?.image == "child-selected"{
                childButton.isSelected = true
            }else if todo?.image == "iphone-selected"{
                phoneButton.isSelected = true
            }else if todo?.image == "shopping-cart-selected"{
                shoppingCarButton.isSelected = true
            }else if todo?.image == "travel-selected"{
                travelButton.isSelected = true
            }
            date.setDate(todo?.date as Date!, animated: false)
            todoTitle.text = todo?.title
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func resetButtons(){
        childButton.isSelected = false
        phoneButton.isSelected = false
        shoppingCarButton.isSelected = false
        travelButton.isSelected = false
    }
    
    @IBAction func childTapped(_ sender: Any) {
        resetButtons()
        childButton.isSelected = true
    }
    @IBAction func phoneTapped(_ sender: Any) {
        resetButtons()
        phoneButton.isSelected = true
    }
    @IBAction func shoppingCarTapped(_ sender: Any) {
        resetButtons()
        shoppingCarButton.isSelected = true
    }
    @IBAction func travelTapped(_ sender: Any) {
        resetButtons()
        travelButton.isSelected = true
    }
    
    @IBAction func okTapped(_ sender: Any) {
        var image:String = ""
        
        if(childButton.isSelected){
            image = "child-selected"
        }else if(phoneButton.isSelected){
             image = "phone-selected"
        }else if(shoppingCarButton.isSelected){
            image = "shopping-cart-selected"
        }else{
            image = "travel-selected"
        }
        if todo == nil {
            let uuid = UUID.init().uuidString
            let todoItem = TodoModel(id: uuid, image: image, title: todoTitle.text ?? "", date: date.date as NSDate)
            
            todos.append(todoItem)
        }else{
            todo?.title = todoTitle.text ?? ""
            todo?.image = image
            todo?.date = date.date as NSDate
        }
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool{
        textField.resignFirstResponder()
        return true
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        todoTitle.resignFirstResponder()
    }
}
