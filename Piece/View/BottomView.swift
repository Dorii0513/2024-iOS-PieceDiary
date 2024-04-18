//
//  BottomSheet.swift
//  Piece
//
//  Created by 김예림 on 4/15/24.
//

import SwiftUI
import PhotosUI

struct BottomView: View {
    
    //keyboard
    @FocusState private var keyboardFocused: Bool
    
    //textField
    @State var text: String = ""
    @State var buttonActive: Bool = false
    
    //binding
    @Binding var pieceList: [Piece]
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading){
                HStack {
                    Image("bolt")
                        .resizable()
                        .scaledToFit()
                    //이미지 크기를 비율로 조절할 수 있는 방법은??
                        .frame(width: 25, height: 25)
                    Spacer().frame(width:0.2)
                    Text("안녕 Kuro,")
                        .tracking(-1.2)
                        .font(.pretendardSemiBold26)
                        .lineSpacing(2)
                        .foregroundColor(Color(hexColor: "EEECE2"))
                }
                .padding(.top, 40)
                
                Spacer().frame(height: 0.7)
                
                Text("방금 무슨 일이 일어났나요?")
                    .tracking(-1.3)
                    .font(.pretendardSemiBold26)
                    .lineSpacing(2)
                    .foregroundColor(Color(hexColor: "EEECE2"))
                
                Spacer().frame(height: 0)
                
                Text("\(getCurrentTime())")
                    .tracking(-0.5)
                    .foregroundColor(Color(hexColor: "7C7B75"))
                    .font(.pretendardSemiBold18)
                    .padding(.vertical, 7)
                
                Spacer().frame(height: 0)
                
                //MARK: - CameraButton
                ImageView()
                
                Spacer().frame(height: 17)
                
                //MARK: - TextField
                ZStack(alignment: .leading){
                        TextField("", text: $text)
                        .placeholder(when: text.isEmpty) {
                            Text("자유롭게 적어주세요")
                                .foregroundColor(Color(hexColor: "858584")).padding(.leading, 5)
                        }
                    //❗️keyboard dismiss
                        .focused($keyboardFocused)
                        .padding().frame(height: 63)
                        .font(.pretendardRegular18)
                            .background(Color(hexColor: "3E3D39"))
                            .frame(width: 335)
                            .cornerRadius(50)
                            .tracking(-1)
                            .foregroundColor(Color(hexColor: "FFFFFF"))
                    //MARK: - sendButton
                        HStack{
                            Spacer().frame(width: 280)
                            Button(action: {
                                //❗️keyboard dismiss
                                keyboardFocused = false
                                pieceList.append(Piece(time: getCurrentTime(), content: text))//배열에 추가
                                savePieceList()
                                text.removeAll()
                            }, label: {
                                //MARK: - Button 활성화
                                ZStack{
                                    if text.isEmpty == true{
                                        Circle()
                                            .frame(width:49)
                                            .foregroundColor(Color(hexColor: "53514B"))
                                    } else{
                                        Circle()
                                            .frame(width:49)
                                            .foregroundColor(Color(hexColor: "F0AFD4"))
                                    }
                                    Image("send")
                                        .resizable()
                                        .frame(width: 18, height: 18)
                                }
                            }).disabled(text.isEmpty)
                        }
                        .frame(alignment: .trailing)
                    }
            }
            //질문 1 : stack 옆에 넣는 alignment랑 frame에 넣는 alignment의 차이가 무엇인지
            .frame(width:430, height: 300,alignment: .topLeading)
            .padding(.leading,95)
            .padding(.bottom, 20)
            .background((Color(hexColor: "474641")))
            
        }.onAppear(){
            loadPieceList()
        }
    }
    
    //MARK: - Userdefaults save
    func loadPieceList() {
        let fileURL = getDocumentsDirectory().appendingPathComponent("piece.json")
        if let data = try? Data(contentsOf: fileURL) {
            if let decoded = try? JSONDecoder().decode([Piece].self, from: data) {
                self.pieceList = decoded
            }
        }
    }
    
    // UserDefaults에 데이터를 저장하는 함수
    func savePieceList() {
        let fileURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("piece.json")
        if let encodedData = try? JSONEncoder().encode(pieceList) {
            try? encodedData.write(to: fileURL)
        }
    }
    
    func getDocumentsDirectory() -> URL {
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
}

func getCurrentTime() -> String {
    let currentTime = Date.now.formatted(date: .omitted, time: .shortened)
    return "\(currentTime)"
}

#Preview {
    BottomView( pieceList: .constant([]))
}
