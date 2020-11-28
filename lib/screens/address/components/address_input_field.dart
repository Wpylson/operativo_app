import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:operativo_final_cliente/models/address.dart';
import 'package:operativo_final_cliente/models/cart_manager.dart';
import 'package:provider/provider.dart';

class AddressInputField extends StatelessWidget {
  const AddressInputField(this.address);

  final Address address;

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    final cartManager = context.watch<CartManager>();

    String emptyValidator(String text) =>
        text.isEmpty ? 'Campo obrigatório' : null;

    if (address.zipCode != null && cartManager.deliveryPrice == null) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          TextFormField(
            enabled: !cartManager.loading,
            initialValue: address.street,
            decoration: const InputDecoration(
              isDense: true,
              labelText: 'Rua/Avenida',
              hintText: 'Av. Pedro Pires',
            ),
            validator: emptyValidator,
            onSaved: (t) => address.street = t,
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: TextFormField(
                  enabled: !cartManager.loading,
                  initialValue: address.number,
                  decoration: const InputDecoration(
                    isDense: true,
                    labelText: 'Número',
                    hintText: '123',
                  ),
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  keyboardType: TextInputType.number,
                  validator: emptyValidator,
                  onSaved: (t) => address.number = t,
                ),
              ),
              const SizedBox(
                width: 16,
              ),
              Expanded(
                child: TextFormField(
                  enabled: !cartManager.loading,
                  initialValue: address.complement,
                  decoration: const InputDecoration(
                    isDense: true,
                    labelText: 'Complemento',
                    hintText: 'Opcional',
                  ),
                  onSaved: (t) => address.complement = t,
                ),
              ),
            ],
          ),
          TextFormField(
            enabled: !cartManager.loading,
            initialValue: address.district,
            decoration: const InputDecoration(
              isDense: true,
              labelText: 'Bairro',
              hintText: 'ex: Saidy Mingas',
            ),
            validator: emptyValidator,
            onSaved: (t) => address.district = t,
          ),
          Row(
            children: <Widget>[
              Expanded(
                flex: 3,
                child: TextFormField(
                  enabled: false,
                  initialValue: address.city,
                  decoration: const InputDecoration(
                    isDense: true,
                    labelText: 'Cidade',
                    hintText: 'Moçamedes',
                  ),
                  validator: emptyValidator,
                  onSaved: (t) => address.city = t,
                ),
              ),
              const SizedBox(
                width: 16,
              ),
              Expanded(
                child: TextFormField(
                  autocorrect: false,
                  enabled: false,
                  textCapitalization: TextCapitalization.characters,
                  initialValue: address.state,
                  decoration: const InputDecoration(
                    isDense: true,
                    labelText: 'UF',
                    hintText: 'MO',
                    counterText: '',
                  ),
                  maxLength: 2,
                  validator: (e) {
                    if (e.isEmpty) {
                      return 'Campo obrigatório';
                    } else if (e.length != 2) {
                      return 'Inválido';
                    }
                    return null;
                  },
                  onSaved: (t) => address.state = t,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          if(cartManager.loading)
            LinearProgressIndicator(
              backgroundColor: Colors.transparent,
              valueColor: AlwaysStoppedAnimation(primaryColor),
            )
          else
            const SizedBox(),
           RaisedButton(
            color: primaryColor,
            disabledColor: primaryColor.withAlpha(100),
            textColor: Colors.white,
            onPressed: !cartManager.loading ? ()async{
              if(Form.of(context).validate()){
                Form.of(context).save();
                //Endereco utilizado para entrega
                try {
                 await context.read<CartManager>().setAddress(address);
                }catch(e){
                  Scaffold.of(context).showSnackBar(
                    SnackBar(
                      content: Text('$e'),
                      backgroundColor: Colors.red,
                    )
                  );
                }
              }
            }: null,
            child: const Text('Calcular Frete'),
          ),
        ],
      );
    } else if(address.zipCode != null) {
      return
        Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: Text(
              '${address.street}, ${address.number}\n${address.district}\n'
                  '${address.city} - ${address.state}'
          ),
        );
    }else{
      return const SizedBox();
    }
  }
}
