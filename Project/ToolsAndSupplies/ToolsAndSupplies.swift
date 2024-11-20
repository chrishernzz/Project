//
//  ToolsAndSupplies.swift
//  Project
//
//  Created by Christian Hernandez on 11/1/24.
//
import SwiftUI

struct ToolsAndSupplies: View {
    @Binding var isSubSidebarOpen: Bool
    @Binding var subSidebarOpen: Bool
    @Binding var selectTheOption: String
    
    //creating an array of names to loop from
    let toolsAndSuppliesItems: [ToolsAndSuppliesSidebarItem] = [
        ToolsAndSuppliesSidebarItem(name: "FOR SEWING"),
        ToolsAndSuppliesSidebarItem(name: "FOR EMBROIDERY"),
        ToolsAndSuppliesSidebarItem(name: "FOR CRAFTING"),
        ToolsAndSuppliesSidebarItem(name: "FOR OFFICE/SHIPPING"),
        ToolsAndSuppliesSidebarItem(name: "FOR ORGANIZATION"),
        ToolsAndSuppliesSidebarItem(name: "FOR PHOTOGRAPHY")
    ]
    
    var body: some View {
        ZStack{
            //even if dark mode we want background to be white
            Color.white.edgesIgnoringSafeArea(.all)
            VStack(alignment: .leading, spacing: 10) {
                //will return to the main sub view
                Button(action: {
                    subSidebarOpen = false
                }) {
                    HStack {
                        Image(systemName: "chevron.left")
                        Text("BACK")
                    }
                    .font(.headline)
                    .foregroundColor(.black)
                    .padding(.top, 10)
                    
                }
                //now loop throught the options starting at index[0]...index[n]
                ForEach(toolsAndSuppliesItems) { item in
                    Button(action: {
                        //set the paramter to the name the user picked
                        selectTheOption = item.name
                        //now flag the isSubSidebarOpen-> we don't want it open
                        isSubSidebarOpen = false
                        subSidebarOpen = false
                    }) {
                        Text(item.name)
                            .font(.headline)
                            .foregroundColor(.black)
                            .padding(.top, 10)
                    }
                }
                Spacer()
            }
        }
    }
}
//precondition: requires a unique identifier for each instance, which allows to distinguish one item from another-> using Identifiable.
//postcondition: this struct takes in name that carries the sub sidebar information
struct ToolsAndSuppliesSidebarItem: Identifiable {
    var id: String { name }
    var name: String
}

//precondition: requires a unique identifier for each instance, which allows to distinguish one item from another-> using Identifiable.
//postcondition: this struct will keep track of the image with the url
struct ItemsOfSupplies: Identifiable {
    //passing two parameters
    var id: String { imageName }
    var imageName: String
    var url: URL
}
//precondition: call the ItemsOfSupplies struct
//postcondition: this will print the information if user clicks on for sewing option
struct ForSewing: View {
    //create an array->will be easier to print the information of the sewing with url
    let sewingItems: [ItemsOfSupplies] = [
        ItemsOfSupplies(imageName: "sewingimage1", url: URL(string:"https://www.amazon.com/gp/product/B074PXC61F/ref=as_li_tl?ie=UTF8&camp=1789&creative=9325&creativeASIN=B074PXC61F&linkCode=as2&tag=yeseniadesign-20&linkId=b656fd244a867b16a84eaeef98ed55e1&th=1")!),
        ItemsOfSupplies(imageName: "sewingimage2", url: URL(string:"https://www.amazon.com/gp/product/B01MRJ8BR7/ref=as_li_tl?ie=UTF8&camp=1789&creative=9325&creativeASIN=B01MRJ8BR7&linkCode=as2&tag=yeseniadesign-20&linkId=a1c27b6b310c8e1e8166d75f7013442e")!),
        ItemsOfSupplies(imageName: "sewingimage3", url: URL(string:"https://www.amazon.com/gp/product/B091JVT5HX/ref=as_li_tl?ie=UTF8&camp=1789&creative=9325&creativeASIN=B091JVT5HX&linkCode=as2&tag=yeseniadesign-20&linkId=f628fae60dee4c52d0e7dd9f1dacb21a")!),
        ItemsOfSupplies(imageName: "sewingimage4", url: URL(string:"https://www.amazon.com/gp/product/B07NC138FQ/ref=as_li_tl?ie=UTF8&camp=1789&creative=9325&creativeASIN=B07NC138FQ&linkCode=as2&tag=yeseniadesign-20&linkId=40e8e9cb42f16225642efa8bcebd1b87")!),
        ItemsOfSupplies(imageName: "sewingimage5", url: URL(string:"https://www.amazon.com/MXBAOHENG-Electric-Rechargeable-Thickness-Batteries/dp/B09M9SC5BK?crid=2IDQOTPHIEYAK&keywords=electric%2Brotary%2Bcutter%2Bfor%2Bfabric&qid=1681188081&sprefix=Electric%2Brotary%2B%2Caps%2C188&sr=8-28&th=1&linkCode=sl1&tag=yeseniadesign-20&linkId=9d9a2114c485f7cc61492b562e4e207e&language=en_US&ref_=as_li_ss_tl")!),
        ItemsOfSupplies(imageName: "sewingimage6", url: URL(string:"https://www.amazon.com/Specialty-Products-734-PTSP-Turner-Needles/dp/B07TTR6G1R?crid=1KLVUCIMQFS9Q&keywords=ez%2Bpoint%2Band%2Bturner%2Btool%2Bfor%2Bsewing&qid=1681188374&sprefix=Ez%2Bpoint%2B,aps,158&sr=8-3&th=1&linkCode=sl1&tag=yeseniadesign-20&linkId=8084c9318e4f04e0e2a7ceaad808f471&language=en_US&ref_=as_li_ss_tl")!),
        ItemsOfSupplies(imageName: "sewingimage7", url: URL(string:"https://www.amazon.com/Hui-Tong-Scissors-Serrated-Scalloped/dp/B06WP56WXD?crid=2K3F1UTDF1GZI&keywords=hui%2Btong%2Bpinking%2Bshears%2B5mm&qid=1681189484&sprefix=hui%2Btong%2Bpinking%2Bshears%2B5mm,aps,191&sr=8-2&th=1&linkCode=sl1&tag=yeseniadesign-20&linkId=75bd693dd05690692dcb7266644bac44&language=en_US&ref_=as_li_ss_tl")!),
        ItemsOfSupplies(imageName: "sewingimage8", url: URL(string:"https://www.amazon.com/Automatic-Machine-Electric-Babylock-Accessory/dp/B07SQXKR9S?crid=1ONC9U4BSK7QT&keywords=automatic+bobbin+winder&qid=1681190507&sprefix=Automatic+bobb,aps,158&sr=8-7&linkCode=sl1&tag=yeseniadesign-20&linkId=5ebc32be7ef0838e8676eb1977153143&language=en_US&ref_=as_li_ss_tl")!),
        ItemsOfSupplies(imageName: "sewingimage9", url: URL(string:"https://www.amazon.com/Handmade-Setting-Machine-Nailheads-Accessories/dp/B0BKLPN6RW?crid=IRV1H602SOVN&dib=eyJ2IjoiMSJ9.2PBUpqlcVUHwz91fg7ZA_gQNQjbyXpn5vfcwxvKasrQfRqk4wwUDECIlEGzvqAM_ei00Ct5rEcFQk8gxaZvSb4wRcmuO8eiiT76zu7X9WtV2gA89zrZFJZEt3aSEbq55e4dwPrlqtjR3qw49dsy36Au6TqfIRMi4GDLqGJrtDivR7PTZTPg29YT7B51VAR8Kftfu9fGNbEY95mquHnNtMoYErRPKWEtNbLmMdPuDAviIW7Iw6sKO1cKj9eNb4ZkIbnu5YRXQyCN0Nyz07jHrlVn2t76k8EacO9J2uGLl1_o.R979RnE1xi7-_3npQolyr4NAlFtEQ0mSSeTa_azwbqk&dib_tag=se&keywords=pearl+setting+machine&qid=1712450676&sprefix=Pearl+setting+,aps,207&sr=8-7&linkCode=sl1&tag=yeseniadesign-20&linkId=b83286adee663c2bcff2d1ff014f2846&language=en_US&ref_=as_li_ss_tl")!)
    ]
    var body: some View {
        ScrollView {
            VStack {
                LinearGradient(
                    gradient: Gradient(colors: [Color.pink.opacity(0.2), Color.white]),
                    startPoint: .top,
                    endPoint: .bottom
                )
                .frame(height: 200)
                .frame(maxWidth: .infinity)
                .padding(.horizontal, -16)
                Text("SEWING")
                    .font(.system(size: 30))
                    .fontWeight(.bold)
                    .foregroundColor(.pink)
                    .padding(.top, -100)
                //loop through the array-> index[0]...index[n]
                ForEach(sewingItems) { item in
                    //if user clicks the url then the button will have an action
                    Button(action: {
                        UIApplication.shared.open(item.url)
                    }) {
                        Image(item.imageName)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 300, height: 250)
                    }
                }
                Text("(affiliate)")
                    .foregroundColor(.gray)
                    .padding(.leading, 15)
                Spacer()
            }
            .padding()
            InformationAfterImages()
        }
        .background(Color.white)
    }
}
struct ForEmbroidery: View {
    //create an array->will be easier to print the information of the sewing with url
    let embroideryItems: [ItemsOfSupplies] = [
        ItemsOfSupplies(imageName: "embroideryimage1", url: URL(string:"https://www.amazon.com/Stainless-Steel-Applique-Duckbill-Embroidery/dp/B071S7F9LK?crid=1S0P1KLEESXKA&keywords=6+inch+appliqué+duckbill+scissors&qid=1681188545&sprefix=6+inch+appliqué+duckbill+scissors+,aps,166&sr=8-2&linkCode=sl1&tag=yeseniadesign-20&linkId=70f853a3343e3866095354bf08739ad6&language=en_US&ref_=as_li_ss_tl")!),
        ItemsOfSupplies(imageName: "embroideryimage2", url: URL(string:"https://www.amazon.com/Tool-Sidehopper-Stitch-Scissor-Assorted-Colors/dp/B003ILWK8S?crid=1T4ZTQ0WBMXLV&dib=eyJ2IjoiMSJ9.PuquKSOInb9oj5I-BOHjFSiLuMF0zzxjziZldhlqbfKUesaQu3cBWfIr7Z58W_suk9frPMPsIiSlUUvplEmbp5m85CgX-cRLnifjAlaYo6Cnp-yZFmV4gdSCZfA4qjifzOiYU1C-4ZNsym8KXnJgD9qGW0Camd1dRqcGbrPRKWBvZnVv2-LTmku5TJrYCPRwgqwV7mT2etV4ilrDZQ5EoZ0kdB6I494cwW7uDWGDRB_ffbVJHzZi6mPfsqKQqrvCYucPxjLy3x-EIbKOZZGFgYTxA2f771m4HNWtmBjRlfc.dYkDXEmDBahSK0FkSdS0KPXN7I551uYC5Y5qcC3ORBg&dib_tag=se&keywords=jump+stitch+scissors+for+embroidery&qid=1717839345&sprefix=Jump+stitch+,aps,152&sr=8-5&linkCode=sl1&tag=yeseniadesign-20&linkId=3d24216d15d31fed0df4a5e72e68ea0f&language=en_US&ref_=as_li_ss_tl")!),
        ItemsOfSupplies(imageName: "embroideryimage3", url: URL(string:"https://www.amazon.com/Therm-Web-Spray-Basting-Adhesive/dp/B007POWZGG?crid=3U4Q4ZOFTD3XR&dib=eyJ2IjoiMSJ9.SfMMXy-4Gr6RkUHzrBITmr41Len6_FMTw_nHlsWmQBMh9mZ2J4xYnmFvnMfvKJJPpLvIh80dXs-4kLMbLHpaxHOFc6kIPx7q-ppZfGMek7ga_EBz-muK8jQuLaZH3SufrmoXfgEG9OaF4OVjN9UINtDxU2YifOX_juh7Z9ie76Oo8O7wHhLMWCoKj3lEHUqof925Lpel8ouv0QUPVMkdf8Ixs7tdaEfgqHw3KYmVFNlFiPryAFd0tLTbwY5sJHZZraKeGj-lRVBdOaMUO2l0HGglbc4uyk7QnX31q69i3RM.IineSOf93lDyi2hwCO66EO2xApLwyQ5xspe85hbSLck&dib_tag=se&keywords=basting%2Badhesive%2Bspray&qid=1712904901&sprefix=Basting%2Bad,aps,148&sr=8-2&th=1&linkCode=sl1&tag=yeseniadesign-20&linkId=cbf512a051bc6fbda3ec35f54ec3dda9&language=en_US&ref_=as_li_ss_tl")!),
        ItemsOfSupplies(imageName: "embroideryimage4", url: URL(string:"https://www.amazon.com/SUPVOX-Elastic-Barbed-Stretch-Fastener/dp/B07KNS3GMG?crid=NFKI41XXWNXG&dib=eyJ2IjoiMSJ9.gnk_E9ty6FJFaz7zx1Tjrsmm2vu1Z1rOSWh7YTDd_V8UZl3TvpXxs_JQJyJ5wSKG2GIwhkja0fupFzdFw8S_zZ0KCk39sMfnE5UOm4BeXPoM645aUVK1iY1PXgNQVLlRmi94kBp4leHCbxa8CvJ4savhxInwbZxEhhHLZsft1Qv38P5VjeG6oo2vT2wG5TjGCoktVGipiwOK4M3RF16B9hsGEVmSyJKX50Ks2Z-1T0H8agvODryAeZ63zu6hzfm0oQErI7tvbk4fJ_Jx8EFO7tYtOKTVD4uGvmWW5KdPyp4.DHJBCtrd6oD2O_aaX8gEHnB7wyL3oJwN2st-oQ97_To&dib_tag=se&keywords=elastic+bands+for+crafts+mask&qid=1712904973&sprefix=elastic+bands+for+crafts+mask,aps,145&sr=8-12-spons&sp_csd=d2lkZ2V0TmFtZT1zcF9tdGY&psc=1&linkCode=sl1&tag=yeseniadesign-20&linkId=c8f76e4d82f81ade3e13cde342d7229d&language=en_US&ref_=as_li_ss_tl")!),
        ItemsOfSupplies(imageName: "embroideryimage5", url: URL(string:"https://www.amazon.com/Soluble-Machine-Embroidery-Stabilizer-Standing/dp/B079R5B7KF?crid=2VE20RSJC36ZD&dib=eyJ2IjoiMSJ9.92k5BFY4II_ypamKkjp1xXejOIGHCUCXnlidQHn-xujiYrUPAfouvABu6jQtmUqMPgTtx3fo5okmS_AXsH1aBuCgeL2hmblC8kwl__QKU55aDLoDqPKJe6zAJSaXXk1A9DUsDRJzRnvu-BEqxZvRdAOo9vRYuQCAz9KnbNH8sh8trLddBEck5qzgS10snAOhKEOsNo9BAGdvpyCi04v-9Z1CEcyh3Mjfge3q-LW5VG_A3rKsHBBaE3eXH9WWx01N5RZDb73EQcQACQAkw4TIRsCiAhKsnQj5CPrSGjuJ2GI.vE4poqxXujq6plW0twuIfjJp0jZ7Pc_n7H8cciglB5Q&dib_tag=se&keywords=FSL+Non+Woven+Water+Soluble+Wash+Away+Embroidery+Stabilizer:&qid=1717838965&sprefix=fsl+non+woven+water+soluble+wash+away+embroidery+stabilizer+,aps,203&sr=8-1&linkCode=sl1&tag=yeseniadesign-20&linkId=5feb1f2a7da0bbcd4ad2e84a49b04aef&language=en_US&ref_=as_li_ss_tl")!),
        ItemsOfSupplies(imageName: "embroideryimage6", url: URL(string:"https://www.amazon.com/New-brothread-Luminary-Embroidery-Quilting/dp/B09GVKYX7G?&linkCode=sl1&tag=yeseniadesign-20&linkId=32f523b9e63a130b01d94f3fa5e9f6e1&language=en_US&ref_=as_li_ss_tl")!),
        ItemsOfSupplies(imageName: "embroideryimage7", url: URL(string:"https://www.amazon.com/New-brothread-Changing-Embroidery-Quilting/dp/B09GVL1KVW?&linkCode=sl1&tag=yeseniadesign-20&linkId=56ac36ac9ffa4e168b988e50b54bfdd5&language=en_US&ref_=as_li_ss_tl")!)
    ]
    var body: some View {
        ScrollView {
            //vertical since sewing goes first then we want the images to be top to bottom
            VStack {
                LinearGradient(
                    gradient: Gradient(colors: [Color.pink.opacity(0.2), Color.white]),
                    startPoint: .top,
                    endPoint: .bottom
                )
                .frame(height: 200)
                .frame(maxWidth: .infinity)
                .padding(.horizontal, -16)
                
                Text("EMBROIDERY")
                    .font(.system(size: 30))
                    .fontWeight(.bold)
                    .foregroundColor(.pink)
                    .padding(.top, -100)
                //loop through the array-> index[0]...index[n]
                ForEach(embroideryItems) { item in
                    //if user clicks the url then the button will have an action
                    Button(action: {
                        UIApplication.shared.open(item.url)
                    }) {
                        Image(item.imageName)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 300, height: 250)
                    }
                }
                Text("(affiliate)")
                    .foregroundColor(.gray)
                    .padding(.leading, 15)
                Spacer()
            }
            .padding()
            InformationAfterImages()
        }
        .background(Color.white)
    }
}
struct ForCrafting: View {
    //create an array->will be easier to print the information of the sewing with url
    let craftingitems: [ItemsOfSupplies] = [
        ItemsOfSupplies(imageName: "craftingimage1", url: URL(string:"https://www.amazon.com/gp/product/B0778XRHCC/ref=as_li_tl?ie=UTF8&camp=1789&creative=9325&creativeASIN=B0778XRHCC&linkCode=as2&tag=yeseniadesign-20&linkId=aa3b98d2450b9b128c74808b8a0d2df3&th=1")!),
        ItemsOfSupplies(imageName: "craftingimage2", url: URL(string:"https://www.amazon.com/gp/product/B078PM1SS6/ref=as_li_tl?ie=UTF8&camp=1789&creative=9325&creativeASIN=B078PM1SS6&linkCode=as2&tag=yeseniadesign-20&linkId=63e1131be9e0a070a29dc61537d16dd3")!),
        ItemsOfSupplies(imageName: "craftingimage3", url: URL(string:"https://www.amazon.com/gp/product/B07CPH32SQ/ref=as_li_tl?ie=UTF8&camp=1789&creative=9325&creativeASIN=B07CPH32SQ&linkCode=as2&tag=yeseniadesign-20&linkId=2a9d9be5fc9eccd602d79b0073f611d3")!),
        ItemsOfSupplies(imageName: "craftingimage4", url: URL(string:"https://www.amazon.com/gp/product/B00MD4IYIQ/ref=as_li_tl?ie=UTF8&camp=1789&creative=9325&creativeASIN=B00MD4IYIQ&linkCode=as2&tag=yeseniadesign-20&linkId=a536a4aa98f6f4945e2f45706f51b347&th=1")!),
        ItemsOfSupplies(imageName: "craftingimage5", url: URL(string:"https://www.amazon.com/gp/product/B0751W55B9/ref=as_li_tl?ie=UTF8&camp=1789&creative=9325&creativeASIN=B0751W55B9&linkCode=as2&tag=yeseniadesign-20&linkId=f3a8f1413429cbcf5229974038159b3d")!),
        ItemsOfSupplies(imageName: "craftingimage6", url: URL(string:"https://www.amazon.com/gp/product/B01DEDA5JA/ref=as_li_tl?ie=UTF8&camp=1789&creative=9325&creativeASIN=B01DEDA5JA&linkCode=as2&tag=yeseniadesign-20&linkId=cb160cd688e517a1a270a469ad796b7f")!),
        ItemsOfSupplies(imageName: "craftingimage7", url: URL(string:"https://www.amazon.com/gp/product/B07CZ7CW1F/ref=as_li_tl?ie=UTF8&camp=1789&creative=9325&creativeASIN=B07CZ7CW1F&linkCode=as2&tag=yeseniadesign-20&linkId=ce28a45f93df1c6b1d1abf1f935a9f57")!),
        ItemsOfSupplies(imageName: "craftingimage8", url: URL(string:"https://www.amazon.com/Including-Scissors-Acrylic-Beginners-Professional/dp/B08NPYZM86?crid=3A7ZOGDKR4BHB&keywords=air+dry+clay+kit+tool&qid=1681188761&sprefix=air+dry+clay+kit+tool,aps,153&sr=8-24&linkCode=sl1&tag=yeseniadesign-20&linkId=ee94681e752a30b5a03a0ca5355cb2aa&language=en_US&ref_=as_li_ss_tl")!),
        ItemsOfSupplies(imageName: "craftingimage9", url: URL(string:"https://www.amazon.com/Stainless-Scissors-SourceTon-Multi-purpose-Ergonomic/dp/B075Q5171F?crid=26UKIOY2UED4U&keywords=herb+scissors+2+pk&qid=1681188943&sprefix=hern+scissors+2+pk,aps,137&sr=8-6&linkCode=sl1&tag=yeseniadesign-20&linkId=99e2da6dc7fa82732a1839d92a924d55&language=en_US&ref_=as_li_ss_tl")!),
        ItemsOfSupplies(imageName: "craftingimage10", url: URL(string:"https://www.amazon.com/Brother-Sewing-Standard-Mat-CAMATSTD12/dp/B0741LMYPP?crid=1BHKAIU9K1W5I&keywords=Brother%2Bstandard%2Bmat%2B12x%2B12&qid=1681190698&sbo=RZvfv%2F%2FHxDF%2BO5021pAnSA%3D%3D&sprefix=brother%2Bstandard%2Bmat%2B12x%2B12%2B%2Caps%2C154&sr=8-2&th=1&linkCode=sl1&tag=yeseniadesign-20&linkId=16003fbdb02c47d6760bac2f817851c4&language=en_US&ref_=as_li_ss_tl")!),
        ItemsOfSupplies(imageName: "craftingimage11", url: URL(string:"https://www.amazon.com/Christmas-Snowflake-Embellishments-Unfinished-Drawstrings/dp/B08MTFZCTZ?crid=30V7X4JXH1QMK&keywords=50%2Bpieces%2BChristmas%2Bwooden%2Bsnowflake%2Bornaments&qid=1681190872&sprefix=50%2Bpieces%2Bchristmas%2Bwooden%2Bsnowflake%2Bornaments%2B,aps,152&sr=8-1&th=1&linkCode=sl1&tag=yeseniadesign-20&linkId=d4b4e63f275303ba271038d922bdb438&language=en_US&ref_=as_li_ss_tl")!),
        ItemsOfSupplies(imageName: "craftingimage12", url: URL(string:"https://www.amazon.com/unuaST-Permanent-Transfer-Scrapbooking-Silhouette/dp/B09DSW88HB?crid=3GFZ8HFF0AQD9&keywords=unuaST%2BUpdated%2BBlack%2BPermanent%2BVinyl%2Bfor%2BCricut%2BMachine,%2BReverse%2BWeeding%2BNo%2BNeed%2BVinyl%2BTransfer%2BTape,%2BBlack%2BVinyl%2Bfor%2BCricut,%2BBlack%2BAdhesive%2BVinyl%2BRoll-%2B12”x%2B30%2BFT%2Bfor%2BScrapbooking%2B,%2BSilhouette%2BCameo%2Band%2BCutters&qid=1652159880&sprefix=,aps,160&sr=8-2&th=1&linkCode=sl1&tag=yeseniadesign-20&linkId=0cbfdc35b94aeda3c397092a5dea594f&language=en_US&ref_=as_li_ss_tl")!),
        ItemsOfSupplies(imageName: "craftingimage13", url: URL(string:"https://www.amazon.com/Release-Weeding-Installation-Glitter-Retractable/dp/B09M6MCHW9?crid=3QWJHUNW6KGL3&keywords=3%2BPieces%2BAir%2BRelease%2BWeeding%2BPen%2BVinyl%2BInstallation%2BPen%2BWeeding%2BTool%2BFine%2BPoint%2BWeeding%2BPin%2BPen%2BGlitter%2BMetal%2BPin%2BPen%2BRetractable%2BCraft%2BVinyl%2BTool%2Bfor%2BDIY%2BCraft%2B(Rose%2BGold%2C%2BSmooth%2BStyle)&qid=1652159966&sprefix=%2Caps%2C161&sr=8-2&th=1&linkCode=sl1&tag=yeseniadesign-20&linkId=3e6a374715458088586fec448efd708e&language=en_US&ref_=as_li_ss_tl")!),
        ItemsOfSupplies(imageName: "craftingimage14", url: URL(string:"https://www.amazon.com/rabbitgoo-Privacy-Rainbow-Decorative-Non-Adhesive/dp/B01N20YR6B?crid=2K14GN0N1UTCZ&keywords=rabbitgoo%2BWindow%2BPrivacy%2BFilm,%2BRainbow%2BWindow%2BClings,%2B3D%2BDecorative%2BWindow%2BVinyl,%2BStained%2BGlass%2BWindow%2BDecals,%2BStatic%2BCling%2BWindow%2BSticker%2BNon-Adhesive,%2B17.5%2Bx%2B78.7%2Binches&qid=1652160003&sprefix=,aps,296&sr=8-5&th=1&linkCode=sl1&tag=yeseniadesign-20&linkId=6b3afa8eed0ef72ccb9b820d9fd90ff8&language=en_US&ref_=as_li_ss_tl")!),
        ItemsOfSupplies(imageName: "craftingimage15", url: URL(string:"https://www.amazon.com/gp/product/B000W4KV2G/ref=as_li_tl?ie=UTF8&camp=1789&creative=9325&creativeASIN=B000W4KV2G&linkCode=as2&tag=yeseniadesign-20&linkId=0702f4d94b64c98d356fdafb92a47c11")!),
        ItemsOfSupplies(imageName: "craftingimage16", url: URL(string:"https://www.amazon.com/gp/product/B07G4V5PGJ/ref=as_li_tl?ie=UTF8&camp=1789&creative=9325&creativeASIN=B07G4V5PGJ&linkCode=as2&tag=yeseniadesign-20&linkId=8f46480ce55e443659651b4682bf512c&th=1")!),
        ItemsOfSupplies(imageName: "craftingimage17", url: URL(string:"https://www.amazon.com/gp/product/B07239S3B4/ref=as_li_tl?ie=UTF8&camp=1789&creative=9325&creativeASIN=B07239S3B4&linkCode=as2&tag=yeseniadesign-20&linkId=5105263efff8b87dc75cc02956c9eaf0")!),
        ItemsOfSupplies(imageName: "craftingimage18", url: URL(string:"https://www.amazon.com/SHOMKIEE-Glow-Transfer-Vinyl-Rolls/dp/B09T9YZG76?crid=2HK0NI7ZYGAM&dib=eyJ2IjoiMSJ9.q-_dVEOKtd8avwxfS35svg.GGYb0iWF4iO9gjUurUkqrUcR_nplibJKOH_ViSNTW7U&dib_tag=se&keywords=Glow%2Bin%2BThe%2BDark%2BHTV%2BHeat%2BTransfer%2BVinyl%2BRolls%2B-%2B12%2BInches%2Bx%2B8%2BFeet%2BHTV%2BVinyl,%2BLuminous%2BIron%2Bon%2BVinyl%2Bfor%2BSilhouette%2BCameo%2B-%2BEasy%2Bto%2BCut%2B%26%2BWeed%2Bfor%2BHeat%2BVinyl%2BDesign%2B(8Ft,%2BZ2-Luminous%2BGreen)&qid=1720774188&sprefix=glow%2Bin%2Bthe%2Bdark%2Bhtv%2Bheat%2Btransfer%2Bvinyl%2Brolls%2B-%2B12%2Binches%2Bx%2B8%2Bfeet%2Bhtv%2Bvinyl,%2Bluminous%2Biron%2Bon%2Bvinyl%2Bfor%2Bsilhouette%2Bcameo%2B-%2Beasy%2Bto%2Bcut%2B%26%2Bweed%2Bfor%2Bheat%2Bvinyl%2Bdesign%2B8ft,%2Bz2-luminous%2Bgreen%2B,aps,285&sr=8-2&th=1&linkCode=sl1&tag=yeseniadesign-20&linkId=e122a2c8d237126b5235548ff661edac&language=en_US&ref_=as_li_ss_tl")!)
    ]
    var body: some View {
        ScrollView {
            //vertical since sewing goes first then we want the images to be top to bottom
            VStack {
                LinearGradient(
                    gradient: Gradient(colors: [Color.pink.opacity(0.2), Color.white]),
                    startPoint: .top,
                    endPoint: .bottom
                )
                .frame(height: 200)
                .frame(maxWidth: .infinity)
                .padding(.horizontal, -16)
                
                Text("CRAFTING")
                    .font(.system(size: 30))
                    .fontWeight(.bold)
                    .foregroundColor(.pink)
                    .padding(.top, -100)
                //loop through the array-> index[0]...index[n]
                ForEach(craftingitems) { item in
                    //if user clicks the url then the button will have an action
                    Button(action: {
                        UIApplication.shared.open(item.url)
                    }) {
                        Image(item.imageName)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 300, height: 250)
                    }
                }
                Text("(affiliate)")
                    .foregroundColor(.gray)
                    .padding(.leading, 15)
                Spacer()
            }
            .padding()
            InformationAfterImages()
        }
        .background(Color.white)
    }
}
struct ForOfficeAndShipping: View {
    //create an array->will be easier to print the information of the sewing with url
    let craftingitems: [ItemsOfSupplies] = [
        ItemsOfSupplies(imageName: "officeandshoppingimage1", url: URL(string:"https://www.amazon.com/gp/product/B08X6PP9P4/ref=as_li_tl?ie=UTF8&camp=1789&creative=9325&creativeASIN=B08X6PP9P4&linkCode=as2&tag=yeseniadesign-20&linkId=94fd6aa723357c4c3cf2598be0ef41ec")!),
        ItemsOfSupplies(imageName: "officeandshoppingimage2", url: URL(string:"https://www.amazon.com/gp/product/B07XDX7NN4/ref=as_li_tl?ie=UTF8&camp=1789&creative=9325&creativeASIN=B07XDX7NN4&linkCode=as2&tag=yeseniadesign-20&linkId=7668c37cb1c64e3ff1d29c7cede9cba4")!),
        ItemsOfSupplies(imageName: "officeandshoppingimage3", url: URL(string:"https://www.amazon.com/gp/product/B07W7H7G4P/ref=as_li_tl?ie=UTF8&camp=1789&creative=9325&creativeASIN=B07W7H7G4P&linkCode=as2&tag=yeseniadesign-20&linkId=7eca1b2f4d1c25573368afd1a5375b95")!),
        ItemsOfSupplies(imageName: "officeandshoppingimage4", url: URL(string:"https://www.amazon.com/gp/product/B098JMG43W/ref=as_li_tl?ie=UTF8&camp=1789&creative=9325&creativeASIN=B098JMG43W&linkCode=as2&tag=yeseniadesign-20&linkId=6016b3cc1180d983d3671995c3b95cff")!),
        ItemsOfSupplies(imageName: "officeandshoppingimage5", url: URL(string:"https://www.amazon.com/gp/product/B08XMQ3Q4H/ref=as_li_tl?ie=UTF8&camp=1789&creative=9325&creativeASIN=B08XMQ3Q4H&linkCode=as2&tag=yeseniadesign-20&linkId=4126debd7a693ca124c6d2686f024820")!),
        ItemsOfSupplies(imageName: "officeandshoppingimage6", url: URL(string:"https://www.amazon.com/gp/product/B07RZZMY6L/ref=as_li_tl?ie=UTF8&camp=1789&creative=9325&creativeASIN=B07RZZMY6L&linkCode=as2&tag=yeseniadesign-20&linkId=2cea0bdae7ff904db2d03ad20507d5fc")!),
        ItemsOfSupplies(imageName: "officeandshoppingimage7", url: URL(string:"https://www.amazon.com/gp/product/B083J23WT9/ref=as_li_tl?ie=UTF8&camp=1789&creative=9325&creativeASIN=B083J23WT9&linkCode=as2&tag=yeseniadesign-20&linkId=c0415f53ebbfec7c2366d8dc4487613e")!),
        ItemsOfSupplies(imageName: "officeandshoppingimage8", url: URL(string:"https://www.amazon.com/gp/product/B08Y5YWPWL/ref=as_li_tl?ie=UTF8&camp=1789&creative=9325&creativeASIN=B08Y5YWPWL&linkCode=as2&tag=yeseniadesign-20&linkId=03158348ca2dc656cde93bf2c06e73f5")!),
        ItemsOfSupplies(imageName: "officeandshoppingimage9", url: URL(string:"https://www.amazon.com/gp/product/B075MXN9G8/ref=as_li_tl?ie=UTF8&camp=1789&creative=9325&creativeASIN=B075MXN9G8&linkCode=as2&tag=yeseniadesign-20&linkId=14f6575351bba01fade34c6b8e20e8fe")!)
    ]
    var body: some View {
        ScrollView {
            //vertical since sewing goes first then we want the images to be top to bottom
            VStack {
                LinearGradient(
                    gradient: Gradient(colors: [Color.pink.opacity(0.2), Color.white]),
                    startPoint: .top,
                    endPoint: .bottom
                )
                .frame(height: 200)
                .frame(maxWidth: .infinity)
                .padding(.horizontal, -16)
                
                Text("OFFICE/SHIPPING")
                    .font(.system(size: 30))
                    .fontWeight(.bold)
                    .foregroundColor(.pink)
                    .padding(.top, -100)
                //loop through the array-> index[0]...index[n]
                ForEach(craftingitems) { item in
                    //if user clicks the url then the button will have an action
                    Button(action: {
                        UIApplication.shared.open(item.url)
                    }) {
                        Image(item.imageName)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 300, height: 250)
                    }
                }
                Text("(affiliate)")
                    .foregroundColor(.gray)
                    .padding(.leading, 15)
                Spacer()
            }
            .padding()
            InformationAfterImages()
        }
        .background(Color.white)
    }
}
struct ForOrganization: View {
    //create an array->will be easier to print the information of the sewing with url
    let craftingitems: [ItemsOfSupplies] = [
        ItemsOfSupplies(imageName: "organizationimage1", url: URL(string:"https://www.amazon.com/gp/product/B07VK7ZCPY/ref=as_li_tl?ie=UTF8&camp=1789&creative=9325&creativeASIN=B07VK7ZCPY&linkCode=as2&tag=yeseniadesign-20&linkId=c3fdc00a6549862e53e1dd149e8fc417")!),
        ItemsOfSupplies(imageName: "organizationimage2", url: URL(string:"https://www.amazon.com/gp/product/B06XYGRKQ8/ref=as_li_tl?ie=UTF8&camp=1789&creative=9325&creativeASIN=B06XYGRKQ8&linkCode=as2&tag=yeseniadesign-20&linkId=bb9f8b987a08389d04db435ea944adb7")!),
        ItemsOfSupplies(imageName: "organizationimage3", url: URL(string:"https://www.amazon.com/gp/product/B08LNG7D9S/ref=as_li_tl?ie=UTF8&camp=1789&creative=9325&creativeASIN=B08LNG7D9S&linkCode=as2&tag=yeseniadesign-20&linkId=e6dff7e75fb559097c928db4aa4bfbab")!),
        ItemsOfSupplies(imageName: "organizationimage4", url: URL(string:"https://www.amazon.com/gp/product/B07RW3YXD3/ref=as_li_tl?ie=UTF8&camp=1789&creative=9325&creativeASIN=B07RW3YXD3&linkCode=as2&tag=yeseniadesign-20&linkId=306fd2b0633a5c1b1d7dc5f61e1e5475")!),
        ItemsOfSupplies(imageName: "organizationimage5", url: URL(string:"https://www.amazon.com/gp/product/B011DYCNRE/ref=as_li_tl?ie=UTF8&camp=1789&creative=9325&creativeASIN=B011DYCNRE&linkCode=as2&tag=yeseniadesign-20&linkId=67df6ea3a9f357ddeefdae76a1bb52b4")!),
        ItemsOfSupplies(imageName: "organizationimage6", url: URL(string:"https://www.amazon.com/gp/product/B00NI1ZO5E/ref=as_li_tl?ie=UTF8&camp=1789&creative=9325&creativeASIN=B00NI1ZO5E&linkCode=as2&tag=yeseniadesign-20&linkId=46da1c3ae49a9132ba05ffb03150ef66")!),
        ItemsOfSupplies(imageName: "organizationimage7", url: URL(string:"https://www.amazon.com/gp/product/B078YMR8MN/ref=as_li_tl?ie=UTF8&camp=1789&creative=9325&creativeASIN=B078YMR8MN&linkCode=as2&tag=yeseniadesign-20&linkId=89bfd890d08d6e33b058faf47796eeda")!)
    ]
    var body: some View {
        ScrollView {
            //vertical since sewing goes first then we want the images to be top to bottom
            VStack {
                LinearGradient(
                    gradient: Gradient(colors: [Color.pink.opacity(0.2), Color.white]),
                    startPoint: .top,
                    endPoint: .bottom
                )
                .frame(height: 200)
                .frame(maxWidth: .infinity)
                .padding(.horizontal, -16)
                
                Text("ORGANIZATION")
                    .font(.system(size: 30))
                    .fontWeight(.bold)
                    .foregroundColor(.pink)
                    .padding(.top, -100)
                //loop through the array-> index[0]...index[n]
                ForEach(craftingitems) { item in
                    //if user clicks the url then the button will have an action
                    Button(action: {
                        UIApplication.shared.open(item.url)
                    }) {
                        Image(item.imageName)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 300, height: 250)
                    }
                }
                Text("(affiliate)")
                    .foregroundColor(.gray)
                    .padding(.leading, 15)
                Spacer()
            }
            .padding()
            InformationAfterImages()
        }
        .background(Color.white)
    }
}
struct ForPhotography: View {
    //create an array->will be easier to print the information of the sewing with url
    let craftingitems: [ItemsOfSupplies] = [
        ItemsOfSupplies(imageName: "photographyimage1", url: URL(string:"https://www.amazon.com/gp/product/B07VK7ZCPY/ref=as_li_tl?ie=UTF8&camp=1789&creative=9325&creativeASIN=B07VK7ZCPY&linkCode=as2&tag=yeseniadesign-20&linkId=c3fdc00a6549862e53e1dd149e8fc417")!),
        ItemsOfSupplies(imageName: "photographyimage2", url: URL(string:"https://www.amazon.com/gp/product/B06XYGRKQ8/ref=as_li_tl?ie=UTF8&camp=1789&creative=9325&creativeASIN=B06XYGRKQ8&linkCode=as2&tag=yeseniadesign-20&linkId=bb9f8b987a08389d04db435ea944adb7")!),
        ItemsOfSupplies(imageName: "photographyimage3", url: URL(string:"https://www.amazon.com/gp/product/B08LNG7D9S/ref=as_li_tl?ie=UTF8&camp=1789&creative=9325&creativeASIN=B08LNG7D9S&linkCode=as2&tag=yeseniadesign-20&linkId=e6dff7e75fb559097c928db4aa4bfbab")!)
    ]
    var body: some View {
        ScrollView {
            //vertical since sewing goes first then we want the images to be top to bottom
            VStack {
                LinearGradient(
                    gradient: Gradient(colors: [Color.pink.opacity(0.2), Color.white]),
                    startPoint: .top,
                    endPoint: .bottom
                )
                .frame(height: 200)
                .frame(maxWidth: .infinity)
                .padding(.horizontal, -16)
                
                Text("PHOTOGRAPHY")
                    .font(.system(size: 30))
                    .fontWeight(.bold)
                    .foregroundColor(.pink)
                    .padding(.top, -100)
                //loop through the array-> index[0]...index[n]
                ForEach(craftingitems) { item in
                    //if user clicks the url then the button will have an action
                    Button(action: {
                        UIApplication.shared.open(item.url)
                    }) {
                        Image(item.imageName)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 300, height: 250)
                    }
                }
                Text("(affiliate)")
                    .foregroundColor(.gray)
                    .padding(.leading, 15)
                Spacer()
            }
            .padding()
            InformationAfterImages()
        }
        .background(Color.white)
    }
}
struct InformationAfterImages: View {
    var body: some View {
        //another divider for the second line
        Divider()
            .frame(height: 6)
            .background(Color.gray.opacity(0.3))
            .padding(.top, 5)
        //add the instagram link and youtube link-> has to be side to side so use HStack-> horizontal
        HStack{
            //call the struct (from the MainContentView)-> pass in the two parameters which are image and url
            InstagramAndYoutubeLink(socialMediaImage: "instagramimage", url: URL(string: "https://www.instagram.com/yeseniadesigns/")!)
                .padding(.top, 100)
                .padding(.bottom, 20)
            InstagramAndYoutubeLink(socialMediaImage: "youtubeimage", url: URL(string: "https://www.youtube.com/@yeseniadesigns")!)
                .padding(.top, 100)
                .padding(.bottom, 20)
        }
        //lastly just place the information of her company
        Text("© 2012-2024 YESENIA DESIGNS. ALL RIGHTS RESERVED.")
            .font(.caption)
        //.regular doesn't make it as bold
            .fontWeight(.regular)
            .foregroundColor(.black)
        //have to center the text
            .multilineTextAlignment(.center)
            .padding(.vertical, 10)
            .frame(maxWidth: .infinity)
    }
}
//preview
//struct ToolsAndSupplies_Previews: PreviewProvider {
//    @State static var isSubSidebarOpen = true
//    @State static var subSidebarOpen = true
//    @State static var selectTheOption: String = ""
//    static var previews: some View {
//        ForPhotography()
//        //ToolsAndSupplies(isSubSidebarOpen: $isSubSidebarOpen, subSidebarOpen: $subSidebarOpen,selectTheOption: $selectTheOption)
//    }
//    
//}

