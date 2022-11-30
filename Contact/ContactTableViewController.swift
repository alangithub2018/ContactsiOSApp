//
//  ContactTableViewController.swift
//  Contact
//
//  Created by MacBookAir on 26/11/22.
//

import UIKit

class ContactTableViewController: UITableViewController {
    
    var contactsData = [Contact]()
    let searchController = UISearchController(searchResultsController: nil)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchController.delegate = self
        searchController.searchBar.delegate = self
        self.navigationItem.searchController = searchController
        self.navigationItem.searchController?.searchBar.placeholder = "search".localizedCapitalized
        //self.navigationItem.searchController?.dimsBackgroundDuringPresentation = false
        self.navigationItem.hidesSearchBarWhenScrolling = false
        
        /*Networking.makeHTTPRequest(
            completion: { data in
                self.contactsData = data
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            },
            endpoint: "/contacts"
        )*/

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func viewWillAppear(_ animated: Bool) {
        Networking.makeHTTPRequest(
            completion: { data in
                self.contactsData = data
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            },
            endpoint: "/contacts"
        )
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return contactsData.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier = "tableCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? ContactTableViewCell
        else {
            fatalError("The dequeued cell is not an instance of ContactTableViewCell.")
        }

        // Configure the cell...
        let contact = contactsData[indexPath.row]
        cell.portraitImageView.loadThumbnail(urlString: contact.profile_image)
        cell.nameLabel.text = contact.first_name
        cell.titleLabel.text = contact.phone_number

        return cell
    }
}

extension ContactTableViewController : UISearchControllerDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.navigationItem.searchController?.searchBar.text = ""
        self.tableView.reloadData()
    }
}

extension ContactTableViewController : UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)
    }
}
