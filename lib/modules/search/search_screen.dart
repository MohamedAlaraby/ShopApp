import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/search/cubit.dart';
import 'package:shop_app/modules/search/states.dart';
import 'package:shop_app/shared/components.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var formKey = GlobalKey<FormState>();
    var searchController = TextEditingController();

    return BlocProvider(
      create: (context) => SearchCubit(),
      child: BlocConsumer<SearchCubit, SearchStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = SearchCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: Text(
                'Search Screen',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
            body: Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.all(
                  20.0,
                ),
                child: Column(
                  children: [
                    DefaultTextFormField(
                      controller: searchController,
                      textInputType: TextInputType.text,
                      validator: (string) {
                        if (string!.isEmpty) {
                          return 'please enter text to search for ';
                        }
                        return null;
                      },
                      label: 'Search',
                      prefix: Icons.search,
                      onFieldSubmitted: (String text) {
                        cubit.search(text);
                      },
                      onChange: (text) {
                        cubit.search(text);
                      },
                    ),
                    const SizedBox(height: 10.0),
                    if (state is SearchLoadingState)
                      const LinearProgressIndicator(),
                    if (state is SearchSuccessState&&cubit.model?.data?.data != null)
                    Expanded(
                      child: ListView.separated(
                      itemBuilder: (context, index) => buildSearchListItem(cubit.model?.data?.data?[index], context),
                      separatorBuilder:(context, index) =>  myDivider(),
                      itemCount: cubit.model!.data!.data!.length,
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
