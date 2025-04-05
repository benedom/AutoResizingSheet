import SwiftUI
import AutoResizingSheet
import UIKit

class UIKitExampleView: UIView {
    private var configuration: AutoResizingSheetConfiguration
    private let staticButton = UIButton(type: .system)
    private let dynamicButton = UIButton(type: .system)
    private let asyncButton = UIButton(type: .system)
    private weak var hostingController: UIViewController?
    
    init(configuration: AutoResizingSheetConfiguration, hostingController: UIViewController?) {
        self.configuration = configuration
        self.hostingController = hostingController
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        self.configuration = AutoResizingSheetConfiguration()
        super.init(coder: coder)
        setupView()
    }
    
    private func setupView() {
        backgroundColor = UIColor.systemBackground
        
        staticButton.setTitle("Show static sheet", for: .normal)
        staticButton.addTarget(self, action: #selector(showStaticSheet), for: .touchUpInside)
        staticButton.translatesAutoresizingMaskIntoConstraints = false
        addSubview(staticButton)
        
        dynamicButton.setTitle("Show dynamic sheet", for: .normal)
        dynamicButton.addTarget(self, action: #selector(showDynamicSheet), for: .touchUpInside)
        dynamicButton.translatesAutoresizingMaskIntoConstraints = false
        addSubview(dynamicButton)
        
        asyncButton.setTitle("Show async sheet", for: .normal)
        asyncButton.addTarget(self, action: #selector(showAsyncSheet), for: .touchUpInside)
        asyncButton.translatesAutoresizingMaskIntoConstraints = false
        addSubview(asyncButton)
        
        NSLayoutConstraint.activate([
            staticButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            staticButton.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -40),
            
            dynamicButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            dynamicButton.topAnchor.constraint(equalTo: staticButton.bottomAnchor, constant: 20),
            
            asyncButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            asyncButton.topAnchor.constraint(equalTo: dynamicButton.bottomAnchor, constant: 20)
        ])
    }
    
    @objc private func showStaticSheet() {
        let sheetContentView = StaticSheetContentView()
        hostingController?.presentViewAsAutoResizingSheet(
            content: sheetContentView,
            configuration: configuration
        )
    }
    
    @objc private func showDynamicSheet() {
        let sheetContentView = DynamicSheetContentView()
        hostingController?.presentViewAsAutoResizingSheet(
            content: sheetContentView,
            configuration: configuration
        )
    }
    
    @objc private func showAsyncSheet() {
        let sheetContentView = AsyncSheetContentView()
        hostingController?.presentViewAsAutoResizingSheet(
            content: sheetContentView,
            configuration: configuration
        )
    }
    
    func updateConfiguration(with configuration: AutoResizingSheetConfiguration) {
        self.configuration = configuration
    }
}

struct UIKitExampleViewRepresentable: UIViewRepresentable {
    let configuration: AutoResizingSheetConfiguration
    
    func makeUIView(context: Context) -> UIKitExampleView {
        let hostingController = UIApplication.shared.windows.first?.rootViewController
        let uiKitView = UIKitExampleView(configuration: configuration, hostingController: hostingController)
        return uiKitView
    }
    
    func updateUIView(_ uiView: UIKitExampleView, context: Context) {
        uiView.updateConfiguration(with: configuration)
    }
}
