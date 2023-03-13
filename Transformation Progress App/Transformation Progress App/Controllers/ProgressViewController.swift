import UIKit
import CoreData

class TodoListViewController: UITableViewController {
    
    var itemArray = [Item]()
    
    var selectedCategory : Category? {
        didSet{
            loadItems()
        }
    }
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // create a file path to the Documents folder
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        
        //?


        
    }
    
    //MARK: - Tableview Datasource Methods
    //method simply returns the number of items in the itemArray. This means that the table view will display one row for each item in the itemArray. If the itemArray is empty, the table view will have no rows.
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    //section: an integer representing the section of the table view (useful for table views with multiple sections)
    
    
    //is a key method for configuring and displaying cells in a UITableView-> custom cell layouts and behavior.
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // subclass that configures and returns a cell for a given row in the table view.
        
        //when the table view needs to display a cell for a specific row. It takes in two parameters:
        
        //    tableView: the UITableView instance that is requesting the cell
        //    indexPath: an IndexPath object representing the section and row of the cell to be displayed
        
        //he method dequeues a reusable cell from the table view using the identifier "ToDoItemCell
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        let item = itemArray[indexPath.row]
        // retrieves the item object from the itemArray at the specified indexPath.row and sets the cell's text label to the item's title.
        
        
        cell.textLabel?.text = item.title
        
        //Ternary operator ==>
        // value = condition ? valueIfTrue : valueIfFalse
        
        cell.accessoryType = item.done ? .checkmark : .none
        // set the cell's accessoryType property to either .checkmark or .none based on the value of the item's done property. If item.done is true,
        
        return cell
        //method returns the configured cell to the table view.
    }
    
    //MARK: - TableView Delegate Methods
    //key method for responding to user interactions in a UITableView
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//is a method in a UITableViewController subclass that gets called when the user taps on a row in the table view.
        
//called automatically by the system when the user selects a row, and it provides you with the tableView
        
//used for Updating the UI, Navigating to a new view controller, Performing some action based on the selected row
        
        
//        context.delete(itemArray[indexPath.row])
//        itemArray.remove(at: indexPath.row)
        
        //so the booleans can have ether true or false
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
// This essentially toggles the completion status of the item, marking it as complete if it was previously incomplete, or marking it as incomplete if it was previously complete.
        
        saveItems()
        
        //common method call used in UITableView delegate methods such as tableView(_:didSelectRowAt:)
        tableView.deselectRow(at: indexPath, animated: true)
        // by default, the row remains highlighted (i.e., selected) until another row is selected or until the view is refreshed. However, in many cases, it is desirable to deselect the row immediately after the user has tapped on it.
        //If animated is set to true, the row will fade out; if it is set to false, the row will be deselected immediately without any animation.
        
    }
    
    //MARK: - Add New Items
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        // creates a new UIAlertController object with a title, message, and style.
        //message parameter specifies additional text to be displayed below the title.
        
        //The preferredStyle parameter specifies the style of the alert. I
        //.alert indicates that the alert should be presented as a dialog box with rounded corners and a gray background.
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            //what will happen once the user clicks the Add Item button on our UIAlert
            
            
            //we are creating a newItem using our class Item
            //context where this item is going to exist -> viewContext of persistentContainer.
            let newItem = Item(context: self.context)
            
            //setting the title
            newItem.title = textField.text!
            
            //deafaukt of bool giving false for the .done property
            newItem.done = false
            
            newItem.parentCategory = self.selectedCategory
            //used when the user creates a new item and assigns it to a category.
            //sorting the items based on their category.
            //important part of creating and organizing items in a to-do list app, and is often used in conjunction with other data models and database operations.
            
            self.itemArray.append(newItem)
            
            self.saveItems()
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
            
        }
        
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
        
    }
    
    //MARK: - Model Manupulation Methods
    
    //encoding and saving  storing
    func saveItems() {
        
        do {
          try context.save()
        } catch {
           print("Error saving context \(error)")
        }
        
        self.tableView.reloadData()
    }
    
    //decoding and retrieving 
    func loadItems(with request: NSFetchRequest<Item> = Item.fetchRequest(), predicate: NSPredicate? = nil) {
        
        let categoryPredicate = NSPredicate(format: "parentCategory.name MATCHES %@", selectedCategory!.name!)
        
        if let addtionalPredicate = predicate {
            request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [categoryPredicate, addtionalPredicate])
        } else {
            request.predicate = categoryPredicate
        }

        
        do {
            itemArray = try context.fetch(request)
        } catch {
            print("Error fetching data from context \(error)")
        }
        
        tableView.reloadData()
        
    }
    
}

//MARK: - Search bar methods
extension TodoListViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {

        let request : NSFetchRequest<Item> = Item.fetchRequest()
    
        let predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!)
        
        request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
        
        loadItems(with: request, predicate: predicate)
        
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0 {
            loadItems()
            
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
          
        }
    }
}







