import 'package:flutter/material.dart';
import 'package:operativo_final_cliente/common/custom_drawer/custom_drawer.dart';
import 'package:operativo_final_cliente/common/custom_icon_button.dart';
import 'package:operativo_final_cliente/common/empty_card.dart';
import 'package:operativo_final_cliente/common/order_tile.dart';
import 'package:operativo_final_cliente/models/admin_orders_manager.dart';
import 'package:operativo_final_cliente/models/order.dart';
import 'package:provider/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class AdminOrdersScreen extends StatefulWidget {
  @override
  _AdminOrdersScreenState createState() => _AdminOrdersScreenState();
}

class _AdminOrdersScreenState extends State<AdminOrdersScreen> {
  final PanelController panelController = PanelController();

  @override
  Widget build(BuildContext context) {

    const BorderRadiusGeometry radius =  BorderRadius.only(
      topLeft: Radius.circular(24.0),
      topRight: Radius.circular(24.0),
    );

    return Scaffold(
      drawer: CustomDrawer(),
      appBar: AppBar(
        title: const Text(
            'Todos os Pedidos'
        ),
        centerTitle: true,
      ),
      body: Consumer<AdminOrdersManager>(
          builder: (_, ordersManager,__){
            final filteredOrders = ordersManager.filteredOrders;

            //Filter Painel
            return SlidingUpPanel(
              controller: panelController,
              body: Column(
                children: [
                  if(ordersManager.userFilter != null)
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 0, 16, 2),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              'Pedido de ${ordersManager.userFilter.name}',
                              style: const TextStyle(
                                fontWeight: FontWeight.w800,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          CustomIconButton(
                            iconData: Icons.close,
                            color: Colors.white,
                            onTap: (){
                              ordersManager.setUserFilter(null);
                            },
                          ),
                        ],
                      ),
                    ),
                  if(filteredOrders.isEmpty)
                    const  Expanded(
                      child:  EmptyCard(
                        title: 'Nenhuma venda realizada!',
                        iconData: Icons.border_clear,
                      ),
                    )
                  else
                    Expanded(
                      child: ListView.builder(
                        itemCount: filteredOrders.length,
                        itemBuilder: (_,index){
                          return OrderTile(
                            filteredOrders.reversed.toList()[index],
                            showControls: true,
                          );
                        },
                      ),
                    ),
                  const SizedBox(height: 120,),
                ],
              ),
              panel: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  GestureDetector(
                    onTap: (){
                      if(panelController.isPanelClosed){
                        panelController.open();
                      }else{
                        panelController.close();
                      }
                    },
                    child: Container(
                      alignment: Alignment.center,
                      //color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Filtros',
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.w800,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: Status.values.map((s){
                        return CheckboxListTile(
                          title: Text(Order.getStatusText(s)),
                          activeColor: Theme.of(context).primaryColor,
                          dense: true,
                          value: ordersManager.statusFilter.contains(s),
                          onChanged: (v){
                            ordersManager.setStatusFilter(
                              status: s,
                              enabled: v
                            );
                          },
                        );
                      }).toList()
                    ),
                  )
                ],
              ) ,
              minHeight: 30,
              maxHeight: 240,
              backdropEnabled: true,
              borderRadius: radius ,
            );

          }
      ),
    );
  }
}
