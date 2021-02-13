//
//  UIViewcontrollerExtension.swift
//  WhereApp
//
//  Created by Salman Nasir on 10/03/2017.
//  Copyright © 2017 Ilsainteractive. All rights reserved.
//

import UIKit
import CoreLocation
import Toast_Swift
//protocol popForviewController : class {
//    func AcceptButtonClick()
//    func RejectButtonClick()
//}
//
//enum ToggleState {
//    case on
//    case off
//}

extension UIViewController {
    func showAlert(title: String, message: String, controller: UIViewController?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(action)
        if controller != nil {
            controller?.present(alert, animated: true, completion: nil)
        }else {
            present(alert, animated: true, completion: nil)
        }
        

    }
    
    func showConfirmationAlertViewWithTitle(title:String,message : String, dismissCompletion:@escaping (AlertViewDismissHandler))
    {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        
        alertController.addAction(UIAlertAction(title: "NO", style: .cancel, handler: { action -> Void in
            //Do some other stuff
            
        }))
        alertController.addAction(UIAlertAction(title: "YES", style: .default, handler: { action -> Void in
            //Do some other stuff
            dismissCompletion()
        }))

        
        present(alertController, animated: true, completion:nil)
    }

    
    func showAlertViewWithTitle(title:String,message : String, dismissCompletion:@escaping (AlertViewDismissHandler))
    {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: { action -> Void in
            //Do some other stuff
            dismissCompletion()
        }))
        
        alertController.addAction(UIAlertAction(title: "Cancel", style: .default, handler: { action -> Void in
            //Do some other stuff
//            dismissCompletion()
        }))
        
        present(alertController, animated: true, completion:nil)
    }

    
    @IBAction func popController(_ sender: UIButton) {
        _ = self.navigationController?.popViewController(animated: true)
    }
    

    func pushToViewControllerWithStoryboardID(storyboardId:String) {
        
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: storyboardId)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func showNotification(with message: String?, viewss : UIView ,  autoDismiss: Bool = true,   handler: (() -> ())? = nil) {
        let notificationLabel = UILabel()
        notificationLabel.translatesAutoresizingMaskIntoConstraints = false
        notificationLabel.text = message
        notificationLabel.textColor = .black
        notificationLabel.textAlignment = .center
        notificationLabel.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        notificationLabel.backgroundColor = UIColor.white.withAlphaComponent(0.8)
        notificationLabel.numberOfLines = 0
        
        guard let navigationController = navigationController else { return }
        
        //        let subviews = navigationController.navigationBar.subviews.filter({ $0 is UILabel })
        
        let subviews = viewss.subviews.filter({$0 is UILabel})
        
        //        navigationController.navigationBar.insertSubview(notificationLabel, at: subviews.count > 0 ? subviews.count : 0)
        self.view.insertSubview(notificationLabel, at: subviews.count > 0 ? subviews.count : 0)
        notificationLabel.centerXAnchor.constraint(equalTo: viewss.centerXAnchor).isActive = true
        notificationLabel.topAnchor.constraint(equalTo: viewss.bottomAnchor).isActive = true
        notificationLabel.widthAnchor.constraint(equalTo: viewss.widthAnchor).isActive = true
        notificationLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 32).isActive = true
        
        notificationLabel.sizeToFit()
        
        notificationLabel.transform = CGAffineTransform(translationX: 0, y: -notificationLabel.frame.height)
        
        UIView.animate(withDuration: 0.25) {
            notificationLabel.transform = .identity
        }
        
        if autoDismiss {
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                UIView.animate(withDuration: 0.25, animations: {
                    notificationLabel.alpha = 0
                    notificationLabel.transform = CGAffineTransform(translationX: 0, y: -notificationLabel.frame.height)
                }, completion: { (done) in
                    notificationLabel.removeFromSuperview()
                    handler?()
                })
            }
        }
    }


    func showToast(_ message: String?) {
        view.makeToast(message)
    }
    
//    func showAlertAppeareance() {
//        let appearance = SCLAlertView.SCLAppearance(
//            kTitleFont: UIFont(name: "HelveticaNeue", size: 20)!,
//            kTextFont: UIFont(name: "HelveticaNeue", size: 14)!,
//            kButtonFont: UIFont(name: "HelveticaNeue-Bold", size: 14)!,
//            showCloseButton: false,
//            dynamicAnimatorActive: true,
//            buttonsLayout: .horizontal
//        )
//        let alert = SCLAlertView(appearance: appearance)
//        _ = alert.addButton("YES", target:self, selector:#selector(UIViewController.firstButton))
//        _ = alert.addButton("NO", target:self, selector:#selector(UIViewController.secondButton))
//        let icon = UIImage(named:"logo")
//        let color = UIColor.orange
//
//        _ = alert.showCustom("Hot Shot", subTitle: ("Are you sure to cancel the booking" as? String)!, color: color, icon: icon!, circleIconImage: icon!)
//
//    }
//
//    @objc func firstButton() {
//
//    }
//
//    @objc func secondButton() {
//
//    }
}

extension UITableView {
    func registerCells(_ cells: [UITableViewCell.Type]) {
        
        cells.forEach({ register(UINib(nibName: String(describing: $0), bundle: nil), forCellReuseIdentifier: String(describing: $0)) })
    }
    
    func registerHeaderFooter(_ headerFooter: [UITableViewHeaderFooterView.Type]) {
        headerFooter.forEach({ register(UINib(nibName: String(describing: $0), bundle: nil), forHeaderFooterViewReuseIdentifier: String(describing: $0)) })
    }
    
    func dequeueReusableCell<T: UITableViewCell>(with type: T.Type, for indexPath: IndexPath) -> T {
        let cell = dequeueReusableCell(withIdentifier: String(describing: type), for: indexPath) as! T
        return cell
    }
    
    func dequeueReusableHeaderFooterView<T: UITableViewHeaderFooterView>(with type: T.Type) -> T? {
        return dequeueReusableHeaderFooterView(withIdentifier: String(describing: type)) as? T
    }
    
//    func scrollToBottomRow() {
//            DispatchQueue.main.async {
//                guard self.numberOfSections > 0 else { return }
//
//                // Make an attempt to use the bottom-most section with at least one row
//                var section = max(self.numberOfSections - 1, 0)
//                var row = max(self.numberOfRows(inSection: section) - 1, 0)
//                var indexPath = IndexPath(row: row, section: section)
//
//                // Ensure the index path is valid, otherwise use the section above (sections can
//                // contain 0 rows which leads to an invalid index path)
//                while !self.indexPathIsValid(indexPath) {
//                    section = max(section - 1, 0)
//                    row = max(self.numberOfRows(inSection: section) - 1, 0)
//                    indexPath = IndexPath(row: row, section: section)
//
//                    // If we're down to the last section, attempt to use the first row
//                    if indexPath.section == 0 {
//                        indexPath = IndexPath(row: 0, section: 0)
//                        break
//                    }
//                }
//
//                // In the case that [0, 0] is valid (perhaps no data source?), ensure we don't encounter an
//                // exception here
//                guard self.indexPathIsValid(indexPath) else { return }
//
//                self.scrollToRow(at: indexPath, at: .bottom, animated: true)
//            }
//      }
    
        func indexPathIsValid(_ indexPath: IndexPath) -> Bool {
            let section = indexPath.section
            let row = indexPath.row
            return section < self.numberOfSections && row < self.numberOfRows(inSection: section)
        }
    
    func scrollToBottomView(animated: Bool = true) {
        let section = self.numberOfSections
        if section > 0 {
            let row = self.numberOfRows(inSection: section - 1)
            if row > 0 {
                self.scrollToRow(at: NSIndexPath(row: row - 1, section: section - 1) as IndexPath, at: .bottom, animated: animated)
            }
        }
    }
    
    func scrollToBottom(){
        
//        let section = self.numberOfSections
//        let row = self.numberOfRows(inSection: self.numberOfSections - 1) - 1;
//        guard (section > 0) && (row > 0) else{ // check bounds
//            return
//        }
//        let indexPath = IndexPath(row: row - 1, section: section - 1)
//        self.scrollToRow(at: indexPath, at: .top, animated: true)
            DispatchQueue.main.async {
                let indexPath = IndexPath(
                    row: self.numberOfRows(inSection:  self.numberOfSections - 1 ) - 1,
                    section: self.numberOfSections - 1)
                self.scrollToRow(at: indexPath, at: .bottom, animated: true)
            }
        }
        
        func scrollToTop() {
            
            DispatchQueue.main.async {
                let indexPath = IndexPath(row: 0, section: 0)
                self.scrollToRow(at: indexPath, at: .top, animated: false)
            }
        }
    
    func reloadWithoutAnimation() {
        let lastScrollOffset = contentOffset
        beginUpdates()
        endUpdates()
        layer.removeAllAnimations()
        setContentOffset(lastScrollOffset, animated: false)
    }

    
    func kostylAgainstJumping(_ block: () -> Void) {
        self.contentInset.bottom = 300
        block()
        self.contentInset.bottom = 0
    }

    func scrollToBottomss(animated: Bool) {
        let y = contentSize.height - frame.size.height
        if y < 0 { return }
        setContentOffset(CGPoint(x: 0, y: y), animated: animated)
    }

    
    func reloadDataSmoothly() {
        UIView.setAnimationsEnabled(false)
        CATransaction.begin()
        
        CATransaction.setCompletionBlock {[weak self] () -> Void in
            UIView.setAnimationsEnabled(true)
        }
        
        reloadData()
        beginUpdates()
        endUpdates()
        
        CATransaction.commit()
    }

    }
