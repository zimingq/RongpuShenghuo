//
//  ProfileView.swift
//  RongpuShenghuo
//
//  Created by Ziming Qiu on 1/11/25.
//

import SwiftUI

struct ProfileView: View {
    @StateObject private var userInfoManager = UserInfoManager()
    
    var body: some View {
        NavigationView {
            Form {
                ProfileButtonView(userInfo: $userInfoManager.users[0])
                
                HStack {
                    CCTVBlockView()
                    GPSBlockView()
                }
                Section {
                    sectionWithButtons(title: "设置", systemName: "gear")
                    sectionWithButtons(title: "隐私", systemName: "lock")
                }
                
                Section {
                    sectionWithButtons(title: "帮助中心", systemName: "questionmark.circle")
                    sectionWithButtons(title: "联系我们", systemName: "envelope")
                }
                
                Section {
                    sectionWithButtons(title: "服务条款", systemName: "doc.text")
                    sectionWithButtons(title: "隐私条款", systemName: "shield")
                }
                sectionWithButtons(title: "退出登录", systemName: "rectangle.portrait.and.arrow.right")
                    .foregroundStyle(Color.red)
            }
            .navigationTitle("个人中心")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    @ViewBuilder
    private func sectionWithButtons(title: String, systemName: String) -> some View {
        Section {
            Button(action: {}) {
                Label(title, systemImage: systemName)
            }
        }
    }
}

struct ProfileButtonView: View {
    @Binding var userInfo: UserInfoModel
    
    var body: some View {
        NavigationLink(destination: ProfileDetailView(userInfo: $userInfo)) {
            HStack(spacing: 10) {
                Image(userInfo.image)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 70, height: 70)
                    .clipShape(Circle())
                    .overlay {
                        Circle().stroke(.gray, lineWidth: 1)
                    }
                    .padding(5)
                
                Text(userInfo.name)
                    .font(.system(size: 28))
            }
            .cornerRadius(16)
        }
    }
}

struct ProfileDetailView: View {
    @Binding var userInfo: UserInfoModel
    
    @State private var name: String
    @State private var age: String
    @State private var province: String
    @State private var city: String
    @State private var memberID: String
    @State private var emergencyContact1: String
    @State private var emergencyContact2: String
    @State private var medicalAccount: String
    @State private var socialSecurityAccount: String
    @State private var membershipType: String
    @State private var joinDate: Date
    @State private var joinDateString: String
    
    @State private var isEditing: Bool = false // New state for edit mode
    
    init(userInfo: Binding<UserInfoModel>) {
        _userInfo = userInfo
        _name = State(initialValue: userInfo.wrappedValue.name)
        _age = State(initialValue: "\(userInfo.wrappedValue.age)")
        _province = State(initialValue: userInfo.wrappedValue.location.province)
        _city = State(initialValue: userInfo.wrappedValue.location.city)
        _memberID = State(initialValue: userInfo.wrappedValue.memberID)
        _emergencyContact1 = State(initialValue: userInfo.wrappedValue.emergencyContacts.first ?? "")
        _emergencyContact2 = State(initialValue: userInfo.wrappedValue.emergencyContacts.dropFirst().first ?? "")
        _medicalAccount = State(initialValue: userInfo.wrappedValue.medicalAccount)
        _socialSecurityAccount = State(initialValue: userInfo.wrappedValue.socialSecurityAccount)
        _membershipType = State(initialValue: userInfo.wrappedValue.memberType)
        _joinDate = State(initialValue: userInfo.wrappedValue.joinDate)
        _joinDateString = State(initialValue: dateFormatter.string(from: userInfo.wrappedValue.joinDate))
    }
    
    var body: some View {
        Form {
            VStack {
                Image(userInfo.image)
                    .resizable()
                    .scaledToFill()
                    .clipShape(Circle())
                    .frame(width: 100, height: 100)
                    .overlay {
                        Circle().stroke(.gray, lineWidth: 1)
                    }
                Text(userInfo.name)
            }
            .listRowBackground(Color(UIColor.systemGroupedBackground))
            .frame(maxWidth: .infinity, alignment: .center)
            
            Section(header: Text("个人信息")) {
                CustomRow(title: "姓名", content: $name, isEditable: isEditing)
                CustomRow(title: "年龄", content: $age, isEditable: isEditing)
                CustomRow(title: "地区", content: Binding(
                    get: { "\(province) \(city)" },
                    set: { newValue in
                        let components = newValue.split(separator: " ")
                        if components.count == 2 {
                            province = String(components[0])
                            city = String(components[1])
                        }
                    }
                ), isEditable: isEditing)
            }
            
            Section(header: Text("紧急联系人")) {
                CustomRow(title: "紧急联系人1", content: $emergencyContact1, isEditable: isEditing)
                CustomRow(title: "紧急联系人2", content: $emergencyContact2, isEditable: isEditing)
            }
            
            Section() {
                CustomRow(title: "医保账号", content: $medicalAccount, isEditable: isEditing)
                CustomRow(title: "社保账号", content: $socialSecurityAccount, isEditable: isEditing)
            }
            
            Section(header: Text("会员信息")) {
                CustomRow(title: "会员编号", content: $memberID, isEditable: false)
                CustomRow(title: "类型", content: $membershipType, isEditable: false)
                CustomRow(title: "入会时间", content: $joinDateString, isEditable: false)
            }
        }
        .navigationTitle("个人资料")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarItems(
            trailing: Button(isEditing ? "保存" : "编辑") {
                if isEditing {
                    saveUserInfo()
                } else {
                    isEditing.toggle()
                }
            }
        )
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                if isEditing {
                    Button("取消") {
                        cancelEditing()
                    }
                }
            }
        }
    }
    
    private func saveUserInfo() {
        userInfo.name = name
        userInfo.age = Int(age) ?? userInfo.age
        userInfo.location = Location(province: province, city: city) // Save updated location
        userInfo.memberID = memberID
        userInfo.emergencyContacts = [emergencyContact1, emergencyContact2]
        userInfo.medicalAccount = medicalAccount
        userInfo.socialSecurityAccount = socialSecurityAccount
        userInfo.memberType = membershipType
        userInfo.joinDate = joinDate
        
        // Exit editing mode
        isEditing = false
    }
    
    private func cancelEditing() {
        // Revert changes to original user info
        name = userInfo.name
        age = "\(userInfo.age)"
        province = userInfo.location.province
        city = userInfo.location.city
        memberID = userInfo.memberID
        emergencyContact1 = userInfo.emergencyContacts.first ?? ""
        emergencyContact2 = userInfo.emergencyContacts.dropFirst().first ?? ""
        medicalAccount = userInfo.medicalAccount
        socialSecurityAccount = userInfo.socialSecurityAccount
        membershipType = userInfo.memberType
        joinDate = userInfo.joinDate
        joinDateString = dateFormatter.string(from: userInfo.joinDate)
        
        // Exit editing mode
        isEditing = false
    }
    
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yy-MM-dd" // Updated to yy-MM-dd format
        return formatter
    }()
}

struct CustomRow: View {
    var title: String
    @Binding var content: String
    var isEditable: Bool = true
    
    var body: some View {
        HStack {
            Text(title)
                .font(.system(size: 17))
            Spacer()
            if isEditable {
                TextField(title, text: $content)
                    .font(.system(size: 17))
                    .foregroundColor(.secondary)
                    .textFieldStyle(PlainTextFieldStyle())
                    .padding(.vertical, 4)
                    .frame(maxWidth: .infinity, alignment: .trailing)
            } else {
                Text(content)
                    .font(.system(size: 17))
                    .foregroundColor(.secondary)
                    .frame(maxWidth: .infinity, alignment: .trailing)
            }
        }
        .padding(.vertical, 4)
    }
}

#Preview {
    ProfileView()
}
