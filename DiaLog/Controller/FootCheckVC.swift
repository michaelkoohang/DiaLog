//
//  FootCheckVC.swift
//  DiaLog
//
//  Created by Michael on 3/9/19.
//  Copyright © 2019 Koohang. All rights reserved.
//

import UIKit
import CoreData
import AVFoundation

var footChecked: Bool = false
var newCheckDate: String = ""

class FootCheckVC: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var footChecks = [FootCheck]()
    let picker = UIImagePickerController()
    var dingSound: AVAudioPlayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBackground
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.tableView.rowHeight = 500
        self.tableView.allowsSelection = false
        self.tableView.separatorStyle = .none
        self.tableView.register(FootCheckCell.self, forCellReuseIdentifier: "footcheck")
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .camera, target: self, action: #selector(newPicture))
        self.title = "Foot Check"
        picker.delegate = self
        getFootChecks()
        
        let url = Bundle.main.url(forResource: "ding", withExtension: "aif")
        do {
            dingSound = try AVAudioPlayer(contentsOf: url!)
        } catch {
            print("error")
        }
    }
    
    // Image picking and table view logic.
    
    @objc func newPicture() {
        if AVCaptureDevice.authorizationStatus(for: .video) ==  .authorized {
            picker.allowsEditing = false
            picker.sourceType = .camera
            picker.cameraCaptureMode = .photo
            picker.modalPresentationStyle = .fullScreen
            present(picker, animated: true, completion: nil)
        } else {
            AVCaptureDevice.requestAccess(for: AVMediaType.video, completionHandler: { (videoGranted: Bool) -> Void in
                if (videoGranted) {
                    DispatchQueue.main.async {
                        self.picker.allowsEditing = false
                        self.picker.sourceType = .camera
                        self.picker.cameraCaptureMode = .photo
                        self.picker.modalPresentationStyle = .fullScreen
                        self.present(self.picker, animated: true, completion: nil)
                    }
                } else {
                    DispatchQueue.main.async {
                        let alert = UIAlertController(title: "Camera Not Authorized", message: "Please go to Settings > Privacy > Camera to enable camera usage on DiaLog.", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                    }
                }
            })
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        let data = image?.jpegData(compressionQuality: 1)
        
        let fc = FootCheck(context: PersistanceService.context)
        fc.image = data
        fc.date = Date()
        PersistanceService.saveContext()
                      
        dingSound!.play()
        getFootChecks()
        self.tableView.reloadData()
        
        let alert = UIAlertController(title: "Success!", message: "Your foot check has been saved.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (UIAlertAction) in
            self.dismiss(animated: true, completion: nil)
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return footChecks.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "footcheck", for: indexPath) as? FootCheckCell {
            cell.configureCell(footCheck: footChecks[indexPath.row])
            return cell
        } else {
            return FootCheckCell()
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
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
            let deleteAction = UIContextualAction(style: .destructive, title: nil) { (_, _, completionHandler) in
                let alert = UIAlertController(title: "Confirm", message: "Are you sure you want to delete this foot check?", preferredStyle: .actionSheet)
                let delete = UIAlertAction(title: "Delete", style: .destructive) { (action) in
                    let fc = self.footChecks[indexPath.row]
                    PersistanceService.context.delete(fc)
                    self.footChecks.remove(at: indexPath.row)
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
    
    func getFootChecks() {
        let fetchRequest: NSFetchRequest<FootCheck> = FootCheck.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "date", ascending: false)]
        do {
            let footChecks = try PersistanceService.context.fetch(fetchRequest)
            self.footChecks = footChecks
        } catch {
            print("error")
        }
    }


}
