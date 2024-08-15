//
//  ScreenViewController.swift
//  MyToDoList
//
//  Created by Ahmed Halilovic on 9. 8. 2024..
//

import UIKit
import RealmSwift

class ScreenViewController: UIViewController {
    
    public var item: ToDoListItem?
    public var deletionHandler: (() -> Void)?
    
    @IBOutlet var itemLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    
    private let realm = try! Realm()
    
    // Making formatter that converts between dates to string
    static let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        return dateFormatter
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        itemLabel.text = item?.item
        if let item = item {
            dateLabel.text = Self.dateFormatter.string(from: item.date)
        } else {
            dateLabel.text = "No date available"
        }
        
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(didTapDelete))
    }
    
    // Delete button when pressed deletes the to-do item. When delete button is pressed, a confirmation dialog will appear before deleting the item.
    @objc private func didTapDelete() {
        guard let myItem = self.item else {
            return
        }
        
        let alert = UIAlertController(title: "Confirm deletion", message: "Are you sure you want to delete this item?", preferredStyle: .alert)
        let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { [self] _ in
            
            //Delete the item here
            realm.beginWrite()
            realm.delete(myItem)
            try! realm.commitWrite()
            
            self.deletionHandler?()
            self.navigationController?.popToRootViewController(animated: true)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        // Attaching action object to the alert
        alert.addAction(deleteAction)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
    }
    
}
