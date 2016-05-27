

import UIKit

class HomePageViewController: UIViewController {
    
    var m_editVC:EditViewController?
    var m_listVC:ListViewController?
    
    
    func refreshWithFrame(frame:CGRect) {
        
        self.view.frame = frame
        self.view.backgroundColor = UIColor.whiteColor()
        self.title = "首頁"
        
        //=====================  HomePage 背景圖片  ========================
        let backgroundImgView = UIImageView(frame: CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height))
        backgroundImgView.image = UIImage(named: "postit_0.png")
        backgroundImgView.contentMode = .ScaleAspectFill
        self.view.addSubview(backgroundImgView)
        
        //=====================  addNoteBt  ==============================
        let addNoteBt = UIButton(frame: CGRect(x: 0, y: 0, width: frame.size.width*0.68, height: frame.size.width*0.68))
        addNoteBt.center = CGPoint(x: frame.size.width/2, y: frame.size.height/2)
        addNoteBt.setBackgroundImage(UIImage(named: "postit_1.png"), forState: .Normal)
        addNoteBt.setBackgroundImage(UIImage(named: "postit_2.png"), forState: .Highlighted)
        addNoteBt.addTarget(self, action: #selector(HomePageViewController.addNoteBtAction(_:)), forControlEvents: .TouchUpInside)
        self.view.addSubview(addNoteBt)
        
    }

//MARK: - Override Function
//-------------------------
    override func viewDidLoad() {
        
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        
        super.viewWillAppear(true)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "我的便利貼", style: .Plain, target: self, action: #selector(HomePageViewController.onBarBtItemAction(_:)))
        
    }

    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
    }
    
//MARK: - onBarBtItemAction
//-------------------------
    func onBarBtItemAction(sender:UIBarButtonItem) {
        
        if m_listVC == nil {
            
            m_listVC = ListViewController()
            m_listVC?.refreashWithFrame(CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height))
        }
        
        self.navigationController?.pushViewController(m_listVC!, animated: true)
    }
    
//MARK: - addNoteBtAction
//-----------------------
    func addNoteBtAction(sender:UIButton) {
        
        if m_editVC == nil {
            
            m_editVC = EditViewController()
            m_editVC?.refreshWithFrame(CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height), navHeight: self.navigationController!.navigationBar.frame.size.height + UIApplication.sharedApplication().statusBarFrame.height)
        }
        
        m_editVC?.m_parentObj = self
        self.navigationController?.pushViewController(m_editVC!, animated: true)
    }
    

}//end class
