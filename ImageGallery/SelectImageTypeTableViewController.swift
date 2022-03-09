//
//  SelectImageTypeTableViewController.swift
//  ImageGallery
//
//  Created by Vasile Sebastian Catur on 07.03.2022.
//

import UIKit

class SelectImageTypeTableViewController: UITableViewController {

    private var selectedUrls = [String]()
    var keyToModify = ""
    var number = 0
    var themes = InitialDict()
    var themesDefaults = [[String:[String]?]]()
    var  array = UserDefaults.standard.array(forKey: "themesArrayOfDict") as? [[String:[String]?]]



    override func viewDidLoad() {
        super.viewDidLoad()
        if let array = array {
            themesDefaults = array
        }
    }

    @IBAction func addTheme(_ sender: UIBarButtonItem) {
        number += 1
        var dict = [String:[String]]()
        dict["Untitled \(number)"] = [String]()
        themesDefaults.append(dict)
        UserDefaults.standard.set(themesDefaults, forKey: "themesArrayOfDict")
        tableView.reloadData()
    }
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return themesDefaults.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ThemeTableViewCell", for: indexPath)
        cell.textLabel?.text = themesDefaults[indexPath.row].keys.first
        return cell
    }


    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let arr = UserDefaults.standard.array(forKey: "themesArrayOfDict") as? [[String:[String]?]]
        if let array = arr {
            themesDefaults = array
        }

        if !themesDefaults[indexPath.row].values.isEmpty {
            if let imgListUrls = themesDefaults[indexPath.row].values.first {
                selectedUrls = imgListUrls ?? [""]
            }

            if let key = themesDefaults[indexPath.row].keys.first {
                keyToModify = key
            }
            performSegue(withIdentifier: "ShowImages", sender: indexPath.row)
        }


    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
//        if splitViewController?.preferredDisplayMode != UISplitViewController.DisplayMode.oneOverSecondary {
//            splitViewController?.preferredDisplayMode = UISplitViewController.DisplayMode.oneOverSecondary
//        }
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? ImageCollectionVC {
            vc.imageListUrls = selectedUrls
            vc.keyToModify = keyToModify
        }
    }


    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }


    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            themesDefaults.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
}
