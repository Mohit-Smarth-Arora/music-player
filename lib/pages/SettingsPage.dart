import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:mymusic/components/neu_box.dart';
import 'package:mymusic/pages/audio_list_page.dart';
import 'package:mymusic/themes/LightMode.dart';
import 'package:mymusic/themes/theme_provider.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatelessWidget {
  SettingsPage({super.key});

  bool isDarkMode = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "S E T T I N G S",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 25),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: NeuBox(
                      neuBoxWidth: 150,
                      neuBoxHeight: 50,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Center(child: Text("Dark Mode",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),)),
                          CupertinoSwitch(
                              value:
                                  Provider.of<ThemeProvider>(context, listen: false)
                                      .isDarkMode,
                              onChanged: (value) {
                                Provider.of<ThemeProvider>(context, listen: false)
                                    .ToggleTheme();
                              },activeColor: Colors.grey.shade800,),
                        ],
                      ),
                    ),
                  ),
                ),

              ],
            ),
            const SizedBox(height: 30,),
            Center(
              child: SizedBox(
                height: 100,
                // width: MediaQuery.of(context).size.width*0.95,
                  child: InkWell(
                    onTap:() => Navigator.push(context, MaterialPageRoute(builder: (context) => AudioListPage())),
                    child: const NeuBox(
                      neuBoxWidth: 370,
                                    child: Center(child: Text("PLAY MUSIC FROM THIS DEVICE",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),)),
                                  ),
                  )),
            )
          ],
        ),

      ),
    );
  }
}
