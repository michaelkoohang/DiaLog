//
//  DBHandler.swift
//  DiaLog
//
//  Created by Michael Koohang on 5/24/20.
//  Copyright © 2020 Koohang. All rights reserved.
//

import Foundation
import CoreData

class DBHandler {
    
    // Blood Sugar
    
    public static func getTargetBloodSugar() -> String {
        let fetchRequest: NSFetchRequest<BloodSugar> = BloodSugar.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "type == %@", "Target")
        do {
            let result = try PersistanceService.context.fetch(fetchRequest)
            if !result.isEmpty {
                return String(result[0].value)
            }
        } catch {
            print("error")
        }
        return "0"
    }
    
    public static func deleteTargetBloodSugar() {
        let fetchRequest: NSFetchRequest<BloodSugar> = BloodSugar.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "type == %@", "Target")
        do {
            let result = try PersistanceService.context.fetch(fetchRequest)
            if !result.isEmpty {
                PersistanceService.context.delete(result[0])
            }
        } catch {
            print("error")
        }
    }
    
    public static func getTodayBloodSugar() -> [Double] {
        let fetchRequest: NSFetchRequest<BloodSugar> = BloodSugar.fetchRequest()
        
        let calendar = Calendar.current
        let dateFrom = calendar.startOfDay(for: Date())
        let dateTo = calendar.date(byAdding: .day, value: 1, to: dateFrom)
        
        let fromPredicate = NSPredicate(format: "date >= %@", dateFrom as NSDate)
        let toPredicate = NSPredicate(format: "date < %@", dateTo! as NSDate)
        fetchRequest.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [fromPredicate, toPredicate])
        do {
            let result = try PersistanceService.context.fetch(fetchRequest)
            return extractTodayBloodSugarLogs(data: result)
        } catch {
            print("error")
        }
        return [0.0, 0.0, 0.0, 0.0, 0.0, 0.0]
    }
    
    private static func extractTodayBloodSugarLogs(data: [BloodSugar]) -> [Double] {
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
                break
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
    
    // A1C
    
    public static func getMostRecentA1C() -> [A1C] {
        let fetchRequest: NSFetchRequest<A1C> = A1C.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "date", ascending: false)]
        do {
            let result = try PersistanceService.context.fetch(fetchRequest)
            return result
        } catch {
            print("error")
        }
        return []
    }
    
    // Medications
    
    public static func getMedications() -> [Medication] {
        let fetchRequest: NSFetchRequest<Medication> = Medication.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "name", ascending: false)]
        do {
            let result = try PersistanceService.context.fetch(fetchRequest)
            return result
        } catch {
            print("error")
        }
        return []
    }
    
    // Foot Check
    
    public static func getMostRecentFootCheck() -> [FootCheck] {
        let fetchRequest: NSFetchRequest<FootCheck> = FootCheck.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "date", ascending: false)]
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM dd, yyyy"
        do {
            let result = try PersistanceService.context.fetch(fetchRequest)
            return result
        } catch {
            print("error")
        }
        return []
    }
    
    
}
