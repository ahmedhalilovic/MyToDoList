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
    
    @objc private func didTapDelete() {
        guard let myItem = self.item else {
            return
        }

        realm.beginWrite()
        realm.delete(myItem)
        try! realm.commitWrite()

        deletionHandler?()
        // To exit from this view and go to list view of To do list items
        navigationController?.popToRootViewController(animated: true)
    }

}
