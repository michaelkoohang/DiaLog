//
//  LogVC.swift
//  DiaLog
//
//  Created by Michael Koohang on 5/24/20.
//  Copyright © 2020 Koohang. All rights reserved.
//

import UIKit
import Lottie
import AVFoundation

class LogVC: BaseVC {
    
    var timer: Timer?
    var currentType = 0
    var lastType = 0
    var rowCount = [2, 1, 5, 1]
    var buttonHeight: NSLayoutConstraint?
    var buttonWidth: NSLayoutConstraint?
    var statusViewHeight: NSLayoutConstraint?
    let picker = UIImagePickerController()
    let timeOfDayOptions = ["Before Breakfast", "After Breakfast", "Before Lunch", "After Lunch", "Before Dinner", "After Dinner"]
    let unitsOptions = ["mg", "g", "units", "mL", "mcg"]
    let frequencyOptions = ["once a day", "twice a day", "three times a day", "once a week", "once a month"]
    
    let hp = UISelectionFeedbackGenerator()
    let buttonFeedback = UINotificationFeedbackGenerator()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.contentInset = UIEdgeInsets(top: 0, left: view.frame.size.width / 2 - 70, bottom: 0, right: view.frame.size.width / 2 - 70)
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.showsVerticalScrollIndicator = false
        tableView.isScrollEnabled = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .clear
        tableView.estimatedRowHeight = 500
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 56, bottom: 0, right: 0)
        
        
        let swipeDownGesture = UISwipeGestureRecognizer(target: self, action: #selector(swipeDown(_:)))
        swipeDownGesture.direction = .down
        let swipeLeftGesture = UISwipeGestureRecognizer(target: self, action: #selector(swipeLeft(_:)))
        swipeLeftGesture.direction = .left
        let swipeRightGesture = UISwipeGestureRecognizer(target: self, action: #selector(swipeRight(_:)))
        swipeRightGesture.direction = .right
        self.view.addGestureRecognizer(swipeDownGesture)
        self.view.addGestureRecognizer(swipeLeftGesture)
        self.view.addGestureRecognizer(swipeRightGesture)
        
        NotificationCenter.default.addObserver(self, selector:#selector(restartAnimation), name:
            UIApplication.willEnterForegroundNotification, object: nil)
        
        picker.delegate = self
        
        setup()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        collectionView.reloadData()
        collectionView.scrollToItem(at: IndexPath(item: currentType, section: 0), at: .centeredHorizontally, animated: true)
    }
    
    func setup() {
        view.addSubview(collectionView)
        view.addSubview(tableView)
        view.addSubview(logButton)
        view.addSubview(statusView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 8),
            collectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0),
            collectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0),
            collectionView.heightAnchor.constraint(equalToConstant: 100),
            
            tableView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 16),
            tableView.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -16),
            tableView.topAnchor.constraint(equalTo: self.collectionView.bottomAnchor, constant: 16),
            tableView.bottomAnchor.constraint(equalTo: self.logButton.topAnchor, constant: -16),
            
            logButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            logButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0),
            
            statusView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: 0),
            statusView.widthAnchor.constraint(equalToConstant: self.view.bounds.width),
            statusView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0)
        ])
        
        
        
        buttonHeight = logButton.heightAnchor.constraint(equalToConstant: 80)
        buttonHeight?.isActive = true
        buttonWidth = logButton.widthAnchor.constraint(equalToConstant: 80)
        buttonWidth?.isActive = true
        statusViewHeight = statusView.heightAnchor.constraint(equalToConstant: 0)
        statusViewHeight?.isActive = true
    }
    
    // UI Components
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.showsHorizontalScrollIndicator = false
        cv.backgroundColor = .systemGroupedBackground
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.register(LogTypeCell.self, forCellWithReuseIdentifier: "cell")
        return cv
    }()
    
    let tableView: UITableView = {
        let t = UITableView(frame: CGRect(), style: .plain)
        t.backgroundColor = .systemRed
        t.translatesAutoresizingMaskIntoConstraints = false
        return t
    }()
    
    let logButton: UIButton = {
        var b = UIButton()
        b.setTitle("Log", for: .normal)
        b.backgroundColor = .systemBlue
        b.setTitleColor(.white, for: .normal)
        b.layer.cornerRadius = 40
        b.titleLabel?.font = .systemFont(ofSize: 17, weight: .bold)
        b.addTarget(self, action: #selector(save), for: .touchUpInside)
        b.translatesAutoresizingMaskIntoConstraints = false
        return b
    }()
    
    let statusView: StatusView = {
        let ev = StatusView(title: "Missing Fields", message: "Make sure to fill out all the fields!", type: .Error)
        ev.translatesAutoresizingMaskIntoConstraints = false
        return ev
    }()
    
    @objc func restartAnimation() {
        collectionView.reloadData()
    }
    
    @objc func swipeRight(_ gesture: UISwipeGestureRecognizer) -> Bool {
        if currentType != 0 {
            collectionView.delegate?.collectionView?(collectionView, didSelectItemAt: IndexPath(item: currentType-1, section: 0))
            return true
        }
        return false
    }
    
    @objc func swipeLeft(_ gesture: UISwipeGestureRecognizer) -> Bool {
        if currentType != 3 {
            collectionView.delegate?.collectionView?(collectionView, didSelectItemAt: IndexPath(item: currentType+1, section: 0))
            return true
        }
        return false
    }
    
    @objc func swipeDown(_ gesture: UISwipeGestureRecognizer) -> Bool {
        self.view.endEditing(true)
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 10, initialSpringVelocity: 10, options: .curveEaseOut, animations: {
            self.timer?.invalidate()
            self.statusViewHeight?.constant = 0
            self.view.layoutIfNeeded()
        }, completion: nil)
        return true
    }
    
    //    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
    //        print(touch.location(in: tableView))
    //        print(tableView.point)
    //        for i in 0..<rowCount[currentType] {
    //            let cell = tableView.cellForRow(at: IndexPath(row: i, section: 0))!
    //            if (touch.view?.isDescendant(of: cell))! {
    //                return false
    //            }
    //        }
    //        return true
    //    }
    
}

extension LogVC: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 140, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.row {
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! LogTypeCell
            if currentType == 0 {
                cell.configureCell(type: .BloodSugar, active: true)
            } else {
                cell.configureCell(type: .BloodSugar, active: false)
            }
            return cell
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! LogTypeCell
            if currentType == 1 {
                cell.configureCell(type: .A1C, active: true)
            } else {
                cell.configureCell(type: .A1C, active: false)
            }
            return cell
        case 2:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! LogTypeCell
            if currentType == 2 {
                cell.configureCell(type: .Medication, active: true)
            } else {
                cell.configureCell(type: .Medication, active: false)
            }
            return cell
        case 3:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! LogTypeCell
            if currentType == 3 {
                cell.configureCell(type: .FootCheck, active: true)
            } else {
                cell.configureCell(type: .FootCheck, active: false)
            }
            return cell
        default:
            break
        }
        
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        lastType = currentType
        currentType = indexPath.row
        hp.selectionChanged()
        reload()
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
    
    @objc func reload() {
        let contentOffset = collectionView.contentOffset
        collectionView.reloadData()
        collectionView.layoutIfNeeded()
        collectionView.setContentOffset(contentOffset, animated: false)
        
        let range = NSMakeRange(0, self.tableView.numberOfSections)
        let sections = NSIndexSet(indexesIn: range)
        if lastType != currentType {
            self.tableView.reloadSections(sections as IndexSet, with: .automatic)
        }
    }
    
}

extension LogVC: UITableViewDataSource, UITableViewDelegate {
    
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rowCount[currentType]
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if currentType == 2 {
            if indexPath.row == 4 {
                return 100
            }
        }
        return 55
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch currentType {
        case 0:
            hideButton(hidden: false)
            if indexPath.row == 0 {
                let cell = InputCell(iconTitle: "number", placeholder: "Amount", position: 0)
                cell.input.keyboardType = .numberPad
                return cell
            }
            
            if indexPath.row == 1 {
                let cell = InputPickerCell(iconTitle: "clock", placeholder: "Time of Day", options: timeOfDayOptions, position: 2)
                return cell
            }
        case 1:
            hideButton(hidden: false)
            let cell = InputCell(iconTitle: "percent", placeholder: "Amount", position: -1)
            cell.input.keyboardType = .decimalPad
            
            return cell
        case 2:
            hideButton(hidden: false)
            self.logButton.isHidden = false
            
            if indexPath.row == 0 {
                let cell = InputCell(iconTitle: "square.and.pencil", placeholder: "Name", position: 0)
                return cell
            }
            
            if indexPath.row == 1 {
                let cell = InputCell(iconTitle: "number", placeholder: "Dosage", position: 1)
                cell.input.keyboardType = .numberPad
                return cell
            }
            
            if indexPath.row == 2 {
                let cell = InputPickerCell(iconTitle: "u.circle", placeholder: "Units", options: unitsOptions, position: 1)
                return cell
            }
            
            if indexPath.row == 3 {
                let cell = InputPickerCell(iconTitle: "gobackward", placeholder: "Frequency", options: frequencyOptions, position: 1)
                return cell
            }
            
            if indexPath.row == 4 {
                let cell = InputLongCell(iconTitle: "doc", placeholder: "Notes", position: 2)
                return cell
            }
        case 3:
            hideButton(hidden: true)
            let cell = InputImageCell(iconTitle: "camera", text: "Take a Picture", position: -1)
            return cell
        default:
            break
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(currentType)
        print(indexPath.row)
        if currentType == 3 {
            if indexPath.row == 0 {
                print("HELLO")
                saveFootCheck()
            }
        }
    }
    
}

extension LogVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @objc func save() {
        switch currentType {
        case 0:
            let amountCell = tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as! InputCell
            guard let amount = Int(amountCell.input.text!) else {
                playStatusAnimation(title: "Input Error", message: "'Amount' value is invalid.", type: .Error)
                return
            }
            
            let timeOfDayCell = tableView.cellForRow(at: IndexPath(row: 1, section: 0)) as! InputCell
            guard let type = timeOfDayCell.input.text, timeOfDayOptions.contains(type) else {
                playStatusAnimation(title: "Input Error", message: "'Time of Day' value is invalid", type: .Error)
                return
            }
            saveBloodSugar(amount: amount, timeOfDay: type)
        case 1:
            let amountCell = tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as! InputCell
            guard let amount = Double(amountCell.input.text!) else {
                playStatusAnimation(title: "Input Error", message: "'Amount' value is invalid.", type: .Error)
                return
            }
            saveA1C(amount: amount)
        case 2:
            let nameCell = tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as! InputCell
            guard let name = nameCell.input.text, isValidString(name: name) else {
                playStatusAnimation(title: "Input Error", message: "'Name' value is invalid.", type: .Error)
                return
            }
            
            let dosageCell = tableView.cellForRow(at: IndexPath(row: 1, section: 0)) as! InputCell
            guard let dosage = Int(dosageCell.input.text!) else {
                playStatusAnimation(title: "Input Error", message: "'Dosage' value is invalid.", type: .Error)
                return
            }
            
            let unitsCell = tableView.cellForRow(at: IndexPath(row: 2, section: 0)) as! InputPickerCell
            guard let units = unitsCell.input.text, unitsOptions.contains(units) else {
                playStatusAnimation(title: "Input Error", message: "'Units' value is invalid.", type: .Error)
                return
            }
            
            let frequencyCell = tableView.cellForRow(at: IndexPath(row: 3, section: 0)) as! InputPickerCell
            guard let frequency = frequencyCell.input.text, frequencyOptions.contains(frequency) else {
                playStatusAnimation(title: "Input Error", message: "'Frequency' value is invalid.", type: .Error)
                return
            }
            
            let notesCell = tableView.cellForRow(at: IndexPath(row: 4, section: 0)) as! InputLongCell
            guard let notes = notesCell.input.text, isValidString(name: notes) else {
                playStatusAnimation(title: "Input Error", message: "'Notes' value is invalid.", type: .Error)
                return
            }
            
            saveMedication(name: name, dosage: dosage, units: units, frequency: frequency, notes: notes)
            
        default:
            break
        }
    }
    
    
    func isValidString(name: String) -> Bool {
        if name.isEmpty {
            return false
        }
        
        if name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            return false
        }
        
        return true
    }
    
    func saveBloodSugar(amount: Int, timeOfDay: String) {
        if (amount >= 30 && amount <= 500) {
            let value = Int16(amount)
            let type = timeOfDay
            let date = Date()
            
            let bs = BloodSugar(context: PersistanceService.context)
            bs.value = value
            bs.type = type
            bs.date = date
            PersistanceService.saveContext()
            
            let amountCell = tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as! InputCell
            let timeOfDayCell = tableView.cellForRow(at: IndexPath(row: 1, section: 0)) as! InputCell
            amountCell.input.text = ""
            timeOfDayCell.input.text = ""
            
            let formatter = DateFormatter()
            formatter.dateFormat = "MMM dd, yyyy"
            
            playStatusAnimation(title: "Logged", message: "\(value) mg / dL \(type.lowercased()) on \(formatter.string(from:bs.date!)).", type: .Success)
        } else {
            playStatusAnimation(title: "Out of Range", message: "Acceptable values are between 30-500.", type: .Error)
        }
    }
    
    func saveA1C(amount: Double) {
        if (amount >= 4.0 && amount <= 15.0) {
            let a1c = A1C(context: PersistanceService.context)
            a1c.value = amount
            a1c.date = Date()
            PersistanceService.saveContext()
            
            let amountCell = tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as! InputCell
            amountCell.input.text = ""
            
            let formatter = DateFormatter()
            formatter.dateFormat = "MMM dd, yyyy"
            
            playStatusAnimation(title: "Logged", message: "\(amount) % on \(formatter.string(from: a1c.date!)).", type: .Success)
        } else {
            playStatusAnimation(title: "Out of Range", message: "Acceptable values are between 4.0-15.0.", type: .Error)
        }
    }
    
    func saveMedication(name: String, dosage: Int, units: String, frequency: String, notes: String) {
        let medication = Medication(context: PersistanceService.context)
        medication.name = name
        medication.dosage = Int16(dosage)
        medication.units = units
        medication.frequency = frequency
        medication.notes = notes == "Notes" ? "" : notes
        
        PersistanceService.saveContext()
        playStatusAnimation(title: "Logged", message: "\(name) saved to medications.", type: .Success)
        
        let nameCell = tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as! InputCell
        let dosageCell = tableView.cellForRow(at: IndexPath(row: 1, section: 0)) as! InputCell
        let unitsCell = tableView.cellForRow(at: IndexPath(row: 2, section: 0)) as! InputPickerCell
        let frequencyCell = tableView.cellForRow(at: IndexPath(row: 3, section: 0)) as! InputPickerCell
        let notesCell = tableView.cellForRow(at: IndexPath(row: 4, section: 0)) as! InputLongCell
        
        nameCell.input.text = ""
        dosageCell.input.text = ""
        unitsCell.input.text = ""
        frequencyCell.input.text = ""
        notesCell.input.text = "Notes"
        notesCell.input.textColor = .tertiaryLabel
    }
    
    func saveFootCheck() {
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
        
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM dd, yyyy"
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.playStatusAnimation(title: "Logged", message: "Foot check on \(formatter.string(from: fc.date!)).", type: .Success)
            
        }
        tableView.deselectRow(at: IndexPath(row: 0, section: 0), animated: true)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
        tableView.deselectRow(at: IndexPath(row: 0, section: 0), animated: true)
    }
    
    func playStatusAnimation(title: String, message: String, type: Status) {
        timer?.invalidate()
        statusView.title.text = title
        statusView.message.text = message
        if type == .Success {
            statusView.backgroundColor = .systemGreen
        }
        if type == .Error {
            statusView.backgroundColor = .systemRed
        }
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 10, initialSpringVelocity: 10, options: .curveEaseOut, animations: {
            self.statusViewHeight?.constant = 100
            self.view.layoutIfNeeded()
        }, completion: nil)
        
        timer = Timer.scheduledTimer(withTimeInterval: 4.0, repeats: true) { timer in
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 10, initialSpringVelocity: 10, options: .curveEaseOut, animations: {
                self.statusViewHeight?.constant = 0
                self.view.layoutIfNeeded()
            }, completion: nil)
        }
        
        buttonFeedback.notificationOccurred(.error)
    }
    
    func hideButton(hidden: Bool) {
        if hidden {
            UIView.animate(withDuration: 0.2, animations: {
                self.logButton.transform = CGAffineTransform(scaleX: 0.00001, y: 0.00001)
                self.logButton.isUserInteractionEnabled = false
            })
        } else {
            UIView.animate(withDuration: 0.2, animations: {
                self.logButton.transform = CGAffineTransform(scaleX: 1, y: 1)
                self.logButton.isUserInteractionEnabled = true
            })
        }
    }
    
}

