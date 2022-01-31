import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/componanes/componanets.dart';
import 'package:shop_app/modouls/search_modouls.dart';
import 'package:shop_app/shared/cubit/search_cubit.dart';
import 'package:shop_app/shared/cubit/search_states.dart';
import 'package:shop_app/shared/shop_cubit/shop_cubit.dart';

class ShopSearch extends StatelessWidget {

 var searchController=TextEditingController();
 var formKey=GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) =>SearchCubit(),
      child: BlocConsumer<SearchCubit,SearchStates>(
        listener: (context,state){},
        builder: (context,state){
          return Scaffold(
            appBar: AppBar(

            ),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: key,
                child: Column(
                  children: [

                    defaultTextField(
                      onSubmit:(String text){
                        SearchCubit.get(context).getSearchData(text: text);
                        print(text);
                      },
                        label: 'Search',
                        prefix: Icons.search,
                        type: TextInputType.text,
                        validate: (String? search ) {
                          if(search!.isEmpty)
                            return 'This Filed can\'t be empty';
                        },
                        controller: searchController
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    if (state is ShopLoadingSearch)
                      LinearProgressIndicator(),
                    if(state is ShopSuccessSearch)
                    Expanded(
                      child: ListView.separated(
                        physics: BouncingScrollPhysics(),
                        separatorBuilder: (BuildContext context, int index) {
                          return Divider(
                            height: 1,
                          );
                        },
                        itemCount: SearchCubit.get(context).model!.data.data.length,
                        itemBuilder: (BuildContext context, int index) => buildListItem(
                            SearchCubit.get(context).model!.data.data[index],
                            context),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },

      ),
    );
  }

}
