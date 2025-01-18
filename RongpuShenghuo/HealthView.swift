//
//  HealthView.swift
//  RongpuShenghuo
//
//  Created by Ziming Qiu on 1/11/25.
//

import SwiftUI
import AVKit
import MapKit

struct HealthView: View {
    @StateObject private var userInfoManager = UserInfoManager()
    @State private var selectedUser: UserInfoModel?
    @State private var showingDeleteAlert = false
    
    private var users: [UserInfoModel] {
        userInfoManager.users
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 15) {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(users) { user in
                                UserBlockView(user: user, selectedUser: $selectedUser)
                                    .opacity(selectedUser?.id == user.id ? 1.0 : 0.5)
                            }
                        }
                        .padding(.trailing)
                    }
                    .padding(.top)
                    
                    if let selectedUser = selectedUser {
                        let metrics: [(type: HealthMetricType, color: Color?, data: Any?)] = [
                            (.heartRate, .red, selectedUser.heartRate),
                            (.bloodPressure, .blue, selectedUser.bloodPressure),
                            (.bloodSugar, .green, selectedUser.bloodSugar),
                            (.cholesterol, .yellow, selectedUser.cholesterol)
                        ]
                        
                        let filteredMetrics = metrics.filter { $0.data != nil }
                        
                        let metricPairs = stride(from: 0, to: filteredMetrics.count, by: 2).map {
                            Array(filteredMetrics[$0..<min($0 + 2, filteredMetrics.count)])
                        }
                        
//                        HStack {
//                            CCTVBlockView()
//                            GPSBlockView()
//                        }
                        
                        GraphBlockView(data: [10, 20, 15, 30, 10, 40, 35])
                        
                        HStack {
                            HealthInfoBlockView(user: selectedUser)
                            AlertBlcokView(image: "", state: 0)
                        }
                        
                        ForEach(metricPairs.indices, id: \.self) { index in
                            HStack {
                                ForEach(metricPairs[index], id: \.type) { metric in
                                    HealthMetricView(user: selectedUser, metricType: metric.type, color: metric.color ?? Color.green)
                                }
                            }
                        }
                        
                        HealthDataAddBlockView()
                            .padding(.bottom)
                    } else {
                        VStack {
                            Text("当前没有用户")
                                .font(.system(size: 24))
                        }
                    }
                }
                .onAppear {
                    // Use a delayed update to avoid view update cycle issues
                    if users.isEmpty {
                        self.selectedUser = nil
                    } else if selectedUser == nil {
                        self.selectedUser = users.first
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Image("logoText2")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100)
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    HStack {
                        NavigationLink(destination: UserCreationView(users: $userInfoManager.users)) {
                            Image(systemName: "plus")
                                .foregroundColor(.black)
                        }
                        Button(action: deleteSelectedUser) {
                            Image(systemName: "trash")
                                .foregroundColor(.black)
                        }
                    }
                }
            }
            .toolbarBackground(Color("LightGray"), for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
        }
        .alert(isPresented: $showingDeleteAlert) {
            Alert(
                title: Text("删除用户"),
                message: Text("你确定要删除这个用户吗?"),
                primaryButton: .destructive(Text("删除")) {
                    // Perform the delete action here
                    if let selectedUser = selectedUser {
                        if let index = userInfoManager.users.firstIndex(where: { $0.id == selectedUser.id }) {
                            userInfoManager.users.remove(at: index)
                        }
                        self.selectedUser = userInfoManager.users.first
                    }
                },
                secondaryButton: .cancel()
            )
        }
    }
    
    private func deleteSelectedUser() {
        showingDeleteAlert = true
    }
}


struct UserBlockView: View {
    var user: UserInfoModel
    @Binding var selectedUser: UserInfoModel?
    
    private var isSelected: Bool {
        selectedUser?.id == user.id
    }
    
    private var selectionIcon: some View {
        Image(systemName: isSelected ? "circle.circle.fill" : "circle")
            .font(.system(size: 24))
            .foregroundColor(isSelected ? .pink : .gray)
    }
    
    private var userImage: some View {
        Image(user.image)
            .resizable()
            .scaledToFit()
            .clipShape(Circle())
            .frame(width: 60)  // Adjusted the size to be more consistent
            .overlay(Circle().stroke(Color.gray, lineWidth: 1))
    }
    
    private var userName: some View {
        Text(user.name)
            .foregroundColor(.black)
            .font(.system(size: 22))
            .frame(width: 90, alignment: .leading)  // Adjusted width for better layout
    }
    
    var body: some View {
        Button(action: {
            selectedUser = user
        }) {
            HStack(spacing: 10) {
                selectionIcon
                userImage
                userName
            }
            .padding()
            .background(RoundedRectangle(cornerRadius: 25).foregroundColor(.white))
            .shadow(radius: 5)
            .frame(height: 70)  // Explicitly set height to control button size
        }
        .padding(.vertical)
        .padding(.leading)
    }
}

struct UserCreationView: View {
    @State private var selectedTab = 0
    @State private var name: String = ""
    @State private var memberID: String = ""
    @State private var errorMessage: String? // To display an error message
    @Binding var users: [UserInfoModel]
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationStack {
            VStack {
                Picker("Select Tab", selection: $selectedTab) {
                    Text("添加用户").tag(0)
                    Text("购买会员").tag(1)
                    Text("会员续费").tag(2)
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()
                
                Form {
                    switch selectedTab {
                    case 0:
                        // Form for "添加用户"
                        userForm
                    case 1:
                        // Form for "购买会员"
                        membershipPurchaseForm
                    case 2:
                        // Form for "会员续费"
                        membershipRenewalForm
                    default:
                        EmptyView()
                    }
                }
                
                Button(action: {
                    switch selectedTab {
                    case 0:
                        createUser()
                    case 1:
                        purchaseMembership()
                    case 2:
                        renewMembership()
                    default:
                        break
                    }
                }) {
                    Text("提交")
                        .foregroundColor(.black)
                        .frame(maxWidth: .infinity, maxHeight: 44)
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(10)
                }
                .disabled(name.isEmpty || memberID.isEmpty)
                .padding() // Add padding around the button
            }
            .navigationTitle(tabTitle)
        }
    }
    
    private var userForm: some View {
        VStack {
            Section(header: Text("添加用户")) {
                TextField("姓名", text: $name)
                TextField("会员编号", text: $memberID)
                
                if let errorMessage = errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .padding(.top, 5) // Add padding for better spacing
                }
            }
        }
    }
    
    private var membershipPurchaseForm: some View {
        VStack {
            Section(header: Text("购买会员")) {
                TextField("姓名", text: $name)
                TextField("身份证号码", text: $memberID)
                
                if let errorMessage = errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .padding(.top, 5) // Add padding for better spacing
                }
            }
        }
    }
    
    private var membershipRenewalForm: some View {
        VStack {
            Section(header: Text("会员续费")) {
                TextField("姓名", text: $name)
                TextField("会员编号", text: $memberID)
                
                if let errorMessage = errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .padding(.top, 5) // Add padding for better spacing
                }
            }
        }
    }
    
    private var tabTitle: String {
        switch selectedTab {
        case 0: return "添加用户"
        case 1: return "购买会员"
        case 2: return "会员续费"
        default: return "用户管理"
        }
    }
    
    private var buttonTitle: String {
        switch selectedTab {
        case 0: return "添加用户"
        case 1: return "购买会员"
        case 2: return "会员续费"
        default: return ""
        }
    }
    
    private func createUser() {
        // Validate memberID
        guard memberID.hasPrefix("Y") || memberID.hasPrefix("Z") else {
            errorMessage = "会员编号必须以 'Y' 或 'Z' 开头。"
            return
        }
        
        let newUser = UserInfoModel(
            id: UUID(),
            name: name,
            code: "",
            DoB: Calendar.current.date(from: DateComponents(year: 1969, month: 10, day: 5)) ?? Date(), // Placeholder for code, if needed
            age: 70,
            gender: "男",
            image: "profilePicMan",  // Placeholder image
            location: Location(province: "海南", city: "海口"),  // Placeholder location
            memberID: memberID,
            emergencyContacts: [],
            medicalAccount: "",  // Placeholder for medical account
            socialSecurityAccount: "",  // Placeholder for social security account
            memberType: "Standard",
            joinDate: Date()
        )
        
        users.append(newUser)
        clearForm()
        dismiss()
    }
    
    private func purchaseMembership() {
        // Handle membership purchase
        clearForm()
        dismiss()
    }
    
    private func renewMembership() {
        // Handle membership renewal
        clearForm()
        dismiss()
    }
    
    private func clearForm() {
        name = ""
        memberID = ""
        errorMessage = nil
    }
}


struct HealthMetricView: View {
    let user: UserInfoModel
    let metricType: HealthMetricType
    let color: Color
    
    var body: some View {
        let metricValue: String
        let metricName: String
        
        switch metricType {
        case .heartRate:
            metricValue = "\(user.heartRate ?? 0) bpm"
            metricName = "心率"
        case .bloodPressure:
            metricValue = "\(user.bloodPressure ?? 0) mmHg"
            metricName = "血压"
        case .bloodSugar:
            metricValue = "\(user.bloodSugar ?? 0) mg/dL"
            metricName = "血糖"
        case .cholesterol:
            metricValue = "\(user.cholesterol ?? 0) mg/dL"
            metricName = "膽固醇"
        }
        
        return ZStack {
            RoundedRectangle(cornerRadius: 16)
                .fill(color.opacity(0.2))
                .frame(width: 180, height: 120)
                .shadow(radius: 5)
            
            VStack(spacing: 10) {
                Text(metricName)
                    .font(.system(size: 24))
                    .foregroundColor(color)
                Text(metricValue)
                    .font(.system(size: 24))
                    .fontWeight(.bold)
                    .foregroundColor(color)
            }
        }
    }
}

struct HealthInfoBlockView: View {
    let user: UserInfoModel
    
    var body: some View {
        NavigationLink(destination: HealthInfoDetailView(user: user)) {
            ZStack {
                RoundedRectangle(cornerRadius: 16)
                    .fill(Color.green.opacity(0.2))
                    .frame(width: 180, height: 120)
                    .shadow(radius: 5)
                
                VStack(spacing: 10) {
                    Text("健康信息")
                        .font(.system(size: 24))
                        .foregroundColor(Color.green)
                }
            }
        }
    }
}

struct AlertBlcokView: View {
    let image: String
    @State var state: Int
    let colors = [Color.green, Color.yellow, Color.red]
    let statesText = ["正常", "黄色预警", "红色警告"]
    
    var body: some View {
        Button(action: {
            if (state < 2){
                state += 1
            }else{
                state = 0
            }
        }, label: {
            ZStack {
                RoundedRectangle(cornerRadius: 16)
                    .fill(colors[state].opacity(0.2))
                    .frame(width: 180, height: 120)
                    .shadow(radius: 5)
                
                VStack(spacing: 10) {
                    Text(statesText[state])
                        .font(.system(size: 24))
                        .foregroundColor(colors[state])
                    Image(image)
                        .foregroundColor(colors[state])
                }
            }
        })
    }
}

struct GPSBlockView: View {
    @StateObject private var locationManager = LocationDataManager()
    @State private var showAlert = false
    
    var body: some View {
        VStack {
            Button(action: {
                // Show alert to confirm navigation
                locationManager.updateRegionToCurrentLocation()
                showAlert = true
            }) {
                Map(coordinateRegion: $locationManager.region)
                    .frame(width: 150, height: 120)
                    .clipShape(RoundedRectangle(cornerRadius: 16))
            }
            Text("GPS")
                .font(.system(size: 18))
                .bold()
                .padding(.top, 5)
                .padding(.bottom, 10)
        }
        .padding(5)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 15.0))
        .shadow(radius: 5)
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text("打开地图"),
                message: Text("您需要打开地图吗?"),
                primaryButton: .default(Text("是")) {
                    openMapApp()
                },
                secondaryButton: .cancel()
            )
        }
    }
    
    private func openMapApp() {
        let latitude = locationManager.region.center.latitude
        let longitude = locationManager.region.center.longitude
        // Construct the URL to open Maps centered on the location without a pin
        if let url = URL(string: "https://maps.apple.com/?ll=\(latitude),\(longitude)") {
            UIApplication.shared.open(url)
        }
    }
}

struct CCTVBlockView: View {
    @State private var isImagePickerPresented = false
    private var videoURL: URL? {
        Bundle.main.url(forResource: "cctv", withExtension: "mov")
    }
    
    var body: some View {
        VStack {
            if let videoURL = videoURL {
                VideoPlayerView(videoURL: videoURL)
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 150, height: 120)
                    .clipShape(RoundedRectangle(cornerRadius: 15.0))
                    .overlay(
                        RoundedRectangle(cornerRadius: 15.0)
                            .stroke(Color.gray, lineWidth: 1)
                    )
            } else {
                Text("Video not found")
                    .frame(width: 170, height: 120)
                    .foregroundColor(.red)
            }
            Text("卫星影像")
                .font(.system(size: 18))
                .bold()
                .padding(.top, 5)
                .padding(.bottom, 10)
        }
        .padding(5)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 15.0))
        .shadow(radius: 5)
        .onTapGesture {
            isImagePickerPresented = true
        }
        .sheet(isPresented: $isImagePickerPresented) {
            ImagePicker(isPresented: $isImagePickerPresented)
        }
    }
}

struct LineGraph: View {
    let data: [CGFloat]
    
    var body: some View {
        GeometryReader { geometry in
            let width = geometry.size.width
            let height = geometry.size.height
            let stepX = width / CGFloat(data.count - 1)
            let maxValue = data.max() ?? 1
            let minValue = data.min() ?? 0
            let range = maxValue - minValue == 0 ? 1 : maxValue - minValue
            
            ZStack {
                // Draw the graph line
                Path { path in
                    guard !data.isEmpty else { return }
                    
                    let firstPointY = height - ((data[0] - minValue) / range * height)
                    path.move(to: CGPoint(x: 0, y: firstPointY))
                    
                    for index in 1..<data.count {
                        let x = CGFloat(index) * stepX
                        let y = height - ((data[index] - minValue) / range * height)
                        path.addLine(to: CGPoint(x: x, y: y))
                    }
                }
                .stroke(Color.blue, lineWidth: 2)
                
                // Draw data points
                ForEach(data.indices, id: \.self) { index in
                    let x = CGFloat(index) * stepX
                    let y = height - ((data[index] - minValue) / range * height)
                    
                    Circle()
                        .fill(Color.blue)
                        .frame(width: 8, height: 8)
                        .position(x: x, y: y)
                }
            }
        }
        .frame(height: 110) // Set the height explicitly
        .padding(10) // Avoid clipping near the edges
    }
}


struct GraphBlockView: View {
    @State private var isDetailPresented = false
    let data: [CGFloat]
    
    var body: some View {
        VStack {
            // Graph area
            if !data.isEmpty {
                LineGraph(data: data)
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 340, height: 140)
                    .clipShape(RoundedRectangle(cornerRadius: 15.0))
                    .overlay(
                        RoundedRectangle(cornerRadius: 15.0)
                            .stroke(Color.gray, lineWidth: 1)
                    )
            } else {
                Text("No data available")
                    .foregroundColor(.red)
            }
            
            // Title
            Text("健康曲线")
                .font(.system(size: 18))
                .bold()
                .padding(.top, 5)
                .padding(.bottom, 10)
        }
        .padding(5)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 15.0))
        .shadow(radius: 5)
        .onTapGesture {
            isDetailPresented = true
        }
        .sheet(isPresented: $isDetailPresented) {
            // Detail view for the graph
            Text("Graph details would go here.")
        }
    }
}

struct ImagePicker: UIViewControllerRepresentable {
    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        var parent: ImagePicker
        
        init(parent: ImagePicker) {
            self.parent = parent
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            parent.isPresented = false
        }
        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            parent.isPresented = false
        }
    }
    
    @Binding var isPresented: Bool
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self)
    }
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        picker.sourceType = .camera
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}
}


struct VideoPlayerView: UIViewControllerRepresentable {
    let videoURL: URL
    
    func makeUIViewController(context: Context) -> AVPlayerViewController {
        let playerViewController = AVPlayerViewController()
        let player = AVPlayer(url: videoURL)
        playerViewController.player = player
        playerViewController.showsPlaybackControls = false // Hide controls
        
        // Mute the audio
        player.isMuted = true
        
        // Set up video loop
        NotificationCenter.default.addObserver(
            forName: .AVPlayerItemDidPlayToEndTime,
            object: player.currentItem,
            queue: .main
        ) { _ in
            player.seek(to: .zero)
            player.play()
        }
        
        return playerViewController
    }
    
    func updateUIViewController(_ uiViewController: AVPlayerViewController, context: Context) {
        guard let player = uiViewController.player else { return }
        if player.currentItem == nil {
            let item = AVPlayerItem(url: videoURL)
            player.replaceCurrentItem(with: item)
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            player.play()
        }
    }
}

struct HealthDataAddBlockView: View {
    var body: some View {
        Button(action: {
            //            Add new health block
        }, label: {
            ZStack {
                RoundedRectangle(cornerRadius: 16)
                    .fill(.gray.opacity(0.2))
                    .frame(width: 180, height: 120)
                    .shadow(radius: 5)
                
                VStack(spacing: 10) {
                    Text("+")
                        .font(.system(size: 36))
                        .foregroundColor(Color.white)
                    Text("添加设备")
                        .font(.system(size: 24))
                        .fontWeight(.bold)
                        .foregroundColor(Color.white)
                }
            }
        })
    }
}

#Preview {
    HealthView()
}
