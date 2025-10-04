//
//  PortfolioViewController.swift
//  Portfolio
//
//  Created by Ausias on 02/04/16.
//  Copyright © 2016 kobiuter. All rights reserved.
//

import UIKit

class PortfolioViewController: UIViewController, PortfolioTableViewControllerDelegate {

    // OTHER CONTROLLERS
    
    /** Controller that contains the table view with all the assets */
    var portfolioTableViewController: PortfolioTableViewController?
    
    /** Controller for the lock screen for privacy reasons. */
    var lockScreenViewController: LockScreenViewController?
    
    // MODEL
    
    /** Height of the portfolio header. */
    let portfolioHeaderHeight: CGFloat = 100.0
    
    /** Model for the portfolio header. */
    // FIXME: this model may not be necessary for now...
    var portfolioHeader = PortfolioHeader()
    
    /** True if the portfolio should use the local currency to display value. */
    var _shouldUseLocalCurrency: Bool = false
    
    
    
    // VIEW
    
    @IBOutlet weak var TotalValue: UILabel!
    
    /** Button to toggle privacy mode for the total value. */
    var privacyToggleButton: UIButton!
    
    /** Visual effect view for blurring the total value. */
    var blurEffectView: UIVisualEffectView?
    
    /** Animator to control blur intensity. */
    var blurAnimator: UIViewPropertyAnimator?
    
    /** True if the total value should be hidden for privacy. */
    var _isValueHidden: Bool = false
    @IBAction func tapOnTotalValue(_ sender: UITapGestureRecognizer) {
        _shouldUseLocalCurrency = !_shouldUseLocalCurrency
        
        portfolioTableViewController?.refresh()
        
    }
    
    @IBAction func refreshPortfolio(_ sender: AnyObject) {
        // Update portfolio table model and view
        portfolioTableViewController?.refresh()
    }
    
    @IBOutlet weak var SortPortfolioButton: UIBarButtonItem!
    @IBAction func sortPortfolio(_ sender: Any) {
        // Sort portfolio table 
        portfolioTableViewController?.sort()
    }
    
    
    
    //  o   o o--o o-O-o o  o  o-o  o-o    o-o
    //  |\ /| |      |   |  | o   o |  \  |
    //  | O | O-o    |   O--O |   | |   O  o-o
    //  |   | |      |   |  | o   o |  /      |
    //  o   o o--o   o   o  o  o-o  o-o   o--o
    //
    //
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        /************ VIEWS ****************/
        // Add portfolio table view controller as child
        let myStoryboard:UIStoryboard = self.storyboard!
        portfolioTableViewController = (myStoryboard.instantiateViewController(withIdentifier: "PortfolioTableControllerID") as! PortfolioTableViewController)
        
        // Present portfolio table view controller and handle view hierarchy
        addNewChildViewController(portfolioTableViewController!, parentView: self.view)
        
        // Position portfolio table within the main portfolio controller view
        portfolioTableViewController?.view.frame = CGRect(x: 0, y: portfolioHeaderHeight, width: self.view.frame.width, height: self.view.frame.height - portfolioHeaderHeight)
        
        // Add self as delegate for the portfolio table view controller
        portfolioTableViewController?.delegate = self
        
        // Setup privacy toggle button
        setupPrivacyToggleButton()
        
        // Add observers for app lifecycle events
        NotificationCenter.default.addObserver(self, selector: #selector(appWillEnterForeground), name: UIApplication.willEnterForegroundNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(appDidBecomeActive), name: UIApplication.didBecomeActiveNotification, object: nil)
        
        // Present privacy screen and request authentication
        lockScreenViewController = (myStoryboard.instantiateViewController(withIdentifier: "LockScreenID") as! LockScreenViewController)
        lockScreenViewController!.modalPresentationStyle = .overFullScreen
        
        self.parent?.present(lockScreenViewController!, animated: false, completion:
            {() -> Void in
                // Init portfolio once the privace screen finished appearing
                self.portfolioTableViewController?.initPortfolio()
                self.portfolioTableViewController?.sortByMethod(aSortMethod: SortMethod.Percent)
        })
        lockScreenViewController!.isLocked = true
        lockScreenViewController!.requestLocalAuthentication()
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Restore blur state if it was hidden when returning to view
        if _isValueHidden {
            refreshBlurEffect()
        }
    }
    
    @objc func appWillEnterForeground() {
        // Refresh blur early when app is about to enter foreground (before Face ID)
        if _isValueHidden {
            refreshBlurEffect()
        }
    }
    
    @objc func appDidBecomeActive() {
        // Refresh blur when app becomes active (after Face ID)
        if _isValueHidden {
            // Add a small delay to ensure Face ID UI is dismissed
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { [weak self] in
                self?.refreshBlurEffect()
            }
        }
    }
    
    deinit {
        // Remove observers when view controller is deallocated
        NotificationCenter.default.removeObserver(self, name: UIApplication.willEnterForegroundNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIApplication.didBecomeActiveNotification, object: nil)
    }
    
    
    
    func addNewChildViewController(_ viewController:UIViewController, parentView:UIView) {
        // Add controller to the controllers hierarchy
        // This also calls willMoveToParentViewController
        self.addChild(viewController)
        
        // Add controller's view to parent's view hierarchy
        parentView.addSubview(viewController.view)
        
        // Notify controller it was added to parent controller hierarchy
        viewController.didMove(toParent: self)
        
    }
    
    
    
    /** Manage controller view size changes including rotations. */
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        // Manage rotation
        print("View is about to rotate!")
        
        // TODO: Implement changes on UI for rotation. For instance, in portrait mode we show symbols of currencies while in landscape we show the full name.
        
    }
    
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if (segue.identifier == "TreemapView") {
            //if you need to pass data to the next controller do it here
            // Get the new view controller using segue.destinationViewController.
            let treemapViewController: TreemapViewController = segue.destination as! TreemapViewController
            
            // Pass the selected object to the new view controller.
            treemapViewController.portfolio = portfolioTableViewController?.portfolio
        }
    }
 
    
    
    /** Updates the label of the portfolio button. */
    func ChangeSortButtonLabelToMethod(aSortMethod: SortMethod) {
        var sortButtonSymbol: String
        
        switch aSortMethod {
        case SortMethod.Name:
            sortButtonSymbol = "@"
        case SortMethod.Price:
            sortButtonSymbol = "$"
        case SortMethod.Quantity:
            sortButtonSymbol = "Q"
        case SortMethod.Value:
            sortButtonSymbol = "V"
        case SortMethod.Percent:
            sortButtonSymbol = "%"
        }
        
        // Update sort button symbol
        SortPortfolioButton.title = sortButtonSymbol
    }
    
    
    
    // MARK: - Data persistence methods
    
    func savePortfolioData() {
        portfolioTableViewController?.savePortfolioData()
    }
    
    
    
    
    //  o-o   o--o o    o--o  o-o    O  o-O-o o--o
    //  |  \  |    |    |    o      / \   |   |
    //  |   O O-o  |    O-o  |  -o o---o  |   O-o
    //  |  /  |    |    |    o   | |   |  |   |
    //  o-o   o--o O---oo--o  o-o  o   o  o   o--o
    //
    
    // MARK: - Delegate methods for the Portfolio Table View Controller
    
    func portfolioTableDidTapOnAsset(_ portfolioTableViewController: PortfolioTableViewController, assetIndex index: Int) {
        print("Method portfolioTableDidTapOnAsset NOT implemented yet...")
        
    }
    
    func portfolioTableDidUpdate(_ portfolioTableViewController: PortfolioTableViewController) {
        TotalValue.text = CurrencyFormatter.sharedInstance.string(from: NSNumber(value: portfolioTableViewController.getPortfolioTotalValue()))
        updatePrivacyState()
    }
    
    func portfolioTableShouldUseLocalCurrency(_ portfolioTableViewController: PortfolioTableViewController) -> Bool {
        return _shouldUseLocalCurrency
    }
    
    func portfolioTableDidChangeSortMethod(_ portfolioTableViewController: PortfolioTableViewController, sortMethod aSortMethod: SortMethod) {
        ChangeSortButtonLabelToMethod(aSortMethod: aSortMethod)
    }
    
    
    
    // MARK: - Privacy Toggle Methods
    
    /** Sets up the privacy toggle button next to the total value label. */
    func setupPrivacyToggleButton() {
        // Create the button
        privacyToggleButton = UIButton(type: .system)
        privacyToggleButton.translatesAutoresizingMaskIntoConstraints = false
        
        // Configure button appearance
        let eyeImage = UIImage(systemName: "eye.fill")
        privacyToggleButton.setImage(eyeImage, for: .normal)
        privacyToggleButton.tintColor = .lightGray
        
        // Add action
        privacyToggleButton.addTarget(self, action: #selector(togglePrivacyMode), for: .touchUpInside)
        
        // Add button to the view
        self.view.addSubview(privacyToggleButton)
        
        // Setup constraints to position button to the right of TotalValue label
        NSLayoutConstraint.activate([
            privacyToggleButton.centerYAnchor.constraint(equalTo: TotalValue.centerYAnchor),
            privacyToggleButton.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            privacyToggleButton.widthAnchor.constraint(equalToConstant: 30),
            privacyToggleButton.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    /** Toggles the privacy mode for the total value display. */
    @objc func togglePrivacyMode() {
        _isValueHidden = !_isValueHidden
        updatePrivacyState()
    }
    
    /** Updates the UI based on the current privacy state. */
    func updatePrivacyState() {
        if _isValueHidden {
            // Show eye.slash icon when value is hidden
            let eyeSlashImage = UIImage(systemName: "eye.slash.fill")
            privacyToggleButton.setImage(eyeSlashImage, for: .normal)
            
            // Apply blur effect
            applyBlurEffect()
        } else {
            // Show eye icon when value is visible
            let eyeImage = UIImage(systemName: "eye.fill")
            privacyToggleButton.setImage(eyeImage, for: .normal)
            
            // Remove blur effect
            removeBlurEffect()
        }
    }
    
    /** Applies a blur effect to the total value label with adjustable intensity. */
    func applyBlurEffect() {
        // Remove existing blur if present
        if blurEffectView != nil {
            return
        }
        
        // Calculate the actual text size
        guard let text = TotalValue.text, let font = TotalValue.font else { return }
        let textSize = (text as NSString).size(withAttributes: [.font: font])
        
        // Create blur effect view (initially without effect)
        blurEffectView = UIVisualEffectView(effect: nil)
        blurEffectView?.translatesAutoresizingMaskIntoConstraints = false
        blurEffectView?.isUserInteractionEnabled = false
        blurEffectView?.layer.cornerRadius = 4
        blurEffectView?.clipsToBounds = true
        
        // Add to view hierarchy
        self.view.addSubview(blurEffectView!)
        
        // Position blur view centered on label with text-only dimensions
        // Add extra padding to prevent blur from being cropped at edges
        NSLayoutConstraint.activate([
            blurEffectView!.centerXAnchor.constraint(equalTo: TotalValue.centerXAnchor),
            blurEffectView!.centerYAnchor.constraint(equalTo: TotalValue.centerYAnchor),
            blurEffectView!.widthAnchor.constraint(equalToConstant: textSize.width + 18),
            blurEffectView!.heightAnchor.constraint(equalToConstant: textSize.height + 14)
        ])
        
        // Use UIViewPropertyAnimator to control blur intensity
        // fractionComplete controls the blur strength (0.0 = no blur, 1.0 = full blur)
        let blurEffect = UIBlurEffect(style: .regular)
        blurAnimator = UIViewPropertyAnimator(duration: 1, curve: .linear) { [weak self] in
            self?.blurEffectView?.effect = blurEffect
        }
        
        // Set blur intensity: 0.0 (no blur) to 1.0 (full blur)
        // Adjust this value to control blur strength (e.g., 0.7 for 70% blur)
        blurAnimator?.fractionComplete = 0.2
    }
    
    /** Removes the blur effect from the total value label. */
    func removeBlurEffect() {
        blurAnimator?.stopAnimation(true)
        blurAnimator = nil
        blurEffectView?.removeFromSuperview()
        blurEffectView = nil
    }
    
    /** Refreshes the blur effect (useful when returning from background or other views). */
    func refreshBlurEffect() {
        // Remove existing blur
        blurAnimator?.stopAnimation(true)
        blurAnimator = nil
        blurEffectView?.removeFromSuperview()
        blurEffectView = nil
        
        // Reapply blur
        applyBlurEffect()
    }

}
