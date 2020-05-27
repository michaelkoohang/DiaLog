//
//  A1CVC.swift
//  DiaLog
//
//  Created by Michael on 3/9/19.
//  Copyright © 2019 Koohang. All rights reserved.
//

import UIKit
import CoreData

class A1CVC: BaseVC {
    
    var a1cs = [A1C]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .secondarySystemBackground
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "All Logs", style: .plain, target: self, action: #selector(showAllLogs))
        self.title = "A1C"
        setup()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        updateGraph()
    }
    
    func setup() {
        self.view.addSubview(yearlyAverage)
        
        NSLayoutConstraint.activate([
            yearlyAverage.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 14),
            yearlyAverage.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 14),
            yearlyAverage.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -14),
            yearlyAverage.heightAnchor.constraint(equalToConstant: 300),
        ])
 

    }
    
    // UI Components
    
    let yearlyAverage = LineGraphView(title: "Yearly Average")
    
    // Navigation
    
    @objc func showAllLogs() {
        self.navigationController?.pushViewController(AllA1CVC(), animated: true)
    }
    
    // Logic
    
    func updateGraph() {
        getA1CData()
        yearlyAverage.updateGraph(data: extractA1CData(data: self.a1cs))
    }
    
    func getA1CData() {
        self.a1cs = []
        
        let fetchRequest: NSFetchRequest<A1C> = A1C.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "date", ascending: false)]
        do {
            let result = try PersistanceService.context.fetch(fetchRequest)
            for obj in result {
                let a1cYear = Calendar.current.component(.year, from: obj.date!)
                let currentYear = Calendar.current.component(.year, from: Date())
                
                if a1cYear == currentYear {
                    self.a1cs.append(obj)
                }
            }
        } catch {
            print("error")
        }
    }
    
    func extractA1CData(data: [A1C]) -> [Double] {
        var result = [0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]

        var jan = 0.0, janCount = 0.0
        var feb = 0.0, febCount = 0.0
        var mar = 0.0, marCount = 0.0
        var apr = 0.0, aprCount = 0.0
        var may = 0.0, mayCount = 0.0
        var jun = 0.0, junCount = 0.0
        var jul = 0.0, julCount = 0.0
        var aug = 0.0, augCount = 0.0
        var sep = 0.0, sepCount = 0.0
        var oct = 0.0, octCount = 0.0
        var nov = 0.0, novCount = 0.0
        var dec = 0.0, decCount = 0.0

        for obj in data {
            let calendar = Calendar.current
            let month = calendar.component(.month, from: obj.date!)
            switch month {
            case 1:
                jan += Double(obj.value)
                janCount += 1
            case 2:
                feb += Double(obj.value)
                febCount += 1
            case 3:
                mar += Double(obj.value)
                marCount += 1
            case 4:
                apr += Double(obj.value)
                aprCount += 1
            case 5:
                may += Double(obj.value)
                mayCount += 1
            case 6:
                jun += Double(obj.value)
                junCount += 1
            case 7:
                jul += Double(obj.value)
                julCount += 1
            case 8:
                aug += Double(obj.value)
                augCount += 1
            case 9:
                sep += Double(obj.value)
                sepCount += 1
            case 10:
                oct += Double(obj.value)
                octCount += 1
            case 11:
                nov += Double(obj.value)
                novCount += 1
            case 12:
                dec += Double(obj.value)
                decCount += 1
            default:
                print("NONE")
            }
        }
        
        result[0] = (janCount > 0) ? jan / janCount : 0.0
        result[1] = (febCount > 0) ? feb / febCount : 0.0
        result[2] = (marCount > 0) ? mar / marCount : 0.0
        result[3] = (aprCount > 0) ? apr / aprCount : 0.0
        result[4] = (mayCount > 0) ? may / mayCount : 0.0
        result[5] = (junCount > 0) ? jun / junCount : 0.0
        result[6] = (julCount > 0) ? jul / julCount : 0.0
        result[7] = (augCount > 0) ? aug / augCount : 0.0
        result[8] = (sepCount > 0) ? sep / sepCount : 0.0
        result[9] = (octCount > 0) ? oct / octCount : 0.0
        result[10] = (novCount > 0) ? nov / novCount : 0.0
        result[11] = (decCount > 0) ? dec / decCount : 0.0

        return result
    }
    
}
