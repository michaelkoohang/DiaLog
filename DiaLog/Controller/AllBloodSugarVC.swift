//
//  AllBloodSugarVC.swift
//  DiaLog
//
//  Created by Michael on 7/25/19.
//  Copyright © 2019 Koohang. All rights reserved.
//

import UIKit
import CoreData

class AllBloodSugarVC: UITableViewController {
    
    var logs = [BloodSugar]()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.tableView.register(BloodSugarCell.self, forCellReuseIdentifier: "bloodSugar")
        self.tableView.allowsSelection = false
        self.tableView.rowHeight = 80
        self.title = "All Logs"
        getBloodSugar()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return logs.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "bloodSugar", for: indexPath) as? BloodSugarCell {
            cell.configureCell(bloodSugar: logs[indexPath.row])
            return cell
        } else {
            return BloodSugarCell()
        }
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
    
    func getBloodSugar() {
        let fetchRequest: NSFetchRequest<BloodSugar> = BloodSugar.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "date", ascending: false)]
        fetchRequest.predicate = NSPredicate(format: "type != %@", "Target")
        do {
            let bloodSugars = try PersistanceService.context.fetch(fetchRequest)
            self.logs = bloodSugars
        } catch {
            print("error")
        }
    }

}
