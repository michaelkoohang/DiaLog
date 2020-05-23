//
//  MainVC.swift
//  DiaLog
//
//  Created by Michael on 5/29/19.
//  Copyright © 2019 Koohang. All rights reserved.
//

import UIKit
import CoreData
import ScrollableGraphView

class MainVC: UIViewController {
    
    let hapticFeedback = UISelectionFeedbackGenerator()
    var medicationsViewHeight: NSLayoutConstraint?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Dia/Log"
        self.view.backgroundColor = .systemBackground
        self.navigationController?.navigationBar.prefersLargeTitles = true
        bloodSugarView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(goToBloodSugar)))
        a1cView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(goToA1C)))
        medicationsView.addGestureRecognizer((UITapGestureRecognizer(target: self, action: #selector(goToMedications))))
        footCheckView.addGestureRecognizer((UITapGestureRecognizer(target: self, action: #selector(goToFootCheck))))
        setup()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        dateView.setDate()
        dateView.rotate()
        
        getTargetBloodSugar()
        getTodayBloodSugar()
        getMostRecentA1C()
        getYourMedications()
        updateMedicationsViewHeight()
        getMostRecentFootCheck()
    }
    
    override func viewDidLayoutSubviews() {
        updateMedicationsViewHeight()
    }
    
    func setup() {
        self.scrollView.addSubview(dateView)
        self.scrollView.addSubview(bloodSugarView)
        self.scrollView.addSubview(a1cView)
        self.scrollView.addSubview(medicationsView)
        self.scrollView.addSubview(footCheckView)
        self.view.addSubview(scrollView)
        
        scrollView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: 0).isActive = true
        scrollView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 0).isActive = true
        scrollView.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: 0).isActive = true
        
        dateView.topAnchor.constraint(equalTo: self.scrollView.topAnchor, constant: 14).isActive = true
        dateView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 14).isActive = true
        dateView.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -14).isActive = true
        dateView.heightAnchor.constraint(equalToConstant: 80).isActive = true

        bloodSugarView.topAnchor.constraint(equalTo: self.dateView.bottomAnchor, constant: 14).isActive = true
        bloodSugarView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 14).isActive = true
        bloodSugarView.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -14).isActive = true
        bloodSugarView.heightAnchor.constraint(equalToConstant: 445).isActive = true
        
        a1cView.topAnchor.constraint(equalTo: self.bloodSugarView.bottomAnchor, constant: 14).isActive = true
        a1cView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 14).isActive = true
        a1cView.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -14).isActive = true
        a1cView.heightAnchor.constraint(equalToConstant: 190).isActive = true
        
        medicationsView.topAnchor.constraint(equalTo: self.a1cView.bottomAnchor, constant: 14).isActive = true
        medicationsView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 14).isActive = true
        medicationsView.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -14).isActive = true
        medicationsViewHeight = medicationsView.heightAnchor.constraint(equalToConstant: 380)
        medicationsViewHeight?.isActive = true
        
        footCheckView.topAnchor.constraint(equalTo: self.medicationsView.bottomAnchor, constant: 14).isActive = true
        footCheckView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 14).isActive = true
        footCheckView.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -14).isActive = true
        footCheckView.heightAnchor.constraint(equalToConstant: 450).isActive = true
    }

    // UI Components
    
    let scrollView: UIScrollView = {
        var v = UIScrollView()
        v.contentSize = CGSize(width: UIScreen.main.bounds.width, height: 1250)
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    let dateView = DateView()
    
    let bloodSugarView: BloodSugarView = {
        var bsv = BloodSugarView()
        bsv.editButton.addTarget(self, action: #selector(goToEditTargetBloodSugar), for: .touchUpInside)
        return bsv
    }()
    
    let a1cView = A1CView()
    
    let medicationsView = MedicationsView()
    
    let footCheckView = FootCheckView()
    
    // Navigation
    
    @objc func goToBloodSugar() {
        hapticFeedback.selectionChanged()
        self.navigationController?.pushViewController(BloodSugarVC(), animated: true)
    }
    
    @objc func goToA1C() {
        hapticFeedback.selectionChanged()
        self.navigationController?.pushViewController(A1CVC(), animated: true)
    }
    
    @objc func goToMedications() {
        hapticFeedback.selectionChanged()
        self.navigationController?.pushViewController(MedicationsVC(), animated: true)
    }
    
    @objc func goToFootCheck() {
        hapticFeedback.selectionChanged()
        self.navigationController?.pushViewController(FootCheckVC(), animated: true)
    }
    
    @objc func goToEditTargetBloodSugar() {
        let editTargetBloodSugarVC = EditTargetBloodSugarVC()
        editTargetBloodSugarVC.callbackClosure = { [weak self] in
            self!.getTargetBloodSugar()
        }
        self.navigationController?.present(editTargetBloodSugarVC, animated: true, completion: nil)
    }
    
    // Logic Functions
    
    func updateMedicationsViewHeight() {
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseIn, animations: {
            self.medicationsViewHeight?.constant = self.medicationsView.tableview.contentSize.height + 80
            self.scrollView.contentSize.height = 1250 + self.medicationsViewHeight!.constant
            self.medicationsView.tableview.layoutIfNeeded()
            self.medicationsView.layoutIfNeeded()
            self.view.layoutIfNeeded()
        })
    }
    
    func getTargetBloodSugar() {
        let fetchRequest: NSFetchRequest<BloodSugar> = BloodSugar.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "type == %@", "Target")
        do {
            let result = try PersistanceService.context.fetch(fetchRequest)
            if !result.isEmpty {
                bloodSugarView.setTargetBloodSugar(data: String(result[0].value))
            }
        } catch {
            print("error")
        }
    }
    
    func getTodayBloodSugar() {
        let fetchRequest: NSFetchRequest<BloodSugar> = BloodSugar.fetchRequest()
        
        let calendar = Calendar.current
        let dateFrom = calendar.startOfDay(for: Date())
        let dateTo = calendar.date(byAdding: .day, value: 1, to: dateFrom)
        
        let fromPredicate = NSPredicate(format: "date >= %@", dateFrom as NSDate)
        let toPredicate = NSPredicate(format: "date < %@", dateTo! as NSDate)
        fetchRequest.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [fromPredicate, toPredicate])
        do {
            let result = try PersistanceService.context.fetch(fetchRequest)
            if !result.isEmpty {
                bloodSugarView.updateTodayGraph(data: extractTodayBloodSugarLogs(data: result))
            }
        } catch {
            print("error")
        }
    }
    
    func extractTodayBloodSugarLogs(data: [BloodSugar]) -> [Double] {
        var result = [0.0, 0.0, 0.0, 0.0, 0.0, 0.0]
        
        var bb = 0.0, bbCount = 0.0
        var ab = 0.0, abCount = 0.0
        var bl = 0.0, blCount = 0.0
        var al = 0.0, alCount = 0.0
        var bd = 0.0, bdCount = 0.0
        var ad = 0.0, adCount = 0.0
        
        for bs in data {
            let type = bs.type
            switch type {
            case "Before Breakfast":
                bb += Double(bs.value)
                bbCount += 1
            case "After Breakfast":
                ab += Double(bs.value)
                abCount += 1
            case "Before Lunch":
                bl += Double(bs.value)
                blCount += 1
            case "After Lunch":
                al += Double(bs.value)
                alCount += 1
            case "Before Dinner":
                bd += Double(bs.value)
                bdCount += 1
            case "After Dinner":
                ad += Double(bs.value)
                adCount += 1
            default:
                print("NONE FOUND")
            }
        }
        
        result[0] = (bbCount > 0) ? bb / bbCount : 0.0
        result[1] = (abCount > 0) ? ab / abCount : 0.0
        result[2] = (blCount > 0) ? bl / blCount : 0.0
        result[3] = (alCount > 0) ? al / alCount : 0.0
        result[4] = (bdCount > 0) ? bd / bdCount : 0.0
        result[5] = (adCount > 0) ? ad / adCount : 0.0

        return result
    }
    
    func getMostRecentA1C() {
        let fetchRequest: NSFetchRequest<A1C> = A1C.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "date", ascending: false)]
        do {
            let result = try PersistanceService.context.fetch(fetchRequest)
            if !result.isEmpty {
                a1cView.setMostRecentA1C(log: result[0])
            }
        } catch {
            print("error")
        }
    }
    
    func getYourMedications() {
        let fetchRequest: NSFetchRequest<Medication> = Medication.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "name", ascending: false)]
        do {
            let result = try PersistanceService.context.fetch(fetchRequest)
            self.medicationsView.updateMedications(data: result)
        } catch {
            print("error")
        }
    }
    
    func getMostRecentFootCheck() {
        let fetchRequest: NSFetchRequest<FootCheck> = FootCheck.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "date", ascending: false)]
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yyyy"
        do {
            let result = try PersistanceService.context.fetch(fetchRequest)
            if !result.isEmpty {
                self.footCheckView.setMostRecentFootCheck(footCheck: result[0])
            } else {
                self.footCheckView.setToBlank()
            }
        } catch {
            print("error")
        }
    }
    
}
