//
//  CropWorkerTVC.swift
//  AssessmentsApp
//
//  Created by jon richardson-williams on 22/11/2021.
//

import UIKit
import CoreData

class CropWorkerTVC: UITableViewController {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var cropWorkers: [CropWorker] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        fetchCropWorkers()
    }
    
    func fetchCropWorkers() {
        
        do {
            self.cropWorkers = try context.fetch(CropWorker.fetchRequest())
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        catch {
            
        }
    }

    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cropWorkers.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Cells.CropWorkerNameCell, for: indexPath)
        let cropWorkerName = self.cropWorkers[indexPath.row]
        cell.textLabel?.text = cropWorkerName.name

        return cell
    }

    @IBAction func addTapped(_ sender: Any) {
    
        let alert = UIAlertController(title: "Add Crop Worker", message: "What is their name?", preferredStyle: .alert)
        alert.addTextField()
        
        let submitButton = UIAlertAction(title: "Add", style: .default) { (action) in
            
            let textField = alert.textFields![0]
            
            
            let newCropWorker = CropWorker(context: self.context)
            newCropWorker.name = textField.text
            
            do {
                try self.context.save()
            }
            catch {
                
            }
            
            self.fetchCropWorkers()
        }
        
        alert.addAction(submitButton)
        self.present(alert, animated: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let action = UIContextualAction(style: .destructive, title: "Delete") { (action, view, completionHandler) in
            
            let cropWorkerToRemove = self.cropWorkers[indexPath.row]
            
            self.context.delete(cropWorkerToRemove)
            
            do {
                try self.context.save()
            }
            catch {
                
            }
            
            self.fetchCropWorkers()
        }
        
        return UISwipeActionsConfiguration(actions: [action])
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cropWorker = self.cropWorkers[indexPath.row]
        
        let alert = UIAlertController(title: "Edit Crop Worker", message: "Edit Name", preferredStyle: .alert)
        alert.addTextField()
        
        let textField = alert.textFields![0]
        textField.text = cropWorker.name
        
        let saveButton = UIAlertAction(title: "Save", style: .default) { (action) in
            
            let textField = alert.textFields![0]
            
            cropWorker.name = textField.text
            
            do {
                try self.context.save()
            }
            catch {
                
            }
            
            self.fetchCropWorkers()
        }
        
        alert.addAction(saveButton)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    
        
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
