//
//  ViewController.swift
//  MyToDoList
//
//  Created by Ahmed Halilovic on 8. 8. 2024..
//

import RealmSwift
import UIKit

/*
 - To show a list of current to do list items
 - To enter new to do list item
 - To show previously entered to do list item
 
 - Item
 - Date
 */

class ToDoListItem: Object {
    @objc dynamic var item: String = ""
    @objc dynamic var date: Date = Date()
}

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var table: UITableView!
    
    private let realm = try! Realm()
    private var data = [ToDoListItem]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        data = realm.objects(ToDoListItem.self).map({ $0 })
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        table.delegate = self
        table.dataSource = self
    }
    
    private func loadData() {
        data = Array(realm.objects(ToDoListItem.self))
        table.reloadData()
    }
    
    // Mark: Table
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let item = data[indexPath.row]
        //cell.textLabel?.text = data[indexPath.row].item
        
        // Try to use this below because textLabel will soon be depricated
        var contentConfiguration = cell.defaultContentConfiguration()
        contentConfiguration.text = item.item
        contentConfiguration.secondaryText = DateFormatter.localizedString(from: item.date, dateStyle: .short, timeStyle: .short)
        cell.contentConfiguration = contentConfiguration
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        // With this we open the screen where we can see item info and also delete it
        let item = data[indexPath.row]
        
        guard let vc = storyboard?.instantiateViewController(identifier: "view") as?
            ScreenViewController else {
            return
        }
        
        vc.item = item
        vc.deletionHandler = { [weak self] in
            self?.refresh()
        }
        
        vc.title = item.item
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func didTapAddButton() {
        guard let vc = storyboard?.instantiateViewController(identifier: "enter") as? EntryViewController else {
            return
        }
        
        vc.completionHandler = { [weak self] in
            self?.refresh()
        }
        
        vc.title = "New Item"
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func refresh() {
        data = realm.objects(ToDoListItem.self).map({ $0 })
        table.reloadData()
    }

}

