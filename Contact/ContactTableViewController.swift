//
//  ContactTableViewController.swift
//  Contact
//
//  Created by MacBookAir on 26/11/22.
//

import UIKit

class ContactTableViewController: UITableViewController, UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        let scopeButton = searchBar.scopeButtonTitles![searchBar.selectedScopeButtonIndex]
        let searchText = searchBar.text!
        
        //filterForSearchTextAndScopeButton(searchText, scopeButton)
    }
    
    /*func filterForSearchTextAndScopeButton(searchText: String, scopeButton: String = "All"){
        filteredContacts = contactsData.filter {
            Contact in
            let scopeMatch = (scopeButton = "All" || Contact.first_name)
        }
    }*/
    
    
    var contactsData = [Contact]()
    let searchController = UISearchController()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        initSearchController()
        
        /*searchController.delegate = self
        searchController.searchBar.delegate = self
        self.navigationItem.searchController = searchController
        self.navigationItem.searchController?.searchBar.placeholder = "search".localizedCapitalized
        //self.navigationItem.searchController?.dimsBackgroundDuringPresentation = false
        self.navigationItem.hidesSearchBarWhenScrolling = false*/
    }
    
    func initSearchController() {
        searchController.loadViewIfNeeded()
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.enablesReturnKeyAutomatically = false
        searchController.searchBar.returnKeyType = UIReturnKeyType.done
        definesPresentationContext = true
        
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        
        searchController.searchBar.scopeButtonTitles = ["All", "Male", "Female"]
        
        searchController.searchBar.delegate = self
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
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(identifier: "DetallesViewController") as? DetallesViewController {
            let contactDetail = contactsData[indexPath.row]
            
            guard let cell = tableView.cellForRow(at: indexPath) as? ContactTableViewCell
                 else{
                   return
                 }
            
            vc.imgProfile = cell.portraitImageView.image!
            vc.detailName = contactDetail.first_name
            vc.detailEmail = contactDetail.email
            vc.detailTelefono = contactDetail.phone_number
            vc.detailEdad = contactDetail.age
            vc.detailRfc = contactDetail.rfc
            vc.detailDob = contactDetail.dob
            vc.detailGender = contactDetail.gender
            vc.detailDegree = contactDetail.academic_degree
            
            self.navigationController?.pushViewController(vc, animated: true)
        }
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
