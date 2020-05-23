//
//  AllA1CVC.swift
//  DiaLog
//
//  Created by Michael on 7/25/19.
//  Copyright © 2019 Koohang. All rights reserved.
//

import UIKit
import CoreData

class AllA1CVC: UITableViewController {

    var logs = [A1C]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.tableView.register(A1CCell.self, forCellReuseIdentifier: "a1c")
        self.tableView.allowsSelection = false
        self.tableView.rowHeight = 80
        self.title = "All Logs"
        getA1C()
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.transform = CGAffineTransform(translationX: 0, y: cell.frame.height / 2)
        cell.alpha = 0

        UIView.animate(
            withDuration: 0.5,
            delay: 0.1 * Double(indexPath.row),
            options: [.curveEaseInOut],
            animations: {
                cell.transform = CGAffineTransform(translationX: 0, y: 0)
                cell.alpha = 1
        })
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let alert = UIAlertController(title: "Confirm", message: "Are you sure you want to delete this log?", preferredStyle: .actionSheet)
            let delete = UIAlertAction(title: "Delete", style: .destructive) { (action) in
                let log = self.logs[indexPath.row]
                PersistanceService.context.delete(log)
                self.logs.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
                PersistanceService.saveContext()
            }
            let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            alert.addAction(cancel)
            alert.addAction(delete)
            self.present(alert, animated: true, completion: nil)
                      
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return logs.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "a1c", for: indexPath) as? A1CCell {
            cell.configureCell(a1c: logs[indexPath.row])
            return cell
        } else {
            return A1CCell()
        }
    }
    
    func getA1C() {
        let fetchRequest: NSFetchRequest<A1C> = A1C.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "date", ascending: false)]
        do {
            let a1cs = try PersistanceService.context.fetch(fetchRequest)
            self.logs = a1cs
        } catch {
            print("error")
        }
    }

}
