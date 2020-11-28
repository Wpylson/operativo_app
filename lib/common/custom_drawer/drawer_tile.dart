import 'package:flutter/material.dart';
import 'package:operativo_final_cliente/models/page_manager.dart';
import 'package:provider/provider.dart';

class DrawerTile extends StatelessWidget {

  const DrawerTile({this.iconData,this.title,this.page});

  final IconData iconData;
  final String title;
  final int page;

  @override
  Widget build(BuildContext context) {
    final int currentPage = context.watch<PageManager>().page; //obter a page actual
    final Color primaryColor = Theme.of(context).primaryColor;
    return InkWell(
      onTap: (){
        context.read<PageManager>().setPage(page);
      },
      child: SizedBox(
        height: 60,
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Icon(
                iconData,
                size: 32,
                color: currentPage == page ? primaryColor : Colors.grey[700],
              ),
            ),
            Text(
              title,
              style: TextStyle(
                fontSize: 16.0,
                color: currentPage == page ? primaryColor : Colors.grey[700],
              ),
            )
          ],
        ),
      ),
    );
  }
}
