import 'package:flutter/material.dart';

class FoodPicker extends StatefulWidget {
  const FoodPicker({Key? key}) : super(key: key);

  @override
  State<FoodPicker> createState() => _FoodPickerState();
}

int selectedComidas = 0;
int selectedSanas = 0;

class _FoodPickerState extends State<FoodPicker> {
  final List<int> _comidas = [0, 1, 2, 3, 4, 5, 6, 7];
  List<int> _sanas = [];

  @override
  void initState() {
    super.initState();
    selectedComidas = _comidas[0];
    selectedSanas = _sanas.isNotEmpty ? _sanas[0] : 0;
    _updatesanas(selectedComidas);
  }

  void _updatesanas(int option) {
    setState(() {
      _sanas = List<int>.generate(option + 1, (index) => index);
      if (!_sanas.contains(selectedSanas)) {
        selectedSanas = _sanas.isNotEmpty ? _sanas[0] : 0;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildFirstPicker(),
        _buildSecondPicker(),
      ],
    );
  }

  Widget _buildFirstPicker() {
    return DropdownButton<int>(
      value: selectedComidas,
      items: _comidas.map((int option) {
        return DropdownMenuItem<int>(
          value: option,
          child: Text(option.toString()),
        );
      }).toList(),
      onChanged: (int? option) {
        if (option != null) {
          setState(() {
            selectedComidas = option;
            _updatesanas(option);
          });
        }
      },
    );
  }

  Widget _buildSecondPicker() {
    return DropdownButton<int>(
      value: selectedSanas,
      items: _sanas.map((int option) {
        return DropdownMenuItem<int>(
          value: option,
          child: Text(option.toString()),
        );
      }).toList(),
      onChanged: (int? option) {
        if (option != null) {
          setState(() {
            selectedSanas = option;
          });
        }
      },
    );
  }
}
