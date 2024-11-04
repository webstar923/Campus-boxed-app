import 'package:boxed_project/theme/spacing.dart';
import 'package:boxed_project/utils/constants.dart';
import 'package:boxed_project/views/chats/chatting_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:boxed_project/route_structure/go_navigator.dart';
import 'package:boxed_project/theme/colors.dart';
import 'package:boxed_project/theme/font_structures.dart';
import 'package:boxed_project/widgets/custom_cached_network_image.dart';
import 'package:boxed_project/widgets/custom_icon_button.dart';
import 'package:boxed_project/widgets/filled_box.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  @override
  void initState() {
    tabController = TabController(
      length: 2,
      vsync: this,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Palette.themecolor,
        title: Image.asset(
          Constants.splashLogo,
          width: 200,
        ),
        actions: [
          CustomIconButton(
            onTap: () {},
            child: const Icon(
              CupertinoIcons.bell,
              color: themewhitecolor,
            ),
          ),
          10.kW,
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: TabBar(
            controller: tabController,
            indicatorColor: themewhitecolor,
            labelColor: themewhitecolor,
            unselectedLabelColor: themelightgreycolor,
            dividerColor: themewhitecolor,
            indicatorSize: TabBarIndicatorSize.tab,
            labelStyle: const TextStyle(
              fontSize: mediumfontsize1,
              color: themewhitecolor,
              fontWeight: boldfontweight,
            ),
            unselectedLabelStyle: const TextStyle(
              fontSize: mediumfontsize3,
              color: themegreytextcolor,
            ),
            tabs: const [
              Tab(
                text: "Customer",
              ),
              Tab(
                text: "Contact Support",
              ),
            ],
          ),
        ),
      ),
      body: TabBarView(
        controller: tabController,
        children: [
          customer(),
          contactSupport(),
        ],
      ),
    );
  }

  Widget customer() {
    return ListView.separated(
      primary: false,
      shrinkWrap: true,
      padding: const EdgeInsets.all(
        15,
      ),
      itemCount: messagesmodel.length,
      itemBuilder: (context, index) {
        return FilledBox(
          color: themewhitecolor,
          padding: EdgeInsets.zero,
          borderRadius: BorderRadius.circular(12),
          boxShadow: const [
            BoxShadow(
              blurRadius: 6,
              color: themegreycolor,
              offset: Offset(3, 6),
            ),
          ],
          child: ListTile(
            onTap: () {
              Go.route(
                context,
                ChattingScreen(
                  username: messagesmodel[index].title,
                  userImage: messagesmodel[index].userImage,
                ),
              );
            },
            leading: CustomCachedNetworkImage(
              imageUrl: messagesmodel[index].userImage,
              imageBuilder: (context, imageProvider) {
                return CircleAvatar(
                  radius: 25,
                  backgroundImage: imageProvider,
                );
              },
              animChild: const CircleAvatar(
                radius: 25,
                backgroundColor: themegreycolor,
              ),
            ),
            title: Row(
              children: [
                Text(
                  messagesmodel[index].title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            subtitle: Text(
              messagesmodel[index].subtitle,
            ),
            trailing: CircleAvatar(
              radius: 12,
              backgroundColor: Palette.themecolor,
              child: Center(
                child: Text(
                  messagesmodel[index].messagescount,
                  style: const TextStyle(
                    color: themewhitecolor,
                    fontSize: 12,
                  ),
                ),
              ),
            ),
          ),
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return const SizedBox(
          height: 10,
        );
      },
    );
  }

  Widget contactSupport() {
    return ListView.separated(
      primary: false,
      shrinkWrap: true,
      padding: const EdgeInsets.all(
        15,
      ),
      itemCount: messagesmodel.length,
      itemBuilder: (context, index) {
        return FilledBox(
          color: themewhitecolor,
          padding: EdgeInsets.zero,
          borderRadius: BorderRadius.circular(12),
          boxShadow: const [
            BoxShadow(
              blurRadius: 6,
              color: themegreycolor,
              offset: Offset(3, 6),
            ),
          ],
          child: ListTile(
            onTap: () {
              Go.route(
                context,
                ChattingScreen(
                  username: messagesmodel[index].title,
                  userImage: messagesmodel[index].userImage,
                ),
              );
            },
            leading: CustomCachedNetworkImage(
              imageUrl: messagesmodel[index].userImage,
              imageBuilder: (context, imageProvider) {
                return CircleAvatar(
                  radius: 25,
                  backgroundImage: imageProvider,
                );
              },
              animChild: const CircleAvatar(
                radius: 25,
                backgroundColor: themegreycolor,
              ),
            ),
            title: Row(
              children: [
                Text(
                  messagesmodel[index].title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            subtitle: Text(
              messagesmodel[index].subtitle,
            ),
            trailing: CircleAvatar(
              radius: 12,
              backgroundColor: Palette.themecolor,
              child: Center(
                child: Text(
                  messagesmodel[index].messagescount,
                  style: const TextStyle(
                    color: themewhitecolor,
                    fontSize: 12,
                  ),
                ),
              ),
            ),
          ),
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return const SizedBox(
          height: 10,
        );
      },
    );
  }
}

class MessagesModel {
  final String title;
  final String subtitle;
  final String messagescount;
  final String userImage;
  MessagesModel({
    required this.title,
    required this.subtitle,
    required this.messagescount,
    required this.userImage,
  });
}

List<MessagesModel> messagesmodel = [
  MessagesModel(
    title: "Willard Purnell",
    subtitle: "tranthuy@gmail.com",
    messagescount: "2",
    userImage:
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSOGB8hL92pHixnkA7yY-IrWBfJNDSl3FTe8w&usqp=CAU",
  ),
  MessagesModel(
    title: "Thad Eddings",
    subtitle: "tienlapspktnd@gmail.com",
    messagescount: "3",
    userImage:
        "https://giovannicosmetics.com/wp-content/uploads/2020/04/For-Men.jpg",
  ),
  MessagesModel(
    title: "Brittni Lando",
    subtitle: "john.smith@gmail.com",
    messagescount: "5",
    userImage:
        "https://images.pexels.com/photos/1043474/pexels-photo-1043474.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
  ),
  MessagesModel(
    title: "Merrill Kervin",
    subtitle: "manhhachkt08@gmail.com",
    messagescount: "7",
    userImage:
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRxdK4GRL3vgubOIijabP0gpqzaoBBtpjKs7g&usqp=CAU",
  ),
  MessagesModel(
    title: "Aileen Fullbright",
    subtitle: "danghoang87hl@gmail.com",
    messagescount: "1",
    userImage:
        "https://www.menspharmacy.co.uk/static/version1678987769/frontend/menspharmacy/default/en_GB/Magento_Theme/images/homepage_banner_m.jpg",
  ),
  MessagesModel(
    title: "Geoffrey Mott",
    subtitle: "vt.isst.nute@gmail.com",
    messagescount: "12",
    userImage:
        "https://images.hugoboss.com/is/image/hugobossdm/HBME_110_S23SR_BOSS_Tier3_BMB_031?%24large%24&cropN=0.1172333,0.0203125,0.6565064,0.5117188&align=0,-1&fit=crop,1&ts=1676564591291&qlt=80&wid=520&hei=608",
  ),
  MessagesModel(
    title: "Kylee Danford",
    subtitle: "vuhaithuongnute@gmail.com",
    messagescount: "7",
    userImage:
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRFJCqr5ZsspoEqMfdX6ymhLOrSndKlWfW3AA&usqp=CAU",
  ),
  MessagesModel(
    title: "Elmer Laverty",
    subtitle: "trungkian@gmail.com",
    messagescount: "4",
    userImage:
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSWg0P92nbmSxE0A8klCRwR9nsOmmSHKSIPkg&usqp=CAU",
  ),
];
