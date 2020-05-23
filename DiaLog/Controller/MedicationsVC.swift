//
//  MedicationsVC.swift
//  DiaLog
//
//  Created by Michael on 3/9/19.
//  Copyright © 2019 Koohang. All rights reserved.
//

import UIKit
import CoreData

class MedicationsVC: UITableViewController {

    var medications = [Medication]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addMedication))
        self.tableView.register(MedicationCell.self, forCellReuseIdentifier: "medication")
        self.tableView.allowsSelection = false
        self.title = "Medications"
    }
    
    // Table view logic
    
    override func viewDidAppear(_ animated: Bool) {
        updateMedications()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return medications.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if !medications.isEmpty {
            let medication = medications[indexPath.row]
            if let cell = tableView.dequeueReusableCell(withIdentifier: "medication", for: indexPath) as? MedicationCell {
                cell.configureCell(medication: medication)
                return cell
            }
        }
        return MedicationCell()
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
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: nil) { (_, _, completionHandler) in
            let alert = UIAlertController(title: "Confirm", message: "Are you sure you want to delete this medication?", preferredStyle: .actionSheet)
            let delete = UIAlertAction(title: "Delete", style: .destructive) { (action) in
                let medication = self.medications[indexPath.row]
                PersistanceService.context.delete(medication)
                self.medications.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
                PersistanceService.saveContext()
            }
            let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            alert.addAction(cancel)
            alert.addAction(delete)
            self.present(alert, animated: true, completion: nil)
            completionHandler(true)
        }
        deleteAction.image = UIImage(systemName: "trash")!.withTintColor(.blue, renderingMode: .alwaysTemplate)
        deleteAction.backgroundColor = .systemRed
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
        return configuration
    }
    
    // Logic
    
    @objc func addMedication() {
        let addMedicationVC = AddMedicationVC()
        addMedicationVC.callbackClosure = { [weak self] in
            self?.updateMedications()
        }
        self.navigationController?.present(addMedicationVC, animated: true, completion: nil)
    }
    
    func updateMedications() {
        let fetchRequest: NSFetchRequest<Medication> = Medication.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
        do {
            let medications = try PersistanceService.context.fetch(fetchRequest)
            self.medications = medications
            tableView.reloadData()
        } catch {
            print("error")
        }
    }
    
}
