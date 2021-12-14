//
//  ViewController.swift
//  Update
//
//  Created by R on 10/05/1443 AH.
//  Copyright © 1443 R. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UITableViewController,addNewItem {
    func updateItem(title: Item, titlle2: String) {
        update(title1: title, title2: titlle2)
    }
    
    var items :[Item] = []
    
    let context = (UIApplication.shared.delegate as!AppDelegate).persistentContainer.viewContext

    
    func addItem(title: String) {
        create(title: title)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Core Data"
        read()
    }
    
    @IBAction func go(_ sender: UIBarButtonItem) {
        let secondVc = storyboard?.instantiateViewController(identifier: "SecondView") as! SecondViewController
        secondVc.delegate = self
        navigationController?.pushViewController(secondVc, animated: true)
    }
    
}

extension ViewController{
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "itemsCell", for: indexPath)
        cell.textLabel?.text = items[indexPath.row].title
        return cell
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let del = UIContextualAction(style: .destructive, title: "delete") { (action, view, escap) in
            let itemdel = self.items[indexPath.row]
            self.delete(title: itemdel)
        }
        return UISwipeActionsConfiguration(actions: [del])
    }
    
    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let upd = UIContextualAction(style: .normal, title: "Update") { (action, view, esc) in
            let secondVc = self.storyboard?.instantiateViewController(identifier: "SecondView") as! SecondViewController
            secondVc.delegate = self
            secondVc.updatedText = self.items[indexPath.row]
            self.navigationController?.pushViewController(secondVc, animated: true)
        }
        return UISwipeActionsConfiguration(actions: [upd])

    }
}


extension ViewController{
    
    func create(title:String){
        let taskItem = Item(context: context) // important
        taskItem.title = title
        taskItem.id = UUID()
            do {
                try context.save()
                print("create() Success")
                read()
            } catch {
                print("\(error)")
        }
    }
    
    func read(){
        do {
            items = try context.fetch(Item.fetchRequest())
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            print("getTask() Success")
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func update(title1:Item,title2:String){
        title1.title = title2
        do {
              try context.save()
              print("upd() Success")
               read()
                       
            } catch {
               print("\(error)")
        }
    }
    
    func delete(title:Item){
        context.delete(title)
        
            do {
                try context.save()
                print("del() Success")
                read()
                
            } catch {
                print("\(error)")
        }

    }
    

    
}

