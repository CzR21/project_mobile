import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:project_mobile/data/models/produto_model.dart';

class ProdutoWidget extends StatefulWidget {
  final model;
  const ProdutoWidget({super.key, required this.model});

  @override
  State<ProdutoWidget> createState() => _ProdutoWidgetState();
}

class _ProdutoWidgetState extends State<ProdutoWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10),
        Text(
          '${widget.model.key} (${widget.model.value.length})',
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 15),
        GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisExtent: 200,
            crossAxisSpacing: 30,
          ),
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: widget.model.value.length,
          itemBuilder: (context, index) {
            return Card(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 20,
                    ),
                    child: Container(
                      height: 90,
                      decoration: BoxDecoration(
                        color: const Color(0xffA0A5BA),
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                  Text(widget.model.value[index].nome),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}
