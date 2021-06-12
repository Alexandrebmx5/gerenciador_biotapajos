import 'package:flutter/material.dart';
import 'package:gerenciador_aquifero/screens/suggestions/components/suggestions_header.dart';

import 'components/suggestions_tile.dart';


class SuggestionsTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: SuggestionsHeader(),
          ),
          SliverToBoxAdapter(
            child: Container(
                height: MediaQuery.of(context).size.height,
                child: SuggestionsTile()
            ),
          )
        ],
      ),
    );
  }
}
