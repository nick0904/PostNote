

import UIKit
import CoreData

class ListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate ,NSFetchedResultsControllerDelegate {
    
    var m_tabelView:UITableView?
    
    var m_note = [Note]()
    
    var m_detailVC:DeatilViewController?
    
    //NSFetchedResultsControllerDelegate 只要資料一有變更,便會通知代理人
    var fetchResultController:NSFetchedResultsController!

    
    func refreashWithFrame(frame:CGRect) {
        
        self.view.frame = frame
        self.title = "我的便利貼"
        
        //==========================   讀 取 步 驟   ===============================
        let fetchRequest = NSFetchRequest(entityName: "Note")
        
        //分類排序
        //指定 noteContext 為昇序排列
        let sortDescriptors = NSSortDescriptor(key: "noteContext", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptors]
        
        if let manageObjectContext = (UIApplication.sharedApplication().delegate as? AppDelegate)?.managedObjectContext {
            
            fetchResultController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: manageObjectContext, sectionNameKeyPath: nil, cacheName: nil)
            
            fetchResultController.delegate = self
            
            do {
                
                try fetchResultController.performFetch()
                m_note = fetchResultController.fetchedObjects as! [Note]
                
            } catch {
                
                print("讀取失敗")
            }
        }

        
        //=======================   m_tabelView  =======================
        let backgroubdImgView = UIImageView(frame: CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height))
        backgroubdImgView.contentMode = .ScaleAspectFill
        backgroubdImgView.image = UIImage(named: "back.png")
        m_tabelView = UITableView(frame: CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height))
        m_tabelView?.backgroundView = backgroubdImgView
        m_tabelView?.dataSource = self
        m_tabelView?.delegate = self
        self.view.addSubview(m_tabelView!)
    }

    override func viewWillAppear(animated: Bool) {
        
        super.viewWillAppear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//MARK: - FecthedResultController Delegate
//----------------------------------------
    func controllerWillChangeContent(controller: NSFetchedResultsController) {
        
        self.m_tabelView?.beginUpdates()
    }
    
    func controller(controller: NSFetchedResultsController, didChangeObject anObject: AnyObject, atIndexPath indexPath: NSIndexPath?, forChangeType type: NSFetchedResultsChangeType, newIndexPath: NSIndexPath?) {
        
        switch type {
            
        case .Insert:
            if let myNewIndexPath = newIndexPath {
                
                self.m_tabelView?.insertRowsAtIndexPaths([myNewIndexPath], withRowAnimation: .Fade)
            }
            
        case .Delete:
            if let myIndexPath = indexPath {
                
                self.m_tabelView?.deleteRowsAtIndexPaths([myIndexPath], withRowAnimation: .Left)
            }
            
        case .Update:
            if let myIndexPath = indexPath {
                
                self.m_tabelView?.reloadRowsAtIndexPaths([myIndexPath], withRowAnimation: .Fade)
            }
            
        default:
            self.m_tabelView?.reloadData()
        }
        
        m_note = controller.fetchedObjects as! [Note]
    }
    
    func controllerDidChangeContent(controller: NSFetchedResultsController) {
        
        self.m_tabelView?.endUpdates()
    }
    
    
//MARK: - UITableView  DataSource & Delegate
//------------------------------------------
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return m_note.count
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell_id:String = "CELL_ID"
        var my_cell = tableView.dequeueReusableCellWithIdentifier(cell_id) as! MyTableViewCell!
        
        if my_cell == nil {
            
            my_cell = MyTableViewCell()
            my_cell.refreashWithFrame(CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height/4))
            my_cell.accessoryType = .DisclosureIndicator
        }
        
        my_cell.m_imgView?.image = UIImage(data: self.m_note[indexPath.row].noteImage)
        my_cell.m_contextLabel?.text = self.m_note[indexPath.row].noteContext
        
        return my_cell
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        if m_detailVC == nil {
            
            m_detailVC = DeatilViewController()
            m_detailVC?.resreashWithFrame(UIScreen.mainScreen().bounds, navHeight: self.navigationController!.navigationBar.frame.size.height)
        }
        
        m_detailVC?.m_parentObj = self
        m_detailVC?.m_imgView?.image = UIImage(data: self.m_note[indexPath.row].noteImage)
        m_detailVC?.m_textView?.text = self.m_note[indexPath.row].noteContext
        
        self.navigationController?.pushViewController(m_detailVC!, animated: true)
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        return self.view.frame.size.height/4
    }
    
    func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
        
        let shareAction = UITableViewRowAction(style: .Default, title: "分享") { (action, indexPath) in
            
            let shareText:String = self.m_note[indexPath.row].noteContext
            let shareImg = UIImage(data: self.m_note[indexPath.row].noteImage)
            self.shareMyNote(shareText, img: shareImg!)
            
        }
        shareAction.backgroundColor = UIColor.blueColor()
        
        let deleteAction = UITableViewRowAction(style: .Default, title: "刪除") { (action, indexPath) in
            
            if let managedObjectContext = (UIApplication.sharedApplication().delegate as? AppDelegate)?.managedObjectContext {
                
                let deleteItem = self.fetchResultController.objectAtIndexPath(indexPath) as! Note
                managedObjectContext.deleteObject(deleteItem)
                
                do {
                    
                    try managedObjectContext.save()
                    
                } catch {
                    
                    
                }
            
            }
            
        }
        
        return [shareAction,deleteAction]
        
    }
    

//MARK: - shareMyNote
//-------------------
    func shareMyNote(text:String?,img:UIImage?) {
        
        let actionSheet = UIAlertController(title: "分享我的便利貼", message: "", preferredStyle: .ActionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "僅 分享文字", style: .Default, handler: { (action) in
            
            let activityController = UIActivityViewController(activityItems: [text!], applicationActivities: nil)
            self.presentViewController(activityController, animated: true, completion: nil)
        }))
        
        actionSheet.addAction(UIAlertAction(title: "僅 分享圖片", style: .Default, handler: { (action) in
            
            let activityController = UIActivityViewController(activityItems: [img!], applicationActivities: nil)
            self.presentViewController(activityController, animated: true, completion: nil)
            
        }))
        
        actionSheet.addAction(UIAlertAction(title: "分享文字與圖片", style: .Default, handler: { (action) in
            
            let activityController = UIActivityViewController(activityItems: [text!,img!], applicationActivities: nil)
            self.presentViewController(activityController, animated: true, completion: nil)
        }))
        
        actionSheet.addAction(UIAlertAction(title: "取消", style: .Destructive, handler: nil))
        self.presentViewController(actionSheet, animated: true, completion: nil)
        

        
    }
    

}//end class
