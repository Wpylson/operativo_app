import 'package:flutter/material.dart';
import 'package:operativo_final_cliente/models/product.dart';
import 'package:operativo_final_cliente/models/product_manger.dart';
import 'package:operativo_final_cliente/screens/edit_product/componets/delete_dialog.dart';
import 'package:operativo_final_cliente/screens/edit_product/componets/images_form.dart';
import 'package:operativo_final_cliente/screens/edit_product/componets/sizes_form.dart';
import 'package:provider/provider.dart';

class EditProductScreen extends StatelessWidget {
  EditProductScreen(Product p)
      : editing = p != null,
        product = p != null
            ? p.clone()
            : Product(); //Condicao para add ou editar um produto

  final Product product;
  final bool editing;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final Color primaryColor = Theme.of(context).primaryColor;
    return ChangeNotifierProvider.value(
      value: product,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(
              editing ? 'Editar Produto - ${product.name}' : 'Novo Produto'),
          centerTitle: true,
          actions: [
            if(editing)
              IconButton(
                icon:const Icon(Icons.delete),
                onPressed: (){
                  showDialog(
                      context: context,
                      builder: (_) => DeleteDialog(
                        // ignore: unnecessary_string_interpolations
                        item: '${product.name}',
                        grupo: 'Produto',
                        product: product,
                      )
                  );
                },
              ),

          ],
        ),
        body: Form(
          key: formKey,
          child: ListView(
            children: [
              ImagesForm(product),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextFormField(
                      initialValue: product.name,
                      decoration: const InputDecoration(
                          hintText: 'Nome do produto',
                          border: InputBorder.none),
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.w600),
                      validator: (name) {
                        if (name.length < 6) {
                          return 'Titulo muito curto';
                        }
                        if (name.isEmpty) {
                          return 'Digite um nome para o produto';
                        }
                        return null;
                      },
                      onSaved: (name) => product.name = name,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: Text(
                        'A partir de',
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 13,
                        ),
                      ),
                    ),
                    Text(
                      '... Kz',
                      style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: primaryColor),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 16),
                      child: Text(
                        'Descrição',
                        style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    TextFormField(
                      initialValue: product.description,
                      style: const TextStyle(fontSize: 16),
                      decoration: const InputDecoration(
                          hintText: 'Descrição do produto',
                          border: InputBorder.none),
                      maxLines: null,
                      validator: (desc) {
                        if (desc.length < 10) {
                          return 'Descrição muito curta';
                        }
                        return null;
                      },
                      onSaved: (description) =>
                          product.description = description,
                    ),
                    SizesForm(product),
                    const SizedBox(
                      height: 20,
                    ),
                    Consumer<Product>(
                      builder: (_, product, __) {
                        return SizedBox(
                          height: 44,
                          child: RaisedButton(
                            color: primaryColor,
                            onPressed: !product.loading
                                ? () async{
                                    if (formKey.currentState.validate()) {
                                      formKey.currentState.save();
                                      //Salvar o produto
                                       await product.save();

                                       context.read<ProductManager>()
                                      .update(product);

                                       Navigator.of(context).pop();
                                    }
                                  }
                                : null,
                            textColor: Colors.white,
                            disabledColor: primaryColor.withAlpha(100),
                            child: product.loading
                                ? const CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation(
                                  Colors.white
                                ) ,
                            )
                                : const Text(
                                    'Salvar',
                                    style: TextStyle(
                                      fontSize: 18,
                                    ),
                                  ),
                          ),
                        );
                      },
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
