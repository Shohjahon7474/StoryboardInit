//
//  HomeViewController.swift
//  StoryboardContact
//
//  Created by Asadulla Juraev on 03/11/21.
//

import UIKit

class HomeViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource, HomeView {
    
    @IBOutlet weak var tableView: UITableView!
    var items: Array<Contact> = Array()
    var presenter: HomePresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(doThisWhenNotify(notification:)), name: NSNotification.Name(rawValue: "load"), object: nil)
        initView()
        
    }
    
    func initView(){
        initNavigation()
        tableView.delegate = self
        tableView.dataSource = self
        
        presenter = HomePresenter()
        presenter.homeView = self
        presenter.controller = self
        presenter?.apiContactList()
    }
    
    func onLoadContacts(contacts: [Contact]) {
        if contacts.count > 0 {
            refreshTableView(contacts: contacts)
        }else{
            // error
        }
    }
    
    func onContactDelete(deleted: Bool) {
        if deleted {
            presenter?.apiContactList()
        }else{
            // error
        }
    }
    
    func refreshTableView(contacts: [Contact]) {
        self.items = contacts
        self.tableView.reloadData()
    }
    
    func initNavigation(){
        let refresh = UIImage(systemName: "arrow.clockwise")
        let add = UIImage(systemName: "person.fill.badge.plus")
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: refresh, style: .plain, target: self, action: #selector(leftTapped))
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: add, style: .plain, target: self, action: #selector(rightTapped))
        title = "Contact list"

        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .gray
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]

        // Customizing our navigation bar
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    func callCreateViewController(){
        let vc = CreateViewController(nibName: "CreateViewController", bundle: nil)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func callEditViewController(id: String){
        let vc = EditViewController(nibName: "EditViewController", bundle: nil)
        vc.ContactID = id
        let navigationController = UINavigationController(rootViewController: vc)
        
        self.present(navigationController, animated: true, completion: nil)
    }

    @objc func leftTapped(){
        presenter?.apiContactList()
    }
    
    @objc func rightTapped(){
        callCreateViewController()
    }

    @objc func doThisWhenNotify(notification : NSNotification) {
        //update tableview

        presenter?.apiContactList()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = items[indexPath.row]
        
        let cell = Bundle.main.loadNibNamed("ContactTableViewCell", owner: self, options: nil)?.first as! ContactTableViewCell
        cell.titleLabel.text = item.name
        cell.numberLabel.text = item.number
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        return UISwipeActionsConfiguration(actions: [
            makeCompleteContextualAction(forRowAt: indexPath, contact: items[indexPath.row])
        ])
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        return UISwipeActionsConfiguration(actions: [
            makeDeleteContextualAction(forRowAt: indexPath, contact: items[indexPath.row])
        ])
    }
    
    //MARK: - Contextual Actions
    
    private func makeDeleteContextualAction(forRowAt: IndexPath, contact: Contact) -> UIContextualAction{
        return UIContextualAction(style: .destructive, title: "Delete") { (action, swipeButtonView, completion) in
            
            completion(true)
            self.presenter?.apiContactDelete(contact: contact)
        }
    }
    
    private func makeCompleteContextualAction(forRowAt: IndexPath, contact: Contact) -> UIContextualAction{
        return UIContextualAction(style: .normal, title: "Edit") { (action, swipeButtonView, completion) in
            
            completion(true)
            self.callEditViewController(id: contact.id!)
            
        }
    }
    
}
