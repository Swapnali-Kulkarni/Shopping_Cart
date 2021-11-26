//
//  ViewController.swift
//  Shopping Cart
//
//  Created by Swapnali Kulkarni on 30/08/21.
//

import UIKit
import SwipeCellKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, SwipeTableViewCellDelegate {

    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    var itemArray = [String]()
    var userDef = UserDefaults.standard
    let userDefArray = UserDefaults.standard.array(forKey: "itemsArray")
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let itemArraayFromUD = userDefArray{
            itemArray = itemArraayFromUD as! [String]
            tableView.reloadData()
        }
    }

    @IBAction func clickAddButton(_ sender: Any) {
        if let text = textField.text {
            itemArray.append(text)
            userDef.set(itemArray, forKey: "itemsArray")
            tableView.reloadData()
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) ->UITableViewCell {
        let itemCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ItemTableViewCell
        itemCell.itemLabel.text = itemArray[indexPath.row]
        itemCell.delegate = self
        return itemCell
    }
    
    func collectionView(_ collectionView: UICollectionView, editActionsOptionsForItemAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeOptions {
        var options = SwipeOptions()
        options.expansionStyle = .destructive
        options.transitionStyle = .border
        return options
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        guard orientation == .right else { return nil }

        let deleteAction = SwipeAction(style: .destructive, title: "Delete") { action, indexPath in
            self.itemArray.remove(at: indexPath.row)
            self.userDef.set(self.itemArray, forKey: "itemsArray")
            action.fulfill(with: .delete)
            self.tableView.deleteRows(at: [indexPath], with: .fade)
        }

        // customize the action appearance
        deleteAction.image = UIImage(named: "delete")

        return [deleteAction]
    }
}

