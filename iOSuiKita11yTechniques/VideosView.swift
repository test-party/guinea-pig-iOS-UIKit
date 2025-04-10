import SwiftUI
import UIKit
import AVKit

class VideosViewController: UIViewController {
    
    // MARK: - Properties
    private var darkGreen = UIColor(red: 0/255, green: 102/255, blue: 0/255, alpha: 1.0)
    private var darkRed = UIColor(red: 220/255, green: 20/255, blue: 60/255, alpha: 1.0)
    
    private var isMuted = false
    private var isPlaying = false
    
    private var avPlayerViewController: AVPlayerViewController!
    private var goodPlayerContainer: UIView!
    private var playButton: UIButton!
    private var muteButton: UIButton!
    private var controlsView: UIView!
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Videos"
        view.backgroundColor = .systemBackground
        setupUI()
    }
    
    // MARK: - UI Setup
    private func setupUI() {
        // Create scroll view
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        
        // Create content stack view
        let contentStack = UIStackView()
        contentStack.axis = .vertical
        contentStack.spacing = 16
        contentStack.alignment = .fill
        contentStack.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(contentStack)
        
        // Set constraints
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            contentStack.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 16),
            contentStack.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16),
            contentStack.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -16),
            contentStack.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -16),
            contentStack.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -32)
        ])
        
        // Add content
        setupContent(in: contentStack)
    }
    
    private func setupContent(in stackView: UIStackView) {
        // Introduction text
        let introText = UILabel()
        introText.numberOfLines = 0
        introText.text = "Videos need Closed Captions for deaf users and Audio Descriptions for blind users. Provide a closed caption track on the video and an audio description track that users can select. Or provide a captioned video and a separate audio-described video. Apple's native video player controls are not accessible to VoiceOver, Full Keyboard Access, and other accessibility users because they are hidden by default and a user must tap the video to show the controls. Create a custom play button so that accessibility users can focus on the button and use it to play the video. Use `.accessibilityElement(children: .contain)` to create a group container for the video and for the custom play controls. Add `.accessibilityLabel(\"Name of Video\")` and VoiceOver users will hear the video name if using direct touch. Add `.accessibilityHint(\"Double-tap to play and show controls\")` so VoiceOver users hear how to play the video. Swipe exploration with VoiceOver will not work so the custom play button is required. Full Keyboard Access users have no method to show the native player controls, only the custom play button is keyboard accessible."
        stackView.addArrangedSubview(introText)
        
        // Good Example Header
        let goodExampleHeader = createHeaderLabel(text: "Good Example", color: darkGreen)
        stackView.addArrangedSubview(goodExampleHeader)
        
        let goodDivider = createDivider(color: darkGreen)
        stackView.addArrangedSubview(goodDivider)
        
        // Good Example Video Player
        goodPlayerContainer = UIView()
        goodPlayerContainer.heightAnchor.constraint(equalToConstant: 320).isActive = true
        stackView.addArrangedSubview(goodPlayerContainer)
        
        // Set up AVPlayerViewController
        avPlayerViewController = AVPlayerViewController()
        let url = URL(string: "https://pauljadam.com/demos/closed-descriptions-captions.mov")!
        avPlayerViewController.player = AVPlayer(url: url)
        
        // Add AVPlayerViewController as a child
        addChild(avPlayerViewController)
        avPlayerViewController.view.translatesAutoresizingMaskIntoConstraints = false
        goodPlayerContainer.addSubview(avPlayerViewController.view)
        avPlayerViewController.didMove(toParent: self)
        
        // Set up constraints for player view
        NSLayoutConstraint.activate([
            avPlayerViewController.view.topAnchor.constraint(equalTo: goodPlayerContainer.topAnchor),
            avPlayerViewController.view.leadingAnchor.constraint(equalTo: goodPlayerContainer.leadingAnchor),
            avPlayerViewController.view.trailingAnchor.constraint(equalTo: goodPlayerContainer.trailingAnchor),
            avPlayerViewController.view.bottomAnchor.constraint(equalTo: goodPlayerContainer.bottomAnchor)
        ])
        
        // Set accessibility for video container
        goodPlayerContainer.isAccessibilityElement = true
        goodPlayerContainer.accessibilityLabel = "Biology 101 Video"
        goodPlayerContainer.accessibilityHint = "Double-tap to play and show controls"
        
        // Play the video
        avPlayerViewController.player?.play()
        isPlaying = true
        
        // Create custom controls
        controlsView = UIView()
        controlsView.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(controlsView)
        
        // Play Button
        playButton = UIButton(type: .system)
        playButton.setImage(UIImage(systemName: "pause.fill"), for: .normal)
        playButton.contentHorizontalAlignment = .fill
        playButton.contentVerticalAlignment = .fill
        playButton.imageView?.contentMode = .scaleAspectFit
        playButton.tintColor = .label
        playButton.accessibilityLabel = "Pause"
        playButton.addTarget(self, action: #selector(togglePlayPause), for: .touchUpInside)
        playButton.translatesAutoresizingMaskIntoConstraints = false
        controlsView.addSubview(playButton)
        
        // Mute Button
        muteButton = UIButton(type: .system)
        muteButton.setImage(UIImage(systemName: "speaker.wave.2.fill"), for: .normal)
        muteButton.contentHorizontalAlignment = .fill
        muteButton.contentVerticalAlignment = .fill
        muteButton.imageView?.contentMode = .scaleAspectFit
        muteButton.tintColor = .label
        muteButton.accessibilityLabel = "Mute"
        muteButton.addTarget(self, action: #selector(toggleMute), for: .touchUpInside)
        muteButton.translatesAutoresizingMaskIntoConstraints = false
        controlsView.addSubview(muteButton)
        
        NSLayoutConstraint.activate([
            controlsView.heightAnchor.constraint(equalToConstant: 44),
            
            playButton.leadingAnchor.constraint(equalTo: controlsView.leadingAnchor, constant: 16),
            playButton.centerYAnchor.constraint(equalTo: controlsView.centerYAnchor),
            playButton.widthAnchor.constraint(equalToConstant: 30),
            playButton.heightAnchor.constraint(equalToConstant: 30),
            
            muteButton.trailingAnchor.constraint(equalTo: controlsView.trailingAnchor, constant: -16),
            muteButton.centerYAnchor.constraint(equalTo: controlsView.centerYAnchor),
            muteButton.widthAnchor.constraint(equalToConstant: 30),
            muteButton.heightAnchor.constraint(equalToConstant: 30)
        ])
        
        // Set accessibility for controls
        controlsView.isAccessibilityElement = true
        controlsView.accessibilityLabel = "Biology 101 Video Player Controls"
        controlsView.accessibilityElements = [playButton, muteButton]
        
        // Good Example Details
        let goodDetails = createDisclosureGroup(
            title: "Details",
            content: "The good example has a custom play button so that accessibility users can focus on the button and use it to play the video. `.accessibilityElement(children: .contain)` creates a group container for the video and for the custom play controls. `.accessibilityLabel(\"Biology 101 Video\")` enables VoiceOver users to hear the video name if they focus on the video using direct touch. `.accessibilityHint(\"Double-tap to play and show controls\")` is added so VoiceOver users hear they can double-tap to play the video and show controls. Closed captions and audio descriptions are provided in selectable tracks on the video Audio and Subtitles settings.",
            hint: "Good Example"
        )
        stackView.addArrangedSubview(goodDetails)
        
        // Bad Example Header
        let badExampleHeader = createHeaderLabel(text: "Bad Example", color: darkRed)
        stackView.addArrangedSubview(badExampleHeader)
        
        let badDivider = createDivider(color: darkRed)
        stackView.addArrangedSubview(badDivider)
        
        // Bad Example Video Player
        let badPlayerContainer = UIView()
        badPlayerContainer.heightAnchor.constraint(equalToConstant: 320).isActive = true
        stackView.addArrangedSubview(badPlayerContainer)
        
        // Set up bad example AVPlayerViewController
        let badPlayerViewController = AVPlayerViewController()
        let badUrl = URL(string: "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/Sintel.mp4")!
        badPlayerViewController.player = AVPlayer(url: badUrl)
        
        // Add bad AVPlayerViewController as a child
        addChild(badPlayerViewController)
        badPlayerViewController.view.translatesAutoresizingMaskIntoConstraints = false
        badPlayerContainer.addSubview(badPlayerViewController.view)
        badPlayerViewController.didMove(toParent: self)
        
        // Set up constraints for bad player view
        NSLayoutConstraint.activate([
            badPlayerViewController.view.topAnchor.constraint(equalTo: badPlayerContainer.topAnchor),
            badPlayerViewController.view.leadingAnchor.constraint(equalTo: badPlayerContainer.leadingAnchor),
            badPlayerViewController.view.trailingAnchor.constraint(equalTo: badPlayerContainer.trailingAnchor),
            badPlayerViewController.view.bottomAnchor.constraint(equalTo: badPlayerContainer.bottomAnchor)
        ])
        
        // Bad Example Details
        let badDetails = createDisclosureGroup(
            title: "Details",
            content: "The bad example has no custom play button which blocks accessibility users from playing the video. The video has no group container or accessibility label so VoiceOver users can't focus on the video with direct touch. There is no hint so VoiceOver users wont hear they can double-tap to play the video and show controls. Closed captions and audio descriptions are not provided. The video cannot be played with Full Keyboard Access or other accessibility features.",
            hint: "Bad Example"
        )
        stackView.addArrangedSubview(badDetails)
    }
    
    // MARK: - Helper methods
    private func createHeaderLabel(text: String, color: UIColor) -> UILabel {
        let label = UILabel()
        label.text = text
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.textColor = color
        label.numberOfLines = 0
        label.accessibilityTraits = .header
        return label
    }
    
    private func createDivider(color: UIColor) -> UIView {
        let divider = UIView()
        divider.backgroundColor = color
        divider.heightAnchor.constraint(equalToConstant: 2).isActive = true
        return divider
    }
    
    private func createDisclosureGroup(title: String, content: String, hint: String) -> UIView {
        let containerView = UIView()
        containerView.accessibilityHint = hint
        
        let button = UIButton(type: .system)
        button.setTitle("\(title) ▼", for: .normal)
        button.contentHorizontalAlignment = .left
        button.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(button)
        
        let contentLabel = UILabel()
        contentLabel.text = content
        contentLabel.numberOfLines = 0
        contentLabel.isHidden = true
        contentLabel.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(contentLabel)
        
        NSLayoutConstraint.activate([
            button.topAnchor.constraint(equalTo: containerView.topAnchor),
            button.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            button.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            
            contentLabel.topAnchor.constraint(equalTo: button.bottomAnchor, constant: 8),
            contentLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            contentLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            contentLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
        ])
        
        button.addAction(UIAction { _ in
            contentLabel.isHidden.toggle()
            button.setTitle("\(title) \(contentLabel.isHidden ? "▼" : "▲")", for: .normal)
        }, for: .touchUpInside)
        
        return containerView
    }
    
    // MARK: - Actions
    @objc private func togglePlayPause() {
        isPlaying.toggle()
        
        if isPlaying {
            avPlayerViewController.player?.play()
            playButton.setImage(UIImage(systemName: "pause.fill"), for: .normal)
            playButton.accessibilityLabel = "Pause"
        } else {
            avPlayerViewController.player?.pause()
            playButton.setImage(UIImage(systemName: "play.fill"), for: .normal)
            playButton.accessibilityLabel = "Play"
        }
    }
    
    @objc private func toggleMute() {
        isMuted.toggle()
        
        avPlayerViewController.player?.isMuted = isMuted
        
        if isMuted {
            muteButton.setImage(UIImage(systemName: "speaker.slash.fill"), for: .normal)
            muteButton.accessibilityLabel = "Unmute"
        } else {
            muteButton.setImage(UIImage(systemName: "speaker.wave.2.fill"), for: .normal)
            muteButton.accessibilityLabel = "Mute"
        }
    }
}

struct UIKitVideoPlayerView: UIViewRepresentable {
    @Binding var isPlaying: Bool
    @Binding var isMuted: Bool
    var videoURL: URL
    var accessibilityLabel: String?
    var accessibilityHint: String?
    
    func makeUIView(context: Context) -> UIView {
        // Create container view
        let containerView = UIView()
        containerView.backgroundColor = .clear
        
        // Create AVPlayerViewController
        let playerViewController = AVPlayerViewController()
        playerViewController.player = AVPlayer(url: videoURL)
        
        // Add player view controller as a child of a UIViewController
        let hostingController = UIViewController()
        hostingController.addChild(playerViewController)
        playerViewController.view.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(playerViewController.view)
        playerViewController.didMove(toParent: hostingController)
        
        // Set up constraints
        NSLayoutConstraint.activate([
            playerViewController.view.topAnchor.constraint(equalTo: containerView.topAnchor),
            playerViewController.view.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            playerViewController.view.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            playerViewController.view.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
        ])
        
        // Store the player view controller in the coordinator
        context.coordinator.playerViewController = playerViewController
        
        // Set up accessibility
        containerView.isAccessibilityElement = true
        if let label = accessibilityLabel {
            containerView.accessibilityLabel = label
        }
        if let hint = accessibilityHint {
            containerView.accessibilityHint = hint
        }
        
        // Start playing if needed
        if isPlaying {
            playerViewController.player?.play()
        }
        
        return containerView
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
        guard let playerViewController = context.coordinator.playerViewController else { return }
        
        // Update player state
        if isPlaying {
            playerViewController.player?.play()
        } else {
            playerViewController.player?.pause()
        }
        
        // Update mute state
        playerViewController.player?.isMuted = isMuted
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject {
        var parent: UIKitVideoPlayerView
        var playerViewController: AVPlayerViewController?
        
        init(_ parent: UIKitVideoPlayerView) {
            self.parent = parent
        }
    }
}

struct UIKitVideoControlsView: UIViewRepresentable {
    @Binding var isPlaying: Bool
    @Binding var isMuted: Bool
    var accessibilityLabel: String
    
    func makeUIView(context: Context) -> UIView {
        // Create container view
        let containerView = UIView()
        
        // Create play button
        let playButton = UIButton(type: .system)
        playButton.setImage(UIImage(systemName: isPlaying ? "pause.fill" : "play.fill"), for: .normal)
        playButton.contentHorizontalAlignment = .fill
        playButton.contentVerticalAlignment = .fill
        playButton.imageView?.contentMode = .scaleAspectFit
        playButton.tintColor = .label
        playButton.accessibilityLabel = isPlaying ? "Pause" : "Play"
        playButton.addTarget(context.coordinator, action: #selector(Coordinator.togglePlayPause), for: .touchUpInside)
        playButton.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(playButton)
        
        // Create mute button
        let muteButton = UIButton(type: .system)
        muteButton.setImage(UIImage(systemName: isMuted ? "speaker.slash.fill" : "speaker.wave.2.fill"), for: .normal)
        muteButton.contentHorizontalAlignment = .fill
        muteButton.contentVerticalAlignment = .fill
        muteButton.imageView?.contentMode = .scaleAspectFit
        muteButton.tintColor = .label
        muteButton.accessibilityLabel = isMuted ? "Unmute" : "Mute"
        muteButton.addTarget(context.coordinator, action: #selector(Coordinator.toggleMute), for: .touchUpInside)
        muteButton.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(muteButton)
        
        // Set up constraints
        NSLayoutConstraint.activate([
            playButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            playButton.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            playButton.widthAnchor.constraint(equalToConstant: 30),
            playButton.heightAnchor.constraint(equalToConstant: 30),
            
            muteButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            muteButton.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            muteButton.widthAnchor.constraint(equalToConstant: 30),
            muteButton.heightAnchor.constraint(equalToConstant: 30),
            
            containerView.heightAnchor.constraint(equalToConstant: 44)
        ])
        
        // Set up accessibility
        containerView.isAccessibilityElement = true
        containerView.accessibilityLabel = accessibilityLabel
        containerView.accessibilityElements = [playButton, muteButton]
        
        // Store the buttons in the coordinator
        context.coordinator.playButton = playButton
        context.coordinator.muteButton = muteButton
        
        return containerView
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
        guard let playButton = context.coordinator.playButton,
              let muteButton = context.coordinator.muteButton else { return }
        
        // Update play button
        playButton.setImage(UIImage(systemName: isPlaying ? "pause.fill" : "play.fill"), for: .normal)
        playButton.accessibilityLabel = isPlaying ? "Pause" : "Play"
        
        // Update mute button
        muteButton.setImage(UIImage(systemName: isMuted ? "speaker.slash.fill" : "speaker.wave.2.fill"), for: .normal)
        muteButton.accessibilityLabel = isMuted ? "Unmute" : "Mute"
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject {
        var parent: UIKitVideoControlsView
        var playButton: UIButton?
        var muteButton: UIButton?
        
        init(_ parent: UIKitVideoControlsView) {
            self.parent = parent
        }
        
        @objc func togglePlayPause() {
            parent.isPlaying.toggle()
        }
        
        @objc func toggleMute() {
            parent.isMuted.toggle()
        }
    }
}

struct VideosViewControllerRepresentable: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> VideosViewController {
        return VideosViewController()
    }
    
    func updateUIViewController(_ uiViewController: VideosViewController, context: Context) {
        // Updates from SwiftUI to UIKit if needed
    }
}

struct VideosView: View {
    @State private var isMuted = false
    @State private var isPlaying = true
    
    var body: some View {
        // Option 1: Use the UIViewControllerRepresentable wrapper
        VideosViewControllerRepresentable()
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("Videos")
        
        // Option 2: Use individual UIKit components within SwiftUI
        /*
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Text("Videos need Closed Captions for deaf users and Audio Descriptions for blind users. Provide a closed caption track on the video and an audio description track that users can select. Or provide a captioned video and a separate audio-described video. Apple's native video player controls are not accessible to VoiceOver, Full Keyboard Access, and other accessibility users because they are hidden by default and a user must tap the video to show the controls. Create a custom play button so that accessibility users can focus on the button and use it to play the video. Use `.accessibilityElement(children: .contain)` to create a group container for the video and for the custom play controls. Add `.accessibilityLabel(\"Name of Video\")` and VoiceOver users will hear the video name if using direct touch. Add `.accessibilityHint(\"Double-tap to play and show controls\")` so VoiceOver users hear how to play the video. Swipe exploration with VoiceOver will not work so the custom play button is required. Full Keyboard Access users have no method to show the native player controls, only the custom play button is keyboard accessible.")
                    .padding(.bottom)
                
                Text("Good Example")
                    .font(.subheadline)
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .accessibilityAddTraits(.isHeader)
                
                UIKitVideoPlayerView(
                    isPlaying: $isPlaying,
                    isMuted: $isMuted,
                    videoURL: URL(string: "https://pauljadam.com/demos/closed-descriptions-captions.mov")!,
                    accessibilityLabel: "Biology 101 Video",
                    accessibilityHint: "Double-tap to play and show controls"
                )
                .frame(height: 320)
                
                UIKitVideoControlsView(
                    isPlaying: $isPlaying,
                    isMuted: $isMuted,
                    accessibilityLabel: "Biology 101 Video Player Controls"
                )
                .padding()
            }
            .padding()
        }
        */
    }
}

struct VideosView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            VideosView()
        }
    }
}
