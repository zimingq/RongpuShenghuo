//
//  HealthInfoDetailView.swift
//  RongpuShenghuo
//
//  Created by Ziming Qiu on 1/11/25.
//

import SwiftUI

struct HealthInfoDetailView: View {
    @State private var isEditing = false
    @State private var editableUser: UserInfoModel
    @State private var selectedProvince = ""
    @State private var selectedCity = ""
    
    @Environment(\.dismiss) var dismiss
    
    let bloodTypes = ["A"] // Only A is available for now
    
    init(user: UserInfoModel) {
        _editableUser = State(initialValue: user)
        _selectedProvince = State(initialValue: user.location.province)
        _selectedCity = State(initialValue: user.location.city)
    }
    
    var body: some View {
        Form {
            // Personal Information Section
            Section(header: Text("个人信息").font(.headline)) {
                HStack {
                    Text("姓名：")
                    Spacer()
                    if isEditing {
                        TextField("姓名", text: $editableUser.name)
                    } else {
                        Text(editableUser.name)
                    }
                }
                HStack {
                    Text("性别：")
                    Spacer()
                    if isEditing {
                        Picker("性别", selection: $editableUser.gender) {
                            Text("男").tag("男")
                            Text("女").tag("女")
                            Text("其他").tag("其他")
                            Text("不愿透露").tag("不愿透露")
                        }
                        .pickerStyle(SegmentedPickerStyle())
                    } else {
                        Text(editableUser.gender.isEmpty ? "未设置" : editableUser.gender)
                    }
                }
                HStack {
                    Text("出生年月：")
                    Spacer()
                    if isEditing {
                        DatePicker("", selection: $editableUser.DoB, displayedComponents: .date)
                            .labelsHidden()
                    } else {
                        Text(formattedDate(editableUser.DoB))
                    }
                }
                HStack {
                    Text("住址：")
                    Spacer()
                    if isEditing {
                        VStack {
                            Picker("省份", selection: $selectedProvince) {
                                ForEach(ChinaLocationManager.shared.provinces, id: \.self) { province in
                                    Text(province).tag(province)
                                }
                            }
                            .pickerStyle(MenuPickerStyle())
                            .onChange(of: selectedProvince) { newProvince in
                                // Update cities when province changes
                                selectedCity = ChinaLocationManager.shared.citiesByProvince[newProvince]?.first ?? ""
                            }
                            
                            Picker("城市", selection: $selectedCity) {
                                ForEach(ChinaLocationManager.shared.citiesByProvince[selectedProvince] ?? [], id: \.self) { city in
                                    Text(city).tag(city)
                                }
                            }
                            .pickerStyle(MenuPickerStyle())
                        }
                        .onAppear {
                            // Initialize city selection based on the selected province
                            selectedCity = ChinaLocationManager.shared.citiesByProvince[selectedProvince]?.first ?? ""
                        }
                    } else {
                        Text("\(editableUser.location.province) \(editableUser.location.city)")
                    }
                }
            }
            
            // Basic Information Section
            Section(header: Text("基本信息").font(.headline)) {
                HStack {
                    Text("血型：")
                    Spacer()
                    if isEditing {
                        Text("A 型血")
                    } else {
                        HStack {
                            Text("A")
                            Text("型血")
                        }
                    }
                }
                HStack {
                    Text("其他过敏：")
                    Spacer()
                    if isEditing {
                        TextField("其他过敏", text: .constant("无")) // Replace with actual value
                    } else {
                        Text("无") // Replace with actual value
                    }
                }
            }
            
            // Medical History Section
            Section(header: Text("病史").font(.headline)) {
                VStack(alignment: .leading) {
                    if isEditing {
                        TextField("病史", text: .constant("低血糖")) // Replace with actual value
                        TextField("补充说明", text: .constant("补充说明")) // Replace with actual value
                    } else {
                        Text("低血糖") // Replace with actual data
                        Text("补充说明：") // Replace with actual data
                            .font(.subheadline)
                    }
                }
            }
            
            // Health Metrics Section
            Section(header: Text("健康指标").font(.headline)) {
                VStack(alignment: .leading) {
                    HStack {
                        Text("心率：")
                        Spacer()
                        Text("\(editableUser.heartRate ?? 0) bpm")
                    }
                    HStack {
                        Text("血压：")
                        Spacer()
                        Text("\(editableUser.bloodPressure ?? 0) mmHg")
                    }
                    HStack {
                        Text("血糖：")
                        Spacer()
                        Text("\(editableUser.bloodSugar ?? 0) mg/dL")
                    }
                    HStack {
                        Text("胆固醇：")
                        Spacer()
                        Text("\(editableUser.cholesterol ?? 0) mg/dL")
                    }
                    HStack {
                        Text("血氧：")
                        Spacer()
                        Text("\(editableUser.bloodOxygen ?? 0) %")
                    }
                }
            }
        }
        .navigationBarBackButtonHidden(true)
        .navigationTitle("健康信息")
        .navigationBarBackButtonHidden(isEditing) // Hide back button when editing
        .toolbar {
            ToolbarItemGroup(placement: .navigationBarLeading) {
                if isEditing {
                    Button("取消") {
                        // Exit editing mode without saving
                        isEditing.toggle()
                        // Reset the province and city to the user's original data
                        selectedProvince = editableUser.location.province
                        selectedCity = editableUser.location.city
                    }
                    .padding(.trailing, 8)
                }
            }
            ToolbarItemGroup(placement: .navigationBarTrailing) {
                if isEditing {
                    Button("保存") {
                        // Save changes
                        editableUser.location = Location(province: selectedProvince, city: selectedCity)
                        // Perform save action here
                        isEditing.toggle()
                    }
                } else {
                    Button("编辑") {
                        isEditing.toggle()
                    }
                }
            }
        }
    }
    
    private func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd" // Format for year-month-day
        return formatter.string(from: date)
    }
}

#Preview {
    HealthInfoDetailView(user: UserInfoModel(
        id: UUID(),
        name: "John Doe",
        code: "JD123",
        DoB: Calendar.current.date(from: DateComponents(year: 1969, month: 10, day: 5)) ?? Date(),
        age: 65,
        gender: "男",
        image: "person.circle.fill",
        location: Location(province: "海南", city: "海口"),
        memberID: "123456",
        emergencyContacts: ["Jane Doe", "Jim Doe"],
        medicalAccount: "MA123",
        socialSecurityAccount: "SS123",
        memberType: "Gold",
        joinDate: Date(),
        heartRate: 72,
        bloodPressure: 120,
        bloodSugar: 90,
        cholesterol: 95
    ))
}
