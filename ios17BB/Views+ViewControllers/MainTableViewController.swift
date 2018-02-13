//
//  MainTableViewController.swift
//  ios17BB
//
//  Created by Joe Lucero on 2/12/18.
//  Copyright © 2018 Joe Lucero. All rights reserved.
//

import UIKit

class MainTableViewController: UITableViewController {
   
   @IBOutlet weak var textTextField: UITextField!
   
   @IBAction func postPressed() {
      guard let text = textTextField.text, !text.isEmpty else { return }
      MessageController.shared.saveNewMessageWith(text: text)
      textTextField.text = ""
   }
   
   override func viewDidLoad() {
      super.viewDidLoad()
      NotificationCenter.default.addObserver(self, selector: #selector(refreshTableView), name: JLNotifications.messagesUpdated, object: nil)
      MessageController.shared.loadMessages()
   }
   
   @objc func refreshTableView() {
      DispatchQueue.main.async {
         self.tableView.reloadData()
      }
   }
   
   // MARK: - Table view data source
   override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      // #warning Incomplete implementation, return the number of rows
      return MessageController.shared.messages.count
   }
   
   override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let cell = tableView.dequeueReusableCell(withIdentifier: "MessageCell", for: indexPath)
      
      let message = MessageController.shared.messages[indexPath.row]
      cell.textLabel?.text = message.text
      cell.detailTextLabel?.text = message.date.description
      
      return cell
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
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
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
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
   
}
